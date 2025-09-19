CO2 = 0;
CO1 = 0;
MWL = 0;
Kol1 = 6;
Kol2 = 6;
stopim1 = 0; 
stopim2 = 0;

Dom = GetScriptObjectHPs ( 1020 );
Dom1 = GetScriptObjectHPs ( 1021 );
Dom2 = GetScriptObjectHPs ( 1022 );
Dom3 = GetScriptObjectHPs ( 1023 );
Dom4 = GetScriptObjectHPs ( 1024 );
Dom5 = GetScriptObjectHPs ( 1025 );

-------------------------------------------Film 

function Film() 	
	Wait ( 1 );
	SetIGlobalVar( "temp.plane_min_height", 500 );
	Cmd( 0 , 600 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Djip5" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Tank11" );
 	Cmd( 0 , 602 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Djip5" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Tank11" );
 	Cmd( 0 , 604 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Djip5" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Tank11" );
 	Cmd( 0 , 606 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Djip5" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Tank11" );
 	Cmd( 0 , 601 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 601 , 0 , GetScriptAreaParams "kolona21" );
 	QCmd( 0 , 601 , 0 , GetScriptAreaParams "kolona22" );
 	QCmd( 0 , 601 , 0 , GetScriptAreaParams "Tank21" );
 	Cmd( 0 , 603 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 603 , 0 , GetScriptAreaParams "kolona21" );
 	QCmd( 0 , 603 , 0 , GetScriptAreaParams "kolona22" );
 	QCmd( 0 , 603 , 0 , GetScriptAreaParams "Tank22" );
 	Cmd( 0 , 605 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 605 , 0 , GetScriptAreaParams "kolona21" );
 	QCmd( 0 , 605 , 0 , GetScriptAreaParams "kolona22" );
 	QCmd( 0 , 605 , 0 , GetScriptAreaParams "Tank23" ); 
	ViewZone ( "Camera1" , 1 ); 	ViewZone ( "Camera2" , 1 );
 	ViewZone ( "Camera3" , 1 ); 	ViewZone ( "Camera", 1 );
 	Wait ( 1 );
 	SCRunTime ("Scene01frame01" , "Scene01frame02" , 9 );
 	Wait ( 4 ); 	Cmd( 3 , 599 , 0 , 2176.83 , 3463.55 ); 
	Wait ( 2 ); 	Cmd( 0 , 599 , 0 , 2176.83 , 3463.55 );
 	Wait ( 3 ); 	LandReinforcementFromMap ( 1 , "3" , 7 , 609 );
 	Cmd( 0 , 609 , 0 , GetScriptAreaParams "Tank21" );
 	Sleep ( 10 );
 	SCRunTime ("Scene01frame02" , "Scene02" , 0 );
 	Sleep ( 1 );
 	RemoveScriptGroup ( 601 );
 	RemoveScriptGroup ( 603 );
 	RemoveScriptGroup ( 605 );
 	LandReinforcementFromMap ( 1 , "3" , 8 , 603 );
 	LandReinforcementFromMap ( 1 , "2" , 9 , 605 );
 	LandReinforcementFromMap ( 1 , "2" , 10 , 607 );
 	LandReinforcementFromMap ( 1 , "3" , 20 , 611 );
 	LandReinforcementFromMap ( 1 , "4" , 2 , 901 );
 	ChangeFormation ( 901 , 1 );
 	Cmd( 0 , 603 , 0 , GetScriptAreaParams "Tank21" );
 	Cmd( 0 , 605 , 0 , GetScriptAreaParams "Tank21" );
 	Cmd( 0 , 607 , 0 , GetScriptAreaParams "Tank21" );
 	Cmd( 0 , 611 , 0 , GetScriptAreaParams "Tank21" );
 	RemoveScriptGroup ( 600 ); 	RemoveScriptGroup ( 602 );
 	RemoveScriptGroup ( 604 ); 	RemoveScriptGroup ( 606 );
 	Wait ( 4 );
 	Cmd( 0 , 901 , 0 , GetScriptAreaParams "inf" );
 	Wait ( 4 );
 	Cmd( 9 , 609 );
 	Cmd( 9 , 603 );
 	Cmd( 9 , 605 );
 	Cmd( 9 , 607 );
 	Cmd( 9 , 611 );
 	Wait ( 1 );
 	LandReinforcementFromMap ( 1 , "5" , 11 , 600 );
 	LandReinforcementFromMap ( 1 , "3" , 12 , 602 );
 	LandReinforcementFromMap ( 1 , "3" , 13 , 604 );
 	LandReinforcementFromMap ( 1 , "2" , 14 , 606 );
 	LandReinforcementFromMap ( 1 , "2" , 15 , 608 );
 	LandReinforcementFromMap ( 1 , "3" , 16 , 610 );
 	Cmd( 0 , 600 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 600 , 0 , GetScriptAreaParams "Djip5" );
 	Cmd( 0 , 602 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 602 , 0 , GetScriptAreaParams "Djip5" );
 	Cmd( 0 , 604 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 604 , 0 , GetScriptAreaParams "Djip5" );
 	Cmd( 0 , 606 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 606 , 0 , GetScriptAreaParams "Djip4" );
 	Cmd( 0 , 608 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 608 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 608 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 608 , 0 , GetScriptAreaParams "Djip4" );
 	Cmd( 0 , 610 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 610 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 610 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 610 , 0 , GetScriptAreaParams "Djip4" );
 	Wait ( 2 );
 	SCRunTime ( "Scene03frame01" , "Scene03frame02" , 5 );
 	Wait ( 3 );
 	LandReinforcementFromMap ( 1 , "5" , 3 , 700 );
 	LandReinforcementFromMap ( 1 , "3" , 17 , 701 );
 	LandReinforcementFromMap ( 1 , "3" , 18 , 702 );
 	Cmd( 0 , 700 , 0 , GetScriptAreaParams "Tank14" );
 	Sleep ( 10 );
 	Cmd( 0 , 701 , 0 , GetScriptAreaParams "Tank13" );
 	Sleep ( 10 );
 	Cmd( 0 , 702 , 0 , GetScriptAreaParams "Tank12" );
 	Sleep ( 15 );
 	LandReinforcementFromMap ( 1 , "2" , 19 , 703 );
 	Cmd( 0 , 703 , 0 , GetScriptAreaParams "Tank11" );
 	Wait ( 1 );
 	RemoveScriptGroup ( 600 );
 	RemoveScriptGroup ( 602 );
 	RemoveScriptGroup ( 604 );
 	RemoveScriptGroup ( 606 );
 	RemoveScriptGroup ( 608 );
 	RemoveScriptGroup ( 610 );
 	SCRunTime ("Scene03frame02" , "Scene04" , 0 );
 	Wait ( 3 ); 
	Sleep ( 10 );
 	Wait ( 2 );
 	LandReinforcementFromMap ( 1 , "6" , 4 , 800 );
 	LandReinforcementFromMap ( 1 , "7" , 5 , 302 );
 	Cmd( 0 , 800 , 0 , GetScriptAreaParams "Oficer" ); 
	Sleep ( 10);
 	Cmd( 0 , 700 , 0 , GetScriptAreaParams "j0" );
 	QCmd( 0 , 700 , 0 , GetScriptAreaParams "J1" );
 	Wait ( 1 );
 	Wait ( 1 );
 	Wait ( 1 );
 	Cmd( 0 , 302 , 0 , GetScriptAreaParams "J1" );
 	Wait ( 1 );
 	RemoveScriptGroup ( 700 );
 	ViewZone ( "Camera", 0 );
 	ViewZone ( "Camera1" , 0 );
 	SCRunTime ("Scene04" , "Scene05frame01" ,  0 );
 	Wait ( 1 );
 	Sleep ( 15 );
 	LandReinforcementFromMap ( 1 , "8" , 6 , 802 );
	ChangePlayerForScriptGroup( 802, 0 );
 	Cmd( 0 , 802 , 0 , GetScriptAreaParams "J1" );
 	QCmd( 0 , 802 , 0 , GetScriptAreaParams "J3" );
 	QCmd( 0 , 802 , 0 , GetScriptAreaParams "KolonaT1" );
 	Sleep ( 5 ); 
	Wait ( 1 );
 	SCRunTime ("Scene05frame01" , "Scene05frame02" ,  4 );
 	StartThread( Picnik );
 	Wait ( 4 );
 	SCRunTime ("Scene05frame02" , "Scene05frame03" ,  4 );
  	ViewZone ( "Camera2" , 0 );
 	Wait ( 1 );
 	LandReinforcementFromMap ( 1 , "6" , 21 , 303 );
 	Wait ( 1 );
 	ViewZone ( "Camera3" , 0 );
 	Wait ( 3 );
 	Sleep ( 2 );
 	HideMovieBorder ( );
 	Sleep ( 1 );
 	SCReset ();
 	Sleep ( 1 );
 	StartThread( Start );
