function Init()
	WAIT_BEFORE_END_MISSION = 5;
	OBJ_STATE_START = 0;
	OBJ_STATE_1 = 1;
	OBJ_STATE_2 = 2;
	OBJ_STATE_WIN = 3;
	OBJ_STATE_FAIL = 4;
	Objectives = {};
	Objectives.State = OBJ_STATE_START;
	
	DESC_POINTER_01_SCRIPT_ID = 1001;
	DESC_POINTER_02_SCRIPT_ID = 1002;
	
	CountJapanBoats = 5;

	START_REINF_SCRIPT_ID = 1;
	ENEMY_SHIPS_SCRIPT_ID = 201;
	BigGuns = {};
	BigGuns.n = 4;
	for i = 1, BigGuns.n do
		BigGuns[i] = {};
	end;
	BigGuns[1].Area = "Gun_01";
	BigGuns[1].ScriptId = 101;
	BigGuns[2].Area = "Gun_02";
	BigGuns[2].ScriptId = 102;
	BigGuns[3].Area = "Gun_03";
	BigGuns[3].ScriptId = 103;
	BigGuns[4].Area = "Gun_04";
	BigGuns[4].ScriptId = 104;
	
	JapanCampSquads = {};
	JapanCampSquads.n = 6;
	for i = 1, JapanCampSquads.n do
		JapanCampSquads[i] = {};
		JapanCampSquads[i].SquadScriptID = 300 + i;
		JapanCampSquads[i].BuildingScriptID = 400 + i;
	end;
	CAMP_DEF_DELTA_TIME = 60;
	if GetDifficultyLevel() == DLEVEL_NORMAL then 
		CAMP_DEF_DELTA_TIME = 30;
	end;
	if GetDifficultyLevel() == DLEVEL_HARD then 
		CAMP_DEF_DELTA_TIME = 20;
	end;
	CAMP_DEF_ATTACK_TIME = 40;
	CAMP_DEF_DISPERSION = 10;
	CAPM_DEF_STATE_NORMAL = 0;
	CAPM_DEF_STATE_START = 1;
	CAPM_DEF_STATE_ATTACK = 2;
	CampDefence = {};
	CampDefence.State = CAPM_DEF_STATE_NORMAL;
	CampDefence.Time = 0;
	CampDefence.Pos = {};
	CampDefence.Pos.x = 0;
	CampDefence.Pos.y = 0;

	JapanBeachSquads = {};
	JapanBeachSquads.n = 8;
	for i = 1, JapanBeachSquads.n do
		JapanBeachSquads[i] = {};
	end;
	JapanBeachSquads[1].SquadScriptID = 721;
	JapanBeachSquads[1].BuildingID = GetObjectList(702);
	JapanBeachSquads[2].SquadScriptID = 722;
	JapanBeachSquads[2].BuildingID = GetObjectList(703);
	JapanBeachSquads[3].SquadScriptID = 723;
	JapanBeachSquads[3].BuildingID = GetObjectList(704);

	local bigTrench = GetArray(GetObjectList(701));
	JapanBeachSquads[4].SquadScriptID = 711;
	JapanBeachSquads[4].BuildingID = bigTrench[1];
	JapanBeachSquads[5].SquadScriptID = 712;
	JapanBeachSquads[5].BuildingID = bigTrench[2];
	JapanBeachSquads[6].SquadScriptID = 713;
	JapanBeachSquads[6].BuildingID = bigTrench[3];
	JapanBeachSquads[7].SquadScriptID = 714;
	JapanBeachSquads[7].BuildingID = bigTrench[4];
	JapanBeachSquads[8].SquadScriptID = 715;
	JapanBeachSquads[8].BuildingID = bigTrench[5];

		
	BEACH_DEF_DELTA_TIME = 30;
	if GetDifficultyLevel() == DLEVEL_NORMAL then 
		BEACH_DEF_DELTA_TIME = 20;
	end;
	if GetDifficultyLevel() == DLEVEL_HARD then 
		BEACH_DEF_DELTA_TIME = 10;
	end;
	BEACH_DEF_ATTACK_TIME = 40;
	BEACH_DEF_DISPERSION = 10;
	BEACH_DEF_STATE_NORMAL = 0;
	BEACH_DEF_STATE_START = 1;
	BEACH_DEF_STATE_START_ATTACK = 2;
	BEACH_DEF_STATE_ATTACK = 3;
	BeachDefence = {};
	BeachDefence.State = BEACH_DEF_STATE_NORMAL;
	BeachDefence.Time = 0;
	BeachDefence.Pos = {};
	BeachDefence.Pos.x = 0;
	BeachDefence.Pos.y = 0;


	BATTERY_DELTA_TIME = 60;
	BATTERY_STATE_NORMAL = 0;
	BATTERY_STATE_CAPTURED = 1;
	BATTERY_STATE_ATTACK = 2;
	BATTERY_STATE_DESTROYED = 3;
	Battery = {};
	Battery.State = BATTERY_STATE_NORMAL;
	Battery.Time = 0;
	
	JapanAAESquads = {};
	JapanAAESquads.n = 5;
	for i = 1, JapanAAESquads.n do
		JapanAAESquads[i] = {};
		JapanAAESquads[i].SquadScriptID = 510 + i;
		JapanAAESquads[i].GunScriptID = 500 + i;
	end;
	
	JapanAABSquads = {};
	JapanAABSquads.n = 5;
	for i = 1, JapanAABSquads.n do
		JapanAABSquads[i] = {};
		JapanAABSquads[i].SquadScriptID = 2110 + i;
		JapanAABSquads[i].GunScriptID = 2100 + i;
	end;
	
	BEACH_GUARD_SCRIPT_ID = 1201;
	BEACH_GUARD_STATE_NORMAL = 0;
	BEACH_GUARD_STATE_ALARM = 1;
	BEACH_GUARD_DIR_FORWARD = 0;
	BEACH_GUARD_DIR_BACK = 1;
	BeachGuard = {};
	BeachGuard.State = BEACH_GUARD_STATE_NORMAL;
	BeachGuard.Dir = BEACH_GUARD_DIR_FORWARD;
	BeachGuard.LastPoint = 0;
	BeachGuard.ScriptID = BEACH_GUARD_SCRIPT_ID;
	BeachGuardPoints = {};
	BeachGuardPoints.n = 7;
	BeachGuardPoints[1] = "BeachGuard_01";
	BeachGuardPoints[2] = "BeachGuard_02";
	BeachGuardPoints[3] = "BeachGuard_03";
	BeachGuardPoints[4] = "BeachGuard_04";
	BeachGuardPoints[5] = "BeachGuard_05";
	BeachGuardPoints[6] = "BeachGuard_06";
	BeachGuardPoints[7] = "BeachGuard_07";
	BEACH_GUARD_ALARM_TIME = 10;
	BEACH_GUARD_BEFORE_START = 60;
	
	TANK_FOR_CAPTURE = 2001;
	
	RECON_SCRIPT_ID = 3001;
