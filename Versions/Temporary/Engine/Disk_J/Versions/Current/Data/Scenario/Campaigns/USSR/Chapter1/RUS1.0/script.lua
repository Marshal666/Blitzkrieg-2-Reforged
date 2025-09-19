function Init()
	ENEMY_WAVE01_01_START_SCRIPT_ID = 101;
	ENEMY_WAVE01_02_START_SCRIPT_ID = 121;
	ENEMY_WAVE01_03_START_SCRIPT_ID = 141;
	
	ALLY_BM13_SCRIPT_ID = 201;
	ALLY_BOMBER_SCRIPT_ID = 211;
	
	PLAYER_REINF_SCRIPT_ID = 221;
	
	FIRST_DEFENCE_INFANTRY_01_SCRIPT_ID = 301;
	FIRST_DEFENCE_INFANTRY_02_SCRIPT_ID = 302;
	
	BRIDGE_NORTH_WEST_SCRIPT_ID = 401;
	BRIDGE_NORTH_EAST_SCRIPT_ID = 402;
	BRIDGE_NORTH_EAST_WOODEN_SCRIPT_ID = 403;
	BRIDGE_SOUTH_EAST_SCRIPT_ID = 404;
	
	NORTH_EAST_AI_UNITS_SCRIPT_ID = 501;
	
	SECRET_OBJECTIVE_UNITS_SCRIPT_ID = 601;
	
	ENEMY_ATTACK01_STATE_START = 0;
	ENEMY_ATTACK01_STATE_01 = 1;
	ENEMY_ATTACK01_STATE_02 = 2;
	ENEMY_ATTACK01_STATE_03 = 3;
	ENEMY_ATTACK01_STATE_ALLY_BM13 = 4;
	ENEMY_ATTACK01_STATE_PLAYER_REINF = 5;
	ENEMY_ATTACK01_STATE_ALLY_BOMBER = 6;
	
	ENEMY_ATTACK01_DELTA_01 = 10;
	ENEMY_ATTACK01_DELTA_02 = 10;
	ENEMY_ATTACK01_DELTA_03 = 10;
	ENEMY_ATTACK01_DELTA_ALLY_BM13 = 0;
	ENEMY_ATTACK01_DELTA_ALLY_BOMBER = 30;
	ENEMY_ATTACK01_DELTA_PLAYER_REINF = 20;
	
	Enemy_Attack01 = {};
	Enemy_Attack01.State = ENEMY_ATTACK01_STATE_START;
	Enemy_Attack01.Time = GetGameTime();
	Enemy_Attack01.EachWaveUnitNumber = 8;
	
	Enemy_Attack01_GoalFields = {};
	Enemy_Attack01_GoalFields.n = 8;
	Enemy_Attack01_GoalFields[1] = "enemy_attack01_goal_01";
	Enemy_Attack01_GoalFields[2] = "enemy_attack01_goal_02";
	Enemy_Attack01_GoalFields[3] = "enemy_attack01_goal_03";
	Enemy_Attack01_GoalFields[4] = "enemy_attack01_goal_04";
	Enemy_Attack01_GoalFields[5] = "enemy_attack01_goal_05";
	Enemy_Attack01_GoalFields[6] = "enemy_attack01_goal_06";
	Enemy_Attack01_GoalFields[7] = "enemy_attack01_goal_07";
	Enemy_Attack01_GoalFields[8] = "enemy_attack01_goal_08";
	
	Ally_Bombers_Attack01_GoalFields = {};
	Ally_Bombers_Attack01_GoalFields.n = 2;
	Ally_Bombers_Attack01_GoalFields[1] = "ally_bombers_attack01_goal_01";
	Ally_Bombers_Attack01_GoalFields[2] = "ally_bombers_attack01_goal_02";
	Ally_Bombers_Attack01_GoalFields[3] = "ally_bombers_attack01_goal_03";
	
	OBJECTIVE_STATE_NONE = 0;
	OBJECTIVE_STATE_START = 1;
	OBJECTIVE_STATE_DONE = 2;
	OBJECTIVE_STATE_FAIL = 3;
	Objectives = {};
	Objectives.States = {};
	Objectives.States[0] = OBJECTIVE_STATE_NONE;
	Objectives.States[1] = OBJECTIVE_STATE_NONE;
	Objectives.States[2] = OBJECTIVE_STATE_NONE;
	Objectives.States[3] = OBJECTIVE_STATE_NONE;
	Objectives.States[4] = OBJECTIVE_STATE_NONE;
	
	ENEMY_START_DEFENCE_FIELD_STATE_NONE = 0;
	ENEMY_START_DEFENCE_FIELD_STATE_START = 1;
	ENEMY_START_DEFENCE_FIELD_STATE_RETRIED = 2;
	
	ENEMY_START_DEFENCE_RETRIED_PART = 0.7;
	
	EnemyDefenceField = {};
	EnemyDefenceField.State = ENEMY_START_DEFENCE_FIELD_STATE_NONE;
	EnemyDefenceField.StartNumber = 0;
	
	BRIDGES_STATE_NONE = 0;
	BRIDGES_STATE_START = 1;
	BRIDGES_STATE_DONE = 2;
	BRIDGES_STATE_FAIL = 3;
	
	Bridges = {};
	Bridges.State = BRIDGES_STATE_NONE;
	Bridges.Time = 0;
	Bridges.Bridge01 = 0;
	Bridges.Bridge02 = 0;
	
	KLIN_STATE_NONE = 0;
	KLIN_STATE_START = 1;
	KLIN_STATE_DONE = 2;
	
	KLIN_DONE_CONDITION_COEFF = 3;
	
	Klin = {};
	Klin.State = KLIN_STATE_NONE;
	Klin.Time = 0;
	
	FACTORY_STATE_NONE = 0;
	FACTORY_STATE_START = 1;
	FACTORY_STATE_DONE = 2;
	
	FACTORY_DONE_CONDITION_COEFF = 5;

	Factory = {};
	Factory.State =  FACTORY_STATE_NONE;
	Factory.Time = 0;
	
	AI_GENERAL_STATE_NONE = 0;
	AI_GENERAL_STATE_KLIN = 1;
	AI_GENERAL_STATE_FACTORY = 2;
	
	AI_GENERAL_REINF_KLIN = 5;
	AI_GENERAL_REINF_FACTORY = 8;
	
	AIGeneral = {};
	AIGeneral.State = AI_GENERAL_STATE_NONE;
	
	SECRET_OBJECTIVE_STATE_NONE = 0;
	SECRET_OBJECTIVE_STATE_DONE = 1;
	
	SecretObjective = {};
	SecretObjective.State = SECRET_OBJECTIVE_STATE_NONE;
