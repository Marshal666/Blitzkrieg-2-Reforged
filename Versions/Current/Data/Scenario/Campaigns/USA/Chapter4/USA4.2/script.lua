Most = 0;
Trevoga = 0;

function USHQ()
	while 1 do
		Wait ( 1 );
		if GetNUnitsInArea ( 0 , 'USHQ', 0 ) > 20 then
			if IsSomeBodyAlive ( 1 , 830 ) > 0 then
				LandReinforcementFromMap ( 1 , "0" , 2 , 831 );
				Cmd ( 3 , 831 , 100 , "Most1" );
			end;
			if IsSomeBodyAlive ( 1 , 832 ) > 0 then
				LandReinforcementFromMap ( 1 , "0" , 1 , 833 );
				Cmd ( 3 , 833 , 100 , "Most2" );
			end;
			Wait ( 10 );
			if IsSomeBodyAlive ( 1 , 832 ) > 0 then
				LandReinforcementFromMap ( 1 , "0" , 2 , 834 );
				Cmd ( 3 , 834 , 100 , "Forest" );
			end;
		break;
		end;
	end;
end;

function Patrol11()
	while 1 do
		Cmd ( 3 , 500 , 0 , "Patrol11" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Patrol12" );
		Wait ( 15 );
		Cmd ( 3 , 500 , 0 , "Most1" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Patrol12" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Patrol11" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Flee1" );
		Wait ( 10 );
	end;
end;

function Patrol2()
	while 1 do
		Wait ( 1 );
		if IsSomeBodyAlive ( 1 , 501 ) < 1 then
			Wait ( 40 );
			if IsSomeUnitInArea ( 0 , 'Vilage1', 0 ) < 1 then
				Cmd ( 3 , 606, 0 , "Vilage1" );
				QCmd ( 3 , 606, 0 , "Patrol01" );
				QCmd ( 3 , 606, 0 , "Patrol02" );
				QCmd ( 3 , 606, 0 , "Patrol03" );
				QCmd ( 3 , 606, 100 , "Patrol03" );
			end;
		break;
		end;
	end;
end;

function Patrol01()
	while 1 do
		Cmd ( 3 , 500 , 0 , "Vilage2" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Patrol" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Patrol1" );
		Wait ( 15 );
		Cmd ( 3 , 500 , 0 , "Patrol2" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Patrol1" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Patrol" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Vilage2" );
		Wait ( 10 );
		Cmd ( 3 , 500 , 0 , "Patrol3" );
		Wait ( 10 );
	end;
end;

function Patrol1()
	while 1 do
		Wait ( 1 );
		if IsSomeBodyAlive ( 1 , 501 ) < 1 then
			Wait ( 40 );
			if IsSomeUnitInArea ( 0 , 'Vilage2', 0 ) < 1 then
				Cmd ( 7 , 600 , 0 , "Out" );
				Cmd ( 7 , 601 , 0 , "Out" );
				Cmd ( 7 , 602 , 0 , "Out" );
				Wait ( 2 );
				Cmd ( 6 , 600 , 603 );
				Cmd ( 6 , 601 , 604 );
				Cmd ( 0 , 602 , 0 , "Forest" );
			end;
		break;
		end;
	end;
end;

function Patrol02()
	while 1 do
		Cmd ( 3 , 501 , 0 , "Vilage1" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol01" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol02" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol03" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol04" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol2" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol04" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol03" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol02" );
		Wait ( 10 );
		Cmd ( 3 , 501 , 0 , "Patrol01" );
		Wait ( 15 );
	end;
end;

-----------------------Starting

function Starting()
	vil1 = GetNUnitsInScriptGroup ( 200 );
	vil2 = GetNUnitsInScriptGroup ( 201 );
	tow = GetNUnitsInScriptGroup ( 202 );
end;

function Perehvat()
	LandReinforcementFromMap ( 1 , "0" , 3 , 789 );
	Cmd ( 3 , 789 , 0 , "Return" );
end;

-----------------------Patrol

function SO3()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 602, 'Forest', 0 ) > 0 then
			Trevoga = 1;
			Cmd ( 1007 , 602 );
		end;	
	end;
end;

function SO_3()
	Wait ( 60 );
	if Trevoga == 0 then
		CompleteObjective ( 4 );
		Wait ( 60 );
		StartThread( Perehvat );
	else
		StartThread( Perehvat );
	end;
end;

function SO2()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 558, 'Flee2', 0 ) > 0 then
			Trevoga = 1;
			Cmd ( 1007 , 558 );
		end;	
	end;
end;

function SO_2()
	Wait ( 60 );
	if Trevoga == 0 then
		CompleteObjective ( 2 );
		Wait ( 60 );
		StartThread( Perehvat );
	else
		StartThread( Perehvat );
	end;
end;

function SO1()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 559, 'Flee1', 0 ) > 0 then
			Trevoga = 1;
			Cmd ( 1007 , 559 );
		end;	
	end;
end;

function SO_1()
	Wait ( 60 );
	if Trevoga == 0 then
		CompleteObjective ( 3 );
		Wait ( 60 );
		StartThread( Perehvat );
	else
		StartThread( Perehvat );
	end;
end;

function Patrol()
	while 1 do
		Wait ( 60 );
		Cmd ( 3 , 557 , 0 , "Vilage1" );
		Wait ( 90 );
		Cmd ( 3 , 557 , 0 , "Return" );
		Wait ( 60 );
		Cmd ( 3 , 557 , 0 , "Vilage2" );
		Wait ( 60 );
		Cmd ( 3 , 557 , 0 , "Shuher" );
		Wait ( 60 );
		Cmd ( 3 , 557 , 0 , "Town" );
		Wait ( 60 );
	end;
