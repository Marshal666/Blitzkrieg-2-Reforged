Go = 0;

function Alive()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 2 , 2000 ) < 1 then
		Wait ( 20 );
		LandReinforcementFromMap ( 2 , "0" , 0 , 2000 );
		Wait ( 20 );
		end;
	end;
end;

function IboNefig()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea ( 0 , 'HQ', 0) > 15 then
			Trace ("IboNefig");
			LandReinforcementFromMap ( 1 , "2" , 4 , 2100 );
			Cmd ( 3 , 2100 , 0 , GetScriptAreaParams "Step3" );
			QCmd ( 3 , 2100 , 0 , GetScriptAreaParams "HQ" );
			Wait ( 2 );
			LandReinforcementFromMap ( 1 , "2" , 4 , 2101 );
			Cmd ( 3 , 2101 , 0 , GetScriptAreaParams "Step3" );
			QCmd ( 3 , 2101 , 0 , GetScriptAreaParams "HQ" );
			Wait ( 4 );
			LandReinforcementFromMap ( 1 , "1" , 4 , 2102 );
			Cmd ( 3 , 2102 , 0 , GetScriptAreaParams "Step3" );
			QCmd ( 3 , 2102 , 0 , GetScriptAreaParams "HQ" );
			Wait ( 2 );
			LandReinforcementFromMap ( 1 , "1" , 4 , 2103 );
			Cmd ( 3 , 2103 , 0 , GetScriptAreaParams "Step3" );
			QCmd ( 3 , 2103 , 0 , GetScriptAreaParams "HQ" );
			Wait ( 2 );
			break;
		end;
	end;
end;


function Fire()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Road1', 0 ) > 0 or IsSomeUnitInArea ( 0 , 'Zasada', 0 ) > 0 then
			Trace ("Fire");
			Cmd ( 3 , 122 , 100 , GetScriptAreaParams "Gun2" );
			break;
		end;
	end;
end;

function Gun()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , "Road1" , 0 ) > 0 then
			Cmd ( 0 , 1117 , 0 , GetScriptAreaParams "Gun1" );
			QCmd ( 8 , 1117 , 0 , GetScriptAreaParams "Gun2" );
			StartThread (Gun1);
			break;
		end;
	end;
end;

function Gun1()
	while 1 do
		Wait( 1 );
		if GetNUnitsInScriptGroup ( 122 , 1 ) < 1 then
			Cmd ( 0 , 1117 , 0 , GetScriptAreaParams "Step_4" );
			StartThread (Gun2);
			break;
		end;
	end;
end;

function Gun2()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , "Zasada" , 0 ) > 0 then
			Cmd ( 0 , 1117 , 0 , GetScriptAreaParams "Gun2" );
			break;
		end;
	end;
end;

function Japan()
	Wait ( 30 + Random(30));
	if GetNUnitsInScriptGroup ( 2222 , 1 ) > 0 then
		LandReinforcementFromMap ( 1 , "1" , 2 , 1012 );
		Cmd ( 3 , 1012 , 10 , GetScriptAreaParams "Base_22" );
		QCmd ( 3 , 1012 , 10 , GetScriptAreaParams "Art1" );
		LandReinforcementFromMap ( 1 , "2" , 3 , 1012 );
		Cmd ( 3 , 1012 , 10 , GetScriptAreaParams "Base_22" );
		QCmd ( 3 , 1012 , 10 , GetScriptAreaParams "Sklad" );
	end;
end;

function Base1()
	while 1 do
		Wait( 1 );
		if GetNUnitsInScriptGroup ( 1030 , 1 ) < 1 then
			Cmd ( 3 , 1031 , 200 , GetScriptAreaParams "base1" );
			Wait ( 5 );
			Cmd ( 9 , 1031 );
			break;
		end;
	end;
end;

function Base10()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "base1" , 0 ) < 1 then
			LandReinforcementFromMap ( 1 , "1" , 0 , 1032 );
			Cmd ( 3 , 1032 , 100 , GetScriptAreaParams "base1" );
			break;
		end;
	end;
end;

function SkladA()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , "Base_22" , 0 ) > 0 then
			Cmd ( 3 , 1011 , 10 , GetScriptAreaParams "Base_22" );
			break;
		end;
		if IsSomeUnitInArea ( 0 , "Sklad" , 0 ) > 0 then
			Cmd ( 3 , 1011 , 10 , GetScriptAreaParams "Patrol1" );
			Go = 1;
			StartThread (PatrolA);
			break;
		end;
		if Go == 0 then
			Cmd ( 0 , 1011 , 10 , GetScriptAreaParams "Patrol1" );
			Go = 1;
			StartThread (PatrolS);
			break;
		end;
	end;