end;

function ProcessEnemyAttack01()
	while 1 do
		Wait(1);
		local x, y, h;
		if Enemy_Attack01.State == ENEMY_ATTACK01_STATE_START then
			if GetGameTime() - Enemy_Attack01.Time > ENEMY_ATTACK01_DELTA_01 then
				Enemy_Attack01.State = ENEMY_ATTACK01_STATE_01;
				Enemy_Attack01.Time = GetGameTime();
				for i = 1, Enemy_Attack01.EachWaveUnitNumber do
					x, y, h = GetScriptAreaParams(Enemy_Attack01_GoalFields[i]);
					Cmd(ACT_SWARM, ENEMY_WAVE01_01_START_SCRIPT_ID + i - 1, h, x, y);
				end;
				for i = 1, Enemy_Attack01.EachWaveUnitNumber do
					Cmd(ACT_STAND, ENEMY_WAVE01_02_START_SCRIPT_ID + i - 1);
				end;
				for i = 1, Enemy_Attack01.EachWaveUnitNumber do
					Cmd(ACT_STAND, ENEMY_WAVE01_03_START_SCRIPT_ID + i - 1);
				end;
			end;
		end;
		if Enemy_Attack01.State == ENEMY_ATTACK01_STATE_01 then
			if GetGameTime() - Enemy_Attack01.Time > ENEMY_ATTACK01_DELTA_02 then
				Enemy_Attack01.State = ENEMY_ATTACK01_STATE_02;
				Enemy_Attack01.Time = GetGameTime();
				for i = 1, Enemy_Attack01.EachWaveUnitNumber do
					x, y, h = GetScriptAreaParams(Enemy_Attack01_GoalFields[i]);
					Cmd(ACT_MOVE, ENEMY_WAVE01_02_START_SCRIPT_ID + i - 1, h, x, y);
				end;
			end;
		end;
		if Enemy_Attack01.State == ENEMY_ATTACK01_STATE_02 then
			if GetGameTime() - Enemy_Attack01.Time > ENEMY_ATTACK01_DELTA_03 then
				Enemy_Attack01.State = ENEMY_ATTACK01_STATE_03;
				Enemy_Attack01.Time = GetGameTime();
				for i = 1, Enemy_Attack01.EachWaveUnitNumber do
					x, y, h = GetScriptAreaParams(Enemy_Attack01_GoalFields[i]);
					Cmd(ACT_MOVE, ENEMY_WAVE01_03_START_SCRIPT_ID + i - 1, h, x, y);
					QCmd(ACT_STAND, ENEMY_WAVE01_03_START_SCRIPT_ID + i - 1);
				end;
			end;
		end;
		if Enemy_Attack01.State == ENEMY_ATTACK01_STATE_03 then
			if GetGameTime() - Enemy_Attack01.Time > ENEMY_ATTACK01_DELTA_ALLY_BM13 then
				Enemy_Attack01.State = ENEMY_ATTACK01_STATE_ALLY_BM13;
				Enemy_Attack01.Time = GetGameTime();
				LandReinforcementFromMap(2, "rocket_artillery", 0, ALLY_BM13_SCRIPT_ID);
				x, y, h = GetScriptAreaParams("ally_bm13_position");
				Cmd(ACT_MOVE, ALLY_BM13_SCRIPT_ID, h, x, y);
				local array = GetArray(GetObjectList(ALLY_BM13_SCRIPT_ID));
				for i = 1, array.n do
					local n = i * 2;
					if n > Enemy_Attack01_GoalFields.n then
						n = Enemy_Attack01_GoalFields.n;
					end;
					x, y, h = GetScriptAreaParams(Enemy_Attack01_GoalFields[n]);
					UnitQCmd(ACT_SUPPRESS, array[i], h, x, y);
				end;
			end;
		end;
		if Enemy_Attack01.State == ENEMY_ATTACK01_STATE_ALLY_BM13 then
			if GetGameTime() - Enemy_Attack01.Time > ENEMY_ATTACK01_DELTA_PLAYER_REINF then
				Enemy_Attack01.State = ENEMY_ATTACK01_STATE_PLAYER_REINF;
				Enemy_Attack01.Time = GetGameTime();
