__tutorial_blink_buttons = 1;
lastcommand = 0;
art = {};
ammosum = 0;
ammo_default = 0;

actions = { ACT_ROTATE, ACT_ENTRENCH, ACT_AMBUSH, ACT_ATTACH, ACT_DEPLOY, ACT_SUPPRESS, ACT_RESUPPLY; n = 7 };
buttons = { 6, 14, 10, 25, 26, 53, 23 };

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

function meta( ... )
	return function( x )
		value = x;
		for i = %arg.n, 1, -1 do
			value = %arg[ i ]( value );
		end;
		return value;
	end;
end;

function GetScriptUnitState( scriptid )
	obj = GetObjectListArray( scriptid );
	for i = 1, obj.n do
		if ( IsAlive( obj[i] ) == 1 ) then
			state = GetUnitState( obj[i] );
			return state;
		end;
	end;
end;

--GetScriptUnitState = meta( GetUnitState, GetObjectList );
IsScriptUnitImmobilized = meta( IsImmobilized, GetObjectList );
IsScriptUnitAlive = meta( IsAlive, GetObjectList );

function Gun()
	while ( GetObjectiveState( 4 ) ~= 2 ) do
		Wait( 1 );
		if ( IsSomeBodyAlive( 0, 1 ) == 0 ) then
			DamageScriptObject( 1, 0 );
			Sleep( 10 );
			LandReinforcementFromMap( 0, "gun", 1, 1 );
		end;
	end;
end;

function TruckAndAAGun()
	while ( GetObjectiveState( 6 ) ~= 2 ) do
		Wait( 1 );
		if ( IsSomeBodyAlive( 0, 2 ) == 0 ) then
			DamageScriptObject( 2, 0 );
			Sleep( 10 );
			LandReinforcementFromMap( 0, "aagun", 0, 2 );
		end;
		if ( IsSomeBodyAlive( 0, 3 ) == 0 ) then
			Sleep( 10 );
			LandReinforcementFromMap( 0, "truck", 2, 3 );
		end;
	end;
end;

function Objective0() -- move gun
	if ( IsSomeUnitInArea( 0, "gun1" ) == 1 ) then
		--DamageScriptObject( 301, 0 );
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjectiveTutorial( 1 );
		--DamageScriptObject( 302, 10 );
		BlinkActionButton( 6, 1 ); -- rotate
		StartObjective( Objective1 );
		return 1;
	end;
end;

function Objective1() -- rotate gun
	unit = GetUnitsByParam( GetObjectListArray( 1 ), PT_TYPE, TYPE_MECH );
	if ( unit.n > 0 ) then
	local angle = GetFrontDir( unit[1] );
	if ( angle < 4000 ) or ( angle > 61000 ) then
		--DamageScriptObject( 302, 0 );
		BlinkActionButton( 6, 0 ); -- rotate
		CompleteObjective( 1 );
		Wait( 3 );
		lastcommand = 0;
		GiveObjectiveTutorial( 2 );
		BlinkActionButton( 14, 1 ); -- entrench
		StartObjective( Objective2 );
		return 1;
	end;
	end;
end;

function Objective2() -- entrench gun
	if ( lastcommand == ACT_ENTRENCH ) then
		BlinkActionButton( 14, 0 ); -- entrench
		Wait( 5 );
		CompleteObjective( 2 );
		Wait( 3 );
		lastcommand = 0;
		GiveObjectiveTutorial( 3 );
		BlinkActionButton( 10, 1 ); -- ambush
		StartObjective( Objective3 );
		return 1;
	end;
end;

function Objective3() -- ambush
	if ( lastcommand == ACT_AMBUSH ) then
		BlinkActionButton( 10, 0 ); -- ambush
		Wait( 7 );
		CompleteObjective( 3 );
		Wait( 3 );
		GiveObjectiveTutorial( 4 );
		Cmd( ACT_SWARM, 10, 0, GetScriptAreaParams( "gun1" ) );
		StartObjective( Objective4 );
		return 1;
	end;
