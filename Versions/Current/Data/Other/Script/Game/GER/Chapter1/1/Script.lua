x = {};
y = {};
x1 = {};
y1 = {};
MWL = 0;
Kol1 = 6;
a = 1; a1 = 1;

-----------------------Retirate
function Retirate0()
	while 1 do
		Wait( 1 );
		Kol1 = IsSomeBodyAlive ( 1 , 701 ) + IsSomeBodyAlive ( 1 , 702 ) + IsSomeBodyAlive ( 1 , 703 ) + IsSomeBodyAlive ( 1 , 704 ) + IsSomeBodyAlive ( 1 , 705 ) + IsSomeBodyAlive ( 1 , 706 );
		if (Kol1 < 4) then
			Wait( 3 );
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
			Wait( 3 );
			for a1 = 1 , 6 do
				Sleep ( 1 );
				Cmd ( 0, 706+a , 0 , GetScriptAreaParams ( "Tank24" ) );
				QCmd ( 0, 706+a , 0 , GetScriptAreaParams ( "Road1" ) );
				QCmd ( 0, 706+a , 0 , GetScriptAreaParams ( "Road2" ) );
				QCmd ( 0, 706+a , 0 , GetScriptAreaParams ( "Road3" ) );
				QCmd ( 0, 706+a , 0 , GetScriptAreaParams ( "R2" ) );
				QCmd ( 1007 , 700+a );
			end;
			break;
		end;
	end;
end;
-----------------------Air

-----------------------Picnik
function Picnik()
	Cmd( 4 , 301 , 300 );
	Wait( 6 );
	Cmd( 5 , 300 , 0 , GetScriptAreaParams ( "Blok1" ) );
	while 1 do
		Wait( 1 );
		if (GetNScriptUnitsInArea( 301 , "Blok1" , 0 ) == 2)  then
			Wait( 1 );
			Cmd( 0 , 301 , 0 , GetScriptAreaParams ( "j1" ) );
			Wait( 2 );
			Cmd( 9 , 301 );
			Wait( 4 );
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
			Wait( 3 );
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
	x [ 1 ] = 3395; x [ 2 ] = 3560; x [ 3 ] = 3752; x [ 4 ] = 3895; x [ 5 ] = 4301;
	y [ 1 ] = 167; y [ 2 ] = 723; y [ 3 ] = 1098; y [ 4 ] = 1531; y [ 5 ] = 1310;
	x1 [ 1 ] = 4758; x1 [ 2 ] = 4137; x1 [ 3 ] = 3707; x1 [ 4 ] = 3599; x1 [ 5 ] = 4356;
	y1 [ 1 ] = 5199; y1 [ 2 ] = 4960; y1 [ 3 ] = 4642; y1 [ 4 ] = 4219; y1 [ 5 ] = 5447;
	a = 1; a1 = 1;
	while 1 do
		Sleep( 1 );
		if (GetNScriptUnitsInArea ( 302 , "GoGoGo" , 0 ) > 0)  then
			Sleep( 1 );
			StartThread( AAGun1 );
			break;
		end;
	end;
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
	while 1 do
		Sleep ( 1 );
		if (GetNScriptUnitsInArea ( 306 , "R2" , 0 ) > 0)  then
			Sleep ( 1 );
			StartThread( AAGun2 );
			break;
		end;
	end;
end;
function Trevoga2()
	Wait( 10 );
	Cmd( 0 , 300 , 0 , GetScriptAreaParams ( "Road10" ) );
	QCmd( 0 , 300 , 0 , GetScriptAreaParams ( "Tank21" ) );
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
	while 1 do
		Sleep ( 1 );
		if (GetNScriptUnitsInArea ( 300 , "R3" , 0 ) > 0)  then
			Sleep ( 1 );
			break;
		end;
	end;
end;
-----------------------AAGun
function AAGun1()
	Wait( 20 );
	b = 101 + a;
	Wait( 3 );
	StartThread( AAGun10 );
end;
function AAGun10()
	Wait ( 3 );
	LandReinforcementFromMap( 1 , "1" , 0 , b );
	Cmd( 0 , b , 0 , 2958.99 , 3233.06 );
	QCmd( 0 , b , 0 , 3553.26 , 2723.01 );
	QCmd( 0 , b , 0 , 4069.38 , 1628.87 );
	QCmd( 32 , b , 0 , x [ a ] , y [ a ] );
	QCmd( 0 , b , 0 , 3303 , 30 );
	QCmd( 0 , b , 0 , 2544 , 30 );
	QCmd( 0 , b , 0 , 2486 , 696 );
	a = a + 1;
	if ( a ) < 6  then
		Wait ( 10 );
		StartThread( AAGun1 );
	end;
end;
function AAGun2()
	Wait( 20 );
	b1 = 106 + a1;
	Wait( 3 );
	StartThread( AAGun20 );
