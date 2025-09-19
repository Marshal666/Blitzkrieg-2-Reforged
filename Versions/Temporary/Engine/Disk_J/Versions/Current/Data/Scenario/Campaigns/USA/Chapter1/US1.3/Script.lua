N = 1;

CO1 = 0;
CO2 = 0;

TruckN = 4;

function Desant()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 0 , 'Desant', 0) > 0 then 
			LandReinforcementFromMap ( 2 , "2" , 4 , 5010 );
			Cmd ( 0 , 5010 , 0 , "Desant1" );
			while 1 do 
				Wait( 1 );
				if IsSomeUnitInArea ( 2 , 'Desant1', 0) > 0 then 
					LandReinforcementFromMap ( 2 , "3" , 5 , 5001 );
					StartThread( DesantA );
					Wait ( 1 );
					break;
				end;
			end;
			break;
 		end;
	end;
end;

function DesantA()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 0 , 'DesantA', 0) > 0 then 
			Cmd ( 3 , 5001 , 0 , "Fuel" );
			StartThread( DesantD );
			break;
 		end;
	end;
end;

function DesantD()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 0 , 'Fight', 0) < 1 then 
			Cmd ( 0 , 5001 , 0 , "Fuel" );
			break;
 		end;
	end;
end;

Cmd(ACT_UNLOAD, 500, 0, GetScriptAreaParams ("Para"));

function AAFuel()
 	while 1 do 
		Wait( 1 );
 		if GetNUnitsInScriptGroup ( 401 , 1 ) < 1 then 
			StartThread( Blow1 );
			DamageScriptObject ( 6000 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 6001 , 100 );
			Wait ( 2 );
			DamageScriptObject ( 6002 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 6003 , 100 );
 			break;
 		end;
 		if GetNUnitsInScriptGroup ( 402 , 1 ) < 1 then 
			StartThread( Blow2 );
			DamageScriptObject ( 6000 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 6001 , 100 );
			Wait ( 2 );
			DamageScriptObject ( 6002 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 6003 , 100 );
 			break;
 		end;
 		if GetNUnitsInScriptGroup ( 403 , 1 ) < 1 then 
			StartThread( Blow3 );
			DamageScriptObject ( 6000 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 6001 , 100 );
			Wait ( 2 );
			DamageScriptObject ( 6002 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 6003 , 100 );
 			break;
 		end;
	end;
end; 

function Blow1()
	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 1 , 'Fuel1', 0) < 1 then 
			ViewZone ( "Fuel1" , 1 );
			CO2 = 1;
			Wait ( 10 );
			DamageScriptObject ( 510 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 502 , 100 );
			Wait ( 1 );
			DamageScriptObject ( 504 , 100 );
			Wait ( 2 );
			DamageScriptObject ( 503 , 100 );
			Wait ( 1 );
			DamageScriptObject ( 5000 , 100 );
			Wait ( 2 );
			ViewZone ( "Fuel1" , 0 );
			break;
 		end;
	end;
end;

function Blow3()
	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 1 , 'Fuel1', 0) < 1 then 
			ViewZone ( "Fuel1" , 1 );
			CO2 = 1;
			Wait ( 10 );
			DamageScriptObject ( 503 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 504 , 100 );
			Wait ( 1 );
			DamageScriptObject ( 502 , 100 );
			Wait ( 2 );
			DamageScriptObject ( 510 , 100 );
			Wait ( 2 );
			Wait ( 1 );
			DamageScriptObject ( 5000 , 100 );
			ViewZone ( "Fuel1" , 0 );
		end;
	end;
end;

function Blow2()
	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 1 , 'Fuel1', 0) < 1 then 
			ViewZone ( "Fuel1" , 1 );
			CO2 = 1;
			Wait ( 10 );
			DamageScriptObject ( 502 , 100 );
			Wait ( 3 );
			DamageScriptObject ( 510 , 100 );
			Wait ( 1 );
			DamageScriptObject ( 503 , 100 );
			Wait ( 2 );
			DamageScriptObject ( 504 , 100 );
			Wait ( 2 );
			Wait ( 1 );
			DamageScriptObject ( 5000 , 100 );
			ViewZone ( "Fuel1" , 0 );
		end;
	end;
end;

function Fighter()
	Sleep ( 25 );
	DamageScriptObject ( 500 , 85 );
	Wait ( 3 );
	ChangePlayerForScriptGroup ( 501 , 3 );
	StartThread( Patrol1 );
	Wait ( 20 );
	Cmd ( 0 , 501 , 0 , "Patrol20" );
	Cmd ( 3 , 504 , 0 , "Patrol20" );
end;

function Patrol()
 	while 1 do 
		Wait( 1 );
 		if GetNScriptUnitsInArea ( 120 , 'Patrol5', 0 ) > 0 then 
			StartThread( Patrol1 );
 			break;
 		end;
	end;
end; 

function Patrol0()
 	while 1 do 
		Wait( 1 );
 		if GetNScriptUnitsInArea ( 121 , 'Patrol20', 0 ) > 0 then 
			StartThread( Patrol10 );
 			break;
 		end;
	end;
end; 

function Patrol100()
 	while 1 do 
		Wait( 1 );
 		if GetNScriptUnitsInArea ( 125 , 'Patrol100', 0 ) > 0 then 
			StartThread( Patrol01 );
 			break;
 		end;
	end;
end; 

