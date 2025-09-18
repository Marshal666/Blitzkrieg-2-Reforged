--Cmd( ACTION_COMMAND_ATTACK_OBJECT, 10, 1);
--UnitCmd( ACTION_COMMAND_ATTACK_OBJECT, GetObjectList(10), GetObjectList(1));
--UnitCmd( ACTION_COMMAND_ATTACK_UNIT, GetObjectList(10), GetObjectList(2));
--UnitCmd( ACTION_COMMAND_ENTER, GetObjectList(20), GetObjectList(1));
--Wait( 20 );
--UnitQCmd( ACTION_COMMAND_LEAVE, GetObjectList(20), 1000, 1000);
--Wait( 10 );
--UnitQCmd( ACTION_COMMAND_LOAD, GetObjectList(20), GetObjectList(30));
--Wait( 10 );
--UnitQCmd( ACTION_COMMAND_UNLOAD, GetObjectList(30), 1000, 1000);

--DamageScriptObject(1, -100);
--Wait(1);
--DamageScriptObject(1, -200);
Cmd( ACT_SWARM, 1000, 2000, 500 );


	--Cmd( ACT_SWARM, 10, ObjectGetCoord( GetObjectList( 1) ) );
	--Wait( 1 );
	--while ( GetUnitState( 10 ) ~= STATE_REST ) do -- GetUnitState currentry uses ScriptID
	--	Wait( 1 );
	--end;
	--Trace("Rest");
	--Cmd( ACT_ATTACKOBJECT, 10, 3 );