end;

function StartDisposition()
	Wait(1);
	for i = 1, JapanCampSquads.n do
		Cmd(ACT_ENTER, JapanCampSquads[i].SquadScriptID, 
			JapanCampSquads[i].BuildingScriptID);
	end;
	
	local nLevel = GetDifficultyLevel();
	
	--East AAs
	if nLevel > DLEVEL_EASY then
		Cmd(ACT_TAKE_ARTILLERY, JapanAAESquads[2].SquadScriptID, 
			JapanAAESquads[2].GunScriptID );
		Cmd(ACT_TAKE_ARTILLERY, JapanAAESquads[4].SquadScriptID, 
			JapanAAESquads[4].GunScriptID );
		if nLevel > DLEVEL_NORMAL then
			Cmd(ACT_TAKE_ARTILLERY, JapanAAESquads[1].SquadScriptID, 
				JapanAAESquads[1].GunScriptID );
			Cmd(ACT_TAKE_ARTILLERY, JapanAAESquads[3].SquadScriptID, 
				JapanAAESquads[3].GunScriptID );
			Cmd(ACT_TAKE_ARTILLERY, JapanAAESquads[5].SquadScriptID, 
				JapanAAESquads[5].GunScriptID );
		end;
	end;
	if nLevel < DLEVEL_HARD then
		RemoveScriptGroup( JapanAAESquads[1].SquadScriptID );
		RemoveScriptGroup( JapanAAESquads[3].SquadScriptID );
		RemoveScriptGroup( JapanAAESquads[5].SquadScriptID );
		if nLevel < DLEVEL_NORMAL then
			RemoveScriptGroup( JapanAAESquads[2].SquadScriptID );
			RemoveScriptGroup( JapanAAESquads[4].SquadScriptID );
		end;
	end;
	
	--Beach AAs
	Cmd(ACT_TAKE_ARTILLERY, JapanAABSquads[1].SquadScriptID, 
		JapanAABSquads[1].GunScriptID );
	Cmd(ACT_TAKE_ARTILLERY, JapanAABSquads[2].SquadScriptID, 
		JapanAABSquads[2].GunScriptID );
	if nLevel > DLEVEL_EASY then
		Cmd(ACT_TAKE_ARTILLERY, JapanAABSquads[5].SquadScriptID, 
			JapanAABSquads[5].GunScriptID );
		if nLevel > DLEVEL_NORMAL then
			Cmd(ACT_TAKE_ARTILLERY, JapanAABSquads[3].SquadScriptID, 
				JapanAABSquads[3].GunScriptID );
			Cmd(ACT_TAKE_ARTILLERY, JapanAABSquads[4].SquadScriptID, 
				JapanAABSquads[4].GunScriptID );
		end;
	end;
	if nLevel < DLEVEL_HARD then
		RemoveScriptGroup( JapanAABSquads[3].SquadScriptID );
		RemoveScriptGroup( JapanAABSquads[4].SquadScriptID );
		if nLevel < DLEVEL_NORMAL then
			RemoveScriptGroup( JapanAABSquads[5].SquadScriptID );
		end;
	end;
