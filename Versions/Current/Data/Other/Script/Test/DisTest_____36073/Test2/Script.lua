Trace("plane %g %g %g %g %g %g %g", GetUnitRPGStats( GetObjectList( 1 ) ) );
Trace("gun %g %g %g %g %g %g %g", GetUnitRPGStats( GetObjectList( 2 ) ) );
Trace("as %g %g %g %g %g %g %g", GetUnitRPGStats( GetObjectList( 3 ) ) );
Trace("main %g %g %g %g %g %g %g", GetUnitRPGStats( GetObjectList( 4 ) ) );
Trace("snip %g %g %g %g %g %g %g", GetUnitRPGStats( GetObjectList( 5 ) ) );
a = {};
a = GetArray(GetUnitRPGStats(GetObjectList( 5 )));
Trace(a[2]);

for i = -30, 30 do
b, c = SinCos( i / 10 );
Trace( "%g %g", b * 1000, c * 1000 );
end

function _AreAllUnitsInDirection( array, mindir, maxdir, innerarc )
local dir;
local u;
	if ( array == nil ) or ( array.n == 0 ) then
		Trace( "AreAllUnitsInDirection: first parameter is invalid or empty" );
		return 0;
	end;
	for u = 1, array.n do
		if ( GetObjectHPs( array[u] ) > 0 ) then
			dir = GetFrontDir( array[u] );
			Trace( "dir[%g] = %g", u, dir);
			if ( ( dir > mindir ) and ( dir < maxdir ) ) then
				if ( innerarc == 0 ) then
					return 0;
				end;
			else
				if ( innerarc == 1 ) then
					return 0;
				end;
			end;
		end;
	end;
	return 1;
end;



Artillery = {};

local reinfunits = {};
local mindir = 32000;
local maxdir = 49000;
local astates = {};
local dr = 0;
Artillery.n = 0;
	while 1 do
		Wait( 1 );
		if ( Artillery.n == 0 ) then
			reinfunits = GetUnitListInAreaArray( 0, "Player_Reinf" );
			Artillery = GetUnitsByParam( reinfunits, PT_CLASS, CLASS_ANTITANK_GUN );
		end;
		if ( Artillery.n > 0 ) then
			if ( dr == 0 ) then
				EnableReinforcementPoint( 0, Point_Artillery, 0 );
				dr = 1;
			end;
			astates = GetUnitArrayStatesArray( Artillery );
			Trace( "Artillery.n = %g", Artillery.n );
			Trace( "OnlyValues = %g", OnlyValues( astates, {STATE_REST; n = 1} ) );
			Trace( "AreAllUnitsInDirection = %g", _AreAllUnitsInDirection( Artillery, mindir, maxdir, 0 ) );
			Trace( "AreAllUnitsInDirection = %g", _AreAllUnitsInDirection( Artillery, mindir, maxdir, 1 ) );
		end;
	end;

