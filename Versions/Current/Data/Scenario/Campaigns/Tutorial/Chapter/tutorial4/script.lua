__tutorial_blink_buttons = 1;
lastcommand = 0;
art = {};
ammosum = 0;
sniper_id = 9000;
glob = 0;

actions = { ACT_LOAD, ACT_UNLOAD, ACT_ENTER, ACT_LEAVE, ACT_PARADE, 77, 64, ACT_PLACE_MINE; n = 8 };
buttons = { 4, 5, 4, 5, 11, 44, 21, 18 };

function StartObjective( func, param1, param2 )
	proto = function( )
	while 1 do
		Wait( 1 );
		if ( %func( %param1, %param2 ) ~= nil ) then
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

function WaitWhileAlive( player, sid )
	while ( IsSomeBodyAlive( player, sid ) == 1 ) do
		Wait( 2 );
	end;
end;

function meta_sid_check( checkfunc )
	return function( sid, checkparam, notcheck )
		local units = GetObjectListArray( sid )
		for i = 1, units.n do
			if ( %checkfunc( units[i] ) == checkparam ) then
				if notcheck ~= nil then
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

--[[
--]]

OldIsSomeBodyAlive = IsSomeBodyAlive;

function IsSomeBodyAlive( ... )
local res = 0;
local player = 0;
	if ( arg.n == 1 ) then
		while ( IsPlayerPresent( player ) == 1 ) and ( res == 0 ) do
			if OldIsSomeBodyAlive( player, arg[1] ) > 0 then
				res = 1;
			end;
			player = player + 1;
		end;
	else
		res = OldIsSomeBodyAlive( arg[1], arg[2] );
	end;
	return res;
end;

IsScriptUnitImmobilized = meta_sid_check( IsImmobilized );
IsScriptUnitHPs = meta_sid_check( GetObjectHPs );
IsScriptUnitState = meta_sid_check( GetUnitState );

function StartUnitsLoss1()
	while ( GetObjectiveState( 3 ) ~= 2 ) do
		Wait( 2 );
		if ( IsSomeBodyAlive( 1 ) == 0 ) then
			LandReinforcementFromMap( 0, "inf", 0, 1 );
		end;
	end;
end;

function StartUnitsLoss2()
	while ( GetObjectiveState( 1 ) ~= 2 ) do
		Wait( 2 );
		if ( IsSomeBodyAlive( 2 ) == 0 ) then
			LandReinforcementFromMap( 0, "truck", 0, 2 );
		end;
	end;
end;

function EGuns()
	while ( GetObjectiveState( 11 ) ~= 2 ) do
		Wait( 2 );
		if ( IsSomeBodyAlive( 10 ) == 0 ) then
			LandReinforcementFromMap( 0, "gun", 1, 10 );
		end;
	end;
end;

function Objective0() -- load to truck
	--if ( IsScriptUnitState( 1, STATE_REST_TRANSPORT ) == 1 ) then
	local nSquads = NumUnitsAliveInArray (GetArray(GetObjectList(1)));
	local tracks = GetArray(GetObjectList( 2 ))
	local aliveTrack = nil;
	for i = 1, tracks.n do 
		if IsAlive(tracks[i]) == 1 then
			aliveTrack = tracks[i];
		end;
	end;
	if ( GetPassangersArray( aliveTrack, 0 ).n == nSquads ) then
		BlinkActionButton( 4, 0 ); -- load
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjectiveTutorial( 15 );
		StartObjective( Objective15 );
		--DamageScriptObject( 555, 10 );
		return 1;
	end;
end;

function Objective15() -- move truck
	if ( IsSomeUnitInArea( 0, "truck", 0 ) == 1 ) then
		CompleteObjective( 15 );
		--DamageScriptObject( 555, 0 );
		Wait( 3 );
		GiveObjectiveTutorial( 1 );
		BlinkActionButton( 5, 1 ); -- unload
		StartObjective( Objective1 );
		return 1;
	end;
end;

function Objective1() -- unload infantry
	--if ( IsScriptUnitState( 1, STATE_REST_TRANSPORT, 1 ) == 1 ) then
	if ( GetPassangersArray( GetObjectList( 2 ), 0 ).n == 0 ) then
		BlinkActionButton( 5, 0 ); -- unload	
		CompleteObjective( 1 );
		ChangePlayerForScriptGroup( 2, 3 );
		Cmd( ACT_MOVE, 2, 100, "start" );
		QCmd( ACT_DISAPPEAR, 2 );
		Wait( 3 );
		GiveObjectiveTutorial( 2 );
		BlinkActionButton( 4, 1 ); -- enter
		StartObjective( Objective2 );
		return 1;
	end;
end;