end;

-------------------------------------------Start 
function Start()
	StartThread( Picnik );
	RemoveScriptGroup ( 701 );
 	RemoveScriptGroup ( 702 );
 	RemoveScriptGroup ( 703 );
 	RemoveScriptGroup ( 603 );
 	RemoveScriptGroup ( 605 );
 	RemoveScriptGroup ( 607 );
 	RemoveScriptGroup ( 609 );
 	RemoveScriptGroup ( 611 ); 
	RemoveScriptGroup ( 901 );
 	Sleep ( 1 );
 	LandReinforcementFromMap ( 1 , "9" , 22 , 701 );
 	LandReinforcementFromMap ( 1 , "9" , 23 , 702 ); 
	LandReinforcementFromMap ( 1 , "10" , 24 , 703 );
 	LandReinforcementFromMap ( 1 , "10" , 25 , 704 ); 
	LandReinforcementFromMap ( 1 , "9" , 26 , 705 ); 
	LandReinforcementFromMap ( 1 , "9" , 27 , 706 ); 
	LandReinforcementFromMap ( 1 , "13" , 31 , 710 ); 
	LandReinforcementFromMap ( 1 , "13" , 32 , 711 ); 
	LandReinforcementFromMap ( 1 , "13" , 33 , 712 );
	Cmd ( 50 , 701 );
	Cmd ( 50 , 702 );
	Cmd ( 50 , 703 );
	Cmd ( 50 , 704 );
	Cmd ( 50 , 705 );
	Cmd ( 50 , 706 );
	Cmd ( 50 , 707 );
	Cmd ( 50 , 708 );
	Cmd ( 50 , 709 );
	Cmd ( 50 , 710 );
	Cmd ( 50 , 711 );
	Cmd ( 50 , 712 );
	StartThread( Retirate0 );
