ataka5 = 0;
No = {};
No[1] = "0";
No[2] = "1";
No[3] = "2";
Nom = 200;
MWL = 0;
-----------------------Ataki
function Ataki()
	Wait ( 30 + RandomInt ( 30 ));
	N = RandomInt ( 3 ) + 1;
	LandReinforcementFromMap ( 1 , No[N] , 0 , Nom );
	A = RandomInt ( 2 );
	if A == 0 then
		Cmd ( 3 , Nom , 100 , GetScriptAreaParams "At1" );
		QCmd ( 3 , Nom , 100 , GetScriptAreaParams "At2" );
	else
		Cmd ( 3 , Nom , 100 , GetScriptAreaParams "At3" );
	end;
	Nom = Nom + 1;
	if N == 3 then
		N = 1;
	end;
	N = N + 1;
	LandReinforcementFromMap ( 1 , No[N] , 2 , Nom );
	Cmd ( 3 , Nom , 100 , GetScriptAreaParams "At1" );
	QCmd ( 3 , Nom , 100 , GetScriptAreaParams "At2" );
	Nom = Nom + 1;
	if N == 3 then
		N = 1;
	end;
	N = N + 1;
	LandReinforcementFromMap ( 1 , No[N] , 3 , Nom );
	A = RandomInt ( 2 );
	if A == 0 then
		Cmd ( 3 , Nom , 100 , GetScriptAreaParams "At1" );
		QCmd ( 3 , Nom , 100 , GetScriptAreaParams "At2" );
	else
		Cmd ( 3 , Nom , 100 , GetScriptAreaParams "At3" );
	end;
	Nom = Nom + 1;
	if Nom < 216 then
		StartThread( Ataki );
	else
		StartThread( CompleteObjective0 );
	end;
end;
-----------------------Air
function Air()
	while 1 do
		Wait( 1 );
        if Nom > 212 then
			LandReinforcementFromMap ( 1 , "3" , 1 , 300 );
			Sleep ( 1 );
			Cmd( 5 , 300 , 0 , GetScriptAreaParams ( "Para2" ) );
			LandReinforcementFromMap ( 1 , "3" , 2 , 301 );
			Sleep ( 1 );
			Cmd( 5 , 301 , 0 , GetScriptAreaParams ( "Para1" ) );
			Wait ( 60 );
			Cmd( 3 , 300 , 0 , GetScriptAreaParams ( "At2" ) );
			QCmd( 3 , 300 , 0 , GetScriptAreaParams ( "At1" ) );
			Cmd( 3 , 301 , 0 , GetScriptAreaParams ( "At2" ) );
			QCmd( 3 , 301 , 0 , GetScriptAreaParams ( "At1" ) );
			break;
		end;
	end;
end;
-----------------------Objective
function Objective()
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0", 1 );
end;
function CompleteObjective0()
	Wait( 90 );
	if (IsSomeUnitInArea ( 0 , 'Most', 0 ) + IsSomeUnitInArea ( 2 , 'Most', 0 )) > 0  and  MWL == 0 then
		MWL = 1;
		ObjectiveChanged(0, 2);
		SetIGlobalVar( "temp.objective0", 2 );
		Wait( 1 );
		Win(0);
	end;
end;
------------------------WIn_Loose
function Unlucky()
	while 1 do
		Wait( 3 );
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) and (MWL == 0)) then
			MWL = 1;
			Wait( 3 );
			Win(1);
			break;
		end;
	end;
end;
function Unlucky1()
	while 1 do
		Wait( 3 );
        if (IsSomeUnitInArea ( 0 , 'Most', 0 ) + IsSomeUnitInArea ( 2 , 'Most', 0 )) < 1  and  IsSomeUnitInArea ( 1 , 'Most', 0 ) > 0 then
			MWL = 1;
			Win(1);
		end;
	end;
end;
-------------------------------------------MAIN
StartThread( Unlucky );
StartThread( Unlucky1 );
StartThread( Objective );
StartThread( Ataki );
StartThread( Air );