function Objective2() -- enter building
	--if ( IsScriptUnitState( 1, STATE_REST_BUILDING ) == 1 ) then
	if ( GetPassangersArray( GetObjectList( 3 ), 0 ).n == GetNUnitsInScriptGroup( 1 ) ) then
		BlinkActionButton( 4, 0 ); -- enter
		CompleteObjective( 2 );
		Wait( 2 );
		LandReinforcementFromMap( 1, "inf", 0, 101 );
		Cmd( ACT_SWARM, 101, 100, GetScriptObjCoord( 3 ) );
		WaitWhileAlive( 1, 101 );
		GiveObjectiveTutorial( 3 );
		BlinkActionButton( 5, 1 ); -- leave
		StartObjective( Objective3 );
		return 1;
	end;
end;

function CallInf( pt, obj )
	if ( IsSomeBodyAlive( 0, 1 ) == 0 ) then
		LandReinforcementFromMap( 0, "inf", pt, 1 );
		if ( ObjectiveState( obj ) == 2 ) then
			return 1;
		end;
	end;
end;

function Objective3() -- leave building 
--	if ( IsScriptUnitState( 1, STATE_REST_BUILDING, 1 ) == 1 ) then
--	if ( GetSquadInfo( 1 ) == 3 ) then
	if ( GetPassangersArray( GetObjectList( 3 ), 0 ).n == 0 ) then
		BlinkActionButton( 5, 0 ); -- leave
		CompleteObjective( 3 );
		ChangePlayerForScriptGroup( 10, 1 );
		Cmd( ACT_SUPPRESS, 10, 0, "fire" );
		Wait( 3 );
		GiveObjectiveTutorial( 4 );
		BlinkActionButton( 11, 1 ); -- formation
		--DamageScriptObject( 301, 10 );
		StartObjective( Objective4 );
		StartObjective( CallInf, 3, 4 );
		return 1;
	end;
end;

function Objective4() -- switch to defensive formation and move to the junction
	if ( IsSomeUnitInArea( 0, "junction" ) == 1 ) then
		--DamageScriptObject( 301, 0 );
		CompleteObjective( 4 );
		Cmd( ACT_STOP, 10 );
		ChangePlayerForScriptGroup( 10, 3 );
		Wait( 3 );
		for i = 0, 4 do
			ObjectiveChanged( i, 0 );
		end;
		ObjectiveChanged( 15, 0 );
		
		GiveObjectiveTutorial( 5 );
		BlinkActionButton( 11, 1 ); -- formation
		StartObjective( Objective5 );
		StartObjective( CallInf, 4, 6 );
		return 1;
	end;
end;

function _Objective5() -- switch to aggressive formation
	if ( GetSquadInfo( 1 ) == 2 ) then
		CompleteObjective( 5 );
		Wait( 3 );
		GiveObjectiveTutorial( 6 );
		StartObjective( Objective6 );
		return 1;
	end;
end;

function Objective5() -- switch to aggressive formation and swarm to area
	if ( IsSomeBodyAlive( 1, 11 ) == 0 ) then
		CompleteObjective( 5 );
		Wait( 3 );
		GiveObjectiveTutorial( 6 );
		StartObjective( Objective6 );
		ViewZone( "building", 1 );
		return 1;
	end;
end;

function CallSniper()
local inf = GetUnitsByParamScriptId( sniper_id, PT_TYPE, TYPE_INF );
local car;
	if ( inf.n == 0 ) then
		sniper_id = sniper_id + 1;
		LandReinforcementFromMap( 0, "sniper", 0, sniper_id );
		car = GetUnitsByParamScriptId( sniper_id, PT_TYPE, TYPE_MECH )[1];
		ChangePlayer( car, 2 );
		UnitCmd( ACT_MOVE, car, 0, "p1" );
		UnitQCmd( ACT_MOVE, car, 0, "p2" );
		UnitQCmd( ACT_UNLOAD, car, 0, "p3" );
		UnitQCmd( ACT_MOVE, car, 0, "start" );
		UnitQCmd( ACT_DISAPPEAR, car );
		if (glob == 0 ) then
			Wait( 2 );
			SCRunTime( "cam", "cam2", 8, 2, sniper_id );
			Wait( 8 );
			SCReset();
			glob = 1;
		end;
		--ChangePlayer( car, 2 );
	end;
end;

function Objective6() -- storm building
	if ( IsSomeBodyAlive( 1, 12 ) == 0 ) then
		ViewZone( "building", 0 );
		CompleteObjective( 6 );
		Wait( 3 );
		--CallSniper( );
		StartObjective( CallSniper );
		Wait( 10 );
		--WaitForGroupAtArea( 1001, "p3" );
		ChangePlayerForScriptGroup( 10, 1 );
		GiveObjectiveTutorial( 7 );
		BlinkActionButton( 44, 1 ); -- camouflage
		StartObjective( Objective7 );
		--StartObjective( CallSniper );
		return 1;
	end;
end;