--	StartThread( Retirate1 );
	StartThread( Unlucky ); 
	StartThread( Objective01 );  
	StartThread( ObjectiveSO );
	StartThread( Panika1 );
	StartThread( Air1 );
	StartThread( Air2 );
	StartThread( Kolona );
	StartThread( Kolona2 );
	Sleep ( 1 );
end; 
-----------------------Retirate 
function Retirate0() 	
	while 1 do
 		Wait( 1 );
 		Kol1 = IsSomeBodyAlive ( 1 , 701 ) + IsSomeBodyAlive ( 1 , 702 ) + IsSomeBodyAlive ( 1 , 703 ) + IsSomeBodyAlive ( 1 , 704 ) + IsSomeBodyAlive ( 1 , 705 ) + IsSomeBodyAlive ( 1 , 706 );
 		if (Kol1 < 4) then
			stopim1 = 1 ;
 			Wait( 10 );
 			for a = 1 , 6 do 
				Sleep ( 1 ); 
				Cmd ( 0, 700+a , 0 , GetScriptAreaParams ( "Djip5" ) ); 
				QCmd ( 0, 700+a , 0 , GetScriptAreaParams ( "Djip4" ) ); 
				QCmd ( 0, 700+a , 0 , GetScriptAreaParams ( "Djip2" ) ); 
				QCmd ( 0, 700+a , 0 , GetScriptAreaParams ( "Djip1" ) ); 
				QCmd ( 0, 700+a , 0 , GetScriptAreaParams ( "Djip0" ) ); 	
				QCmd ( 0, 700+a , 0 , GetScriptAreaParams ( "GoGoGo" ) ); 
				QCmd ( 1007 , 700+a ); 
			end; 
			break;
 		end;
 	end;
