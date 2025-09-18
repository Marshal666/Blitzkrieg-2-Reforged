function Init()
	MAIN_PLAYER_TANK_SCRIPT_ID = 1;
	
	POINTER_01_SCRIPT_ID = 11;
	POINTER_02_SCRIPT_ID = 12;
	
	OBJ_STATE_START = 0;
	OBJ_STATE_1 = 1;
	OBJ_STATE_2 = 2;
	OBJ_STATE_WIN = 3;
	OBJ_STATE_LOOSE = 4;
	Objectives = {};
	Objectives.State = OBJ_STATE_START;
	
	
	GER_EAST_SQUADS_START = 0;
	GER_EAST_SQUADS_WAIT_1 = 1;
	GER_EAST_SQUADS_WAVE_1 = 2;
	GER_EAST_SQUADS_WAVE_2 = 3;
	GER_EAST_SQUADS_WIN = 4;
	GER_EAST_SQUADS_LOOSE = 5;
	
	GER_EAST_SQUADS_WAIT_1_DELTA = 15;
	GER_EAST_SQUADS_WAIT_2_DELTA = 20;
	GER_EAST_SQUADS_WAIT_3_DELTA = 50;
	
	GerEastGroup = {};
	GerEastGroup.State = GER_EAST_SQUADS_START;
	GerEastGroup.Time = GetGameTime();
	
	EastAttackRoute_01 = {};
	EastAttackRoute_01.n = 5;
	EastAttackRoute_01[1] = "GER_E_SQ_01_01";
	EastAttackRoute_01[2] = "GER_E_SQ_01_02";
	EastAttackRoute_01[3] = "GER_E_SQ_01_03";
	EastAttackRoute_01[4] = "GER_E_SQ_01_04";
	EastAttackRoute_01[5] = "GER_E_SQ_01_05";
	
	EastAttackRoute_02 = {};
	EastAttackRoute_02.n = 5;
	EastAttackRoute_02[1] = "GER_E_SQ_02_01";
	EastAttackRoute_02[2] = "GER_E_SQ_02_02";
	EastAttackRoute_02[3] = "GER_E_SQ_02_03";
	EastAttackRoute_02[4] = "GER_E_SQ_02_04";
	EastAttackRoute_02[5] = "GER_E_SQ_02_05";
	
	WEST_ATTACK_STATE_NONE = 0;
	WEST_ATTACK_STATE_START = 1;
	WestEnemyReinf = {};
	WestEnemyReinf.State = WEST_ATTACK_STATE_NONE;
	WestEnemyReinf.Time = GetGameTime();
	WestEnemyReinf.CurrentWave = 0;
	
	AddWestEnemyWave(130, "main_squad");
	AddWestEnemyWave(5, "main_squad");
	
	AddWestEnemyWave(45, "main_squad");
	AddWestEnemyWave(20, "pz_ii_ausf_g_3", "WEST_02_01");
	
	AddWestEnemyWave(45, "pz_ii_ausf_g_3", "WEST_01_01");
	AddWestEnemyWave(5, "pz_ii_ausf_g_3", "WEST_02_01");
	
	AddWestEnemyWave(45, "main_squad");
	AddWestEnemyWave(20, "pz_ii_ausf_g_3", "WEST_01_01");
	AddWestEnemyWave(5, "pz_ii_ausf_g_3", "WEST_02_01");
	
	AddWestEnemyWave(45, "main_squad");
	AddWestEnemyWave(20, "pz_vi_tiger_ausf_a_h_1", "WEST_02_01");

	AddWestEnemyWave(45, "pz_vi_tiger_ausf_a_h_1", "WEST_01_01");
	AddWestEnemyWave(5, "pz_vi_tiger_ausf_a_h_1", "WEST_02_01");
	
	local nLevel = GetDifficultyLevel();
	
	if nLevel > DLEVEL_EASY then
		AddWestEnemyWave(45, "main_squad");
		AddWestEnemyWave(20, "pz_vi_tiger_ausf_a_h_2", "WEST_01_01");
		AddWestEnemyWave(5, "pz_vi_tiger_ausf_a_h_2", "WEST_02_01");
		
		if nLevel > DLEVEL_NORMAL then
			AddWestEnemyWave(45, "main_squad");
			AddWestEnemyWave(20, "pz_vi_tiger_ausf_a_h_2", "WEST_01_01");
			AddWestEnemyWave(5, "pz_vi_tiger_ausf_a_h_2", "WEST_02_01");
			AddWestEnemyWave(5, "pz_vi_tiger_ausf_a_h_2", "WEST_01_01");
			AddWestEnemyWave(5, "pz_vi_tiger_ausf_a_h_2", "WEST_02_01");
		end;
	end;

	ENEMY_WAVE_SCRIPT_ID = 1001;
	
	ENGINEER_SCRIPT_ID = 2001;
	EngineerId = 0;
	
	RECON_STATE_OFF = 0;
	RECON_STATE_STARTING = 1;
	RECON_STATE_ON = 2;
	RECON_WAITING = 90;
	Recon = {};
	Recon.Time = 0;
	Recon.State = RECON_STATE_OFF;
	
	RECON_SCRIPT_ID = 2002;
	
	EAST_ALLY_STATE_NONE = 0;
	EAST_ALLY_STATE_START = 1;
	EastAlly = {};
	EastAlly.n = 0;
	EastAlly.State = EAST_ALLY_STATE_NONE;
	EAST_ALLY_SCRIPT_ID = 3001;
