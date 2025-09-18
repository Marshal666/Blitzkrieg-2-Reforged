
function Train()
	Wait( 5 );
	LandReinforcementFromMap( 0, 0, 0, 200 ); 
	Wait( 3 );
	Cmd( 0, 200, 0, 3240, 2156 );
end;

function Train2()
	Wait( 10 );
	LandReinforcementFromMap( 0, 1, 1, 201 ); 
	Wait( 3 );
	Cmd( 0, 201, 0, 3240, 2156 );
end;
---------------------------------------
StartThread( Train );
StartThread( Train2 );