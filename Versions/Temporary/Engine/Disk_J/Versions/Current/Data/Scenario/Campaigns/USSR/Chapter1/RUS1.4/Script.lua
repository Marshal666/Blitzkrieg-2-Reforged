function Init()
	BM13_01_SCRIPT_ID = 301;
	BM13_02_SCRIPT_ID = 302;
	BM13_03_SCRIPT_ID = 303;
	BM13_04_SCRIPT_ID = 304;
	BM13_COUNT = 4;
	
	BMW_SCRIPT_ID = 101
	BMW_STATE_START = 0;
	BMW_STATE_MOVING = 1;
	BMWState = BMW_STATE_START;
	
	SOUTH_ATTACK_SCRIPT_ID = 201;
	SOUTH_ATTACK_STATE_START = 0;
	SOUTH_ATTACK_STATE_PROCESS = 1;
	SOUTH_ATTACK_STATE_STOP = 2;
	SOUTH_ATTACK_DELTA = 30;
	SOUTH_ATTACK_RANDOM = 5;
	SouthAttacks = {};
	SouthAttacks.State = SOUTH_ATTACK_STATE_START;
	SouthAttacks.Time = 0;
	SouthAttacks.Wave = 0;
	
	BIG_ATTACK_SCRIPT_ID = 401;
	BIG_ATTACK_STATE_START = 0;
	BIG_ATTACK_STATE_PROCESS = 1;
	BIG_ATTACK_STATE_STOP = 2;
	BIG_ATTACK_FIRE_DELTA = 30;
	BigAttack = {};
	BigAttack.State = BIG_ATTACK_STATE_START;
	BigAttack.Time = 0;
	BOMBERS_REINF_SCRIPT_ID = 501;
	SOUTH_BRIDGE_SCRIPT_ID = 601;
	
	ENEMY_TANKS_SCRIPT_ID = 701;
	ALLY_TANKS_SCRIPT_ID = 801;
	MB13_WAY_02_DEFENDER_SCRIPT_ID = 901;

	OBJ_STATE_START = 0;
	OBJ_STATE_1 = 1;
	OBJ_STATE_2 = 2;
	OBJ_STATE_WIN = 3;
	OBJ_STATE_LOOSE = 4;
	
	OBJ_1_DELTA = 3;
	
	OBJ_WIN_DELTA = 5;
	OBJ_LOOSE_DELTA = 5;
	
	Objectives = {};
	Objectives.State = OBJ_STATE_START;
	Objectives.Time = GetGameTime();
	
	BM13_STATE_START = 0;
	BM13_STATE_01 = 1;
	BM13_STATE_02 = 2;
	BM13_STATE_03 = 3;
	BM13_STATE_04 = 4;
	BM13Moving = {};
	BM13Moving.State = BM13_STATE_START;
	
	VILLAGE_BOMBING_DELTA = 5;
	
	ATTACK_TO_WAY02_STATE_START = 0;
	ATTACK_TO_WAY02_STATE_PROCESS = 1;
	AttackToWay02 = {};
	AttackToWay02.State = ATTACK_TO_WAY02_STATE_START
	
	ATTACK_TO_WAY02_TANKS_SCRIPT_ID = 1001;
end;

function ProcessBMWActivation()
	while 1 do
		Wait(1);
		if BMWState == BMW_STATE_START then
			if GetNUnitsInArea( 0, "bmw_activation", 0) > 0 then
				local x, y, h = GetScriptAreaParams("bmw_01");
				Cmd(ACT_SWARM, BMW_SCRIPT_ID, h, x, y);
				x, y, h = GetScriptAreaParams("bmw_02");
				QCmd(ACT_SWARM, BMW_SCRIPT_ID, h, x, y);
				BMWState = BMW_STATE_MOVING;
				return 1;
			end;
		end;
	end;
end;