--				LandReinforcementFromMap(0, "tank_heavy", 0, PLAYER_REINF_SCRIPT_ID);
--				x, y, h = GetScriptAreaParams("player_reinf_goal_01");
--				Cmd(ACT_SWARM, PLAYER_REINF_SCRIPT_ID, h, x, y);
--				Wait(3);
				LandReinforcementFromMap(0, "tank_medium", 0, PLAYER_REINF_SCRIPT_ID + 1);
				x, y, h = GetScriptAreaParams("player_reinf_goal_01");
				Cmd(ACT_SWARM, PLAYER_REINF_SCRIPT_ID + 1, h, x, y);
				Wait(3);
--				LandReinforcementFromMap(0, "tank_heavy", 0, PLAYER_REINF_SCRIPT_ID + 2);
--				x, y, h = GetScriptAreaParams("player_reinf_goal_02");
--				Cmd(ACT_SWARM, PLAYER_REINF_SCRIPT_ID + 2, h, x, y);
--				Wait(3);
				LandReinforcementFromMap(0, "tank_medium", 0, PLAYER_REINF_SCRIPT_ID + 3);
				x, y, h = GetScriptAreaParams("player_reinf_goal_02");
				Cmd(ACT_SWARM, PLAYER_REINF_SCRIPT_ID + 3, h, x, y);
			end;
		end;
		if Enemy_Attack01.State == ENEMY_ATTACK01_STATE_PLAYER_REINF then
			if GetGameTime() - Enemy_Attack01.Time > ENEMY_ATTACK01_DELTA_ALLY_BOMBER then
				Enemy_Attack01.State = ENEMY_ATTACK01_STATE_ALLY_BOMBER;
				Enemy_Attack01.Time = GetGameTime();
				for i = 1, Ally_Bombers_Attack01_GoalFields.n do
					LandReinforcementFromMap(2, "bombers", 1, ALLY_BOMBER_SCRIPT_ID + i - 1);
					x, y, h = GetScriptAreaParams(Ally_Bombers_Attack01_GoalFields[i]);
					Cmd(ACT_MOVE, ALLY_BOMBER_SCRIPT_ID + i - 1, h, x, y);
					Wait(5);
				end;
			end;
		end;
	end;
end;