function Patrol01()
 	Cmd ( 3 , 125 , 0 , "Patrol101" );
 	QCmd ( 3 , 125 , 0 , "Patrol102" );
 	QCmd ( 3 , 125 , 0 , "Patrol103" );
 	QCmd ( 3 , 125 , 0 , "Patrol100" );
 	Wait ( 10 );
 	StartThread( Patrol100 );
end;

function Patrol101()
 	while 1 do 
		Wait( 1 );
 		if GetNScriptUnitsInArea ( 126 , 'Patrol102', 0 ) > 0 then 
			StartThread( Patrol02 );
 			break;
 		end;
	end;
end; 

function Patrol02()
 	Cmd ( 3 , 126 , 0 , "Patrol103" );
 	QCmd ( 3 , 126 , 0 , "Patrol100" );
 	QCmd ( 3 , 126 , 0 , "Patrol101" );
 	QCmd ( 3 , 126 , 0 , "Patrol102" );
 	Wait ( 10 );
 	StartThread( Patrol101 );
end;

function Patrol10()
 	Cmd ( 3 , 121 , 0 , "Patrol10" );
 	QCmd ( 3 , 121 , 0 , "Patrol20" );
 	Wait ( 10 );
 	StartThread( Patrol0 );
end; 

function Patrol1()
 	Cmd ( 3 , 120 , 0 , "Patrol1" );
 	QCmd ( 3 , 120 , 0 , "Patrol2" );
 	QCmd ( 3 , 120 , 0 , "Patrol3" );
 	QCmd ( 3 , 120 , 0 , "Patrol4" );
 	QCmd ( 3 , 120 , 0 , "Patrol5" );
 	Wait ( 10 );
 	StartThread( Patrol );
end; 

function Alert()
	Wait ( 10 );
	Num = GetNUnitsInArea ( 1 , 'Camp', 0 );
 	while 1 do 
		Wait( 1 );
		if GetNUnitsInArea ( 1 , 'Camp', 0 ) < Num-1 then 
			Wait ( 10 );
			StartThread( AlertCars );
 			break;
 		end;
	end;
end;

function AlertCars()
	Wait ( 10 );
 	Cmd ( 7 , 203 , 0 , "Out1" );
 	QCmd ( 0 , 203 , 100 , "108" );
 	Wait ( 2 );
 	Cmd ( 7 , 204 , 0 , "Out2" );
 	QCmd ( 0 , 204 , 100 , "109" );
 	Wait ( 5 );
 	Cmd ( 4 , 203 , 108 );
 	Wait ( 1 );
 	Cmd ( 4 , 204 , 109 );
 	Wait ( 5 );
	ChangePlayerForScriptGroup ( 108 , 1 );
	ChangePlayerForScriptGroup ( 109 , 1 );
 	Cmd ( 0 , 108 , 0 , "Road5" );
 	QCmd ( 1007 , 108 );
 	Wait ( 1 );
 	Cmd ( 0 , 109 , 0 , "Road5" );
 	QCmd ( 1007 , 109 );
end; 

function Pilot()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea ( 0 , 'Patrol20', 0 ) > 0 and IsSomeUnitInArea ( 1 , 'Patrol20', 0 ) < 1 then 
			GiveObjective ( 2 );
			Sleep ( 1 );
			CompleteObjective ( 2 );
			ChangePlayerForScriptGroup ( 501 , 2 );
			Cmd ( 0 , 501 , 0 , "Off" );
			Wait ( 5 );
			SwitchWeather ( 0 );
			SwitchWeatherAutomatic ( 0 );
			Wait ( 15 );
			LandReinforcementFromMap ( 2 , "1" , 2 , 500 );
			Cmd ( 0 , 500 , 0 , "Bomb2" );
			Wait ( 1 );
			LandReinforcementFromMap ( 2 , "1" , 3 , 5002 );
			Cmd ( 0 , 5002 , 0 , "Bomb1" );
			Wait ( 30 );
			SwitchWeatherAutomatic ( 1 );
 			break;
 		end;
	end;
end;

------------------------------------------------OBJ

function Objective()
	GiveObjective ( 0 );
 	StartThread( CompleteObjective0 );
 	Wait( 1 );
end; 

function Objective1()
	GiveObjective ( 1 );
	StartThread( CompleteObjective1 );
 	Wait( 1 );
end;

function CompleteObjective0()
 	while 1 do 
		Wait( 1 );
 		if IsSomeUnitInArea( 1 , "Line1" , 0 ) < 1 then
			CompleteObjective ( 0 );
			StartThread( Objective1 );
 		break;
 		end;
	end;
end;

function CompleteObjective1()
 	while 1 do 
		Wait( 1 );
 		if IsSomeBodyAlive ( 1 , 1500 ) < 1 then
			CompleteObjective ( 1 );
			StartThread( Objective2 );
 		break;
 		end;
	end;
end;

function Objective2()
	GiveObjective ( 3 );
	StartThread( CompleteObjective2 );
 	Wait( 1 );
end;

function CompleteObjective2()
 	while 1 do 
		Wait( 1 );
 		if CO2 == 1 then
			Wait ( 3 );
			CompleteObjective ( 3 );
			Wait ( 15 );
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

StartThread( Fighter );
StartThread( Patrol );
StartThread( Patrol0 );
StartThread( Patrol100 );
StartThread( Patrol101 );
StartThread( Alert );

StartThread( AAFuel );

StartThread( Pilot );
StartThread( Desant );

Cmd ( 0 , 523 , 0 , "Sea" );
QCmd ( 1007 , 523 );
Wait ( 30 );
Cmd ( 0 , 760 , 0 , "Road5" );
QCmd ( 1007 , 760 );