end; 

function Retirate1()
 	while 1 do 
		Wait( 1 );
 		Kol2 = IsSomeBodyAlive ( 1 , 708 ) + IsSomeBodyAlive ( 1 , 709 ) + IsSomeBodyAlive ( 1 , 710 ) + IsSomeBodyAlive ( 1 , 711 ) + IsSomeBodyAlive ( 1 , 712 ) + IsSomeBodyAlive ( 1 , 707 );
 		if (Kol2 < 4) then
 			Wait( 10 );
			stopim2 = 0;
  			for a1 = 1 , 6 do
				Sleep ( 1 ); 	
				Cmd ( 0, 706+a1 , 0 , GetScriptAreaParams ( "Tank24" ) );
				QCmd ( 0, 706+a1 , 0 , GetScriptAreaParams ( "Road1" ) ); 
				QCmd ( 0, 706+a1 , 0 , GetScriptAreaParams ( "Road2" ) ); 
				QCmd ( 0, 706+a1 , 0 , GetScriptAreaParams ( "Road3" ) ); 
				QCmd ( 0, 706+a1 , 0 , GetScriptAreaParams ( "R2" ) ); 	
				QCmd ( 1007 , 706+a1 ); 
			end; 
			break;
 		end; 
	end;
end; 

-----------------------Picnik 
function Picnik() 
	Cmd( 4 , 301 , 300 );
 	Wait( 6 );
 	Cmd( 5 , 300 , 0 , GetScriptAreaParams ( "Blok1" ) );
 	while 1 do 
		Wait( 1 ); 
		if (GetNScriptUnitsInArea( 301 , "Blok1" , 0 ) == 2)  then
 			Wait( 1 );
 			Cmd( 0 , 301 , 0 , GetScriptAreaParams ( "offic" ) );
 			Wait( 6 ); 
			Cmd( 4 , 301 , 300 );
 			Cmd( 4 , 303 , 302 );
 			StartThread( Trevoga );
 			break;
 		end;
 	end;
end; 
function Picnik1()
 	Wait( 5 );
 	Cmd( 0 , 300 , 0 , GetScriptAreaParams ( "Bpost0") );
 	QCmd( 5 , 300 , 0 , GetScriptAreaParams ( "Blok2" ) );
 	while 1 do 
		Wait( 3 ); 
		if (GetNScriptUnitsInArea( 301 , "Blok2" , 0 ) == 2)  then
 			Cmd( 0 , 301 , 0 , GetScriptAreaParams ( "Bpost") ); 
			Wait( 6 );
 			Cmd( 4 , 301 , 300 ); 
			Cmd( 4 , 307 , 306 ); 
			StartThread( Trevoga1 ); 
			break; 
		end; 
	end;
end; 
-----------------------Trevoga 

function Trevoga()
 	Wait( 3 );
 	Cmd( 0 , 302 , 0 , GetScriptAreaParams ( "Road4" ) );
 	QCmd( 0 , 302 , 0 , GetScriptAreaParams ( "Road5" ) );
 	QCmd( 0 , 302 , 0 , GetScriptAreaParams ( "Road6" ) );
 	QCmd( 0 , 302 , 0 , GetScriptAreaParams ( "Road7" ) );
 	QCmd( 0 , 302 , 0 , GetScriptAreaParams ( "Djip4" ) );
 	QCmd( 0 , 302 , 0 , GetScriptAreaParams ( "Djip3" ) );
 	QCmd( 0 , 302 , 0 , GetScriptAreaParams ( "Djip2" ) );
 	QCmd( 0 , 302 , 0 , GetScriptAreaParams ( "Djip1" ) );
 	QCmd( 0 , 302 , 0 , GetScriptAreaParams ( "Djip0" ) );
 	QCmd ( 0, 302 , 0 , GetScriptAreaParams ( "GoGoGo" ) ); 
	QCmd ( 1007 , 302 );
 	StartThread( Picnik1 );
end;

