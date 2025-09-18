erebus_calmed = 0;
missionend = 0;
--MINES1 = GetNMinesInScriptArea( "mines1" );
--MINES2 = GetNMinesInScriptArea( "mines2" );
--MINES3 = GetNMinesInScriptArea( "mines3" );
--MINES4 = GetNMinesInScriptArea( "mines4" );
--TOTAL_MINES = MINES1 + MINES2 + MINES3 + MINES4;

function Obj1()
	Wait( 2 );
	StartThread( Lose );
	StartThread( Win1 );
	ObjectiveChanged( 0, 1 );
end;

function Lose()
    while 1 do
        if ( IsSomePlayerUnit( 0 ) < 1 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
			ObjectiveChanged( 0, 3 );
			missionend = 1;
			Wait( 2 );
			Win( 1 );
			return 1;
		end;
		Wait(2);
	end;
end;

function Win1()
    while 1 do
        if ( IsSomeUnitInArea( 1, "village", 0 ) < 3 ) and ( IsSomeUnitInArea( 0, "village", 0 ) > 0 ) then
			ObjectiveChanged( 0, 2 );
			missionend = 1;
			Wait( 3 );
			Win( 0 );
			return 1;
		end;
		Wait(2);
	end;
end;

function erebus1()
    Wait( 5 );
	Cmd( ACT_SUPPRESS, 10, 256, GetScriptAreaParams( "fire1" ) );
	Wait( 25 );
	Cmd( ACT_STOP, 10 );
	Wait( 30 );
	Cmd( ACT_SUPPRESS, 10, 256, GetScriptAreaParams( "fire2" ) );
    Wait( 25 );
	Cmd( ACT_STOP, 10 );
    Trigger( player_in_village, erebus2 );
    
--	StartThread( ReinfInf, 7900, 2 );
	
    Wait( 20 );
	StartThread( erebus_rampage ); 
end;

function player_in_village()
	if ( ( IsSomeUnitInArea( 0, "nearvillage1", 0 ) + IsSomeUnitInArea( 0, "nearvillage2", 0 ) ) > 0 ) then
		return 1;
	end;
end;

function erebus_rampage()
	while ( GetNAmmo( 10 ) > 50 ) and ( erebus_calmed == 0 ) do
	if ( erebus_calmed == 0 ) then
		Cmd( ACT_SUPPRESS, 10, 256, Random( 6000 ) + 1000, Random( 4000 ) + 3000 );
		Wait( 20 );
	end;
	if ( erebus_calmed == 0 ) then
		Cmd( ACT_STOP, 10 );
		Wait( 25 );
    end;
	end;
end;

function erebus2()
	erebus_calmed = 1;
	StartThread( ReinfInfManager3 );
	Cmd( ACT_SUPPRESS, 10, 256, GetScriptAreaParams( "fire3" ) );
	Wait( 20 );
	Cmd( ACT_SUPPRESS, 10, 256, GetScriptAreaParams( "fire4" ) );
    Wait( 20 );
	Cmd( ACT_SUPPRESS, 10, 256, GetScriptAreaParams( "fire5" ) );
    Wait( 20 );
	Cmd( ACT_STOP, 10 );
end;

function gap()
local i = 8000;
local j = 9000;
	while ( missionend == 0 ) do
		i = i + 1;
		LandReinforcementFromMap( 2, "3", RandomInt( 2 ), i );
		Cmd( ACT_SWARM, i, 100, GetScriptAreaParams( "bomb" .. ( Random( 2 ) * 2 ) ) );
		Wait( 2 + Random( 2 ) );
		LandReinforcementFromMap( 1, "0", 0, j );
		Cmd( ACT_SWARM, j, 100, GetScriptAreaParams( "bomb" .. ( Random( 2 ) * 2 ) ) );
		Wait( 120 + Random( 20 ) );
	end;
end;

function bombers()
	Wait( 10 + Random( 5 ) );
	
	for i = 1, 2 do
		LandReinforcementFromMap( 2, "0", 1, 300 + i );
		Cmd( ACT_MOVE, 300 + i, 100, GetScriptAreaParams( "bomb" .. i ) );
		Wait( 15 + Random( 10 ) );
	end;
		
	Wait( 20 );
	
	for i = 3, 4 do
		LandReinforcementFromMap( 2, "0", 0, 300 + i );
		Cmd( ACT_MOVE, 300 + i, 100, GetScriptAreaParams( "bomb" .. i ) );
		Wait( 30 + Random( 10 ) );
	end;

	for i = 5, 6 do
		LandReinforcementFromMap( 2, "0", 1, 300 + i );
		Cmd( ACT_MOVE, 300 + i, 100, GetScriptAreaParams( "bomb" .. i ) );
		Wait( 30 + Random( 10 ) );
	end;

	Wait( 15 );
	
	StartThread( gap );
end;

function CheckReinfs()
	if ( GetNMinesInScriptArea( "mines1" ) + 
		GetNMinesInScriptArea( "mines2" ) + 
		GetNMinesInScriptArea( "mines3" ) +
		GetNMinesInScriptArea( "mines4" ) < TOTAL_MINES ) then
		return 1;
	end;
end;

function EngReinf()
local area = "mines";
	for i = 1, 4 do
		if ( GetNMinesInScriptArea( area .. i ) < MINES1 ) then
			area = area .. i;
			break;
		end;
	end;
	Wait( 5 );
--	CallReinforcement( 2, 18, 2, 911, GetScriptAreaParams( area ) );
	LandReinforcementFromMap( 2, "1", 2, 911 );
	Cmd( ACT_UNLOAD, 911, 200, GetScriptAreaParams( area ) );
	Wait( 30 );
	ChangePlayerForScriptGroup( 911, 0 );
--	Cmd( ACT_UNLOAD, 911, 200, GetScriptAreaParams( area ) );
end;

function ReinfInf( sid, pt )
local units = {};
local boat = {};
local inf = {};
local x, y, x1, y1;
	LandReinforcementFromMap( 2, "2", pt + 1, sid );

	units = GetObjectListArray( sid );
	boat = GetUnitsByParam( units, PT_TYPE, TYPE_MECH );
	x, y = ObjectGetCoord( boat[1] );
	inf = GetUnitsByParam( units, PT_TYPE, TYPE_INF );
	Cmd( ACT_UNLOAD, sid, 200, GetScriptAreaParams( "land".. pt ) );
	while ( GetPassangersArray( boat[1], 2 ).n > 0 ) do
		Wait( 2 );
	end;

	ChangePlayerForArray( inf, 0 );
	ChangeFormation( sid, 2 );
	
	x1, y1 = GetObjCoordMedium( inf );
	for i = 1, inf.n do
		UnitCmd( ACT_MOVE, inf[i], 0, x1 + (i - 2) * 96, y1 );
	end;
	
	UnitCmd( ACT_MOVE, boat[1], 0, x, y );
	UnitQCmd( ACT_DISAPPEAR, boat[1] );
end;

function ReinfInfManager()
	for i = 1, 6 do
		StartThread( ReinfInf, 7500 + i, i );
	end;
end;

function ReinfUsaInf( sid )
local units = {};
local boat = {};
local inf = {};
local x, y, x1, y1;
	LandReinforcementFromMap( 2, "usa_inf", 6, sid );
	units = GetObjectListArray( sid );
	boat = GetUnitsByParam( units, PT_TYPE, TYPE_MECH );
	x, y = ObjectGetCoord( boat[1] );
	inf = GetUnitsByParam( units, PT_TYPE, TYPE_INF );
	Cmd( ACT_UNLOAD, sid, 200, GetScriptAreaParams( "land5" ) );
	
	while ( GetPassangersArray( boat[1], 2 ).n > 0 ) do
		Wait( 2 );
	end;
	
	Wait( 1 );
	
	CmdArrayDisp( ACT_SWARM, inf, 100, GetScriptAreaParams( "nearvillage2" ) );
	QCmdArrayDisp( ACT_SWARM, inf, 100, GetScriptAreaParams( "village" ) );
	UnitCmd( ACT_MOVE, boat[1], 0, x, y );
	UnitQCmd( ACT_DISAPPEAR, boat[1] );
end;

function ReinfInfManager2()
local i = 5000;
	while missionend == 0 do
		Wait( 180 + Random( 20 ) );
		StartThread( ReinfUsaInf, i );
		i = i + 1;
	end;
end;

function ReinfGerInf( sid )
	LandReinforcementFromMap( 1, "ger_inf", 0, sid );
	Cmd( ACT_SWARM, sid, 500, GetScriptAreaParams( "village" ) );
end;

function ReinfInfManager3()
local i = 4000;
	while missionend == 0 do
		Wait( 5 + Random( 5 ) );
		StartThread( ReinfGerInf, i );
		i = i + 1;
		Wait( 150 + Random( 20 ) );
	end;
end;

StartThread( Obj1 );
StartThread( erebus1 );
--StartThread( FlagManager, 1 );
StartThread( bombers );
Wait( 5 );
StartThread( ReinfInfManager );
StartThread( ReinfInfManager2 );
--Trigger( CheckReinfs, EngReinf );