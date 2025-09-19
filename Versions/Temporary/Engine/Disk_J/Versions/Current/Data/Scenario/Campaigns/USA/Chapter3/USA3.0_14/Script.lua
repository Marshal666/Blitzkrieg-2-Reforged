AirPlane = 0;
Who = 0;
L = 0;
N = 0;
Nj = 0;
Na = 0;
Nt = 0;
--ViewZone ( "1" , 1 );
OBJ = 0;
NE = 0;
Eva = 0;
EvaD = 0;
timea = 0;

function Super()
	while 1 do
		Wait ( 1 );
		if IsSomeBodyAlive ( 0 , 901 ) < 1 then
			EnablePlayerSuperWeapon ( 0 , 0 );
			StartThread (SuperOK);
			break;
		end;	
	end;
end;

function SuperOK()
	while 1 do
		Wait ( 1 );
		if IsSomeBodyAlive ( 0 , 901 ) > 0 then
			EnablePlayerSuperWeapon ( 0 , 1 );
			StartThread (Super);
			break;
		end;	
	end;
end;

function Eng()
	while 1 do
		Wait ( 1 );
		if IsSomeBodyAlive ( 0 , 999 ) < 1 and IsSomeBodyAlive ( 0 , 901 ) > 0 then
			Wait ( 30 );
			LandReinforcementFromMap ( 0 , "1" , 0 , 999 );
			Wait ( 30 );
			StartThread (Eng);
			break;
		end;	
	end;
end;

function EastSeaBattle()
	Wait ( 1 );
	if IsSomeBodyAlive ( 1 , 601 ) > 0 and Nj < 5 then
		LandReinforcementFromMap ( 1 , "8" , 8 , 1100 );
		Nj = Nj + 1
		Cmd ( 3 , 1100 , 0 , "Boat1" );
		while 1 do 
			Wait( 1 );
			if IsSomeBodyAlive ( 1 , 1100 ) < 1 then
				Wait ( 180 + Random (180));
				StartThread (EastSeaBattle);
				break;
			else
				L = Random ( 2 );
				if L == 1 then
					Wait ( 10 )
					Cmd ( 3 , 1100 , 0 , "Boat1" );
				else
					Wait ( 10 );
					Cmd ( 3 , 1100 , 0 , "Boat2" );
				end;
			end;
		end;
	end;
end;

function USBoat()
	Wait ( 10 + Random ( 10 ));
	LandReinforcementFromMap ( 0 , "0" , 4 , 2100 );
	Cmd ( 0 , 2100 , 0 , "USBoat" );
end;

function Evacuator()
	Wait ( 60 + Random ( 60 ));
	LandReinforcementFromMap ( 1 , "7" , 6 , 2000 );
	Cmd ( 0 , 2000 , 0 , "Landing1" );
end;

--------------------------------------------------Landing

function TankLanding()
	Wait ( 120 + Random ( 90 ));
	if IsSomeBodyAlive ( 1 , 601 ) > 0 and Nt < 20 then
		Nt = Nt + 1;
		LandReinforcementFromMap ( 1 , "6" , 0 , 1000 );
		Cmd ( 0 , 1000 , 0 , "Landing" );
		while 1 do 
			Wait( 1 );
			if IsSomeUnitInArea ( 1 , 'Landing', 0 ) > 0 then
				Wait ( 1 );
				L = Random ( 2 );
				if L == 1 then
					LandReinforcementFromMap ( 1 , "4" , 5 , 1001 );
					Cmd ( 3 , 1001 , 0 , "Rezerv" );
				else
					LandReinforcementFromMap ( 1 , "5" , 5 , 1002 );
					Cmd ( 0 , 1002 , 0 , "Rezerv" );
				end;
				Cmd ( 0 , 1000 , 0 , "Sea" );
				QCmd ( 1007 , 1000 );
				StartThread (TankLanding);
				break;
			end;
		end;
	end;
end;

function USLanding()
	Wait ( 120 + Random ( 90 ));
	if Na < 20 then
		LandReinforcementFromMap ( 2 , "0" , 0 , 3000 );
		Na = Na + 1;
		Cmd ( 0 , 3000 , 0 , "LandingUS" );
		while 1 do 
			Wait( 1 );
			timea = timea + 1;
			if timea > 30 then
				StartThread (USLanding);
			end;
			if GetNScriptUnitsInArea ( 3000 , 'LandingUS', 0 ) > 0 then
				timea = 0;
				Wait ( 6);
				L = Random ( 2 );
				Sleep ( 1 );
				if L == 1 then
					LandReinforcementFromMap ( 2 , "1" , 1 , 30001 );
				else
					LandReinforcementFromMap ( 2 , "2" , 1 , 30001 );
				end;
				Wait ( 1 );
				L1 = Random ( 2 );
				Sleep ( 1 );
				if L1 == 1 then
					Cmd ( 3 , 30001 , 0 , "USAtack1" );
				else
					Cmd ( 3 , 30001 , 0 , "USAtack2" );
				end;
				Wait ( 2 );
				Cmd ( 0 , 3000 , 0 , "SeaUS" );
				QCmd ( 1007 , 3000 );
				StartThread (USLanding);
				break;
			end;
		end;
	end;
end;

--------------------------------------------------Air
function AirAlert()
	while 1 do
		Wait( 90 + Random ( 90 ));
		if IsSomeBodyAlive ( 1 , 401 ) > 0 then
			Who = Random ( 3 );
			if Who == 1 then
				StartThread (AirGAP);
			break;
			end;
			if Who == 2 then
				StartThread (AirBomb);
			break;
			else
				StartThread (AirRecon);
			break;
			end;
		end;	
	end;