function Trevoga1()
 	Wait( 3 );
 	StartThread( Trevoga2 );
 	Cmd( 0 , 306 , 0 , GetScriptAreaParams ( "Road10" ) );
 	QCmd( 0 , 306 , 0 , GetScriptAreaParams ( "Tank23" ) );
 	QCmd( 0 , 306 , 0 , GetScriptAreaParams ( "Road11" ) );
 	QCmd( 0 , 306 , 0 , GetScriptAreaParams ( "Road1" ) ); 
	QCmd( 0 , 306 , 0 , GetScriptAreaParams ( "Road2" ) );
 	QCmd( 0 , 306 , 0 , GetScriptAreaParams ( "Road3" ) );
 	QCmd( 0 , 306 , 0 , GetScriptAreaParams ( "R2" ) ); 
	QCmd ( 1007 , 306 );
end;
 
function Trevoga2()
 	Wait( 10 ); 
	Cmd( 0 , 300 , 0 , GetScriptAreaParams ( "Road10" ) );
 	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Road11" ) ); 
	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "kolona22" ) ); 
	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Road12" ) ); 
	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Road13" ) ); 
	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Road14" ) ); 
	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Djip2" ) ); 
	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Djip3" ) );
 	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Djip4" ) );
 	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Road7" ) );
 	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Djip5" ) ); 
	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Oficer" ) ); 
	QCmd( 0 , 300 , 0 , GetScriptAreaParams "R3" ); 
	QCmd ( 1007 , 300 ); 
end; 

-----------------------Objective 

function Objective01()
	GiveObjective ( 2 );
	while 1 do 
		Wait( 1 );
 		if IsSomeBodyAlive ( 1 , 1100 ) < 1 then 
			CompleteObjective ( 2 );
			StartThread( Objective0 );
			LandReinforcementFromMap ( 2 , "1" , 2 , 1110 );
			Cmd ( 0 , 1110 , 0 , "KolonaT1" );
 			break;
 		end;
	end;
end; 

function Objective0()
	GiveObjective ( 0 );
 	StartThread( CompleteObjective0 );
end; 

function CompleteObjective0()
 	while 1 do 
		Wait( 1 );
 		if IsSomeBodyAlive ( 1 , 1000 ) < 1 then 
			CompleteObjective ( 0 );
			StartThread( Objective1 );
 			break;
 		end;
	end;
end; 

function Objective02()
	GiveObjective ( 3 );
	while 1 do 
		Wait( 1 );
 		if IsSomeBodyAlive ( 1 , 2100 ) < 1 then 
			CompleteObjective ( 3 );
			Wait ( 5 );
			Win ( 0 );
 			break;
 		end;
	end;
end;

function Objective1()
 	Wait( 1 ); 
	GiveObjective ( 1 );
	StartThread( Recon );
 	StartThread( CompleteObjective1 );
end;

function CompleteObjective1()
 	while 1 do 
		Wait( 1 ); 
		if IsSomeUnitInArea ( 1 , 'KolonaT2', 0 ) < 1 then 
			CompleteObjective ( 1 );
			Wait( 1 ); 
			StartThread( Objective02 );
			break;
 		end;
	end;
end;

-------------------------------------------Air

function Air1()
 	while 1 do 
		Wait( 1 ); 
		if GetNUnitsInArea ( 0 , 'KolonaT1', 1 ) > 1 then
			LandReinforcementFromMap ( 2 , "0" , 0 , 401 );
			Cmd ( 0 , 401 , 0 , GetScriptAreaParams "Road12" );
			Wait ( 1 );
			LandReinforcementFromMap ( 2 , "0" , 1 , 402 );
			Cmd ( 0 , 402 , 0 , GetScriptAreaParams "Road14" );
			Wait ( 20 );
			StartThread( Air1Out );
			Wait ( 90 );
		end;
	end;
end;

function Air1Out()
 	while 1 do 
		Wait( 1 ); 
		if IsSomeBodyAlive ( 1 , 400 ) < 1 then
			Cmd ( 3 , 401 , 0 , GetScriptAreaParams "R3" );
			Cmd ( 3 , 402 , 0 , GetScriptAreaParams "R3" );
			QCmd ( 1007 , 401 );
			QCmd ( 1007 , 402 );
			break;
		end;
	end;
end;