function TestObjectives()
	while 1 do
		Wait(1);
		if Objectives.States[0] == OBJECTIVE_STATE_NONE then
			Objectives.States[0] = OBJECTIVE_STATE_START;
			ObjectiveChanged(0, 1);
		end;
		if Objectives.States[0] == OBJECTIVE_STATE_START then
			if EnemyDefenceField.State == ENEMY_START_DEFENCE_FIELD_STATE_RETRIED then
				Objectives.States[0] = OBJECTIVE_STATE_DONE;
				Objectives.States[1] = OBJECTIVE_STATE_START;
				ObjectiveChanged(0, 2);
				ObjectiveChanged(1, 1);
			end;
		end;
		if Objectives.States[1] == OBJECTIVE_STATE_START then 
			if Bridges.State == BRIDGES_STATE_DONE then
				Objectives.States[1] = OBJECTIVE_STATE_DONE;
				Objectives.States[2] = OBJECTIVE_STATE_START;
				ObjectiveChanged(1, 2);
				ObjectiveChanged(2, 1);
			end;
		end;
		if Objectives.States[2] == OBJECTIVE_STATE_START then 
			if Klin.State == KLIN_STATE_DONE then
				Objectives.States[2] = OBJECTIVE_STATE_DONE;
				Objectives.States[3] = OBJECTIVE_STATE_START;
				ObjectiveChanged(2, 2);
				ObjectiveChanged(3, 1);
			end;
		end;
		if Objectives.States[3] == OBJECTIVE_STATE_START then 
			if Factory.State == FACTORY_STATE_DONE then
				Objectives.States[3] = OBJECTIVE_STATE_DONE;
				ObjectiveChanged(3, 2);
			end;
		end;
		if Objectives.States[4] == OBJECTIVE_STATE_NONE then
			if SecretObjective.State == SECRET_OBJECTIVE_STATE_DONE then
				Objectives.States[4] = OBJECTIVE_STATE_DONE;
				ObjectiveChanged(4, 1);
				Wait(2);
				ObjectiveChanged(4, 2);
			end;
		end;
	end;
end;


function GetNUnitsInFirstDefence()
	return GetNUnitsInScriptGroup(FIRST_DEFENCE_INFANTRY_01_SCRIPT_ID, 1) + 
				GetNUnitsInScriptGroup(FIRST_DEFENCE_INFANTRY_02_SCRIPT_ID, 1);
end;

function ProcessEnemyStartDefenceField()
	while 1 do
		Wait(1);
		if EnemyDefenceField.State == ENEMY_START_DEFENCE_FIELD_STATE_NONE then
			EnemyDefenceField.State = ENEMY_START_DEFENCE_FIELD_STATE_START;
			EnemyDefenceField.StartNumber = GetNUnitsInFirstDefence();
		end;
		if EnemyDefenceField.State == ENEMY_START_DEFENCE_FIELD_STATE_START then
			if GetNUnitsInFirstDefence() / EnemyDefenceField.StartNumber < ENEMY_START_DEFENCE_RETRIED_PART then
				EnemyDefenceField.State = ENEMY_START_DEFENCE_FIELD_STATE_RETRIED;
				local x, y, h = GetScriptAreaParams("retreat_goal_01");
				Cmd(ACT_MOVE, FIRST_DEFENCE_INFANTRY_01_SCRIPT_ID, h, x, y);
				Wait(2);
				x, y, h = GetScriptAreaParams("retreat_goal_02");
				Cmd(ACT_MOVE, FIRST_DEFENCE_INFANTRY_02_SCRIPT_ID, h, x, y);
			end;
		end;
	end;
end;

function ProcessStarting()
	--Destroy north-west bridge
	Wait(1);
	local array = GetArray(GetObjectList(BRIDGE_NORTH_WEST_SCRIPT_ID));
	DamageObject(array[1], 50000);
end;

function ProcessBridges()
	while 1 do
		Wait(1);
		if Bridges.State == BRIDGES_STATE_NONE then
			if EnemyDefenceField.State == ENEMY_START_DEFENCE_FIELD_STATE_RETRIED then
				Bridges.State = BRIDGES_STATE_START; 
				Bridges.Time = GetGameTime();
			end;
		end;
		if Bridges.State == BRIDGES_STATE_START then
			if (IsSomeUnitInArea( 0, "bridge_01_enemy_defence", 0) == 1) and 
				(IsSomeUnitInArea( 1, "bridge_01_enemy_defence", 0) == 0) then
				Bridges.Bridge01 = 1;
			end;
			if (IsSomeUnitInArea( 0, "bridge_02_enemy_defence", 0) == 1) and 
				(IsSomeUnitInArea( 1, "bridge_02_enemy_defence", 0) == 0) then
				Bridges.Bridge02 = 1;
			end;
		end;
		if (Bridges.Bridge01 == 1) or (Bridges.Bridge02 == 1) then
			Bridges.State = BRIDGES_STATE_DONE;
		end;
		if (GetScriptObjectHPs(BRIDGE_NORTH_EAST_SCRIPT_ID) <= 0) and 
			(GetScriptObjectHPs(BRIDGE_NORTH_EAST_WOODEN_SCRIPT_ID) <= 0) then
			Bridges.State = BRIDGES_STATE_FAIL;
		end;
	end;
