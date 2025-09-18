function Start1()
	Wait( 3 );
	LandReinforcementFromMap( 0, "TANK", 2, 302 ); 
	LandReinforcementFromMap( 0, "DREZINA", 1, 301 );
	LandReinforcementFromMap( 0, "TRAIN", 0, 300 );
	Wait( 3 );
	StartThread( Go3 );
	StartThread( Go1 );
	StartThread( Go2 );
end;

function Patrol()
	Wait ( 1 );
	Cmd( 3 , 301 , 0 , GetScriptAreaParams ( "p1" ) );
	QCmd( 3 , 301 , 0 , GetScriptAreaParams ( "p2" ) );
	Wait ( 30 );
	StartThread( Patrol );
end;


function Go1()
	Wait ( 1 );
	Cmd( 3 , 302 , 0 , GetScriptAreaParams ( "A2" ) );
end;

function Go2()
	Wait ( 1 );
	Cmd( 0 , 300 , 0 , GetScriptAreaParams ( "A1" ) );
end;

function Go3()
	Wait ( 1 );
	Cmd( 3 , 301 , 0 , GetScriptAreaParams ( "Z1" ) );
end;

StartThread( Start1);