function ProcessSouthAttacks()
	while 1 do
		Wait(1);
		if SouthAttacks.State == SOUTH_ATTACK_STATE_START then
			SouthAttacks.Time = GetGameTime();
			SouthAttacks.State = SOUTH_ATTACK_STATE_PROCESS;
		end;
		if SouthAttacks.State == SOUTH_ATTACK_STATE_PROCESS then
			if 	GetGameTime() - SouthAttacks.Time > SOUTH_ATTACK_DELTA + Random(SOUTH_ATTACK_RANDOM) then
				SouthAttacks.Wave = SouthAttacks.Wave + 1;
				LandReinforcementFromMap(1, "main_squad", 1, SOUTH_ATTACK_SCRIPT_ID);
				local side = Random(2);
				if side > 1 then
					local x, y, h = GetScriptAreaParams("south_attack_left");
					Cmd(ACT_MOVE,SOUTH_ATTACK_SCRIPT_ID, h, x, y);
				else
					local x, y, h = GetScriptAreaParams("south_attack_right");
					Cmd(ACT_MOVE,SOUTH_ATTACK_SCRIPT_ID, h, x, y);
				end;
				Wait(Random(SOUTH_ATTACK_RANDOM));
				LandReinforcementFromMap(1, "light_tank", 1, SOUTH_ATTACK_SCRIPT_ID + 1);
				if side > 1 then
					local x, y, h = GetScriptAreaParams("south_attack_left");
					Cmd(ACT_MOVE,SOUTH_ATTACK_SCRIPT_ID + 1, h, x, y);
				else
					local x, y, h = GetScriptAreaParams("south_attack_right");
					Cmd(ACT_MOVE,SOUTH_ATTACK_SCRIPT_ID + 1, h, x, y);
				end;
				SouthAttacks.Time = GetGameTime();
			end;
		end;
		if SouthAttacks.State == SOUTH_ATTACK_STATE_STOP then
			return 1;
		end;
	end;
end;

function ProcessBigAttack()
	while 1 do
		Wait(1);
		local x, y, h;
		if BigAttack.State == BIG_ATTACK_STATE_PROCESS then
			if (GetGameTime() - BigAttack.Time > BIG_ATTACK_FIRE_DELTA) or
				(IsUnitInArea(1, "bm13_goal_04", BigAttack.LastReinfUniqueID) == 1) then
				BigAttack.State = BIG_ATTACK_STATE_STOP;
				x, y, h = GetScriptAreaParams("bm13_goal_01");
				Cmd(ACT_SUPPRESS, BM13_01_SCRIPT_ID, h, x, y);
				x, y, h = GetScriptAreaParams("bm13_goal_02");
				Cmd(ACT_SUPPRESS, BM13_02_SCRIPT_ID, h, x, y);
				x, y, h = GetScriptAreaParams("bm13_goal_03");
				Cmd(ACT_SUPPRESS, BM13_03_SCRIPT_ID, h, x, y);
				x, y, h = GetScriptAreaParams("bm13_goal_04");
				Cmd(ACT_SUPPRESS, BM13_04_SCRIPT_ID, h, x, y);

				local id;
				id = GetArray(GetObjectList(BM13_01_SCRIPT_ID));
				ChangePlayer( id[1], 2 );
				id = GetArray(GetObjectList(BM13_02_SCRIPT_ID));
				ChangePlayer( id[1], 2 );
				id = GetArray(GetObjectList(BM13_03_SCRIPT_ID));
				ChangePlayer( id[1], 2 );
				id = GetArray(GetObjectList(BM13_04_SCRIPT_ID));
				ChangePlayer( id[1], 2 );
				
				local array = GetArray(GetObjectList(ALLY_TANKS_SCRIPT_ID))
				for i = 1, array.n do
					ChangePlayer( array[i], 0 );
				end;

				LandReinforcementFromMap(1, "bomber", 4, BOMBERS_REINF_SCRIPT_ID);
				x, y, h = GetScriptAreaParams("bomber_goal");
				Cmd(ACT_MOVE, BOMBERS_REINF_SCRIPT_ID, h, x, y);
				local id = BOMBERS_REINF_SCRIPT_ID;
				BOMBERS_REINF_SCRIPT_ID = BOMBERS_REINF_SCRIPT_ID + 1;
				while 1 do 
					Wait(1);
					if GetNScriptUnitsInArea (id, "bomber_goal", 1 ) > 0 then
						Wait(5);
						DamageScriptObject(SOUTH_BRIDGE_SCRIPT_ID, 100000); 
						break;
					end;
				end;
				return 1;
			end;
		end;
		if BigAttack.State == BIG_ATTACK_STATE_START then
			if (GetNUnitsInArea( 0, "big_attack_trigger", 0) > 0) then
				BigAttack.State = BIG_ATTACK_STATE_PROCESS;
				SouthAttacks.State = SOUTH_ATTACK_STATE_STOP;
				BigAttack.Time = GetGameTime();

				local scriptId = BIG_ATTACK_SCRIPT_ID;
				scriptId = scriptId + 1;
				LandReinforcementFromMap(1, "main_squad", 1, scriptId);
				x, y, h = GetScriptAreaParams("bm13_goal_02");
				Cmd(ACT_MOVE, scriptId, h, x, y);
				Wait(1);

				scriptId = scriptId + 1;
				LandReinforcementFromMap(1, "main_squad", 1, scriptId);
				x, y, h = GetScriptAreaParams("bm13_goal_04");
				Cmd(ACT_MOVE, scriptId, h, x, y);

				Wait(10);
				
				Wait(1);
				scriptId = scriptId + 1;
				LandReinforcementFromMap(1, "tank_light", 1, scriptId);
				x, y, h = GetScriptAreaParams("bm13_goal_01");
				Cmd(ACT_MOVE, scriptId, h, x, y);

				Wait(1);
				scriptId = scriptId + 1;
				LandReinforcementFromMap(1, "tank_light", 1, scriptId);
				x, y, h = GetScriptAreaParams("bm13_goal_02");
				Cmd(ACT_MOVE, scriptId, h, x, y);

				Wait(1);
				scriptId = scriptId + 1;
				LandReinforcementFromMap(1, "tank_light", 1, scriptId);
				x, y, h = GetScriptAreaParams("bm13_goal_03");
				Cmd(ACT_MOVE, scriptId, h, x, y);

				Wait(1);
				scriptId = scriptId + 1;
				LandReinforcementFromMap(1, "tank_light", 1, scriptId);
				x, y, h = GetScriptAreaParams("bm13_goal_04");
				Cmd(ACT_MOVE, scriptId, h, x, y);
				
				local a = GetArray(GetObjectList(scriptId));
				BigAttack.LastReinfUniqueID = a[1];
			end;
		end;
	end;
