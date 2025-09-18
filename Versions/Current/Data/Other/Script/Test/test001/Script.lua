function Patrol_Start()
	if ( GetNUnitsInScriptGroup(100) > 0) then
		StartThread( Patrol_GO);
	end;
end;


function Patrol_GO()
	Wait( 10 );
	GiveCommand(ACT_SWARM, 100, 657, 10538);
	Wait( Random(20) );
	QCmd(ACT_SWARM, 100 , 1413, 10456);
	Wait( Random(20) );
	QCmd(ACT_SWARM, 100 , 884, 9808);
	Wait( Random(20) );
	StartThread( Patrol_Start );
end;


--Main
StartThread( Patrol_Start );