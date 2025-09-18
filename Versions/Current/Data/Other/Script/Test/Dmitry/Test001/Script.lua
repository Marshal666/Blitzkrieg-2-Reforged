


function Air_Attack()
	Wait( 10 );
	LandReinforcement( 2, 885, 0, 3000 ); 
	Wait( 2 );
	Cmd( 5, 3000, 0, 4148, 1888 );
end;

---------------------------------------Patrol
function Start_Patrol()
	while 1 do
		Wait(5);
		if ( GetNUnitsInScriptGroup( 1011 ) > 0 ) then
			Wait(3);
			StartThread( Run1 );
			break
		end;
	end;
end;


------------------------

function Run1 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 1011, "P1" ) > 0 ) then
		Wait( 3 + RandomInt( 30 ) );
		Cmd(3, 1011, 0, GetScriptAreaParams("P2"));
			StartThread( Run2 );
			break
		end;		
	end;
end;

function Run2 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 1011, "P2" ) > 0 ) then
		Wait( 3 + RandomInt( 30 ) );
		Cmd(3, 1011, 0, GetScriptAreaParams("P3"));
			StartThread( Run3 );
			break
		end;		
	end;
end;

function Run3 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 1011, "P3" ) > 0 ) then
		Wait( 3 + RandomInt( 30 ) );
		Cmd(3, 1011, 0, GetScriptAreaParams("P4"));
			StartThread( Run4 );
			break
		end;		
	end;
end;

function Run4 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 1011, "P4" ) > 0 ) then
		Wait( 3 + RandomInt( 30 ) );
		Cmd(3, 1011, 0, GetScriptAreaParams("P1"));
			StartThread( Start_Patrol );
			break
		end;		
	end;
end;

---------------------------------------MAIN

StartThread( Air_Attack );
StartThread( Start_Patrol );