end;

function TestObjectives()
	while 1 do
		Wait(1);
		if Objectives.State == OBJ_STATE_START then
			if GetGameTime() - Objectives.Time > OBJ_1_DELTA then
				Objectives.State = OBJ_STATE_1;
				ObjectiveChanged( 0, 1);
			end;
		end;
		if Objectives.State == OBJ_STATE_1 then
			if BigAttack.State == BIG_ATTACK_STATE_STOP then
				Objectives.State = OBJ_STATE_2;
				ObjectiveChanged( 0, 2);
				ObjectiveChanged( 1, 1);
			end;
		end;
		local isLoose = 0;
		if GetReinforcementCallsLeft( 0 ) == 0 then
			if IsSomePlayerUnit( 0 ) == 0 then
				isLoose = 1;
			end;
		end;
		if GetCountBM13() == 0 then
			isLoose = 1;
		end;
		if isLoose == 1 then
			ObjectiveChanged( 0, 3);
			ObjectiveChanged( 1, 3);
			Objectives.State = OBJ_STATE_LOOSE;
			Wait( OBJ_LOOSE_DELTA );
			Win( 1 );
			return 0;
		end;
		if Objectives.State == OBJ_STATE_2 then
			if GetCountBM13InExit() > 0 then
				Objectives.State = OBJ_STATE_WIN;
				ObjectiveChanged( 1, 2);
				Wait( OBJ_WIN_DELTA );
				Win( 0 );
				return 1;
			end;
		end;
	end;
end;

function GetCountBM13()
	local countAlived = 0;
	for i = 1, BM13_COUNT do
		local array = GetArray(GetObjectList( BM13_01_SCRIPT_ID + i - 1));
		for j = 1, array.n do
			if IsAlive( array[j] ) == 1 then
				countAlived = countAlived + 1;
			end;
		end;
	end;
	return countAlived;
end;

function GetCountWay01EnemyTanks()
	local countAlived = 0;
	local array = GetArray(GetObjectList( ENEMY_TANKS_SCRIPT_ID ));
	for i = 1, array.n do
		if IsAlive( array[i] ) == 1 then
			countAlived = countAlived + 1;
		end;
	end;
	return countAlived;
end;

function GetCountWay02EnemyUnits()
	local countAlived = 0;
	local array = GetArray(GetObjectList( MB13_WAY_02_DEFENDER_SCRIPT_ID ));
	for i = 1, array.n do
		if IsAlive( array[i] ) == 1 then
			countAlived = countAlived + 1;
		end;
	end;
	return countAlived;
end;

function GetCountBM13InExit()
	local countAlived = 0;
	for i = 1, BM13_COUNT do
		local array = GetArray(GetObjectList( BM13_01_SCRIPT_ID + i - 1));
		for j = 1, array.n do
			if IsAlive( array[j] ) == 1 then
				if IsUnitInArea( 2, "bm13_exit", array[j]) == 1 then 
					countAlived = countAlived + 1;
				end;
			end;
		end;
	end;
	return countAlived;
end;

