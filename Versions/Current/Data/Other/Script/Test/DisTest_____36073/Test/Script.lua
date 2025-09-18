Trace( GetNUnitsInArea(1, "ccc" ) );
Trace( GetNUnitsInArea(2, "ccc" ) );
Trace( GetNUnitsInArea(3, "ccc" ) );
Trace( GetNUnitsInArea(4, "ccc" ) );

Trace( GetNUnitsInArea(1, "bbb" ) );
Trace( GetNUnitsInArea(2, "bbb" ) );
Trace( GetNUnitsInArea(3, "bbb" ) );
Trace( GetNUnitsInArea(4, "bbb" ) );

--funcs = {};

--funcs[1] = Trace;
--funcs[1]("traced");

--funcs[2] = function ( ... )
--	Trace( arg[1] );
--end;
--funcs[2]("la la");
--	Trace()
--end;

--local troops = {};
--LandReinforcement(1, 118, 9, 1 );
--Sleep( 5 );
--troops = GetUnitListInAreaArray( 1, "ccc" );
--Trace( troops.n );
--Sleep( 5 );
--CmdArray( ACT_MOVE, troops, 4000, 1000 );

--LandReinforcement2(0, 57, 11, 1, 99 );
--Sleep( 5 );
--Trace( GetNUnitsInScriptGroup( 99 ) );
--function A()
--LandReinforcement(3, 75, 12, 1 );
--end;
--function B()
--LandReinforcement(3, 66, 14, 1);
--end;
--function C()
--LandReinforcement(3, 68, 18, 1);
--end;
--function D()
--LandReinforcement(3, 77, 17, 1);
--end;

--local ab = 10 / 14;
--if ( ab > 0.75 ) then
--Trace( "dssd");
--end;
--f = 0;
--local aa = {};
--local trucks = {};
--local guns = {};
--local tr_hp = 40;
--local gun_hp = 50;
--aa = GetUnitListInAreaArray( 0, "aaa" );
--Trace( aa.n );
--trucks = GetUnitListWithHPs( aa, tr_hp );
--guns = GetUnitListWithHPs( aa, gun_hp );

--Wait( 3 );
--CmdArray(ACT_DEPLOY, trucks, ObjectGetCoord( trucks[1] ) );
--local x, y = ObjectGetCoord( trucks[1] );
--x = x + 200;
--y = y + 200;

--QCmdArray(ACT_MOVE, trucks, x, y );
--Wait( 15 );
--CmdArray(ACT_ROTATE, guns, 1000, 5000 );
--QCmdArray(ACT_ENTRENCH, guns );

--function abcd()
--	while 1 do
--		Wait( 2 );
--		Trace( "APFence %g", GetNAPFencesInScriptArea( "aaa" ) );
--		Trace( "Antitank %g", GetNAntitankInScriptArea( "aaa" ) );
--		Trace( "Fence %g",GetNFencesInScriptArea( "aaa" ) );
--		Trace( "Mines %g",GetNMinesInScriptArea( "aaa" ) );
--	end;
--end;
--zzz = GetUnitListInAreaArray( 0, "c" );
--z = GetUnitsByParam( zzz, PT_TYPE, TYPE_INF );
--Trace( "zzz.n = %g", zzz.n );
--Trace( "z.n = %g", z.n );
--StartThread( abcd );
--ViewZone( "ccc", 1 );