end;

function Objective4() -- destroy enemy
	if ( IsSomeBodyAlive( 1, 10 ) == 0 ) then
		CompleteObjective( 4 );
		Wait( 3 );
		SCRunTime( "cam", "art", 2 );
		Wait( 3 );
		SCReset();
		Wait( 1 );
		for i = 0, 4 do
			ObjectiveChanged( i, 0 );
		end;
		GiveObjectiveTutorial( 5 );
		BlinkActionButton( 25, 1 ); -- hitch gun
		StartObjective( Objective5 );
		return 1;
	end;
end;

function Objective5() -- transport gun
	if ( GetScriptUnitState( 2 ) == STATE_TOWED ) then
		BlinkActionButton( 25, 0 ); -- hitch gun
		CompleteObjective( 5 );
		Wait( 3 );
		GiveObjectiveTutorial( 6 );
		BlinkActionButton( 26, 1 ); -- deploy gun
		StartObjective( Objective6 );
		--DamageScriptObject( 555, 10 );
		Wait( 5 );
		LandReinforcementFromMap( 1, "recon", 0, 1001 );
		Cmd( ACT_MOVE, 1001, 0, GetScriptAreaParams( "gun1" ) );		
		return 1;
	end;
end;

function Objective6() -- deploy gun
	if ( GetNScriptUnitsInArea( 2, "aagun" ) > 0 ) and ( GetScriptUnitState( 2 ) ~= STATE_TOWED ) then
		BlinkActionButton( 26, 0 ); -- deploy gun
		CompleteObjective( 6 );
		--DamageScriptObject( 555, 0 );
		Wait( 3 );
		GiveObjectiveTutorial( 7 );
		StartObjective( Objective7 );
		return 1;
	end;
end;

function Objective7() -- destroy recon
	if ( IsSomeBodyAlive( 1, 1001 ) == 0 ) then
		CompleteObjective( 7 );
		Wait( 3 );
		GiveObjectiveTutorial( 8 );
		StartObjective( FictiveObjective0 );
		return 1;
	end;
end;

function FictiveObjective0() -- heavy artillery
art = GetUnitsByParam( GetUnitListInAreaArray( 0, "reinf", 0 ), PT_CLASS, CLASS_FIELD_ARTILLERY );
	if ( art.n > 0 ) then
		StartObjective( Objective8 );
		ammo_default = GetAmmo( art[1] );
		return 1;
	end;
end;

function Objective8() -- deploy artillery
	WaitWhileStateArray( art, STATE_TOWED );
	CompleteObjective( 8 );
	Wait( 3 );
	for i = 5, 8 do
		ObjectiveChanged( i, 0 );
	end;
	GiveObjectiveTutorial( 9 );
	StartObjective( Objective9 );
	return 1;
end;

function Objective9() -- group assignment
	Wait( 4 );
	CompleteObjective( 9 );
	Wait( 3 );
	GiveObjectiveTutorial( 10 );
	StartObjective( Objective10 );
	return 1;
end;

function Objective10() -- recon
	if ( IsSomeUnitInArea( 0, "recon", 1 ) == 1 ) then
		CompleteObjective( 10 );
		Wait( 3 );
		God( 0, 4 );
		GiveObjectiveTutorial( 11 );
		BlinkActionButton( 53, 1 ); -- suppress
		StartObjective( checkart );
		StartThread( checkkill );
		return 1;
	end;
end;

function checkkill()
local chk = { 0, 0, 0, 0};
local schk = 0;
	while 1 do
		Sleep( 10 );
		for i = 1, 4 do
			if ( chk[i] == 0 ) and ( IsSomeBodyAlive( 0, 7000 + i ) == 0 ) then
				DamageScriptObject( 1010 + i, 0 );
				chk[i] = 1;
				schk = schk + 1;
			end;
		end;
		if ( schk == 4 ) then
			break;
		end;
	end;