end;

function AirGAP()
	if IsSomeBodyAlive ( 1 , 4012 ) < 1 then
		LandReinforcementFromMap ( 1 , "1" , 1 , 4012 );
		Cmd ( 3 , 4012 , 100 , "AirPatrol1" );
		QCmd ( 3 , 4012 , 100 , "AirPatrol2" );
		QCmd ( 3 , 4012 , 100 , "AirPatrol3" );
		QCmd ( 3 , 4012 , 100 , "USHQ" );
		Wait ( 30 + Random (20));
		StartThread (AirAlert);
	else
		StartThread (AirAlert);	
	end;
end;

function AirBomb()
	if IsSomeBodyAlive ( 1 , 4013 ) < 1 then
		LandReinforcementFromMap ( 1 , "2" , 1 , 4013 );
		Cmd ( 0 , 4013 , 300 , "USHQ" );
		Wait ( 50 + Random (30));
		StartThread (AirAlert);
	else
		StartThread (AirAlert);	
	end;
end;

function AirRecon()
	if IsSomeBodyAlive ( 1 , 4014 ) < 1 then
		LandReinforcementFromMap ( 1 , "3" , 1 , 4014 );
		Cmd ( 0 , 4014 , 100 , "AirPatrol1" );
		QCmd ( 0 , 4014 , 100 , "AirPatrol2" );
		QCmd ( 0 , 4014 , 100 , "AirPatrol3" );
		QCmd ( 0 , 4014 , 100 , "USHQ" );
		Wait ( Random (10));
		StartThread (AirAlert);
	else
		StartThread (AirAlert);
	end;
end;

function AirDefence()
	while 1 do
		Wait( 1 );
		AirPlane = GetNUnitsInArea ( 0 , 'USHQ', 1 ) - GetNUnitsInArea ( 0 , 'USHQ', 0 );
		if AirPlane > 3 and IsSomeBodyAlive ( 1 , 401 ) > 0 then
			LandReinforcementFromMap ( 1 , "0" , 1 , 4011 );
			Wait ( 2 );
			LandReinforcementFromMap ( 1 , "0" , 1 , 4012 );
			Wait ( 90 + Random (60));
		end;	
	end;
end;

--------------------------------------------------Start

function Damage()
	Sleep ( 1 );
	DamageScriptObject ( 1 , 200 );
	Sleep ( 1 );
end;


--------------------------------------------------Objectives

function Objective0()
	ObjectiveChanged ( 0 , 1 );
	StartThread( CompleteObjective0 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 401 ) < 1 then
			ObjectiveChanged ( 0 , 2 );
			OBJ = OBJ + 1;
			StartThread( NoCompleteObjective0 );
			break;
		end;	
	end;
end;

function NoCompleteObjective0()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 401 ) > 0 then
			ObjectiveChanged ( 0 , 1 );
			OBJ = OBJ - 1;
			StartThread( CompleteObjective0 );
			break;
		end;	
	end;
end;

function Objective1()
	ObjectiveChanged ( 1 , 1 );
	StartThread( CompleteObjective1 );
end;

function CompleteObjective1()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 444 ) < 1 then
			ObjectiveChanged ( 1 , 2 );
			OBJ = OBJ + 1;
			StartThread (Objective2);
			StartThread (USLanding);
			StartThread (EastSeaBattle);
			StartThread (USBoat);
			break;
		end;	
	end;
end;

function Objective2()
	ObjectiveChanged ( 2 , 1 );
	StartThread( CompleteObjective2 );
end;

function CompleteObjective2()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 601 ) < 1 then
			ObjectiveChanged ( 2 , 2 );
			OBJ = OBJ + 1;
			StartThread( NoCompleteObjective2 );
			break;
		end;	
	end;
end;

function NoCompleteObjective2()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 601 ) > 0 then
			ObjectiveChanged ( 2 , 1 );
			OBJ = OBJ - 1;
			StartThread( CompleteObjective2 );
			break;
		end;	
	end;
end;

function Objective3()
	while 1 do
		Wait( 1 );
		if OBJ > 1 then
			ObjectiveChanged ( 3 , 1 );
			StartThread( CompleteObjective3 );
			StartThread( CompleteObjectiveSO );
			StartThread( Evacuator );
			break;
		end;	
	end;
end;

function CompleteObjective3()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 801 ) < 1 then
			ObjectiveChanged ( 3 , 2 );
			OBJ = OBJ + 1;
			break;
		end;	
	end;
end;

function CompleteObjectiveSO()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , 'Eva', 0 ) < 1 and Eva < 15 then
			ObjectiveChanged ( 4 , 1 );
			Sleep ( 1 );
			ObjectiveChanged ( 4 , 2 );
			break;
		end;	
	end;
end;

--------------------------------------------------WinLoose

function Victory()
	while 1 do
		Wait( 1 );
		if OBJ > 3 then
			Win ( 0 );
			break;
		end;	
	end;
end;

function Defeat()
	while 1 do
		Wait( 1 );
        if (( IsSomePlayerUnit( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			break;
		end;
	end;
end;

StartThread (Damage);
StartThread (AirAlert);
StartThread (TankLanding);
StartThread (Objective0);
StartThread (Objective1);
StartThread (Objective3);
StartThread (Victory);
StartThread (Defeat);
StartThread (Eng);

if GetDifficultyLevel() == 1 or GetDifficultyLevel() == 2 then
	StartThread (AirDefence);
end;