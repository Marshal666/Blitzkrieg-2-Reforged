__tutorial_blink_buttons = 1;
lastcommand = 0;
allunits = {};
classunits = {};

actions = { ACT_ATTACK_UNIT, ACT_SWARM, ACT_STAND, ACT_ENTRENCH, ACT_AMBUSH, ACT_PATROL, ACT_DEMINE, ACT_REPAIR; n = 7 };
buttons = { 2, 2, 15, 14, 10, 59, 19, 22 };

function NewTanks()
	while 1 do
		allunits = GetUnitListOfPlayerArray( 0 );
		Sleep( 5 );
		classunits = GetSortedByClassUnits( allunits );
		Wait( 1 );
	end;
end;

function StartObjective( func )
	proto = function( )
	while 1 do
		Wait( 1 );
		--if ( %func() ~= nil ) then
		if %func() then
			break;
		end;
	end;
	end;
	StartThread( proto );
end;

function meta_sid_check( checkfunc )
	return function( sid, checkparam, any, notcheck )
		local units = GetObjectListArray( sid )
		for i = 1, units.n do
			if ( %checkfunc( units[i] ) == checkparam ) then
				if any ~= nil then
					return 1;
				elseif notcheck ~= nil then
					return 0;
				end;
			else
				if notcheck == nil then
					return 0;
				end;
			end;
		end;
		return 1;
	end;
end;

IsScriptUnitImmobilized = meta_sid_check( IsImmobilized );
IsScriptUnitHPs = meta_sid_check( GetObjectHPs );

function GiveObjectiveTutorial( obj )
	GiveObjective( obj );
	GameMesage( "show_objectives", 0, 0 );
end;

function GetScriptUnitState( sid )
local state = GetUnitState( GetObjectList( sid ) );
	return state;
end;

function Objective0()
	if ( IsSomeBodyAlive( 1, 10 ) == 0 ) then
		BlinkActionButton( 2, 0 ); -- "attack" user action
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjectiveTutorial( 1 );
		Cmd( ACT_SWARM, 11, 0, GetScriptAreaParams( "attack1" ) );
		StartObjective( Objective1 );
		return 1;
	end;
end;

function Objective1()
	if ( IsSomeBodyAlive( 1, 11 ) == 0 ) then
		CompleteObjective( 1 );
		Wait( 3 );
		GiveObjectiveTutorial( 2 );
		BlinkActionButton( 2, 1 ); -- "attack" user action
		StartObjective( Objective2 );
		return 1;
	end;
end;

function Objective2()
	if ( IsSomeBodyAlive( 3, 12 ) == 0 ) then
		BlinkActionButton( 2, 0 ); -- "attack" user action
		CompleteObjective( 2 );
		Wait( 3 );
		GiveObjectiveTutorial( 15 ); -- 2a
		--DamageScriptObject( 301, 10 );
		StartObjective( Objective15 );
		return 1;
	end;
end;

function Objective15()
	if ( IsSomeBodyAlive( 1, 510 ) == 0 ) then
		CompleteObjective( 15 );
		Wait( 3 );
		GiveObjectiveTutorial( 3 ); -- 2a
		--DamageScriptObject( 301, 10 );
		StartObjective( Objective3 );
		return 1;
	end;
end;

function Objective3()
	if ( IsSomeUnitInArea( 0, "prep2" ) == 1 ) then
		--DamageScriptObject( 301, 0 );
		CompleteObjective( 3 );
		Wait( 3 );
		lastcommand = 0;
		GiveObjectiveTutorial( 4 );
		BlinkActionButton( 15, 1 ); -- "stand ground" user action
		StartObjective( FictiveObjective0 );
		return 1;
	end;
end;

function FictiveObjective0() -- stand ground
	if ( lastcommand == ACT_STAND ) then
	--if ( IsStandGround( 1 ) == 1 ) and ( IsStandGround( 2 ) == 1 ) then
		Cmd( ACT_SWARM, 13, 0, GetScriptAreaParams( "attack2" ) );
		StartObjective( Objective4 );
		return 1;
	end;
end;