end;

function CallStartReinforcment()
	LandReinforcementFromMap(0, "Specs", 0, START_REINF_SCRIPT_ID);
	local x, y, h = GetScriptAreaParams( "StartReinfPoint" );
	Cmd(ACT_UNLOAD, START_REINF_SCRIPT_ID, h, x, y);
end;

function TestGuns()
	while 1 do
		Wait(1);
		Battery.State = BATTERY_STATE_NORMAL;
		for i = 1, BigGuns.n do
			if IsSomeUnitInArea( 0, BigGuns[i].Area, 0 ) == 1 then	
				local id = GetObjectList( BigGuns[i].ScriptId );
				if GetNUnitsInScriptGroup ( BigGuns[i].ScriptId, 0 ) == 0 then
					ChangePlayer( id, 0 );
				end;
				Battery.State = BATTERY_STATE_CAPTURED;
				Battery.Time = GetGameTime();
			end;
			if IsSomeUnitInArea( 1, BigGuns[i].Area, 0 ) == 1 then	
				local id = GetObjectList( BigGuns[i].ScriptId );
				if GetNUnitsInScriptGroup ( BigGuns[i].ScriptId, 3 ) == 0 then
					ChangePlayer( id, 3 );
				end;
			end;
		end;
	end;
end;

function TestWinFail()
	while 1 do
		Wait(1);
		if GetReinforcementCallsLeft( 0 ) == 0 or IsReinforcementAvailable(0) ~= 1 then
			if GetNUnitsInPartyUF( 0 ) == 0 then
				Wait( WAIT_BEFORE_END_MISSION );
				Win( 1 );
				return 0;
			end;
		end;
		local array = GetArray(GetObjectList( ENEMY_SHIPS_SCRIPT_ID ));
		CountJapanBoats = 0;
		for i = 1, array.n do
			if IsAlive( array[i] ) == 1 then
				CountJapanBoats = CountJapanBoats + 1;
			end;
		end;
		if  CountJapanBoats == 0 then
			Wait( WAIT_BEFORE_END_MISSION );
			Win( 0 );
			return 1;
		end;
	end;