function Air2()
 	while 1 do 
		Wait( 1 ); 
		if GetNUnitsInArea ( 0 , 'KolonaT2', 1 ) > 1 then
			LandReinforcementFromMap ( 2 , "0" , 0 , 411 );
			Cmd ( 0 , 411 , 0 , GetScriptAreaParams "Road12" );
			Wait ( 1 );
			LandReinforcementFromMap ( 2 , "0" , 1 , 412 );
			Cmd ( 0 , 412 , 0 , GetScriptAreaParams "Road14" );
			Wait ( 20 );
			StartThread( Air2Out );
			Wait ( 90 );
		end;
	end;
end;

function Air2Out()
 	while 1 do 
		Wait( 1 ); 
		if IsSomeBodyAlive ( 1 , 410 ) < 1 then
			Cmd ( 3 , 411 , 0 , GetScriptAreaParams "R3" );
			Cmd ( 3 , 412 , 0 , GetScriptAreaParams "R3" );
			QCmd ( 1007 , 411 );
			QCmd ( 1007 , 412 );
			break;
		end;
	end;
end;

-------------------------------------------Panika

function Panika1()
 	while 1 do 
		Wait( 1 ); 
		if GetNUnitsInArea ( 0 , 'KolonaT1', 1 ) > 1 or GetNUnitsInArea ( 2 , 'KolonaT1', 1 ) > 1 then
			Cmd ( 7 , 1010 , 0 , GetScriptAreaParams "Out1" );
			QCmd ( 0 , 1010 , 200 , GetScriptAreaParams "KolonaT1" );
			QCmd ( 0 , 1010 , 0 , GetScriptAreaParams "Out1" );
			QCmd ( 1007 , 1010 );
			Wait ( 3 );
			Cmd ( 7 , 1015 , 0 , GetScriptAreaParams "Tank14" );
			QCmd ( 0 , 1015 , 200 , GetScriptAreaParams "KolonaT1" );
			QCmd ( 0 , 1015 , 0 , GetScriptAreaParams "R3" );
			QCmd ( 1007 , 1015 );
			Wait ( 4 );
			Cmd ( 7 , 1013 , 0 , GetScriptAreaParams "Tank13" );
			QCmd ( 0 , 1013 , 200 , GetScriptAreaParams "KolonaT1" );
			QCmd ( 0 , 1013 , 0 , GetScriptAreaParams "Out" );
			QCmd ( 1007 , 1013 );
			Wait ( 2 );
			Cmd ( 3 , 701 , 200 , "KolonaT1");
			Cmd ( 3 , 702 , 200 , "KolonaT1");
			Cmd ( 3 , 703 , 200 , "KolonaT1");
			Cmd ( 7 , 1014 , 0 , GetScriptAreaParams "Tank12" );
			QCmd ( 0 , 1014 , 200 , GetScriptAreaParams "KolonaT1" );
			QCmd ( 0 , 1014 , 0 , GetScriptAreaParams "R3" );
			QCmd ( 1007 , 1014 );
			Wait ( 5 );
			Cmd ( 3 , 704 , 200 , "KolonaT1");
			Cmd ( 3 , 705 , 200 , "KolonaT1");
			Cmd ( 3 , 706 , 200 , "KolonaT1");
			Cmd ( 7 , 1011 , 0 , GetScriptAreaParams "Tank11" );
			QCmd ( 0 , 1011 , 200 , GetScriptAreaParams "KolonaT1" );
			QCmd ( 0 , 1011 , 0 , GetScriptAreaParams "Out" );
			QCmd ( 1007 , 1011 );
			Wait ( 2 );
			Cmd ( 7 , 1012 , 0 , GetScriptAreaParams "Tank11" );
			QCmd ( 0 , 1012 , 200 , GetScriptAreaParams "KolonaT1" );
			QCmd ( 0 , 1012 , 0 , GetScriptAreaParams "R3" );
			QCmd ( 1007 , 1012 );
			break;
 		end;
	end;
end;

function Kolona()
	Wait ( 60 );
	LandReinforcementFromMap ( 1 , "11" , 34 , 750 );
	Cmd ( 0 , 750 , 0 , GetScriptAreaParams "KOL1" );
	QCmd ( 0 , 750 , 0 , GetScriptAreaParams "KOL2" );
	QCmd ( 0 , 750 , 0 , GetScriptAreaParams "KOL3" );
	QCmd ( 5 , 750 , 50 , GetScriptAreaParams "KOL4" );
	QCmd ( 6 , 750 , 555 );
	Wait ( 4 );
