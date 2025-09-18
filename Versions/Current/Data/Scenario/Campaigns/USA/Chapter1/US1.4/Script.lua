CO1 = 0;
CO2 = 0;

Artilry = 0;
Order = 0;
Direction = 0;

function Out700()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 0 , 'Out700', 0 ) > 0 then 
			Cmd ( 3 , 700 , 50 , 'Out700' );
 			break;
 		end;
	end;
end;

function Out701()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 0 , 'Out701', 0 ) > 0 then 
			Cmd ( 3 , 701 , 50 , 'Out701' );
 			break;
 		end;
	end;
end;

function Out702()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 0 , 'Out702', 0 ) > 0 then 
			Cmd ( 3 , 702 , 50 , 'Out702' );
 			break;
 		end;
	end;
end;

------------------------------------------------OBJ

function Reinforcement()
 	while 1 do 
		Wait( 1 );
 		if GetNUnitsInScriptGroup ( 100 , 1 ) < 1 then 
			LandReinforcementFromMap ( 1 , "1" , 2 , 10010 );
			Cmd ( 0 , 10010 , 0 , "Left" );
			QCmd ( 3 , 10010 , 0 , "USLeft" );
			Wait ( 40 );
			LandReinforcementFromMap ( 1 , "1" , 2 , 100 );
 			break;
 		end;
	end;
end;

function Reinforcement1()
 	while 1 do 
		Wait( 1 );
 		if GetNUnitsInScriptGroup ( 120 , 1 ) < 1 then 
			LandReinforcementFromMap ( 1 , "1" , 1 , 10020 );
			Cmd ( 0 , 10020 , 0 , "Right" );
			Cmd ( 3 , 10020 , 0 , "USRight" );
			Wait ( 50 );
			LandReinforcementFromMap ( 1 , "1" , 1 , 120 );
 			break;
 		end;
	end;
end;

function AI()
	Direction = Random ( 2 );
	Wait ( 10 );
	USALeft = GetNUnitsInArea ( 0 , 'USLeft', 0 );
	USARight = GetNUnitsInArea ( 0 , 'USRight', 0 );
	USAHQ = GetNUnitsInArea ( 0 , 'USHQ', 0 );
	Trace (USALeft);
	Trace (USARight);
	Trace (USAHQ);
	JpLeft = GetNUnitsInArea ( 1 , 'JapLeft', 0 );
	JpRight = GetNUnitsInArea ( 1 , 'JapRight', 0 );
	JpHQ = GetNUnitsInArea ( 1 , 'Jap HQ', 0 );
	Hills = GetNUnitsInArea ( 1 , 'Hill', 0 );
	Trace (JpLeft);
	Trace (JpRight);
	Trace (JpHQ);
	Trace (Hills);
end;

function Tanks1()
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "1" , 1 , 120 );
	StartThread( Defence );
	Wait ( 2 );
	StartThread( Reinforcement1 );
end;

function Defence()
 	while 1 do 
		Wait( 2 );
 		if GetNUnitsInArea ( 0 , 'Jap HQ', 0 ) > 0 then 
			Trace ("HQ");
			Cmd ( 3 , 100 , 0 , "Jap HQ" );
			Cmd ( 3 , 120 , 0 , "Jap HQ" );
			Order = 1;
			StartThread( Prepair );
 			break;
 		end;
 		if GetNUnitsInArea ( 0 , 'Hill', 0 ) > 0 then 
			Trace ("Hill");
			Cmd ( 3 , 100 , 0 , "Hill" );
			Cmd ( 3 , 120 , 0 , "Hill" );
			Order = 1;
			StartThread( Prepair );
 			break;
 		end;
 		if GetNUnitsInArea ( 0 , 'JapLeft', 0 ) > 0 then 
			Trace ("Left");
			Cmd ( 3 , 100 , 0 , "USRight" );
			Cmd ( 3 , 120 , 0 , "JapLef" );
			Order = 1;
			StartThread( Prepair );
 			break;
 		end;
 		if GetNUnitsInArea ( 0 , 'JapRight', 0 ) > 0 then 
			Trace ("Right");
			Cmd ( 3 , 100 , 0 , "JapRight" );
			Cmd ( 3 , 120 , 0 , "USLeft" );
			Order = 1;
			StartThread( Prepair );
 			break;
 		else
			Order = 0;
			Trace ("No");
			StartThread( Prepair );
			break;
 		end;
	end;
end;

function Prepair()
	if Order == 0 then 
		if GetNScriptUnitsInArea ( 100 , 'Hill', 0 ) < 1 then
			Cmd ( 3 , 100 , 0 , "Hill" );
			QCmd ( 50 , 100  );
		end;
		if GetNScriptUnitsInArea ( 120 , 'JapLeft', 0 ) < 1 then
		Cmd ( 3 , 120 , 0 , "JapLef" );
		QCmd ( 50 , 120  );
		end;
		if GetNScriptUnitsInArea ( 100 , 'Hill', 0 ) > 0 and GetNScriptUnitsInArea ( 120 , 'JapLeft', 0 ) > 0 then
			Wait ( 2 );
			StartThread( Atack );
		else
			StartThread( Defence );
		end;
	else
		Wait ( 5 );
		StartThread( Defence );
		Trace ("Def");
	end;