end;

function DefenceOfCamp()
	while 1 do
		Wait(1);
		if (CampDefence.State == CAPM_DEF_STATE_ATTACK) then 
			if (GetGameTime() - CampDefence.Time > CAMP_DEF_ATTACK_TIME) then
				CampDefence.State = CAPM_DEF_STATE_NORMAL;
				for i = 1, JapanCampSquads.n do
					Cmd(ACT_ENTER, JapanCampSquads[i].SquadScriptID, 
						JapanCampSquads[i].BuildingScriptID);
				end;
			end;
		end;
		if (CampDefence.State == CAPM_DEF_STATE_START) then 
			local unitArray = GetArray(GetUnitListInArea( 0, "CenterOfCamp", 0 ));
			local b = 0;
			for i = 1, unitArray.n do
				if PlayerCanSee( 1, unitArray[i]) == 1 then
					b = 1;
					break;
				end;
			end;
			if b == 0 then
				CampDefence.State = CAPM_DEF_STATE_NORMAL;
			else
				if (GetGameTime() - CampDefence.Time > CAMP_DEF_DELTA_TIME) then
					for i = 1, JapanCampSquads.n do
						QCmd(ACT_LEAVE, JapanCampSquads[i].SquadScriptID, 
							JapanCampSquads[i].BuildingScriptID);
						QCmd(ACT_SWARM, JapanCampSquads[i].SquadScriptID, 
							CAMP_DEF_DISPERSION, 
							CampDefence.Pos.x, CampDefence.Pos.y );
					end;
					CampDefence.Time = GetGameTime();
					CampDefence.State = CAPM_DEF_STATE_ATTACK;
				end;
			end;
		end;
		if CampDefence.State == CAPM_DEF_STATE_NORMAL then
			local unitArray = GetArray(GetUnitListInArea( 0, "CenterOfCamp", 0 ));
			for i = 1, unitArray.n do
				if PlayerCanSee( 1, unitArray[i]) == 1 then
						CampDefence.State = CAPM_DEF_STATE_START;
						CampDefence.Time = GetGameTime();
						CampDefence.Pos.x, CampDefence.Pos.y = ObjectGetCoord(unitArray[i]);
						CampDefence.State = CAPM_DEF_STATE_START;
						break;
				end;
			end;
		end;
	end;
end;