end;

function checkart() -- check to deploy enemy artillery
	if ( ( IsSomeBodyAlive( 1, 1011 ) + IsSomeBodyAlive( 1, 1012 ) + 
		IsSomeBodyAlive( 1, 1013 ) + IsSomeBodyAlive( 1, 1014 ) ) <= 3 ) then
		LandReinforcementFromMap( 1, "artillery", 1, 1002 );
		Cmd( ACT_SUPPRESS, 1002, 200, GetScriptAreaParams( "aagun" ) );
		Wait( 10 );
		StartThread( Objective11 );
		return 1;
	end;
end;

function Objective11() -- suppressive fire
	BlinkActionButton( 53, 0 ); -- suppress
	CompleteObjective( 11 );
	CmdArray( ACT_STOP, art );
	Wait( 3 );
	GiveObjectiveTutorial( 12 );
	StartObjective( Objective12 );
	Wait( 10 );
	ViewZone( "view_art", 1 );
	return 1;
end;

function Objective12() -- counter artillery
	if ( IsSomeBodyAlive( 1, 1002 ) == 0 ) then
		CompleteObjective( 12 );
		ViewZone( "view_art", 0 );
		CmdArray( ACT_STOP, art );
		Wait( 3 );
		lastcommand = 0;
--		for i = 1, art.n do
--			if ( IsAlive( art[i] ) == 1 ) then
--				ammosum = ammosum + GetAmmo( art[i] );
--			end;
--		end;		
		GiveObjectiveTutorial( 13 );
		BlinkActionButton( 23, 1 ); -- resupply
		StartObjective( Objective13 );
		return 1;
	end;
end;

function Objective13() -- resupply
--local newammosum = 0;
--	for i = 1, art.n do
--		newammosum = newammosum + GetAmmo( art[i] );
--	end;
--	if ( ( newammosum - ammosum ) >= 6 ) or ( newammosum == ammo_default *  ) then
local proceed = 1;
	for i = 1, art.n do
		if ( IsAlive( art[i] ) == 1 ) then
			if ( GetAmmo( art[i] ) < ammo_default ) then
				proceed = 0;
				break;
			end;
		end;
	end;
	
	if ( lastcommand == ACT_RESUPPLY ) or ( proceed == 1 ) then
		BlinkActionButton( 23, 0 ); -- resupply
		Wait( 5 );
		CompleteObjective( 13 );
		Wait( 3 );
		GiveObjectiveTutorial( 14 );
		StartObjective( Objective14 );
		ViewZone( "house", 1 );
		return 1;
	end;
end;

function Objective14() -- spg
	if ( IsSomeBodyAlive( 1, 15 ) ~= 1 ) then
		CompleteObjective( 14 );
		ViewZone( "house", 0 );
		Wait( 3 );
		Win( 0 );
		return 1;
	end;
end;

--
function OnRegisteredCommand( nCommand )
	lastcommand = nCommand;
	for i = 1, actions.n do
		if ( lastcommand == actions[ i ] ) then
			BlinkActionButton( buttons[ i ], 0 );
		end;
	end;
end;

for i = 1, actions.n do
	RegisterCommandObserver( actions[ i ] );
end;

RT_TANKS = 9;
RT_BOMBERS = 14;

o = { 555, 301, 302 };
for i = 1, 3 do
	DamageScriptObject( o[i], 0 );
end;
-----------------------------------
--EnablePlayerReinforcement( RT_TANKS, 0 );
--EnablePlayerReinforcement( RT_BOMBERS, 0 );
--Password( "Barbarossa" );
SetCheatDifficultyLevel( 0 );
God( 0, 1 );
StartThread( Gun );
StartThread( TruckAndAAGun );

SetIGlobalVar( "temp.nogeneral_sript", 1 );
Wait( 4 );
--DamageScriptObject( 301, 10 );
GiveObjectiveTutorial( 0 );
StartObjective( Objective0 );