end;

function AddWestEnemyWave(fWaitBefore, sName, sPoint)
	if WestEnemyReinf.Waves == nil then
		WestEnemyReinf.Waves = {};
		WestEnemyReinf.Waves.n = 0;
	end;
	WestEnemyReinf.Waves.n = WestEnemyReinf.Waves.n + 1;
	WestEnemyReinf.Waves[WestEnemyReinf.Waves.n] = {};
	WestEnemyReinf.Waves[WestEnemyReinf.Waves.n].WaitBefore = fWaitBefore;
	WestEnemyReinf.Waves[WestEnemyReinf.Waves.n].ReinfName = sName;
	WestEnemyReinf.Waves[WestEnemyReinf.Waves.n].ScriptID = -1;
	WestEnemyReinf.Waves[WestEnemyReinf.Waves.n].Point = "";
	if sPoint ~= nil then
		WestEnemyReinf.Waves[WestEnemyReinf.Waves.n].Point = sPoint;
	end;
end;

function Start()
end;

function StartWave1()
	local x, y, h;
	x, y, h = GetScriptAreaParams(EastAttackRoute_01[1]);
	Cmd(ACT_MOVE, 101, h, x, y);
	Cmd(ACT_MOVE, 102, h, x, y);
	Cmd(ACT_MOVE, 103, h, x, y);
	x, y, h = GetScriptAreaParams(EastAttackRoute_02[1]);
	Cmd(ACT_MOVE, 111, h, x, y);
	Cmd(ACT_MOVE, 112, h, x, y);
	Cmd(ACT_MOVE, 113, h, x, y);
	for i = 2, EastAttackRoute_01.n do
		x, y, h = GetScriptAreaParams(EastAttackRoute_01[i]);
		QCmd(ACT_SWARM, 101, h, x, y);
		QCmd(ACT_SWARM, 102, h, x, y);
		QCmd(ACT_SWARM, 103, h, x, y);
	end;
	for i = 2, EastAttackRoute_02.n do
		x, y, h = GetScriptAreaParams(EastAttackRoute_02[i]);
		QCmd(ACT_SWARM, 111, h, x, y);
		QCmd(ACT_SWARM, 112, h, x, y);
		QCmd(ACT_SWARM, 113, h, x, y);
	end;
end;

function StartWave2()
	local x, y, h;
	x, y, h = GetScriptAreaParams(EastAttackRoute_01[1]);
	Cmd(ACT_MOVE, 121, h, x, y);
	Cmd(ACT_MOVE, 122, h, x, y);
	Cmd(ACT_MOVE, 151, h, x, y);
	x, y, h = GetScriptAreaParams(EastAttackRoute_02[1]);
	Cmd(ACT_MOVE, 131, h, x, y);
	Cmd(ACT_MOVE, 132, h, x, y);
	Cmd(ACT_MOVE, 161, h, x, y);
	for i = 2, EastAttackRoute_01.n do
		x, y, h = GetScriptAreaParams(EastAttackRoute_01[i]);
		QCmd(ACT_SWARM, 121, h, x, y);
		QCmd(ACT_SWARM, 122, h, x, y);
		QCmd(ACT_SWARM, 151, h, x, y);
	end;
	for i = 2, EastAttackRoute_02.n do
		x, y, h = GetScriptAreaParams(EastAttackRoute_02[i]);
		QCmd(ACT_SWARM, 131, h, x, y);
		QCmd(ACT_SWARM, 132, h, x, y);
		QCmd(ACT_SWARM, 161, h, x, y);
	end;
end;

function AttackEastVillage()
	while 1 do
		Wait(1);
		if GerEastGroup.State == GER_EAST_SQUADS_START then
			GerEastGroup.Time = GetGameTime();
			GerEastGroup.State = GER_EAST_SQUADS_WAIT_1;
		end;
		if GerEastGroup.State == GER_EAST_SQUADS_WAIT_1 and 
			GetGameTime() > GerEastGroup.Time + GER_EAST_SQUADS_WAIT_1_DELTA then
			GerEastGroup.State = GER_EAST_SQUADS_WAVE_1;
			GerEastGroup.Time = GetGameTime();
			StartWave1();
		end;
		if GerEastGroup.State == GER_EAST_SQUADS_WAVE_1 and 
			GetGameTime() > GerEastGroup.Time + GER_EAST_SQUADS_WAIT_2_DELTA then
			GerEastGroup.State = GER_EAST_SQUADS_WAVE_2;
			GerEastGroup.Time = GetGameTime();
			StartWave2();
		end;
	end;