function DefenceOfBeach()
	while 1 do
		Wait(1);
		if (BeachDefence.State == BEACH_DEF_STATE_ATTACK) then 
			if (GetGameTime() - BeachDefence.Time > BEACH_DEF_ATTACK_TIME) then
				BeachDefence.State = BEACH_DEF_STATE_NORMAL;
				for i = 1, JapanBeachSquads.n do
					UnitCmd(ACT_ENTER, GetObjectList(JapanBeachSquads[i].SquadScriptID), 
						JapanBeachSquads[i].BuildingID);
				end;
			end;
		end;
		if (BeachDefence.State == BEACH_DEF_STATE_START) then 
			local unitArray = GetArray(GetUnitListInArea( 0, "CenterOfBeach", 0 ));
			local b = 0;
			for i = 1, unitArray.n do
				if PlayerCanSee( 1, unitArray[i]) == 1 then
					b = 1;
					break;
				end;
			end;
			if b == 0 then
				BeachDefence.State = BEACH_DEF_STATE_NORMAL;
			else
				if (GetGameTime() - BeachDefence.Time > BEACH_DEF_DELTA_TIME) then
					BeachDefence.State = BEACH_DEF_STATE_START_ATTACK;
				end;
			end;
		end;
		if BeachDefence.State == BEACH_DEF_STATE_START_ATTACK then
			for i = 1, JapanBeachSquads.n do
				UnitQCmd(ACT_LEAVE, GetObjectList(JapanBeachSquads[i].SquadScriptID), 
					JapanBeachSquads[i].BuildingID);
				UnitQCmd(ACT_SWARM, GetObjectList(JapanBeachSquads[i].SquadScriptID), 
					BEACH_DEF_DISPERSION, 
					BeachDefence.Pos.x, BeachDefence.Pos.y );
			end;
			BeachDefence.Time = GetGameTime();
			BeachDefence.State = BEACH_DEF_STATE_ATTACK;
		end;
		if BeachDefence.State == BEACH_DEF_STATE_NORMAL then
			local unitArray = GetArray(GetUnitListInArea( 0, "CenterOfBeach", 0 ));
			for i = 1, unitArray.n do
				if PlayerCanSee( 1, unitArray[i]) == 1 then
						BeachDefence.State = BEACH_DEF_STATE_START;
						BeachDefence.Time = GetGameTime();
						BeachDefence.Pos.x, BeachDefence.Pos.y = ObjectGetCoord(unitArray[i]);
						BeachDefence.State = BEACH_DEF_STATE_START;
						break;
				end;
			end;
		end;
	end;
end;

function BatteryCounterAttack()
	while 1 do
		Wait(1);
		if (Battery.State == BATTERY_STATE_CAPTURED) and 
			(GetGameTime() - Battery.Time > BATTERY_DELTA_TIME ) then
			for i = 1, JapanCampSquads.n do
				QCmd(ACT_LEAVE, JapanCampSquads[i].SquadScriptID, 
					JapanCampSquads[i].BuildingScriptID);
				QCmd(ACT_SWARM, JapanCampSquads[i].SquadScriptID, 
					CAMP_DEF_DISPERSION, 
					CampDefence.Pos.x, CampDefence.Pos.y );
			end;
			Battery.State = BATTERY_STATE_ATTACK;
		end;
	end;
end;

function TestObjectives()
	while 1 do
		Wait(1);
		if Objectives.State == OBJ_STATE_START then
			Wait(5);
			ObjectiveChanged(0, 1);
			Objectives.State = OBJ_STATE_1;
		end;
		if Objectives.State == OBJ_STATE_1 then
			if Battery.State == BATTERY_STATE_CAPTURED then
				ObjectiveChanged(0, 2);
				ObjectiveChanged(1, 1);
				DamageScriptObject(DESC_POINTER_01_SCRIPT_ID, 100);
				DamageScriptObject(DESC_POINTER_02_SCRIPT_ID, -50);
				Objectives.State = OBJ_STATE_2; 
			end;
		end;
		if Objectives.State == OBJ_STATE_2 then
			if CountJapanBoats == 0 then
				ObjectiveChanged(1, 2);
				DamageScriptObject(DESC_POINTER_02_SCRIPT_ID, 100);
				Objectives.State = OBJ_STATE_WIN;
			end;
		end;
		if Objectives.State ~= OBJ_STATE_FAIL then
			if GetReinforcementCallsLeft( 0 ) == 0 then
				if GetNUnitsInPartyUF( 0 ) == 0 then
					ObjectiveChanged(0, 3);
					ObjectiveChanged(1, 3);
--					DamageScriptObject(DESC_POINTER_01_SCRIPT_ID, 100);
--					DamageScriptObject(DESC_POINTER_02_SCRIPT_ID, 100);
					Objectives.State = OBJ_STATE_FAIL;
				end;
			end;
		end;
	end;