function Objective4()
	if ( IsSomeBodyAlive( 1, 13 ) == 0 ) then
		BlinkActionButton( 15, 0 ); -- "stand ground" user action
		CompleteObjective( 4 );
		Wait( 3 );
		for i = 0, 3 do
			ObjectiveChanged( i, 0 );
		end;
		ObjectiveChanged( 15, 0 );
		Sleep( 1 );
		lastcommand = 0;
		GiveObjectiveTutorial( 5 );
		BlinkActionButton( 14, 1 ); -- "entrench self" user action
		StartObjective( Objective5 );
		return 1;
	end;
end;

function Objective5() -- entrench
	if ( lastcommand == ACT_ENTRENCH ) then
		Wait( 5 );
	--if ( IsEntrenched( 1 ) == 1 ) and ( IsEntrenched( 2 ) == 1 ) then
		CompleteObjective( 5 );
		Wait( 3 );
		lastcommand = 0;
		GiveObjectiveTutorial( 6 );
		BlinkActionButton( 10, 1 ); -- "ambush" user action
		StartObjective( Objective6 );
		return 1;
	end;
end;

function Objective6() -- ambush
	if ( lastcommand == ACT_AMBUSH ) then
		Wait( 5 );
		CompleteObjective( 6 );
		Wait( 3 );
		GiveObjectiveTutorial( 7 );
		Cmd( ACT_SWARM, 14, 0, GetScriptAreaParams( "attack2" ) );
		StartObjective( Objective7 );
		return 1;
	end;
end;

function Objective7() -- fend off a tank attack
	if ( IsSomeBodyAlive( 1, 14 ) == 0 ) then
		CompleteObjective( 7 );
		Wait( 3 );
		lastcommand = 0;
		GiveObjectiveTutorial( 8 );
		BlinkActionButton( 59, 1 ); -- "patrol" user action
		StartObjective( Objective8 );
		return 1;
	end;
end;

function Objective8() -- patrol
	if ( lastcommand == ACT_PATROL ) then
		Wait( 4 );
		CompleteObjective( 8 );
		Wait( 3 );
		for i = 4, 8 do
			ObjectiveChanged( i, 0 );
		end;
		Sleep( 1 );
		GiveObjectiveTutorial( 9 );
		LandReinforcementFromMap( 1, "bomber", 0, 1001 );
		Cmd( ACT_MOVE, 1001, 0, GetScriptAreaParams( "attack2" ) );
		Wait( 1 );
		StartObjective( Objective9 );
		return 1;
	end;
end;

function engs()
	while ( GetObjectiveState( 12 ) ~= 2 ) do
		Wait( 1 );
		if ( IsSomeBodyAlive( 0, 911 ) == 0 ) then
			LandReinforcementFromMap( 0, "eng", 1, 911 );
			Cmd( ACT_MOVE, 911, 0, GetScriptAreaParams( "truck" ) );
		end;
	end;
end;

function Objective9() -- shoot down bomber
	if ( IsSomeBodyAlive( 1, 1001 ) == 0 ) then
		CompleteObjective( 9 );
		Wait( 3 );
		--God( 0, 4 );
		LandReinforcementFromMap( 2, "jeep", 0, 2005 );
		Cmd( ACT_MOVE, 2005, 20, "mines" );
		Wait( 5 );
		HP_MAX3 = GetObjectHPs( GetObjectList( 2005 ) );
		--LandReinforcementFromMap( 0, "eng", 1, 911 );
		GiveObjectiveTutorial( 10 );
		StartObjective( Objective10 );
		--DamageScriptObject( 555, 10 );
		Wait( 1 );
		--StartThread( engs );
		return 1;
	end;
end;

