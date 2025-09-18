__tutorial_blink_buttons = 1
tanks = {};
tanks[1] = GetObjectList( 1 );
tanks.n = 1;
tanks.concat = function( array )
	tanks = ConcatArray( tanks, array );
end;
lastcommand = 0;

function StartObjective( func )
	proto = function( )
	while 1 do
		Wait( 1 );
		if ( %func() ~= nil ) then 
			break;
		end;
	end;
	end;
	StartThread( proto );
end;

function GiveObjectiveTutorial( obj )
	GiveObjective( obj );
	GameMesage( "show_objectives", 0, 0 );	
end;

function TankLoss()
	while ( GetObjectiveState( 3 ) ~= 2 ) do
		Wait( 2 );
		if ( IsSomeBodyAlive( 0, 1 ) == 0 ) then
			LandReinforcementFromMap( 0, "onetank", 0, 1 );
			tanks[1] = GetObjectList( 1 );
		end;
	end;
end;

function Objective0()
	while 1 do
		Wait( 1 );
		if (GetIGlobalVar("Mission.Current.ObjectiveShown",0) == 0) then
			break;
		end;
	end;
end;

function Objective1()
	if ( GetIGlobalVar( "temp.TutorialOnly.SelectedUnits", 0 ) >= 1 ) then
		CompleteObjective( 1 );
		Wait( 3 );
		GiveObjectiveTutorial( 2 );
		--DamageScriptObject( 302, 10 );
		StartObjective( Objective2 );
		return 1;
	end;
end;

function Objective2()
	if ( IsSomeUnitInArea( 0, "obj2" ) == 1 ) then
		--DamageScriptObject( 302, 0 );
		CompleteObjective( 2 );
		Cmd( ACT_STOP, 1 );
		Wait( 3 );
		GiveObjectiveTutorial( 3 );
		--DamageScriptObject( 303, 10 );
		StartObjective( Objective3 );		
		return 1;
	end;
end;

function Objective3()
	if ( IsSomeUnitInArea( 0, "obj3" ) == 1) then
		--DamageScriptObject( 303, 0 );
		CompleteObjective( 3 );
		Cmd( ACT_STOP, 1 );
		Wait( 1 );
		--StartThread( Objective4 );
		GiveObjectiveTutorial( 10 );
		StartObjective( Objective10 );
		return 1;
	end;
end;

function Objective4()
	--ChangePlayerForScriptGroup( 2, 0 );
	--Cmd( ACT_MOVE, 2, 0, GetScriptAreaParams( "p1" ) );
	--QCmd( ACT_MOVE, 2, 0, GetScriptAreaParams( "p2" ) );
	--QCmd( ACT_MOVE, 2, 0, GetScriptAreaParams( "obj3" ) );
	--Wait( 10 );
	GiveObjectiveTutorial( 4 );
	while 1 do
		Wait( 1 );
		if ( GetIGlobalVar( "temp.TutorialOnly.SelectedUnits", 0 ) > 1 ) then
			break;
		end;
	end;
	CompleteObjective( 4 );
	Wait( 3 );
	GiveObjectiveTutorial( 5 );
	StartObjective( Objective5 );
	--DamageScriptObject( 305, 10 );
end;

function stopem()
	CmdArray( ACT_STOP, tanks );
end;

function Objective5()
	if ( IsSomeUnitInArea( 0, "obj5" ) == 1 ) then
		--DamageScriptObject( 305, 0 );
		CompleteObjective( 5 );
		stopem();
		Wait( 3 );
		for i = 0, 4 do
			ObjectiveChanged( i, 0 );
		end;
		GiveObjectiveTutorial( 6 );
		--DamageScriptObject( 306, 10 );
		StartObjective( Objective6 );		
		return 1;
	end;
end;

function check_escape()
	if ( PlayerCanSee( 0, GetObjectList( 10 ) ) == 1 ) then
		Sleep( Random( 10 ) );
		Cmd( ACT_MOVE, 10, 0, "a1" );
		for i = 2, 4 do
			QCmd( ACT_MOVE, 10, 0, "a" .. i );
		end;
		return 1;
	end;
end;

function Objective6()
	if ( IsSomeUnitInArea( 0, "obj6" ) == 1 ) then
		--DamageScriptObject( 306, 0 );
		CompleteObjective( 6 );
		stopem();
		Wait( 3 );
		lastcommand = 0;
		GiveObjectiveTutorial( 7 );
		StartObjective( Objective7 );
		StartObjective( check_escape );
		return 1;
	end;
end;

function CheckSwarm()
	if ( lastcommand == ACT_SWARM ) then
		BlinkActionButton( 2, 0 ); -- "attack" user action
		return 1;
	end;
end;