end;

function TestGerEastGroup()
	while 1 do
		Wait(1);
		if GerEastGroup.State == GER_EAST_SQUADS_WAVE_2 then
			if GetGameTime() > GerEastGroup.Time + GER_EAST_SQUADS_WAIT_3_DELTA then
				if GetNUnitsInArea( 1, "EAST_VILLAGE", 0) > 0 then
					if GetNUnitsInArea( 0, "EAST_VILLAGE", 0) == 0 then
						GerEastGroup.State = GER_EAST_SQUADS_WIN;
					end;
				else
					GerEastGroup.State = GER_EAST_SQUADS_LOOSE;
				end;
			end;
		end;
	end;
end;

function TestWinLooseCondition()
	while 1 do
		Wait(1);
		if (GerEastGroup.State == GER_EAST_SQUADS_WIN) or (Objectives.State == OBJ_STATE_LOOSE) then
			Wait(10);
			Win(1);
			break;
		end;
		if Objectives.State == OBJ_STATE_WIN then
			Wait(10);
			Win(0);
		end;
	end;
end;

function IsLastWaveDestroyed()
	if WestEnemyReinf.CurrentWave > WestEnemyReinf.Waves.n then
		local hasAlive = 0;
		for i = 1, WestEnemyReinf.Waves.n do
			local enemies = GetArray(GetObjectList(WestEnemyReinf.Waves[i].ScrtiptID));
			for j = 1, enemies.n do
				if IsAlive(enemies[j]) == 1 then
					hasAlive = 1;
					break;
				end;
			end;
		end;
		if hasAlive == 0 then
			return 1;
		end;
	end;
	return 0;
end;

function TestObjectives()
	while 1 do
		Wait(1);
		if Objectives.State == OBJ_STATE_START then
			Wait(2);
			ObjectiveChanged(0, 1);
--			DamageScriptObject(POINTER_01_SCRIPT_ID, 10);
			Objectives.State = OBJ_STATE_1;
		end;
		if Objectives.State == OBJ_STATE_1 then
			if GerEastGroup.State == GER_EAST_SQUADS_LOOSE then
				ObjectiveChanged(0, 2);
				ObjectiveChanged(1, 1);
--				DamageScriptObject(POINTER_01_SCRIPT_ID, 100);
--				DamageScriptObject(POINTER_02_SCRIPT_ID, 10);
				Objectives.State = OBJ_STATE_2; 
			end;
		end;
		if Objectives.State == OBJ_STATE_2 then
			if IsLastWaveDestroyed() == 1 then
				ObjectiveChanged(1, 2);
--				DamageScriptObject(POINTER_02_SCRIPT_ID, 100);
				Objectives.State = OBJ_STATE_WIN;
			end;
		end;
		if Objectives.State ~= OBJ_STATE_WIN then
			if (GetReinforcementCallsLeft( 0 ) == 0 and GetNUnitsInPartyUF( 0 ) == 0) or
				(IsWestVillageCaptured() == 1) then
				ObjectiveChanged(0, 3);
				ObjectiveChanged(1, 3);
--				DamageScriptObject(POINTER_01_SCRIPT_ID, 100);
--				DamageScriptObject(POINTER_02_SCRIPT_ID, 100);
				Objectives.State = OBJ_STATE_LOOSE;
			end;
		end;
	end;
end;

function IsWestVillageCaptured()
	if Objectives.State == OBJ_STATE_2 then
		if GetNUnitsInArea( 1, "WEST_VILLAGE", 0) > 0 then
			if (GetNUnitsInArea( 0, "WEST_VILLAGE", 0) == 0) and 
				(GetNUnitsInArea( 2, "WEST_VILLAGE", 0) == 0) then
				return 1;
			end;
		end;
	end;
	return 0;
end;