end;


function SkladS()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , "Base_22" , 0 ) > 0 then
			Cmd ( 3 , 1011 , 10 , GetScriptAreaParams "Base_22" );
			break;
		end;
		if IsSomeUnitInArea ( 0 , "Sklad" , 0 ) < 1 then
			Cmd ( 0 , 1011 , 10 , GetScriptAreaParams "Patrol1" );
			Go = 1;
			StartThread (PatrolS);
			break;
		end;
		if Go == 0 then
			Cmd ( 3 , 1011 , 10 , GetScriptAreaParams "Patrol1" );
			Go = 1;
			StartThread (PatrolA);
			break;
		end;
	end;
end;

function PatrolA()
	Trace ("Agresiv");
	QCmd ( 3 , 1011 , 10 , GetScriptAreaParams "Patrol2" );
	QCmd ( 3 , 1011 , 10 , GetScriptAreaParams "Patrol3" );
	QCmd ( 3 , 1011 , 10 , GetScriptAreaParams "Patrol4" );
	QCmd ( 3 , 1011 , 10 , GetScriptAreaParams "Patrol1" );
	Wait ( 1 );
	StartThread (SkladS);
	Wait ( 11 );
	Go = 0;
end;

function PatrolS()
	Trace ("Silence");
	QCmd ( 0 , 1011 , 10 , GetScriptAreaParams "Patrol2" );
	QCmd ( 0 , 1011 , 10 , GetScriptAreaParams "Patrol3" );
	QCmd ( 0 , 1011 , 10 , GetScriptAreaParams "Patrol4" );
	QCmd ( 0 , 1011 , 10 , GetScriptAreaParams "Patrol1" );
	Wait ( 1 );
	StartThread (SkladA);
	Wait ( 11 );
	Go = 0;
end;

function Barels()
	while 1 do
		Wait ( 1 );
		if GetNUnitsInScriptGroup ( 1011 , 1 ) < 1 then
			DamageScriptObject ( 222 , 100 );
			Wait ( 2 );
			DamageScriptObject ( 223 , 100 );
			break;
		end;
	end;
end;

function Zasada()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "Art1" , 0 ) > 0  and IsSomeUnitInArea ( 0 , "Zasada" , 0 ) > 0 then
			Wait ( 5 );
			LandReinforcementFromMap ( 1 , "0" , 4 , 1010 );
			Cmd ( 0 , 1010 , 30 , GetScriptAreaParams "Zasada" );
			QCmd ( 0 , 1010 , 0 , GetScriptAreaParams "Step_6" );
			QCmd ( 0 , 1010 , 30 , GetScriptAreaParams "Step_7" );
			QCmd ( 3 , 1010 , 50 , GetScriptAreaParams "Zasada" );
			break;
		end;	
	end;
end;

function Colona()
	LandReinforcementFromMap ( 1 , "3" , 5 , 1014 );
	Cmd ( 0 , 1014 , 0 , GetScriptAreaParams "Step_8" );
	QCmd ( 0 , 1014 , 0 , GetScriptAreaParams "Step_7" );
	QCmd ( 0 , 1014 , 0 , GetScriptAreaParams "Step_6" );
	QCmd ( 0 , 1014 , 0 , GetScriptAreaParams "FleeK" );
	QCmd ( 1007 , 1014 );
	Wait ( 7 );
	LandReinforcementFromMap ( 1 , "3" , 5 , 1015 );
	Cmd ( 0 , 1015 , 0 , GetScriptAreaParams "Step_8" );
	QCmd ( 0 , 1015 , 0 , GetScriptAreaParams "Step_7" );
	QCmd ( 0 , 1015 , 0 , GetScriptAreaParams "Step_6" );
	QCmd ( 0 , 1015 , 0 , GetScriptAreaParams "FleeK" );
	QCmd ( 1007 , 1015 );
end;

function Tanks()
	LandReinforcementFromMap ( 1 , "1" , 3 , 1012 );
	Cmd ( 3 , 1012 , 10 , GetScriptAreaParams "Base_22" );
	God ( 2 , 2 );
	Trace ("God");
	Wait ( 20 );
	God ( 2 , 0 );
	Trace ("NoGod");	
end;

function Inf()
	LandReinforcementFromMap ( 1 , "1" , 3 , 1013 );
	Cmd ( 3 , 1013 , 10 , GetScriptAreaParams "Base_22" );
end;

-----------------------Roads

function Road1()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "Road1" , 0 ) < 1 then
			Cmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_1" );
			QCmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_2" );
			StartThread (Road2);
			break;
		end;	
	end;
end;