end;
function AAGun20()
	Wait ( 3 );
	LandReinforcementFromMap( 1 , "1" , 1 , b1 );
	Cmd( 0 , b1 , 0 , 1453.37 , 7206.78 );
	QCmd( 0 , b1 , 0 , 1856.44 , 6415.03 );
	QCmd( 0 , b1 , 0 , 3229.01 , 4288.91 );
	QCmd( 32 , b1 , 0 , x1 [ a1 ] , y1 [ a1 ] );
	QCmd( 0 , b1 , 0 , 3467.59 , 5172.75 );
	a1 = a1 + 1;
	if ( a1 ) < 6  then
		Wait ( 10 );
		StartThread( AAGun2 );
	end;
end;
-----------------------Objective
function Objective()
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0", 1 );
	tank1 = 0;
	tank2 = 0;
	StartThread( Find1 );
	StartThread( Find2 );
	StartThread( CompleteObjective0 );
	Wait( 3 );
end;
function Find1()
	while 1 do
		Wait( 1 );
		if (IsSomeUnitInArea ( 0 , 'KolonaT1', 1 ) > 0) then
			tank1 = 1;
			break;
		end;	
	end;
end;
function Find2()
	while 1 do
		Wait( 1 );
		if (IsSomeUnitInArea ( 0 , 'KolonaT2', 1 ) > 0) then
			tank2 = 1;
			break;
		end;	
	end;
end;			
function CompleteObjective0()
	while 1 do
		Wait( 1 );
		if (tank1 == 1)  and (tank2 == 1) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0", 2 );
			Wait( 3 );
			EnablePlayerReinforcement( 15 , 1);
			StartThread( Objective1 );
			break;
		end;	
	end;
end;
function Objective1()
	ObjectiveChanged(1, 1); 
	SetIGlobalVar( "temp.objective1", 1 );
	StartThread( CompleteObjective1 );
	Wait( 3 );
end;
function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if (Kol1 < 4)  and (Kol2 < 4) then
			ObjectiveChanged(1, 2);
			SetIGlobalVar( "temp.objective1", 2 );
			StartThread( Winner );
			Wait( 3 );
			break;
		end;	
	end;
end;
------------------------WIn_Loose
function Winner()
	while 1 do
		Wait( 5 );
		if MWL == 0 then
			MWL = 1;
			Wait( 3 );
			Win(0);
			break;
		end;
	end;

end;
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
-------------------------------------------Film
function Film()
	Wait ( 1 );
	ShowMovieBorder ( );
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
	ViewZone ( "Camera1" , 1 );
	ViewZone ( "Camera2" , 1 );
	ViewZone ( "Camera3" , 1 );
	ViewZone ( "Camera", 1 );
	Wait ( 1 );
	SCRunTime ("Scene01frame01" , "Scene01frame02" , 9 );
	Wait ( 4 );
	Cmd( 3 , 599 , 0 , 2176.83 , 3463.55 );
	Wait ( 2 );
	Cmd( 0 , 599 , 0 , 2176.83 , 3463.55 );
	Wait ( 3 );
	LandReinforcementFromMap ( 1 , "3" , 7 , 609 );
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
	RemoveScriptGroup ( 600 );
	RemoveScriptGroup ( 602 );
	RemoveScriptGroup ( 604 );
	RemoveScriptGroup ( 606 );
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
	LandReinforcementFromMap ( 1 , "2" , 19 , 703 );
	Cmd( 0 , 700 , 0 , GetScriptAreaParams "Tank14" );
	Sleep ( 10 );
	Cmd( 0 , 701 , 0 , GetScriptAreaParams "Tank13" );
	Sleep ( 10 );
	Cmd( 0 , 702 , 0 , GetScriptAreaParams "Tank12" );
	Sleep ( 15 );
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
	ChangePlayerForScriptGroup( 802 , 0 );
	Cmd( 0 , 802 , 0 , GetScriptAreaParams "J1" );
	QCmd( 0 , 802 , 0 , GetScriptAreaParams "J3" );
	QCmd( 0 , 802 , 0 , GetScriptAreaParams "J1" );
	Sleep ( 5 );
	Wait ( 1 );
	SCRunTime ("Scene05frame01" , "Scene05frame02" ,  4 );
	Wait ( 4 );
	SCRunTime ("Scene05frame02" , "Scene05frame03" ,  4 );
	Wait ( 1 );
	LandReinforcementFromMap ( 1 , "6" , 21 , 303 );
	Wait ( 3 );
	ViewZone ( "Camera2" , 0 );
	ViewZone ( "Camera3" , 0 );
	HideMovieBorder ( );
	Wait ( 1 );
	SCReset ();
	EnablePlayerReinforcement( 15 , 0);
	StartThread( Start );
end;
-------------------------------------------Start
function Start()
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
	LandReinforcementFromMap ( 1 , "9" , 28 , 707 );
	LandReinforcementFromMap ( 1 , "9" , 29 , 708 );
	LandReinforcementFromMap ( 1 , "10" , 30 , 709 );
	LandReinforcementFromMap ( 1 , "10" , 31 , 710 );
	LandReinforcementFromMap ( 1 , "9" , 32 , 711 );
	LandReinforcementFromMap ( 1 , "9" , 33 , 712 );
	StartThread( Unlucky );
	StartThread( Objective );
	StartThread( Picnik );
	StartThread( Retirate0 );
	StartThread( Retirate1 );
end;

StartThread( Film );