end;

function Atack()
 	while 1 do 
		Trace ("URA!!!!")
		Wait( 1 );
 		if GetNUnitsInArea ( 1 , 'USHQ', 0 ) < 10 then 
			Cmd ( 3 , 120 , 0 , "Jap HQ" );
			QCmd ( 3 , 120 , 0 , "USHQ" );
			Wait ( 20 );
			Cmd ( 3 , 100 , 0 , "USHQ" );
			StartThread( Defence );
 			break;
 		end;
 		if GetNUnitsInArea ( 0 , 'USLeft', 0 ) < 5 then 
			Cmd ( 3 , 120 , 0 , "USLeft" );
			Wait ( 25 );
			Cmd ( 3 , 100 , 0 , "USHQ" );
			StartThread( Defence );
 			break;
 		end;
 		if GetNUnitsInArea ( 0 , 'USRight', 0 ) < 5 then 
			Cmd ( 3 , 120 , 0 , "Jap HQ" );
			QCmd ( 3 , 120 , 0 , "USHQ" );
			Wait ( 20 );
			Cmd ( 3 , 100 , 0 , "USRight" );
			StartThread( Defence );
 			break;
 		end;
 		StartThread( Defence );
 		StartThread( Waiting );
	end;
end;

function Art1()
 	while 1 do 
		Wait( 1 );
 		if GetNScriptUnitsInArea ( 101, 'Art1', 0 ) > 0 then 
			Wait( 7 );
			Cmd ( 0 , 201 , 0 , "Flee" );
			QCmd ( 1007 , 201 );
			Artilry = 1;
			Wait ( 3 );
			Cmd ( 8 , 101 , 0 , "USRight" );
 			break;
 		end;
	end;
end; 

function Art2()
 	while 1 do 
		Wait( 1 );
 		if GetNScriptUnitsInArea ( 102, 'Art2', 0 ) > 0 then 
			Wait( 7 );
			Cmd ( 0 , 202 , 0 , "Flee" );
			QCmd ( 1007 , 202 );
			Artilry = 1;
			Wait ( 3 );
			Cmd ( 8 , 102 , 0 , "USHQ" );
 			break;
 		end;
	end;
end; 

function Art3()
 	while 1 do 
		Wait( 1 );
 		if GetNScriptUnitsInArea ( 103, 'Art3', 0 ) > 0 then 
			Wait( 7 );
			Cmd ( 0 , 203 , 0 , "Flee" );
			QCmd ( 1007 , 203 );
			Artilry = 1;
			Wait ( 3 );
			Cmd ( 8 , 103 , 0 , "USHQ" );
 			break;
 		end;
	end;
end; 

function Art4()
 	while 1 do 
		Wait( 1 );
 		if GetNScriptUnitsInArea ( 104, 'Art4', 0 ) > 0 then 
			Wait( 7 );
			Cmd ( 0 , 204 , 0 , "Flee" );
			QCmd ( 1007 , 204 );
			Artilry = 1;
			Wait ( 3 );
			Cmd ( 8 , 104 , 0 , "USLeft" );
 			break;
 		end;
	end;
end; 

function Waiting()
 	Wait ( 70 );
 	StartThread( Air );
end; 

function Air()
 	Wait ( 40 + Random( 20 ));
 	LandReinforcementFromMap ( 1 , "0" , 0 , 400 );
 	Cmd ( 0 , 400 , 0 , "USHQ" );
end; 

function Objective()
	GiveObjective ( 0 );
 	StartThread( CompleteObjective0 );
 	Wait( 1 );
end; 

function CompleteObjective0()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 0 , 'Jap HQ', 0 ) > 0 and IsSomeUnitInArea ( 1 , 'Jap HQ', 0 ) < 1 then 
 			Wait( 1 );
 			Win ( 0 );
 			break;
 		end;
	end;
end; 

------------------------------------------------WinLoose

function Unlucky()
	while 1 do
		Wait( 1 );
        if (( IsSomePlayerUnit( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			break;
		end;
	end;
end;

------------------------------------------------Start

StartThread( Objective );
StartThread( Unlucky );

StartThread( AI );
StartThread( Air );
--StartThread( Art1 );
--StartThread( Art2 );
StartThread( Art3 );
StartThread( Art4 );
StartThread( Tanks1 );
StartThread( Reinforcement );

Wait ( 15 );
StartThread( Out700 );
StartThread( Out701 );
StartThread( Out702 );
