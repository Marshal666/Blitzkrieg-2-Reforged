wol = 0;

-----------------------Stop

function Stop0()

	Wait ( 5 );

	StartThread( Attake0 );

end;

function Stop1()

	Wait ( 5 );

	StartThread( Attake1 );

end;

function Stop2()

	Wait ( 5 );

	StartThread( Attake2 );

end;

function Stop3()

	Wait ( 5 );

	StartThread( Attake3 );

end;

function Stop4()

	Wait ( 5 );

	StartThread( Attake4 );

end;

function Stop5()

	Wait ( 5 );

	StartThread( Attake5 );

end;

function Stop6()

	Wait ( 5 );

	StartThread( Attake6 );

end;

function Stop7()

	Wait ( 5 );

	StartThread( Attake7 );

end;

-----------------------Zasada

function Zasada()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInArea ( 0 , "Zasada" , 0 ) > 0) then

			Wait( 3 );

			Cmd (3 , 100 , 0 , GetScriptAreaParams "Zasada");

			Cmd (3 , 101 , 0 , GetScriptAreaParams "Zasada");

			Cmd (3 , 102 , 0 , GetScriptAreaParams "Zasada");

			break;

		end;

	end;

end;

-----------------------Souz

function Souz()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInArea ( 0 , "Start" , 0 ) > 0) then

			Wait( 3 );

			StartThread( Go );

			break;

		end;	

	end;

end;

-----------------------Attake

function Go()

	Wait( 3 );

	Cmd (3 , 200 , 0 , GetScriptAreaParams "Go01");

	Cmd (3 , 201 , 0 , GetScriptAreaParams "Go11");

	Cmd (3 , 202 , 0 , GetScriptAreaParams "Go21");

	Cmd (3 , 203 , 0 , GetScriptAreaParams "Go31");

	Cmd (3 , 205 , 0 , GetScriptAreaParams "Go51");

	Cmd (3 , 206 , 0 , GetScriptAreaParams "Go61");

	Cmd (3 , 207 , 0 , GetScriptAreaParams "Go71");

	Wait( 15 );

	StartThread( Move );

	StartThread( Attake );

end;

function Move()

	Wait( 3 );

	Cmd (3 , 200 , 0 , GetScriptAreaParams "Go02");

	QCmd (3 , 200 , 0 , GetScriptAreaParams "Go03");

	QCmd (3 , 200 , 0 , GetScriptAreaParams "Town");

	Cmd (3 , 201 , 0 , GetScriptAreaParams "Go12");

	QCmd (3 , 201 , 0 , GetScriptAreaParams "Go13");

	QCmd (3 , 201 , 0 , GetScriptAreaParams "Town");

	Cmd (3 , 202 , 0 , GetScriptAreaParams "Go22");

	QCmd (3 , 202 , 0 , GetScriptAreaParams "Go23");

	QCmd (3 , 202 , 0 , GetScriptAreaParams "Town");

	Cmd (3 , 203 , 0 , GetScriptAreaParams "Go32");

	QCmd (3 , 203 , 0 , GetScriptAreaParams "Go33");

	QCmd (3 , 203 , 0 , GetScriptAreaParams "Town");

	Cmd (3 , 205 , 0 , GetScriptAreaParams "Go52");

	QCmd (3 , 205 , 0 , GetScriptAreaParams "Go53");

	QCmd (3 , 205 , 0 , GetScriptAreaParams "Town");

	Cmd (3 , 206 , 0 , GetScriptAreaParams "Go62");

	QCmd (3 , 206 , 0 , GetScriptAreaParams "Go63");

	QCmd (3 , 206 , 0 , GetScriptAreaParams "Town");

	Cmd (3 , 207 , 0 , GetScriptAreaParams "Go72");

	QCmd (3 , 207 , 0 , GetScriptAreaParams "Go73");

	QCmd (3 , 207 , 0 , GetScriptAreaParams "Town");

end;

function Attake()

	Wait( 3 );

	StartThread( Attake0 );

	StartThread( Attake1 );

	StartThread( Attake2 );

	StartThread( Attake3 );

	StartThread( Attake5 );

	StartThread( Attake6 );

	StartThread( Attake7 );

end;

function Attake0()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInScriptGroup ( 200 ) < 1) then

			LandReinforcementFromMap ( 2 , "0" , 0 , 200 );

			Wait ( 3 );

			Cmd (3 , 200 , 0 , GetScriptAreaParams "Go01");

			QCmd (3 , 200 , 0 , GetScriptAreaParams "Go02");

			QCmd (3 , 200 , 0 , GetScriptAreaParams "Go03");

			QCmd (3 , 200 , 0 , GetScriptAreaParams "Town");

			StartThread( Stop0 );

			break;

		end;

	end;

end;