function ProcessBM13Moving()
	while 1 do
		Wait(1);
		local h, x, y;
		if BM13Moving.State == BM13_STATE_START then
			if Objectives.State == OBJ_STATE_2 then
				if GetCountWay01EnemyTanks() == 0 then
					BM13Moving.State = BM13_STATE_01;
					x, y, h = GetScriptAreaParams("bm13_way_01");
					Cmd(ACT_MOVE, BM13_02_SCRIPT_ID, h, x, y);
					Cmd(ACT_MOVE, BM13_03_SCRIPT_ID, h, x, y);
					Cmd(ACT_MOVE, BM13_04_SCRIPT_ID, h, x, y);
					Wait(5);
					Cmd(ACT_MOVE, BM13_01_SCRIPT_ID, h, x, y);
				end;
			end;
		end;
		if BM13Moving.State == BM13_STATE_01 then
--			if AttackToWay02.State == ATTACK_TO_WAY02_STATE_PROCESS then
				if GetCountWay02EnemyUnits() == 0 then
					if IsSomeUnitInArea( 1, "north_west_field", 0 ) == 0 then
						BM13Moving.State = BM13_STATE_02;
						x, y, h = GetScriptAreaParams("bm13_way_02");
						QCmd(ACT_MOVE, BM13_01_SCRIPT_ID, h, x, y);
						QCmd(ACT_MOVE, BM13_02_SCRIPT_ID, h, x, y);
						QCmd(ACT_MOVE, BM13_03_SCRIPT_ID, h, x, y);
						QCmd(ACT_MOVE, BM13_04_SCRIPT_ID, h, x, y);
					end;
				end;
--			end;
		end;
		if BM13Moving.State == BM13_STATE_02 then
			if IsSomeUnitInArea( 1, "north_bridge_defence", 0 ) == 0 then
				BM13Moving.State = BM13_STATE_03;
				x, y, h = GetScriptAreaParams("bm13_way_03");
				QCmd(ACT_MOVE, BM13_01_SCRIPT_ID, h, x, y);
				QCmd(ACT_MOVE, BM13_02_SCRIPT_ID, h, x, y);
				QCmd(ACT_MOVE, BM13_03_SCRIPT_ID, h, x, y);
				QCmd(ACT_MOVE, BM13_04_SCRIPT_ID, h, x, y);
			end;
		end;
		if BM13Moving.State == BM13_STATE_03 then
			if IsSomeUnitInArea( 1, "exit_defence", 0 ) == 0 then
				BM13Moving.State = BM13_STATE_04;
				x, y, h = GetScriptAreaParams("bm13_way_04");
				QCmd(ACT_MOVE, BM13_01_SCRIPT_ID, h, x, y);
				QCmd(ACT_MOVE, BM13_02_SCRIPT_ID, h, x, y);
				QCmd(ACT_MOVE, BM13_03_SCRIPT_ID, h, x, y);
				QCmd(ACT_MOVE, BM13_04_SCRIPT_ID, h, x, y);
			end;
		end;
	end;
end;

function ProcessVillageBombing()
	while 1 do
		Wait(1);
		if BM13Moving.State >= BM13_STATE_01 then
			if IsSomeUnitInArea( 0, "bomber_goal_02", 0 ) == 0 then
				Wait(VILLAGE_BOMBING_DELTA);
				local x, y, h = GetScriptAreaParams("bomber_goal_02");
				LandReinforcementFromMap(1, "bomber", 4, BOMBERS_REINF_SCRIPT_ID);
				Cmd(ACT_MOVE, BOMBERS_REINF_SCRIPT_ID, h, x, y);
				Wait(10);
				LandReinforcementFromMap(1, "bomber", 4, BOMBERS_REINF_SCRIPT_ID + 1);
				Cmd(ACT_MOVE, BOMBERS_REINF_SCRIPT_ID + 1, h, x, y);
				return 1;
			end;
		end;
	end;
end;

function ProcessAttackToWay02()
	while 1 do
		Wait(1);
--		if Objectives.State ~= OBJ_STATE_1 then
			if AttackToWay02.State == ATTACK_TO_WAY02_STATE_START then
				if GetCountWay02EnemyUnits() == 0 then
					LandReinforcementFromMap(1, "tank_light", 0, ATTACK_TO_WAY02_TANKS_SCRIPT_ID);
					local x, y, h = GetScriptAreaParams("attack_to_way02_goal");
					Cmd(ACT_MOVE, ATTACK_TO_WAY02_TANKS_SCRIPT_ID, h, x, y);
					Wait(1);
					AttackToWay02.State = ATTACK_TO_WAY02_STATE_PROCESS;
					return 1;
				end;
			end;
--		end;
	end;
end;

Init();

StartThread(ProcessBMWActivation);
StartThread(ProcessSouthAttacks);
StartThread(ProcessBigAttack);
StartThread(TestObjectives);
StartThread(ProcessBM13Moving);
StartThread(ProcessVillageBombing);
--StartThread(ProcessAttackToWay02);