end;

function Most2()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Most2', 0 ) > 0 then
			if Most == 0 then
				Most = 2;
				StartThread( SO2 );
				StartThread( SO_2 );
			end;
			Wait( 3 );
			Cmd ( 0 , 558 , 0 , "Town" );
			QCmd ( 0 , 558 , 0 , "Flee2" );
			break;
		end;	
	end;
end;

function Most1()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Most1', 0 ) > 0 then
			if Most == 0 then
				Most = 1;
				StartThread( SO1 );
				StartThread( SO_1 );
			end;
			Wait( 3 );
			Cmd ( 0 , 559 , 0 , "Flee1" );
			break;
		end;	
	end;
end;

function Vilage2()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Vilage2', 0 ) > 0 then
			if Most == 0 then
				Most = 3;
				StartThread( SO3 );
				StartThread( SO_3 );
			end;
			Cmd ( 7 , 602 , 0 , "Out" );
			Wait ( 2 );
			Cmd ( 0 , 602 , 0 , "Forest" );
			break;
		end;	
	end;
end;

-----------------------Trevoga

function Trevoga1()
	while 1 do
		Wait( 1 );
		if GetNUnitsInScriptGroup ( 200 ) < vil1 then
			Wait( 3 );
			LandReinforcementFromMap ( 1 , "1" , 2 , 301 );
			Wait( 1 );
			Cmd ( 3 , 301 , 0 , GetScriptAreaParams ( "Vilage1" ));
			QCmd ( 3 , 301 , 0 , GetScriptAreaParams ( "Return" ));
			LandReinforcementFromMap ( 1 , "2" , 2 , 302 );
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

			LandReinforcementFromMap ( 1 , "0" , 0 , 400 );

			Wait( 1 );

			Cmd ( 3 , 400 , 0 , GetScriptAreaParams ( "Vilage2" ));

			LandReinforcementFromMap ( 1 , "1" , 2 , 401 );

			Wait( 1 );

			Cmd ( 3 , 401 , 0 , GetScriptAreaParams ( "Vilage2" ));

			QCmd ( 3 , 401 , 0 , GetScriptAreaParams ( "Return" ));

			LandReinforcementFromMap ( 1 , "2" , 1 , 402 );

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
			LandReinforcementFromMap ( 1 , "1" , 1 , 501 );
			Wait( 1 );
			Cmd ( 3 , 501 , 0 , GetScriptAreaParams ( "Town" ));
			QCmd ( 3 , 501 , 0 , GetScriptAreaParams ( "Return" ));
			LandReinforcementFromMap ( 1 , '2' , 1 , 502 );
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
	l = Random ( 3 );
	Trace ( l );
	Wait ( 1 );
	if l == 1 then
		LandReinforcementFromMap ( 3 , "0" , 1 , 5555 );
		Wait ( 1 );
		Cmd ( 0 , 5555 , 100 , "Landing1" );
		StartThread( Find1 );
	end;
	if l == 2 then
		LandReinforcementFromMap ( 3 , "0" , 2 , 5555 );
		Wait ( 1 );
		Cmd ( 0 , 5555 , 100 , "Landing2" );
		StartThread( Find2 );
	end;
	if l == 3 then
		LandReinforcementFromMap ( 3 , "0" , 3 , 5555 );
		Wait ( 1 );
		Cmd ( 0 , 5555 , 1200 , "Landing3" );
		StartThread( Find3 );
	end;
end;
-----------------------Shuher

function Shuher()
	Cmd ( 3 , 300 , 500 , GetScriptAreaParams ( "Shuher" ));
end;
-----------------------Find

function Find1()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "Landing1" , 0 ) > 0 then
			Wait( 1 );
			ChangePlayerForScriptGroup( 5555 , 0 );
			Wait( 1 );
			break;
		end;	
	end;
end;

function Find2()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "Landing2" , 0 ) > 0 then
			Wait( 1 );
			ChangePlayerForScriptGroup( 5555 , 0 );
			Wait( 1 );
			break;
		end;	
	end;
end;

function Find3()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "Landing3" , 0 ) > 0 then
			Wait( 1 );
			ChangePlayerForScriptGroup( 5555 , 0 );
			Wait( 1 );
			break;
		end;	
	end;
end;

-----------------------Objective

function Objective()
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0" , 1 );
	Wait ( 3 );
	StartThread( CompleteObjective0 );
	Wait( 3 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInScriptGroup ( 5555 , 0 ) > 0 ) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0" , 2 );
			Wait( 3 );
			StartThread( Objective1 );
			StartThread( Shuher );
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

		if GetNScriptUnitsInArea ( 5555 , "Return" , 0 ) > 0 then

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
        if GetNUnitsInScriptGroup ( 5555 ) < 1  then
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
StartThread( Patrol );

StartThread( Patrol1 );
StartThread( Patrol01 );
StartThread( Patrol2 );
StartThread( Patrol02 );
StartThread( Patrol11 );

StartThread( Run );
--StartThread( Trevoga1 );
--StartThread( Trevoga2 );
--StartThread( Trevoga3 );

StartThread( Most2 );
StartThread( Most1 );
StartThread( Vilage2 );

StartThread( USHQ );
Wait ( 3 );
StartThread( KIA );