end;

function NextBeachGuardPoint()
	if BeachGuard.Dir == BEACH_GUARD_DIR_FORWARD then
		if BeachGuard.LastPoint < BeachGuardPoints.n then
			BeachGuard.LastPoint = BeachGuard.LastPoint + 1;
		else
			BeachGuard.Dir = BEACH_GUARD_DIR_BACK;
			return 1;
		end;
	end;
	if BeachGuard.Dir == BEACH_GUARD_DIR_BACK then
		if BeachGuard.LastPoint > 1 then
			BeachGuard.LastPoint = BeachGuard.LastPoint - 1;
		else
			BeachGuard.Dir = BEACH_GUARD_DIR_FORWARD;
			return 1;
		end;
	end;
end;

function BeachGuardMoving()
	Wait(BEACH_GUARD_BEFORE_START);
	while 1 do
		Wait(1);
		local id = GetObjectList(BeachGuard.ScriptID);
		if IsAlive(id) == 0 then
			return 0;
		end;
		if BeachGuard.State == BEACH_GUARD_STATE_NORMAL then
			NextBeachGuardPoint();
			local area = BeachGuardPoints[BeachGuard.LastPoint];
			local x, y, d = GetScriptAreaParams(area); 
			Cmd( ACT_MOVE, BeachGuard.ScriptID, 0, x, y )
			local time = GetGameTime();
			while IsUnitInArea( 0, area, GetObjectList(id)) ~= 1 do
				Wait(0.3);
				if GetUnitState( id ) == STATE_REST then
					break;
				end;
				if PlayerCanSee( 0, id) == 1 then
					Wait(2);
					x, y, d = GetScriptAreaParams("CenterOfBeach")
					BeachGuard.State = BEACH_GUARD_STATE_ALARM;
					Cmd( ACT_MOVE, BeachGuard.ScriptID, 0, x, y )
					break;
				end;
			end;
		end;
		if BeachGuard.State == BEACH_GUARD_STATE_ALARM then
			local area = "CenterOfBeach";
			local x, y, d = GetScriptAreaParams(area)
			Cmd( ACT_MOVE, BeachGuard.ScriptID, 0, x, y )
			while IsUnitInArea( 0, area, GetObjectList(id)) ~= 1 do
				Wait(0.3);
				if GetUnitState( id ) == STATE_REST then
					break;
				end;
			end;
			BeachDefence.State = BEACH_DEF_STATE_START_ATTACK;
			Wait(BEACH_GUARD_ALARM_TIME);
			BeachGuard.State = BEACH_GUARD_STATE_NORMAL; 
		end;
	end;
end;

function CaptureJapanTank()
	while 1 do
		Wait(1);
		if IsSomeUnitInArea( 0, "Japan_Tank_For_Capture", 0) == 1 then
			ChangePlayer( GetObjectList(TANK_FOR_CAPTURE), 0 );
			ObjectiveChanged(2, 1);
			Wait(1);
			ObjectiveChanged(2, 0);
			break;
		end; 
	end;
end;

function CallRecon()
	while 1 do
		Wait(1);
		if Battery.State == BATTERY_STATE_CAPTURED then
			local id = GetObjectList(RECON_SCRIPT_ID);
			if (id == nil) or (IsAlive( id ) == 0) then
				RECON_SCRIPT_ID = RECON_SCRIPT_ID + 1;
				LandReinforcementFromMap(2, "Recon", 1, RECON_SCRIPT_ID);
			end;
		end;
	end;
end;

Init();
CallStartReinforcment();

StartThread( StartDisposition );
StartThread( TestGuns );
StartThread( TestWinFail );
StartThread( DefenceOfCamp );
StartThread( DefenceOfBeach );
--StartThread( BatteryCounterAttack );
StartThread( TestObjectives );
StartThread( BeachGuardMoving );
StartThread( CaptureJapanTank );
StartThread( CallRecon );