function Road2()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "Alert" , 0 ) < 1 then
			Cmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_3" );
			QCmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_4" );
			StartThread (Road3);
			break;
		end;	
	end;
end;

function Road3()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "Road2" , 0 ) < 1 then
			Cmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_5" );
			QCmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_6" );
			QCmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_7" );
			StartThread (Road4);
--			StartThread (Inf);
			break;
		end;	
	end;
end;

function Road4()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "Road3" , 0 ) < 1 then
			Cmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_8" );
			QCmd ( 0 , 2000 , 0 , GetScriptAreaParams "Step_9" );
			QCmd ( 24 , 2000 , 0 , GetScriptAreaParams "Step_9" );
			Wait ( 22 );
			StartThread (RepairTruck);
			break;
		end;	
	end;
end;

function RepairTruck()
	while 1 do
		Wait( 1 );
		if IsImmobilized( GetObjectList ( 200 ) ) == 1 or GetScriptObjectHPs ( 200 ) < 20 then
			Cmd ( 0 , 2000 , 0 , ObjectGetCoord ( GetObjectList ( 200 )));
			QCmd ( 24 , 2000 , 100 , ObjectGetCoord ( GetObjectList ( 200 )));
			Wait ( 30 );
		end;	
	end;
end;

function Art()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , "Alert" , 0 ) > 0 then
			Wait ( 5 );
			Cmd ( 0 , 1005 , 0 , GetScriptAreaParams "Flee" );
			QCmd ( 1007 , 1005 );
			Wait ( 2 )
			Cmd ( 7 , 1001 , 50 , GetScriptAreaParams "Art" );
			Wait ( 2 );
			Cmd ( 7 , 1002 , 40 , GetScriptAreaParams "Art" );
			Wait ( 7 )
			QCmd ( 56 , 1001 , 1003 );
			Wait ( 3 );
			QCmd ( 56 , 1002 , 1004 );
			break;
		end;	
	end;
end;

function Alies()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , "Alies" , 0 ) > 0 then
			GiveObjective ( 2 );
			ChangePlayerForScriptGroup ( 1006 , 0 );
			ChangePlayerForScriptGroup ( 1116 , 0 );
			Cmd ( 7 , 1006 , 0 , GetScriptAreaParams "Alies" );
			Sleep ( 1 );
			CompleteObjective ( 2 );
			Wait ( 2 );
			ChangeFormation ( 1006 , 1 );
			Cmd (  0 , 1116 , 100 , "Step_100" );
			break;
		end;	
	end;
end;
-----------------------Objective 

function Objective00()
	GiveObjective ( 3 );
	StartThread( CompleteObjective00 );
end;

function CompleteObjective00()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 2223 ) < 1 then
			CompleteObjective ( 3 );
			Cmd ( 0 , 122 , 0 , "Base_33" );
			QCmd ( 1007 , 122 );
			StartThread( Objective );
			break;
		end;	
	end;
end;

function Objective()
	GiveObjective ( 0 );
	StartThread( CompleteObjective0 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 2000 , 'Base_22', 0 ) > 0 then
			Wait ( 5 );
			CompleteObjective ( 0 );
			ChangePlayerForScriptGroup( 200 , 0 );
			StartThread( Objective1 );
			break;
		end;	
	end;
end;

function Objective1()
	GiveObjective ( 1 );
	StartThread( CompleteObjective1 );
	StartThread( Japan );
end;

function CompleteObjective1()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 200 , 'OBJ', 0 ) > 0 and IsSomeUnitInArea ( 1 , 'Base_11', 0 ) < 1 then
			CompleteObjective ( 1 );
			Wait ( 3 );
			Win ( 0 );
			break;
		end;	
	end;
end;

------------------------WIn_Loose
function Unlucky()
	while 1 do
		Wait( 1 );
        if (( IsSomePlayerUnit( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			break;
		end;
	end;
end;

function Unlucky2()
	while 1 do
		Wait( 1 );
        if GetNUnitsInScriptGroup (200) < 1 then
			Win(1);
			break;
		end;
	end;
end;

---------------------------------------------------------Cmd ( 0 , 1011 , 10 , GetScriptAreaParams "Patrol1" );

StartThread (Objective00);

StartThread (Unlucky);
StartThread (Unlucky2);
StartThread (Art);
StartThread (Alies);
StartThread (Road1);
StartThread (Zasada);
StartThread (SkladA);
StartThread (Barels);
StartThread (Base1);
StartThread (Base10);
StartThread (Gun);
StartThread (IboNefig);
StartThread (Fire);
StartThread (Alive);

Wait ( 30 + Random ( 30 ) );
StartThread (Colona);
Wait ( 60 );
StartThread (Tanks);