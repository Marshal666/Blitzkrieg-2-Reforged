
-----------------------Starting
function Starting()
	vil1 = GetNUnitsInScriptGroup ( 200 );
	vil2 = GetNUnitsInScriptGroup ( 201 );
	tow = GetNUnitsInScriptGroup ( 202 );
end;
-----------------------Trevoga
function Trevoga1()
	while 1 do
		Wait( 1 );
		if GetNUnitsInScriptGroup ( 200 ) < vil1 then
			Wait( 3 );
			LandReinforcementFromMap ( 1 , 0 , 0 , 300 );
			Wait( 1 );
			Cmd ( 3 , 300 , 0 , GetScriptAreaParams ( "Vilage1" ));
			LandReinforcementFromMap ( 1 , 1 , 2 , 301 );
			Wait( 1 );
			Cmd ( 3 , 301 , 0 , GetScriptAreaParams ( "Vilage1" ));
			QCmd ( 3 , 301 , 0 , GetScriptAreaParams ( "Return" ));
			LandReinforcementFromMap ( 1 , 2 , 2 , 302 );
			Wait( 1 );
			Cmd ( 5 , 302 , 0 , GetScriptAreaParams ( "Vilage1" ));
			QCmd ( 3 , 302 , 0 , GetScriptAreaParams ( "Return" ));
			Wait( 1 );
			break;
		end;	
	end;
end;
function Trevoga2()
	while 1 do
		Wait( 1 );
		if GetNUnitsInScriptGroup ( 201 ) < vil2 then
			Wait( 3 );
			LandReinforcementFromMap ( 1 , 0 , 0 , 400 );
			Wait( 1 );
			Cmd ( 3 , 400 , 0 , GetScriptAreaParams ( "Vilage2" ));
			LandReinforcementFromMap ( 1 , 1 , 2 , 401 );
			Wait( 1 );
			Cmd ( 3 , 401 , 0 , GetScriptAreaParams ( "Vilage2" ));
			QCmd ( 3 , 401 , 0 , GetScriptAreaParams ( "Return" ));
			LandReinforcementFromMap ( 1 , 2 , 1 , 402 );
			Wait( 1 );
			Cmd ( 5 , 402 , 0 , GetScriptAreaParams ( "Town" ));
			QCmd ( 3 , 402 , 0 , GetScriptAreaParams ( "Return" ));
			Wait( 1 );
			break;
		end;	
	end;
end;
function Trevoga3()
	while 1 do
		Wait( 1 );
		if GetNUnitsInScriptGroup ( 202 ) < tow then
			Wait( 3 );
			LandReinforcementFromMap ( 1 , 0 , 0 , 500 );
			Wait( 1 );
			Cmd ( 3 , 500 , 0 , GetScriptAreaParams ( "Town" ));
			LandReinforcementFromMap ( 1 , 1 , 1 , 501 );
			Wait( 1 );
			Cmd ( 3 , 501 , 0 , GetScriptAreaParams ( "Town" ));
			QCmd ( 3 , 501 , 0 , GetScriptAreaParams ( "Return" ));
			LandReinforcementFromMap ( 1 , 2 , 1 , 502 );
			Wait( 1 );
			Cmd ( 5 , 502 , 0 , GetScriptAreaParams ( "Town" ));
			QCmd ( 3 , 502 , 0 , GetScriptAreaParams ( "Return" ));
			Wait( 1 );
			break;
		end;	
	end;
end;
-----------------------Run
function Run()
	Wait ( 1 );
	l1 = Random ( 3 );
	l = l1 - 1;
	LandReinforcementFromMap ( 2 , 0 , l , 100 );
	Wait ( 1 );
	Cmd ( 0 , 100 , 200 , GetScriptAreaParams ( "Landing"..l1 ));
	StartThread( Find );
end;
-----------------------Find
function Find()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "Landing"..l1 , 0 ) > 0 then
			Wait( 3 );
			ChangePlayerForScriptGroup( 100 , 0 );
			Wait( 1 );
			break;
		end;	
	end;
end;
-----------------------Objective
function Objective()
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0" , 1 );
	StartThread( CompleteObjective0 );
	Wait( 3 );
end;
function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInScriptGroup ( 100 , 0 ) > 0 ) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0" , 2 );
			Wait( 3 );
			StartThread( Objective1 );
			StartThread( KIA );
			Wait( 1 );
			break;
		end;	
	end;
end;
function Objective1()
	ObjectiveChanged(1, 1); 
	SetIGlobalVar( "temp.objective1" , 1 );
	StartThread( CompleteObjective1 );
	Wait( 3 );
end;
function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if GetNScriptUnitsInArea ( 100 , "Return" , 0 ) > 0 then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective1" , 2 );
			Wait( 1 );
			Win(0);
			Wait( 1 );
			break;
		end;	
	end;
end;
------------------------WIn_Loose
function Unlucky()
	while 1 do
		Wait( 3 );
        if ( GetNUnitsInParty( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
			Win(1);
			Wait( 2 );
			break;
		end;
	end;
end;
function KIA()
	while 1 do
		Wait( 3 );
        if GetNUnitsInScriptGroup ( 100 , 0 ) < 1  then
			Win(1);
			Wait( 2 );
			break;
		end;
	end;
end;
-------------------------------------------  MAIN
StartThread( Objective );
StartThread( Unlucky );
StartThread( Starting );

StartThread( Run );
StartThread( Trevoga1 );
StartThread( Trevoga2 );
StartThread( Trevoga3 );