end;

function ProcessWinLoose()
	while 1 do
		Wait(1);
		if ((IsSomePlayerUnit(0) == 0) and (IsReinforcementAvailable(0) == 0)) or 
		 (Bridges.State == BRIDGES_STATE_FAIL) then
			Wait(5);
			Win(1);
			return 1;
		end;
		if (Objectives.States[0] == OBJECTIVE_STATE_DONE) and
			(Objectives.States[1] == OBJECTIVE_STATE_DONE) and
			(Objectives.States[2] == OBJECTIVE_STATE_DONE) and 
			(Objectives.States[3] == OBJECTIVE_STATE_DONE) then
			Wait(5);
			Win(0);
			return 1;
		end;
	end;
end;

function ProcessKlin()
	while 1 do
		Wait(1);
		if Klin.State == KLIN_STATE_NONE then
			if Bridges.State == BRIDGES_STATE_DONE then
				Klin.State = KLIN_STATE_START;
				Klin.Time = GetGameTime();
			end;
		end;
		if Klin.State == KLIN_STATE_START then
			local nEnemies = GetNUnitsInArea(1, "Klin", 0);
			local nPlayers = GetNUnitsInArea(0, "Klin", 0);
			if (nPlayers > 0) and ((nEnemies == 0) or (nPlayers / nEnemies > KLIN_DONE_CONDITION_COEFF)) then
				Klin.State = KLIN_STATE_DONE;
			end;
		end;
	end;
end;

function ProcessFactory()
	while 1 do
		Wait(1);
		if Factory.State == FACTORY_STATE_NONE then
			if Klin.State == KLIN_STATE_DONE then
				Factory.State = KLIN_STATE_START;
				Factory.Time = GetGameTime();
			end;
		end;
		if Factory.State == FACTORY_STATE_START then
			local nEnemies = GetNUnitsInArea(1, "factory", 0);
			local nPlayers = GetNUnitsInArea(0, "factory", 0);
			if (nPlayers > 0) and ((nEnemies == 0) or (nPlayers / nEnemies > FACTORY_DONE_CONDITION_COEFF)) then
				Factory.State = FACTORY_STATE_DONE;
			end;
		end;
	end;
end;

function ProcessAIGeneral()
	while 1 do
		Wait(1);
		if AIGeneral.State == AI_GENERAL_STATE_NONE then
			if Klin.State == KLIN_STATE_START then
				AIGeneral.State = AI_GENERAL_STATE_KLIN;
				GiveReinforcementCalls(1, AI_GENERAL_REINF_KLIN);
			end;
		end;
		if AIGeneral.State == AI_GENERAL_STATE_KLIN then
			if Factory.Stae == FACTORY_STATE_START then
				AIGeneral.State = AI_GENERAL_STATE_FACTORY;
				GiveReinforcementCalls(1, AI_GENERAL_REINF_FACTORY);
			end;
		end;
	end;
end;

function ProcessSecretObjective()
	while 1 do
		Wait(1);
		if SecretObjective.State == SECRET_OBJECTIVE_STATE_NONE then
			if GetNUnitsInScriptGroup( SECRET_OBJECTIVE_UNITS_SCRIPT_ID, 0) > 0 then
				SecretObjective.State = SECRET_OBJECTIVE_STATE_DONE;
			end;
		end;
	end;
end;

Init();

StartThread(ProcessStarting);
StartThread(ProcessEnemyAttack01);
StartThread(TestObjectives);
StartThread(ProcessEnemyStartDefenceField);
StartThread(ProcessBridges);
StartThread(ProcessWinLoose);
StartThread(ProcessKlin);
StartThread(ProcessFactory);
StartThread(ProcessAIGeneral);
StartThread(ProcessSecretObjective);