function Attake1()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInScriptGroup ( 201 ) < 1) then

			LandReinforcementFromMap ( 2 , "0" , 0 , 201 );

			Wait ( 3 );

			Cmd (3 , 201 , 0 , GetScriptAreaParams "Go11");

			QCmd (3 , 201 , 0 , GetScriptAreaParams "Go12");

			QCmd (3 , 201 , 0 , GetScriptAreaParams "Go13");

			QCmd (3 , 201 , 0 , GetScriptAreaParams "Town");

			StartThread( Stop1 );

			break;

		end;

	end;

end;

function Attake2()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInScriptGroup ( 202 ) < 1) then

			LandReinforcementFromMap ( 2 , "0" , 0 , 202 );

			Wait ( 3 );

			Cmd (3 , 202 , 0 , GetScriptAreaParams "Go21");

			QCmd (3 , 202 , 0 , GetScriptAreaParams "Go22");

			QCmd (3 , 202 , 0 , GetScriptAreaParams "Go23");

			QCmd (3 , 202 , 0 , GetScriptAreaParams "Town");

			StartThread( Stop2 );

			break;

		end;

	end;

end;

function Attake3()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInScriptGroup ( 203 ) < 1) then

			LandReinforcementFromMap ( 2 , "3" , 0 , 203 );

			Wait ( 3 );

			Cmd (3 , 203 , 0 , GetScriptAreaParams "Go31");

			QCmd (3 , 203 , 0 , GetScriptAreaParams "Go32");

			QCmd (3 , 203 , 0 , GetScriptAreaParams "Go33");

			QCmd (3 , 203 , 0 , GetScriptAreaParams "Town");

			StartThread( Stop3 );

			break;

		end;

	end;

end;

function Attake5()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInScriptGroup ( 205 ) < 1) then

			LandReinforcementFromMap ( 2 , "1" , 0 , 205 );

			Wait ( 3 );

			Cmd (3 , 205 , 0 , GetScriptAreaParams "Go51");

			QCmd (3 , 205 , 0 , GetScriptAreaParams "Go52");

			QCmd (3 , 205 , 0 , GetScriptAreaParams "Go53");

			QCmd (3 , 205 , 0 , GetScriptAreaParams "Town");

			StartThread( Stop5 );

			break;

		end;

	end;

end;

function Attake6()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInScriptGroup ( 206 ) < 1) then

			LandReinforcementFromMap ( 2 , "2" , 0 , 206 );

			Wait ( 3 );

			Cmd (3 , 206 , 0 , GetScriptAreaParams "Go61");

			QCmd (3 , 206 , 0 , GetScriptAreaParams "Go62");

			QCmd (3 , 206 , 0 , GetScriptAreaParams "Go63");

			QCmd (3 , 206 , 0 , GetScriptAreaParams "Town");

			StartThread( Stop6 );

			break;

		end;

	end;

end;

function Attake7()

	while 1 do

		Wait( 3 );

		if (GetNUnitsInScriptGroup ( 207 ) < 1) then

			LandReinforcementFromMap ( 2 , "2" , 0 , 207 );

			Wait ( 3 );

			Cmd (3 , 207 , 0 , GetScriptAreaParams "Go71");

			QCmd (3 , 207 , 0 , GetScriptAreaParams "Go72");

			QCmd (3 , 207 , 0 , GetScriptAreaParams "Go73");

			QCmd (3 , 207 , 0 , GetScriptAreaParams "Town");

			StartThread( Stop7 );

			break;

		end;

	end;

end;

-----------------------Objective

function Objective()
	ObjectiveChanged(0, 1); 
	StartThread( CompleteObjective0 );
	Wait( 1 );
end;


function CompleteObjective0()
	while 1 do
		Wait( 1 );
		if (GetNUnitsInArea ( 1 , "Town" , 0 ) < 1) then
			StartThread( Winner );
			Wait ( 1 );
			break;
		end;
	end;
end;

------------------------WIn_Loose
function Winner()
	while 1 do
		Wait( 1 );
		if (GetNUnitsInArea ( 0 , "Town" , 0 ) > 0) and (wol == 0 ) then
			wol = 1;
			ObjectiveChanged(0, 2);
			Wait( 1 );
			Win(0);
			break;
		end;
		if (GetNUnitsInArea ( 2 , "Town" , 0 ) > 0) and (wol == 0) then
			wol = 1;
			Wait( 1 );
			Win(1);
			break;
		end;
	end;
end;

function Unlucky()
	while 1 do
		Wait( 3 );
        if ( IsSomePlayerUnit( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
			Wait( 1 );
			Win(1);
			break;
		end;
	end;
end;

-------------------------------------------  MAIN

StartThread( Objective );
StartThread( Unlucky );
StartThread( Zasada );
StartThread( Souz );