function Objective10() -- move to point
local forward = 0;
	for i = 1, classunits[ CLASS_LIGHT_TANK ].n do
		if ( IsAlive( classunits[ CLASS_LIGHT_TANK ][i] ) == 1 ) and ( IsImmobilized( classunits[ CLASS_LIGHT_TANK ][i] ) == 1 ) then
			forward = 1
		end;
	end;
	for i = 1, classunits[ CLASS_MEDIUM_TANK ].n do
		if ( IsAlive( classunits[ CLASS_MEDIUM_TANK ][i] ) == 1 ) and ( IsImmobilized( classunits[ CLASS_MEDIUM_TANK ][i] ) == 1 ) then
			forward = 1
		end;
	end;
	if ( IsScriptUnitImmobilized( 2005, 1, 1 ) == 1 ) or ( forward == 1 ) or 
		( ( IsSomeUnitInArea( 0, "mines", 0 ) == 1 ) and ( GetNMinesInScriptArea( "mines" ) == 0 ) ) then
		--DamageScriptObject( 555, 0 );
		--Cmd( ACT_STAND, 1 );
		--Cmd( ACT_STAND, 2 );
		CmdArray( ACT_STAND, classunits[ CLASS_LIGHT_TANK ] );
		CmdArray( ACT_STAND, classunits[ CLASS_MEDIUM_TANK ] );
		Cmd( ACT_STAND, 2005 );
		CompleteObjective( 10 );
		--Cmd( ACT_MOVE, 911, 0, GetScriptAreaParams( "truck" ) );
		Wait( 3 );
		GiveObjectiveTutorial( 11 );
		BlinkActionButton( 19, 1 ); -- "clear mines" user action
		StartObjective( Objective11 );
		return 1;
	end;
end;

function Objective11() -- demine
	if ( GetNMinesInScriptArea( "mines" ) == 0 ) then
		BlinkActionButton( 19, 0 ); -- "clear mines" user action
		CompleteObjective( 11 );
		Wait( 3 );
		GiveObjectiveTutorial( 12 );
		BlinkActionButton( 22, 1 ); -- "repair" user action
		StartObjective( Objective12 );
		return 1;
	end;
end;

function Objective12() -- repair
local allunits = GetUnitListOfPlayerArray( 0 );--GetUnitListInAreaArray( 0, "repunits", 0 );
local alliedallunits = GetUnitListOfPlayerArray( 2 );--GetUnitListInAreaArray( 2, "repunits", 0 );
local all = ConcatArray( allunits, alliedallunits );
local pcs = 1;
	for i = 1, all.n do
		if ( IsAlive( all[i] ) == 1) then
			local maxhp = GetUnitRPGStatsArray( all[i] ).MaxHP;
			if ( GetObjectHPs( all[i] ) < maxhp ) then
				pcs = 0;
				break;
			end;
		end;
	end;
	--if ( IsScriptUnitHPs( 2005, HP_MAX3 ) == 1 ) then
	if ( pcs == 1 ) then
		BlinkActionButton( 22, 0 ); -- "repair" user action
		ChangePlayerForScriptGroup( 2005, 0 );
		CompleteObjective( 12 );
		Wait( 3 );
		GiveObjectiveTutorial( 13 );
		StartObjective( Objective13 );
		return 1;
	end;
end;

function Objective13() -- tanks vs infantry
	if ( IsSomeBodyAlive( 1, 15 ) == 0 ) then
		CompleteObjective( 13 );
		Wait( 3 );
		GiveObjectiveTutorial( 14 );
		ChangePlayerForScriptGroup( 16, 1 );
		StartObjective( Objective14 );
		return 1;
	end;
end;

function Objective14() -- gap vs artillery
	if ( (IsSomeBodyAlive( 1, 16 ) + IsSomeBodyAlive( 1, 17 )) == 0 ) then
		CompleteObjective( 14 );
		Wait( 3 );
		Win( 0 );
		return 1;
	end;
end;

function KillBridges()
	while 1 do
		DamageScriptObject( 111, 0 );
		Wait( 5 );
	end;
end;

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

HP_MAX1 = GetScriptObjectHPs( 1 );
HP_MAX2 = GetScriptObjectHPs( 2 );
HP_MAX3 = 0;
RT_TANKS = 9;
RT_BOMBERS = 14;

o = { 555, 301 };
for i = 1, 2 do
	DamageScriptObject( o[i], 0 );
end;

-----------------------------------
--EnablePlayerReinforcement( RT_TANKS, 0 );
--EnablePlayerReinforcement( RT_BOMBERS, 0 );
SetCheatDifficultyLevel( 1 );
StartThread( NewTanks );
StartThread( KillBridges );
ChangePlayerForScriptGroup( 16, 3 );
--God( 0, 1 );
SetIGlobalVar( "temp.nogeneral_sript", 1 );
Wait( 4 );
GiveObjectiveTutorial( 0 );
BlinkActionButton( 2, 1 ); -- "attack" user action
StartObjective( Objective0 );