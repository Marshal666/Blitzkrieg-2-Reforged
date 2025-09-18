function Drive()
	StartSequence ( )
end;


function Camera()
	while 1 do
		Wait( 1 );
		SCRunTime ( "100", "200", 5 );
		Wait( 5 );
		SCRunTime ( "200", "300", 5 );
		Wait( 5 );
		SCRunTime ( "300", "400", 5 );
		Wait( 5 );
		SCRunTime ( "400", "100", 5 );
		Wait( 5 );
	end;
end;
----------------------------
StartThread(Drive);
StartThread(Camera);