function Objective7()
	if ( IsSomeBodyAlive( 1, 10 ) == 0 ) then
		CompleteObjective( 7 );
		stopem();
		Wait( 3 );
		GiveObjectiveTutorial( 8 );
		BlinkActionButton( 2, 1 ); -- "attack" user action
		StartCycled( CheckSwarm );
		--StartObjective( FictiveObjective0 );		
		LandReinforcementFromMap( 1, "prey", 0, 11 );
		Cmd( ACT_STAND, 11 );
		Wait( 1 );
		StartObjective( Objective8 );
		return 1;
	end;
end;

function GetScriptUnitState( sid )
local state = GetUnitState( GetObjectList( sid ) );
	return state;
end;

function FictiveObjective0()
	for i = 1, tanks.n do
	if GetUnitState( tanks[i] ) == STATE_SWARM then
		LandReinforcementFromMap( 1, "prey", 0, 11 );
		Wait( 1 );
		StartObjective( Objective8 );
		return 1;
	end;
	end;
end;

function Objective8()
	if ( IsSomeBodyAlive( 1, 11 ) == 0 ) then
		BlinkActionButton( 2, 0 ); -- "swarm" user action
		CompleteObjective( 8 );
		Wait( 3 );
		lastcommand = 0;
		GiveObjectiveTutorial( 9 );
		BlinkActionButton( 39, 1 ); -- "stop" user action
		--StartThread( FictiveObjective1 );
		StartObjective( Objective9 );
		return 1;
	end;
end;

function FictiveObjective1()
	for i = 1, tanks.n do
		if GetUnitState( tanks[i] ) == STATE_REST then
			Cmd( ACT_MOVE, 1, GetScriptAreaParams( "obj6" ) );
			Cmd( ACT_MOVE, 2, GetScriptAreaParams( "obj6" ) );
			break;
		end;
	end;
	Wait( 1 );
	StartObjective( Objective9 );
end;

function Objective9()
	--for i = 1, tanks.n do
	--	if GetUnitState( tanks[i] ) ~= STATE_REST then
	--		return
	--	end;
	--end;
	if ( lastcommand == ACT_STOP ) then
		BlinkActionButton( 39, 0 ); -- "stop" user action
		CompleteObjective( 9 );
		Wait( 3 );
		for i = 5, 7 do
			ObjectiveChanged( i, 0 );
		end;
	--EnablePlayerReinforcement( RT_TANKS, 1 );
	--GiveObjectiveTutorial( 10 );
	--StartObjective( Objective10 );
	
		GiveObjectiveTutorial( 12 );
		StartObjective( Objective11 );
	--DamageScriptObject( 311, 10 );
		return 1;
	end;
end;

function Objective10()
--	if ( ( GetNUnitsInArea( 0, "reinf", 0 ) - GetNScriptUnitsInArea( 1, "reinf" ) - GetNScriptUnitsInArea( 2, "reinf" ) ) > 0 ) then
	if ( ( GetNUnitsInArea( 0, "reinf", 0 ) - GetNScriptUnitsInArea( 1, "reinf" ) ) > 0 ) then
		CompleteObjective( 10 );
		tanks.concat( DeleteElement( GetUnitListInAreaArray( 0, "reinf", 0 ), tanks[1] ) );
		Wait( 3 );
		--GiveObjectiveTutorial( 11 );
		--DamageScriptObject( 311, 10 );
		--StartObjective( Objective11 );
		
		StartThread( Objective4 );
		return 1;
	end;
end;

function Objective11()
	if ( IsSomeUnitInArea( 0, "obj11" ) == 1 ) then
		--DamageScriptObject( 311, 0 );
		CompleteObjective( 12 );
		Wait( 3 );
		GiveObjectiveTutorial( 11 );
		StartObjective( Objective12 );		
		return 1;
	end;
end;

function Objective12()
	if ( IsSomeUnitInArea( 0, "obj12" ) == 1 ) then
		CompleteObjective( 11 );
		Wait( 3 );
		--EnablePlayerReinforcement( RT_BOMBERS, 1 );
		GiveObjectiveTutorial( 13 );
		StartObjective( Objective13 );
		return 1;
	end;
end;

function Objective13()
	if ( IsSomeBodyAlive( 1, 12 ) == 0 ) then
		CompleteObjective( 13 );
		Wait( 3 );
		Win( 0 );		
		return 1;
	end;
end;

function OnRegisteredCommand( nCommand )
	lastcommand = nCommand;
end;

RegisterCommandObserver( ACT_STOP );
RegisterCommandObserver( ACT_SWARM );

RT_TANKS = 9;
RT_BOMBERS = 14;

o = { 302, 303, 305, 306, 311 };
for i = 1, 5 do
	DamageScriptObject( o[i], 0 );
end;
-----------------------------------
--EnablePlayerReinforcement( RT_TANKS, 0 );
--EnablePlayerReinforcement( RT_BOMBERS, 0 );
SetCheatDifficultyLevel( 0 );
SetIGlobalVar( "temp.nogeneral_sript", 1 );
Wait( 4 );
GiveObjectiveTutorial( 1 );
StartThread( TankLoss );
StartObjective( Objective1 );