function Objective7() -- sniper's camouflage
	if ( lastcommand == 77 ) then
		Wait( 5 )
		CompleteObjective( 7 );
		Wait( 3 );
		for i = 5, 7 do
			ObjectiveChanged( i, 0 );
		end;
		Cmd( ACT_SWARM, 1122, 0, "zzz" );
		QCmd( ACT_DISAPPEAR, 1122 );
		GiveObjectiveTutorial( 8 );
		StartObjective( Objective8 );
		--DamageScriptObject( 556, 10 );
		return 1;
	end;
end;

function Objective8() -- sneak into area
	if ( IsSomeUnitInArea( 0, "defence", 0 ) == 1 ) then
		CompleteObjective( 8 );
		--DamageScriptObject( 556, 0 );
		Wait( 3 );
		GiveObjectiveTutorial( 9 );
		StartObjective( Objective9 );
		--DamageScriptObject( 557, 10 );
		return 1;
	end;
end;

function Objective9() -- paradrop
local elites = GetUnitsByParam( GetUnitListInAreaArray( 0, "artillery", 0 ), PT_CLASS, CLASS_SPECIAL_SQUAD );
	--if ( (GetNUnitsInArea( 0, "artillery", 1 ) - GetNUnitsInArea( 0, "artillery", 0 )) > 0 ) then
		if ( elites.n > 0 ) then
		Wait( 3 );
		--DamageScriptObject( 557, 0 );
		CompleteObjective( 9 );
		WaitWhileAlive( 1, 10 );
		GiveObjectiveTutorial( 10 );
		StartObjective( Objective10 );
		return 1;
	end;
end;

function Objective10() -- capture artillery
	if ( IsSomeBodyAlive( 0, 10 ) == 1 ) then
		Wait( 5 );
		CompleteObjective( 10 );
		Wait( 6 );
		GiveObjectiveTutorial( 11 );
		StartObjective( Objective11 );
		return 1;
	end;
end;

function Objective11() -- destroy tank using artillery and sniper
	if ( IsSomeBodyAlive( 1, 14 ) == 0 ) then
		CompleteObjective( 11 );
		--LandReinforcementFromMap( 0, "eng", 1, 2000 );
		Wait( 3 );
		for i = 8, 11 do
			ObjectiveChanged( i, 0 );
		end;
		GiveObjectiveTutorial( 12 );
		BlinkActionButton( 21, 1 ); -- dig trenches
		StartObjective( Objective12 );
		--DamageScriptObject( 302, 10 );
		return 1;
	end;
end;

function Objective12() -- call inf and dig trenches
	if ( GetNTrenchesInScriptArea ( "defence" ) > 1 ) then
		--DamageScriptObject( 302, 0 );
		BlinkActionButton( 21, 0 ); -- dig trenches
		CompleteObjective( 12 );
		Wait( 3 );
		GiveObjectiveTutorial( 13 );
		BlinkActionButton( 18, 1 ); -- lay mines
		StartObjective( Objective13 );
		--DamageScriptObject( 303, 10 );
		return 1;
	end;
end;

function Objective13() -- place mines
	if ( GetNMinesInScriptArea ( "mines" ) > 5 ) then
		BlinkActionButton( 18, 0 ); -- lay mines
		--DamageScriptObject( 303, 0 );
		CompleteObjective( 13 );
		Wait( 3 );
		GiveObjectiveTutorial( 14 );
		StartObjective( Objective14 );
		LandReinforcementFromMap( 1, "attack", 1, 102 );
		inf = GetUnitsByParamScriptId( 102, PT_TYPE, TYPE_INF )[1];
		mech = GetUnitsByParamScriptId( 102, PT_TYPE, TYPE_MECH )[1];
		UnitCmd( ACT_FOLLOW, mech, inf );
		UnitCmd( ACT_SWARM, inf, 100, "defence" );
		return 1;
	end;
end;

function Objective14() -- repell attack
	if ( IsSomeBodyAlive ( 1, 102 ) == 0 ) then
		CompleteObjective( 14 );
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

o = { 555, 556, 557, 301, 302, 303 };
for i = 1, 6 do
	DamageScriptObject( o[i], 0 );
end;
-----------------------------------
--EnablePlayerReinforcement( RT_TANKS, 0 );
--EnablePlayerReinforcement( RT_BOMBERS, 0 );
ChangePlayerForScriptGroup( 10, 3 );
SetCheatDifficultyLevel( 0 );
--God( 0, 1 );
SetIGlobalVar( "temp.nogeneral_sript", 1 );
Wait( 4 );
--DamageScriptObject( 301, 10 );
GiveObjectiveTutorial( 0 );
BlinkActionButton( 4, 1 ); -- load
StartObjective( Objective0 );
StartThread( StartUnitsLoss1 );
StartThread( StartUnitsLoss2 );
StartThread( EGuns );