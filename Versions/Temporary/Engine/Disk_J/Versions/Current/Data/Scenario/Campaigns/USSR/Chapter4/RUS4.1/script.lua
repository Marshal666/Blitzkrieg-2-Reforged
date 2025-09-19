missionend = 0;
id = 2000;
OBJ_HIDDEN = 0;
OBJ_SHOWN = 1;
OBJ_GIVEN = OBJ_SHOWN;
OBJ_COMPLETE = 2;
OBJ_FAILED = 3;
__difficulty = GetDifficultyLevel();
__olddifficulty = oldGetDifficultyLevel();

function GetUnitsByParamSegmented( array, paramtype, param )
local sorted = {};
local stats = {};
local k = 0;
local delay = 1;
local cycles_per_segment = 10;
local cyc = 1;
	sorted.n = 0;
	for u = 1, array.n do
		if ( IsAlive( array[u] ) > 0 ) then
			stats = GetArray( GetUnitRPGStats( array[u] ) );
			if ( paramtype == PT_CLASS ) then
				if ( param > 100 ) then
					if ( stats[ PT_TYPE ] == TYPE_INF ) then
						if ( stats[ paramtype ] == ( param - 100 ) ) then
							k = k + 1;
							sorted[k] = array[u];
						end;
					end;
				else
					if ( stats[ PT_TYPE ] == TYPE_MECH ) then
						if ( stats[ paramtype ] == param ) then
							k = k + 1;
							sorted[k] = array[u];
						end;
					end;
				end;
			else
				if ( stats[ paramtype ] == param ) then
					k = k + 1;
					sorted[k] = array[u];
				end;
			end;
		end;
		if ( ( u - cycles_per_segment * cyc ) == 0 ) then
			Sleep( delay );
			cyc = cyc + 1;
		end;
	end;
	sorted.n = k;
	return sorted;
end;

function SPG_Spy()
local units, spgs = {}, {};
local shooting = 0;
local pos = {};
local gradusnik = 0;
local GRADUSNIK_HOT = 100 - __difficulty * 10;
	while missionend == 0 do
		Wait( 1 );
		shooting = 0;
		units = GetUnitListOfPlayerArray( 0 );
--		Trace( units.n );
		spgs = GetUnitsByParamSegmented( units, PT_CLASS, CLASS_ASSAULT_SPG );
--		Trace( spgs.n );
		for i = 1, spgs.n do
			if ( GetUnitState( spgs[i] ) == STATE_SUPPRESS ) and ( GetAmmo( spgs[i] ) > 0 ) then
				shooting = shooting + 1;
				pos[shooting] = {};
				pos[shooting].x, pos[shooting].y = ObjectGetCoord( spgs[i] );
			end;
		end;
		if ( shooting > 0 ) then
			gradusnik = gradusnik + shooting;
		elseif ( gradusnik > 0 ) then
			gradusnik = gradusnik - 1;
		end;
		--Trace( "gradusnik = %g, shooting = %g", gradusnik, shooting );
		if ( gradusnik >= GRADUSNIK_HOT ) then
			LandReinforcementFromMap( 1, "bombers", 0, 105 );
			local p = Random( shooting );
			Cmd( ACT_MOVE, 105, 256, pos[p].x, pos[p].y );
			Wait( 120 );
			gradusnik = 0;
		end;
	end;
end;

function Bomb()
	Sleep( 10 + Random( 40 ) );
	LandReinforcementFromMap( 1, "bombers", 1, 100 );
	Cmd( ACT_MOVE, 100, 100, "bridges" );
	Wait( 5 );
	LandReinforcementFromMap( 1, "bombers", 1, 100 );
	Cmd( ACT_MOVE, 100, 100, "bridges" );
end;

function Assault( pos )
	id = id + 1;
	LandReinforcementFromMap( 1, "assinf", pos, id );
	if ( pos == 0 ) then
		Cmd( ACT_SWARM, id, 0, "p1" );
		QCmd( ACT_SWARM, id, 0, "p2" );
	else
		Cmd( ACT_SWARM, id, 0, "p2" );
	end;
end;

function AssaultManager()
	Wait( 5 + Random( 5 ) );
	while ( missionend == 0 ) do
		if ( GetObjectiveState( 1 ) ~= OBJ_COMPLETE ) then
			StartThread( Assault, 0 );
		end;
		Wait( 10 );
		if ( GetObjectiveState( 2 ) ~= OBJ_COMPLETE ) then
			StartThread( Assault, 1 );
		end;
		if ( __olddifficulty == 3 ) then -- very easy
			Wait( 300 );
		else
			Wait( 200 - __difficulty * 20 );
		end;
	end;
end;

function Objective0()
	if ( IsSomeUnitInArea( 0, "nbridge" ) == 1 ) and ( IsSomeUnitInArea( 1, "nbridge" ) == 0 ) then
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjective( 1 );
		GiveObjective( 2 );
		return 1;
	end;
end;

function Objective0fail()
	if ( IsSomeBodyAlive( 2, 190 ) ~= 1 ) then
		FailObjective( 0 );
		return 1;
	end;
end;

function Objective1()
	if ( IsSomeBodyAlive( 0, 502 ) ~= 0 ) then
		CompleteObjective( 1 );
		return 1;	
	end;
end;

function Objective2()
	if ( IsSomeBodyAlive( 0, 503 ) ~= 0 ) then
		CompleteObjective( 2 );
		return 1;	
	end;
end;

function Objective3()
	if ( IsSomeUnitInArea( 0, "factory" ) == 0 ) and ( IsSomeUnitInArea( 1, "factory" ) == 1 ) then
		counter = counter + 1;
	end;
	if ( IsSomeUnitInArea( 0, "factory" ) == 1 ) then
		counter = 0;
	end;
	if ( counter >= 15 ) then
		FailObjective( 3 );
		return 1;
	elseif ( GetObjectiveState( 0 ) == OBJ_COMPLETE ) and ( GetObjectiveState( 1 ) == OBJ_COMPLETE )
		and ( GetObjectiveState( 2 ) == OBJ_COMPLETE ) then
		CompleteObjective( 3 );
		return 1;
	end;
end;

--
Objectives_Count = 4;
objectives = { Objective0, Objective1, Objective2, Objective3 };

DamageScriptObject( 180, 0 );
StartAllObjectives( objectives, 4 );
StartCycled( Objective0fail );
--StartThread( Bomb );
StartThread( WinCheck, 4 );
StartThread( LooseCheck, 4 );
StartThread( AssaultManager );

if __olddifficulty ~= 3 then
	StartThread( SPG_Spy );
else
	RemoveScriptGroup( 899 );
	UnitRemove( GetObjectList( 11 ) );
end;

Wait( 3 );
GiveObjective( 0 );
GiveObjective( 3 );