--	LandReinforcementFromMap ( 1 , "11" , 34 , 751 );
--	Cmd ( 0 , 751 , 0 , GetScriptAreaParams "KOL1" );
--	QCmd ( 0 , 751 , 0 , GetScriptAreaParams "KOL2" );
--	QCmd ( 5 , 751 , 50 , GetScriptAreaParams "KOL3" );
--	QCmd ( 6 , 751 , 556 );
	StartThread( KolonaOut );
end;

function Kolona2()
	Wait ( 110 );
	LandReinforcementFromMap ( 1 , "12" , 35 , 760 );
	Sleep ( 6 );
	Cmd( 0 , 760 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "Road6" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "Road5" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "Road4" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "J1" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "J2" );
 	QCmd( 0 , 760 , 0 , GetScriptAreaParams "J4" );
	QCmd ( 1007 , 760 );
	Wait ( 6 );
	LandReinforcementFromMap ( 1 , "12" , 35 , 761 );
	Sleep ( 5 );
	Cmd( 0 , 761 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "Road6" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "Road5" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "Road4" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "J1" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "J2" );
 	QCmd( 0 , 761 , 0 , GetScriptAreaParams "J4" );
	QCmd ( 1007 , 761 );
	Wait ( 6 );
	LandReinforcementFromMap ( 1 , "12" , 35 , 762 );
	Sleep ( 5 );
	Cmd( 0 , 762 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "Road6" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "Road5" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "Road4" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "J1" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "J2" );
 	QCmd( 0 , 762 , 0 , GetScriptAreaParams "J4" );
	QCmd ( 1007 , 762 );
	Wait ( 6 );
	LandReinforcementFromMap ( 1 , "12" , 35 , 763 );
	Sleep ( 5 );
	Cmd( 0 , 763 , 0 , GetScriptAreaParams "Djip0" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "Djip1" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "Djip2" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "Djip3" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "Djip4" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "Road6" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "Road5" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "Road4" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "J1" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "J2" );
 	QCmd( 0 , 763 , 0 , GetScriptAreaParams "J4" );
	QCmd ( 1007 , 763 );
end;

function KolonaOut()
 	while 1 do 
		Wait( 1 ); 
		if GetNUnitsInArea ( 0 , 'KolonaT2', 1 ) > 1 then
			Wait ( 5 );
			Cmd ( 0 , 750 , 0 , GetScriptAreaParams "Djip0" );
			QCmd ( 0 , 750 , 0 , GetScriptAreaParams "GoGoGo" );
			QCmd ( 1007 , 750 );
			Cmd ( 0 , 751 , 0 , GetScriptAreaParams "Djip0" );
			QCmd ( 0 , 751 , 0 , GetScriptAreaParams "GoGoGo" );
			QCmd ( 1007 , 751 );
			break;
 		end;
	end;
end;

-------------------------------------------Recon

function Recon()
 	while 1 do 
		Wait( 1 ); 
		if IsSomeBodyAlive ( 0 , 802 ) < 1 then 
			LandReinforcementFromMap (  0 , "0" , 0 , 802 );
			Cmd ( 0 , 802 , 0 , GetScriptAreaParams "KolonaT2" );
			break;
 		end;
	end;
end;

------------------------WIn_Loose 

function Unlucky()
 	while 1 do 
		Wait( 1 );
         if ( IsSomePlayerUnit( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
 			Wait( 1 ); 
			Win(1);
 			break; 
		end;
 	end;
end;

function ObjectiveSO()
	while 1 do 
		Wait( 1 );
 		if GetNUnitsInArea ( 0 , 'SOObjective', 0 ) > 0 then 
			LandReinforcementFromMap ( 0 , "2" , 1 , 1111 );
			Cmd ( 5 , 1111 , 0 , "Para" );
			Wait ( 2 );
			GiveObjective ( 4 );
			Sleep ( 1 );
			CompleteObjective ( 4 );
 			break;
 		end;
	end;
end;

StartThread( Start );