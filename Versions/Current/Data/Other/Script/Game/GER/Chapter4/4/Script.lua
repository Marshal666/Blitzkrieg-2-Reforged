missionend = 0;

function ArtillerySupport()
local minammo = { 1000, 1000 };
local ammo = {};
	Cmd( ACT_SUPPRESS, 100, 300, GetScriptAreaParams( "fire" ) );
	units = GetObjectListArray( 100 );
	while ( minammo[1] + minammo[2] > 0 ) do
		Wait( 3 );
		for i = 1, 2 do
			ammo = GetArray( GetAmmo( units[i] ) );
			for guns = 1, ammo.n do
				if ammo[guns] < minammo[i] then
					minammo[i] = ammo[guns];
				end;
			end;
		end;
	end;
	Cmd( ACT_MOVE, 100, 100, GetScriptAreaParams( "destpoint" ) );
	QCmd( ACT_ROTATE, 100, 100, GetScriptAreaParams( "fire" ) );
	QCmd( ACT_STAND, 100 );
	Wait( 15 );
	GiveObjective( 1 );
end;

function CheckSupport()
	if ( IsSomeUnitInArea( 0, "check1" ) > 0 ) then
		return 1;
	end;
end;

function CheckCounterAttack()
	if ( IsSomeUnitInArea( 0, "check2" ) > 0 ) then
		return 1;
	end;
end;

function CounterAttack()
	Cmd( ACT_SWARM, 12, 100, GetScriptAreaParams( "fire" ) );
end;

function Objective0()
	--if ( IsSomeBodyAlive( 0, 501 ) == 1 ) then
	if ( GetNUnitsInScriptGroup( 501, 0 ) == 1 ) then
		CompleteObjective( 0 );
		return 1;
	end;
end;

function Objective1()
	if ( IsSomeBodyAlive( 1, 100 ) + IsSomeBodyAlive( 1, 101 ) +
		 IsSomeBodyAlive( 1, 102 ) == 0 ) then
		CompleteObjective( 1 );
		return 1;
	end;
end;

function BackMove( unit )
local k = 0;
local x, y, x1, y1;
local r = 350;
	while k < 3 do
	Wait( 2 );
	x, y = ObjectGetCoord( unit );
	if ( IsSomeUnitInArea( 0, x, y, r ) == 1 ) then
		y1, x1 = SinCos( GetFrontDir( unit ) / 65536 * M_2PI - M_PI2 );
		UnitCmd( ACT_MOVE, unit, 20, x + x1 * 150, y + y1 * 150 );
		UnitQCmd( ACT_MOVE, unit, 20, x + x1 * 300, y + y1 * 300 );
		UnitQCmd( ACT_STAND, unit );
		k = k + 1;
		Wait( 5 + Random( 2 ) );
	end;
	end;
end;

function BackMove_Manager()
local units = GetObjectListArray( 111 );
	for i = 1, units.n do
		StartThread( BackMove, units[i] );
	end;
end;

----------------------------------
Objectives = { Objective0, Objective1 };
Objectives_Count = 2;

StartAllObjectives( Objectives, Objectives_Count );

Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( BackMove_Manager );
Trigger( CheckSupport, ArtillerySupport );
Trigger( CheckCounterAttack, CounterAttack );
