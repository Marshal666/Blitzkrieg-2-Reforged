units = {};
tanks = {};
units = GetObjectListArray( 1 );
tanks = GetUnitsByParam( units, PT_TYPE, TYPE_MECH );
Trace( "tanks.n = %g", tanks.n );
CmdArrayDisp( ACT_SWARM, tanks, 256, 5000, 5000 );