function ProcessWestEnemyReinf()
	while 1 do
		Wait(1);
		if GerEastGroup.State == GER_EAST_SQUADS_WAVE_2 and 
			WestEnemyReinf.State == WEST_ATTACK_STATE_NONE then
			WestEnemyReinf.State = WEST_ATTACK_STATE_START;
			WestEnemyReinf.CurrentWave = 1;
			WestEnemyReinf.Time = GetGameTime();
		end;
		if WestEnemyReinf.State == WEST_ATTACK_STATE_START and 
			WestEnemyReinf.CurrentWave <= WestEnemyReinf.Waves.n then
			if GetGameTime() >= WestEnemyReinf.Time + WestEnemyReinf.Waves[WestEnemyReinf.CurrentWave].WaitBefore then
				ENEMY_WAVE_SCRIPT_ID = ENEMY_WAVE_SCRIPT_ID + 1;
				WestEnemyReinf.Waves[WestEnemyReinf.CurrentWave].ScrtiptID = ENEMY_WAVE_SCRIPT_ID;
				LandReinforcementFromMap(1, WestEnemyReinf.Waves[WestEnemyReinf.CurrentWave].ReinfName, 
					0, WestEnemyReinf.Waves[WestEnemyReinf.CurrentWave].ScrtiptID);
				local x, y, h;
				local startPoint = WestEnemyReinf.Waves[WestEnemyReinf.CurrentWave].Point;
				if startPoint ~= "" then
					x, y, h = GetScriptAreaParams(startPoint);
					Cmd(ACT_MOVE, WestEnemyReinf.Waves[WestEnemyReinf.CurrentWave].ScrtiptID, h, x, y);
				end;
				x, y, h = GetScriptAreaParams("WEST_ENEMY_ATTACK_GOAL");
				QCmd(ACT_SWARM, WestEnemyReinf.Waves[WestEnemyReinf.CurrentWave].ScrtiptID, h, x, y);
				WestEnemyReinf.Time = GetGameTime();
				WestEnemyReinf.CurrentWave = WestEnemyReinf.CurrentWave + 1;
			end;
		end;
	end;
end;

function RespawnEngineer()
	while 1 do
		Wait(1);
		if IsAlive(EngineerId) ~= 1 then
			local nReinfPoint = 0;
			if Objectives.State == OBJ_STATE_2 then
				nReinfPoint = 1;
			end;
			LandReinforcementFromMap( 0, 'engineer', nReinfPoint, 
				ENGINEER_SCRIPT_ID );
			local array = GetArray(GetObjectList(ENGINEER_SCRIPT_ID));
			if array.n > 0 then
				EngineerId = array[array.n];
			else
				EngineerId = 0;
			end;
		end;
	end;
end;

function ProcessRecon()
	while 1 do
		Wait(1);
		if Recon.State == RECON_STATE_OFF then
			if GerEastGroup.State == GER_EAST_SQUADS_WAVE_2 then
				Recon.Time = GetGameTime();
				Recon.State = RECON_STATE_STARTING;

			end;
		end;
		if Recon.State == RECON_STATE_STARTING then
			if GetGameTime() > Recon.Time + RECON_WAITING then
				LandReinforcementFromMap(2, "recon", 0, RECON_SCRIPT_ID);
				local x, y, h = GetScriptAreaParams("RECON_01");
				Cmd(ACT_PATROL, RECON_SCRIPT_ID, h, x, y);
				x, y, h = GetScriptAreaParams("RECON_02");
				QCmd(ACT_PATROL, RECON_SCRIPT_ID, h, x, y);
				Recon.State = RECON_STATE_ON;
			end;
		end;
	end;
end;

function ProcessEastAlly()
	while 1 do
		Wait(1);
		if (Objectives.State == OBJ_STATE_2) and (EastAlly.State == EAST_ALLY_STATE_NONE) then
			EastAlly.n = EastAlly.n + 1;
			EastAlly[1] = {};
			EastAlly[1].ScriptID = EAST_ALLY_SCRIPT_ID;
			LandReinforcementFromMap(2, "tank_heavy", 1, EastAlly[1].ScriptID);
			local x, y, h;
			
			x, y, h = GetScriptAreaParams("EAST_ALLY_01");
			Cmd(ACT_MOVE, EastAlly[1].ScriptID, h, x, y);
			QCmd(ACT_STAND, EastAlly[1].ScriptID);
			
			Wait(5);

			EastAlly.n = EastAlly.n + 1;
			EastAlly[2] = {};
			EastAlly[2].ScriptID = EAST_ALLY_SCRIPT_ID + 1;
			LandReinforcementFromMap(2, "tank_heavy", 1, EastAlly[2].ScriptID);
			x, y, h = GetScriptAreaParams("EAST_ALLY_02");
			Cmd(ACT_MOVE, EastAlly[2].ScriptID, h, x, y);
			QCmd(ACT_STAND, EastAlly[2].ScriptID);

			EastAlly.State = EAST_ALLY_STATE_START;
		end;
	end;
end;

Init();
Start();

StartThread(AttackEastVillage);
StartThread(TestObjectives);
StartThread(TestGerEastGroup);
StartThread(TestWinLooseCondition);
StartThread(ProcessWestEnemyReinf);
StartThread(RespawnEngineer);
StartThread(ProcessRecon);
StartThread(ProcessEastAlly);