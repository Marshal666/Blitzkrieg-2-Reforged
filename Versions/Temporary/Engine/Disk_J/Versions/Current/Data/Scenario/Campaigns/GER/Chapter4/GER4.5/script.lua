missionend = 0;
DefPos = { {1, 1}, {1, 1} };
__difficulty = GetDifficultyLevel();

function Descent()
local passanger;
local k = 0;
	LandReinforcementFromMap( 1, "usa_inf", 1, 10 );
	local inf = GetObjectListArray( 10 );
	local transport = GetObjectListArray( 1 );
	Wait( 2 );
	ChangeFormation( 10, 3 );
	Wait( 1 );
	UnitCmd( ACT_LOAD_NOW, inf[1], transport[1] );
	UnitCmd( ACT_LOAD_NOW, inf[2], transport[2] );
	while k < 2 do
		k = 0;
		for i = 1, transport.n do
			if GetPassangers( transport[i], 2 ) then
				k = k + 1;
			end;
		end;
		Wait( 3 );
	end;
	Wait( 3 );
	Cmd( ACT_UNLOAD, 1, 50, GetScriptAreaParams( "descent" ) );
	Wait( 1 );
	WaitWhileStateArray( inf, STATE_IN_TRANSPORT );
	Cmd( ACT_SWARM, 10, 100, GetScriptObjCoord( 502 ) );
	local x, y = GetScriptObjCoordMedium( 1 );	
	StartThread( Boat, x, y );
end;

function Boat( x, y )
	while 1 do
		Wait( 2 );
		if ( IsSomeUnitInArea( 0, x, y, 200, 0 ) > 0 ) and 
		   ( IsSomeUnitInArea( 1, x, y, 200, 0 ) == 0 ) then
			ChangePlayerForScriptGroup( 1, 0 );
			break;
		end;
	end;
end;

function Objective0()
	if ( GetNUnitsInScriptGroup( 501, 0 ) == 1 ) then
		CompleteObjective( 0 );
		return 1;
	end;
end;

function Attack( id, pt )
local Reinfs_Enemy = { "comb1", "comb2", "comb3" };
local Reinfs_Enemy_Easy = { "comb1", "comb2e", "comb3e" };
local hp_sum = 0;
local p_pt = "p" .. pt .. "_";
local def_pt = "def" .. pt .. "_";
	Wait( 5 + Random( 10 ) );
	if oldGetDifficultyLevel() == 3 then -- if easy difficulty
		Reinforcement = Reinfs_Enemy_Easy[ Random( 3 ) ];
	else
		Reinforcement = Reinfs_Enemy[ Random( 3 ) ];
	end;
	LandReinforcementFromMap( 1, Reinforcement, pt, id );
	Wait( 2 );
	
	local units = GetObjectListArray( id );
	for i = 1, units.n do
		hp_sum = hp_sum + GetObjectHPs( units[i] );
	end;
	local hp = hp_sum;
	
	Cmd( ACT_SWARM, id, 500, p_pt .. 1 );
	for i = 2, 5 do
		QCmd( ACT_SWARM, id, 500, p_pt .. i );
	end;
	while ( hp > ( hp_sum / 2.0 ) ) do
		Wait( 1 );
		hp = 0;
		for i = 1, units.n do
			local _hp = GetObjectHPs( units[i] );
			if ( _hp > 0 ) then
				hp = hp + _hp;
			end;
		end;  
	end;
	local centrepos_x, centrepos_y = GetScriptObjCoordMedium( id );
	if ( DefPos[pt+1][1] + DefPos[pt+1][2] > 0 ) then
		if ( DefPos[pt+1][2] == 1 ) then
			RetreatGroup( units, GetScriptAreaParams( def_pt .. 1 ) );
			j = 3;
		elseif ( DefPos[pt+1][1] == 1 ) then
			RetreatGroup( units, GetScriptAreaParams( def_pt .. 0 ) );
			j = 2;
		end;
		QCmd( ACT_ROTATE, id, 200, centrepos_x, centrepos_y );
		QCmd( ACT_ENTRENCH, id, 1 );
		Wait( 60 + Random( 10 ) );
		if ( GetNUnitsInScriptGroup( id ) > 0 ) then
			Cmd( ACT_SWARM, id, 500, GetScriptAreaParams( p_pt .. j ) );
			for i = j + 1, 4 do
				QCmd( ACT_SWARM, id, 500, GetScriptAreaParams( p_pt .. i ) );
			end;
			QCmd( ACT_ROTATE, id, 500, GetScriptAreaParams( p_pt .. 5 ) );
			QCmd( ACT_ENTRENCH, id, 1 );
		end;
	end;
end;

function StartAttacks()
local RecycleTime = 200 - __difficulty * 25;
local RecycleTimeRandom = 20;
local id = 8000;
	while ( missionend == 0 ) do
		id = id + 1;
		StartThread( Attack, id, 0 );
		id = id + 1;
		StartThread( Attack, id, 1 );
		Wait( RecycleTime + Random( RecycleTimeRandom ) );
	end;
end;

function TruckRush( id )
	LandReinforcementFromMap( 1, "ass_inf", 0, id );
	local inf = GetUnitsByParamScriptId( id, PT_TYPE, TYPE_INF );
	local trucks = GetUnitsByParamScriptId( id, PT_TYPE, TYPE_MECH );
	CmdArray( ACT_MOVE, trucks, "truck1" );
	for i = 2, 4 do
		QCmdArray( ACT_MOVE, trucks, "truck" .. i );
	end;
	QCmdArrayDisp( ACT_UNLOAD, trucks, 500, "unload" );
	Wait( 1 );
	WaitWhileStateArray( inf, STATE_IN_TRANSPORT );
	Wait( 1 );
	ChangeFormation( id, 3 );
	Cmd( ACT_SWARM, id, 500, "ass_inf" );
	CmdArray( ACT_MOVE, trucks, 2000, 9000 );
	QCmdArray( ACT_DISAPPEAR, trucks );
end;

function InfAttackManager()
local id = 2000;
	while missionend == 0 do
		Wait( 200 + Random( 120 ) );
		id = id + 1;
		StartThread( TruckRush, id );
	end;
end;

function DefPosManager()
local cnt;
	while missionend == 0 do
		Wait( 3 );
		cnt = 0;
		for i = 0, 1 do
		for j = 0, 1 do
			if ( IsSomeBodyAlive( 1, 5000 + i * 10 + j ) == 0 ) then
				DefPos[i+1][j+1] = 0;
				cnt = cnt + 1;
			end;
		end;
		end;
		if ( cnt == 4 ) then
			break;
		end;
	end;
end;

----------------------------------
Objectives = { Objective0 };
Objectives_Count = 1;

StartAllObjectives( Objectives, Objectives_Count );

SetIGlobalVar( "temp.general_reinforcement", 0 );
Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( StartAttacks );
StartThread( InfAttackManager );
StartThread( DefPosManager );
Wait( 60 + Random( 60 ) );
StartThread( Descent );
--Trigger( CheckSupport, ArtillerySupport );