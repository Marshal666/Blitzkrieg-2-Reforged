-------------------------------start_rus3.0
--------------------------------------/////obj00
function RevealObjective0()
	GiveObjective( 0 );
	StartThread( Objective0 );
end;

function Objective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "V0", 0) < 1) and (GetNUnitsInArea(0, "V0", 0) > 0)) then
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.objective0", 2 );
			break;
		end;	
	end;
end;
-------------------------------------/////obj01
function RevealObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "V2", 0) > 1) or (GetIGlobalVar("temp.objective0", 1) == 2)) then
			GiveObjective( 1 );
			Wait( 2 );
			StartThread( Objective1 );
			break;
		end;	
	end;
end;

function Objective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "V1", 0) < 1) and (GetNUnitsInArea(0, "V1", 0) > 0)) then
			CompleteObjective( 1 );
			SetIGlobalVar( "temp.objective1", 2 );
			LandReinforcementFromMap( 0, "ING", 1, 8 ); 
			break;
		end;	
	end;
end;
------------------------------------/////obj02
function RevealObjective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "V2", 0) > 1) or (GetIGlobalVar("temp.objective1", 1) == 2)) then
			GiveObjective( 2 );
			Wait( 2 );
			StartThread( Objective2 );
			break;
		end;	
	end;
end;

function Objective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "V2", 0) < 1) and (GetNUnitsInArea(0, "V2", 0) > 0)) then
			CompleteObjective( 2 );
			SetIGlobalVar( "temp.objective2", 2 );
			break;
		end;	
	end;
end;
-----------------------------------/////obj03
function RevealObjective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "V3", 0) > 1) or (GetIGlobalVar("temp.objective1", 1) == 2)) then
			GiveObjective( 3 );
			Wait( 2 );
			StartThread( Objective3 );
			break;
		end;	
	end;
end;

function Objective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "V3", 0) < 1) and (GetNUnitsInArea(0, "V3", 0) > 0)) then
			CompleteObjective( 3 );
			SetIGlobalVar( "temp.objective3", 2 );
			break;
		end;	
	end;
end;
----------------------------------/////obj04_Kalach
function RevealObjective4()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "KALACH", 0) > 1) or ((GetIGlobalVar("temp.objective2", 1) == 2) and (GetIGlobalVar("temp.objective3", 1) == 2)) then
			GiveObjective( 4 );
			Wait( 2 );
			StartThread( Objective4 );
			break;
		end;	
	end;
end;

function Objective4()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "KALACH", 0) < 1) and (GetNUnitsInArea(0, "KALACH", 0) > 0)) then
			CompleteObjective( 4 );
			SetIGlobalVar( "temp.objective4", 2 );
			break;
		end;	
	end;
end;
-----------------------------------////Winners
function Glory()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective2", 1) == 2) and (GetIGlobalVar("temp.objective3", 1) == 2) and (GetIGlobalVar("temp.objective4", 1) == 2)) then
			Wait( 1 );
			CompleteObjective( 0 );
			CompleteObjective( 1 );
			Win(0);
			break;
		end;	
	end;
end;

function Disgrace()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;
--------------------------------------/////All_attack_1
function A_Attack_1()
	while 1 do
		Wait( 3 );
		if (GetIGlobalVar("temp.objective0", 1) == 2) and (GetNUnitsInArea(1, "VV3", 0) > 0) and ( GetNUnitsInScriptGroup( 701 ) < 1 ) and ( GetNUnitsInScriptGroup( 702 ) < 1 )then
		Wait( 10 );
			StartThread( AA1 );
			StartThread( AAA1 );
			break;
		end;	
	end;
end;

function AA1()
	Wait( 15 );
	LandReinforcementFromMap( 2, "T1", 0, 701 );        
	Wait( 2 );
	Cmd(ACT_SWARM, 701, 0, GetScriptAreaParams( "z1" ) );
	QCmd(ACT_SWARM, 701, 0, GetScriptAreaParams( "z2" ) );
	Wait( 80 );
	StartThread( A_Attack_1 );
end;

function AAA1()
	LandReinforcementFromMap( 2, "INF1", 0, 702 );         
	Wait( 2 );
	ChangeFormation( 702, 3 );
	Cmd(ACT_SWARM, 702, 0, GetScriptAreaParams( "z1" ) );
	QCmd(ACT_SWARM, 702, 0, GetScriptAreaParams( "z2" ) );
	Wait( 80 );
end;
----------------------------------/////All_attack_2
function A_Attack_2()
	while 1 do
		Wait( 3 );
		if (GetIGlobalVar("temp.objective1", 1) == 2) and (GetNUnitsInArea(1, "VV2", 0) > 0) and ( GetNUnitsInScriptGroup( 711 ) < 1 ) and ( GetNUnitsInScriptGroup( 712 ) < 1 )then
		Wait( 10 );
			StartThread( BB1 );
			StartThread( BBB1 );
			break;
		end;	
	end;
end;

function BB1()
	Wait( 15 );
	LandReinforcementFromMap( 2, "T1", 1, 711 );        
	Wait( 2 );
	Cmd(ACT_SWARM, 711, 0, GetScriptAreaParams( "x11" ) );
	QCmd(ACT_SWARM, 711, 0, GetScriptAreaParams( "x2" ) );
	Wait( 80 );
	StartThread( A_Attack_2 );
end;

function BBB1()
	Wait( 15 );
	LandReinforcementFromMap( 2, "T1", 2, 712 );         
	Wait( 2 );
	Cmd(ACT_SWARM, 712, 0, GetScriptAreaParams( "x1" ) );
	QCmd(ACT_SWARM, 712, 0, GetScriptAreaParams( "x22" ) );
	Wait( 80 );
end;
-------------------------------------------//////All_attack_3
function A_Attack_3()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective2", 1) == 2) or (GetIGlobalVar("temp.objective3", 1) == 2)) and (GetNUnitsInArea(1, "VV1", 0) > 0) and ( GetNUnitsInScriptGroup( 721 ) < 1 ) and ( GetNUnitsInScriptGroup( 722 ) < 1 )then
		Wait( 10 );
			StartThread( CC1 );
			StartThread( CCC1 );
			break;
		end;	
	end;
end;

function CC1()
	Wait( 15 );
	LandReinforcementFromMap( 2, "T1", 3, 721 );        
	Wait( 2 );
	Cmd(ACT_SWARM, 721, 0, GetScriptAreaParams( "y1" ) );
	QCmd(ACT_SWARM, 721, 0, GetScriptAreaParams( "y2" ) );
	QCmd(ACT_SWARM, 721, 0, GetScriptAreaParams( "y3" ) );
	Wait( 80 );
	StartThread( A_Attack_3 );
end;

function CCC1()
	LandReinforcementFromMap( 2, "INF1", 3, 722 );         
	Wait( 2 );
	ChangeFormation( 722, 3 );
	Cmd(ACT_SWARM, 722, 0, GetScriptAreaParams( "y1" ) );
	QCmd(ACT_SWARM, 722, 0, GetScriptAreaParams( "y2" ) );
	QCmd(ACT_SWARM, 722, 0, GetScriptAreaParams( "y3" ) );
	Wait( 80 );
end;
-------------------------------------------/////All_attack_4final
function A_Attack_4()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective2", 1) == 2) or (GetIGlobalVar("temp.objective3", 1) == 2)) and (GetNUnitsInArea(0, "KALACH_BIG", 0) > 0) and (GetNUnitsInArea(1, "KALACH_SMALL", 0) > 0)then
		Wait( 10 );
			StartThread( DD1 );
			StartThread( DDD1 );
			break;
		end;	
	end;
end;

function DD1()
	Wait( 10 );
	LandReinforcementFromMap( 2, "T1", 4, 751 );        
	Wait( 2 );
	Cmd(ACT_SWARM, 751, 0, GetScriptAreaParams( "y2" ) );
	QCmd(ACT_SWARM, 751, 0, GetScriptAreaParams( "y3" ) );
	Wait( 120 );
	StartThread( A_Attack_4 );
end;

function DDD1()
	Wait( 5 );
	LandReinforcementFromMap( 2, "T1", 2, 752 );        
	Wait( 2 );
	Cmd(ACT_SWARM, 752, 0, GetScriptAreaParams( "x1" ) );
	QCmd(ACT_SWARM, 752, 0, GetScriptAreaParams( "x2" ) );
end;
--------------------------------------------//////Z_Sau
function Zen1()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "VV3", 0) < 1) then
			LandReinforcementFromMap( 2, "Zenitka", 0, 61 );
			LandReinforcementFromMap( 2, "Squads", 0, 51 );
			Wait( 2 );
			Cmd(32, 61, 0, 628, 2915 ); 
			Cmd(0, 51, 0, 637, 2619 ); 
			break;
		end;	
	end;
end;

function Zen2()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "VV2", 0) < 1) then
			LandReinforcementFromMap( 2, "Zenitka", 1, 62 );
			LandReinforcementFromMap( 2, "Squads", 1, 41 );
			Cmd(32, 62, 0, 2538, 7517 );
			Cmd(0, 41, 0, 3291, 6334 ); 
			Wait( 2 );
			LandReinforcementFromMap( 2, "Zenitka", 1, 63 );
			LandReinforcementFromMap( 2, "Squads", 2, 42 );
			Cmd(32, 63, 0, 3640, 7221 ); 
			Cmd(0, 42, 0, 3640, 7221 ); 
			break;
		end;	
	end;
end;

function Zen3()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "VV1", 0) < 1) then
			LandReinforcementFromMap( 2, "Zenitka", 3, 64 );
			LandReinforcementFromMap( 2, "Squads", 3, 43 );
			Wait( 2 );
			Cmd(32, 64, 0, 1072, 12836 ); 
			Cmd(0, 43, 0, 1647, 12119 ); 
			break;
		end;	
	end;
end;
--------------------------
function SAU1()
	while 1 do
		Wait( 10 );
		if (GetNUnitsInArea(1, "VV3", 0) < 1) then
			LandReinforcementFromMap( 2, "SAU", 0, 71 );
			Wait( 3 );
			Cmd(0, 71, 0, 791, 2349 );
			QCmd(8, 71, 0, 1388, 2116 );
			break;
		end;	
	end;
end;

function SAU2()
	while 1 do
		Wait( 10 );
		if (GetNUnitsInArea(1, "VV2", 0) < 1) then
			LandReinforcementFromMap( 2, "SAU", 0, 72 );
			Cmd(0, 72, 0, 3640, 6242 );
			Wait( 3 );
			LandReinforcementFromMap( 2, "SAU", 0, 73 );
			Cmd(0, 73, 0, 3663, 7803 );
			break;
		end;	
	end;
end;

function SAU3()
	while 1 do
		Wait( 10 );
		if (GetNUnitsInArea(1, "VV1", 0) < 1) then
			LandReinforcementFromMap( 2, "SAU", 3, 74 );
			Wait( 3 );
			Cmd(0, 74, 0, 1471, 12625 );
			QCmd(8, 74, 0, 2336, 12362 );
			break;
		end;	
	end;
end;
---------------------------------------------////Drezines
-------------------------1
function Armortr_1() 
	while 1 do
		Wait( 3 );
			if ((GetNScriptUnitsInArea(85, "dr1") > 0) and ( GetNUnitsInScriptGroup ( 85 ) > 0 )) then
			Wait( 2 );
			Cmd( 3, 85, 0, GetScriptAreaParams( "dr2" ) );
			StartThread( Armortr_2 );
			break;
		end;
	end;
end;

function Armortr_2() 
	while 1 do
		Wait( 3 );
			if ((GetNScriptUnitsInArea(85, "dr2") > 0) and ( GetNUnitsInScriptGroup ( 85 ) > 0 )) then
			Wait( 2 );
			Cmd( 3, 85, 0, GetScriptAreaParams( "dr1" ) );
			StartThread( Armortr_1 );
			break;
		end;
	end;
end;
--------------------------2
function Armortr_3() 
	while 1 do
		Wait( 3 );
			if ((GetNScriptUnitsInArea(86, "dr3") > 0) and ( GetNUnitsInScriptGroup ( 86 ) > 0 )) then
			Wait( 2 );
			Cmd( 3, 86, 0, GetScriptAreaParams( "dr4" ) );
			StartThread( Armortr_4 );
			break;
		end;
	end;
end;

function Armortr_4() 
	while 1 do
		Wait( 3 );
			if ((GetNScriptUnitsInArea(86, "dr4") > 0) and ( GetNUnitsInScriptGroup ( 86 ) > 0 )) then
			Wait( 2 );
			Cmd( 3, 86, 0, GetScriptAreaParams( "dr3" ) );
			StartThread( Armortr_3 );
			break;
		end;
	end;
end;
-------------------------------------------////ART
function Art_depl()
	while 1 do
		Wait( 3 );
		if (GetIGlobalVar("temp.objective0", 1) == 2) then
			Wait( 60 );
			LandReinforcementFromMap( 1, "ART", 2, 274 );
			break;
		end;	
	end;
end;
------------------------------------------////DL
function D_L()
	Wait(200);
	if (GetDifficultyLevel() == 1) then
	GiveReinforcementCalls ( 1, 10 );
	end;
	if (GetDifficultyLevel() == 2) then
	GiveReinforcementCalls ( 1, 20 );
	end;
end;

function D_L_2()
	Wait(1);
	if (GetDifficultyLevel() == 0) then
	RemoveScriptGroup(1001);
	end;
end;
---------------------------------------------/////Br_save
function Brg()
	while 1 do
		Wait( 3 );
		if (GetScriptObjectHPs(109) < 4000) then
			DamageScriptObject( 109, -10000 );  
			break;
		end;	
	end;
end;
----------------------------------------------//First_k_at

function First_1()
	while 1 do
		Wait( 3 );
			if (GetNUnitsInArea(1, "V0", 0) < 1) then
			Wait( 20 );
			Cmd( 3, 5405, 0, GetScriptAreaParams( "V0" ) );
			Cmd( 3, 1145, 0, GetScriptAreaParams( "V0" ) );
			break;
		end;
	end;
end;

function First_2()
	while 1 do
		Wait( 3 );
			if (GetNUnitsInArea(1, "V3", 0) < 1) and (GetNUnitsInArea(0, "SUR1", 0) < 1)then
			LandReinforcementFromMap( 1, "Sur_1", 3, 3345 );
			Cmd( 3, 3345, 0, GetScriptAreaParams( "V3" ) );
			Cmd( 3, 3345, 0, GetScriptAreaParams( "V0" ) );
			break;
		end;
	end;
end;
-----------------------------------------------///Avia
function Ger_avia()
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective2", 1) ~= 2) and (GetIGlobalVar("temp.objective3", 1) ~= 2)) then
			LandReinforcementFromMap( 1, "G_AVIA", 0, 5006 );
			Cmd( 3, 5006, 500, 7333, 6066 );
			Wait( 120 + Random( 200 ) );
			StartThread( Ger_avia_2 );
			break;
		end;
	end;
end;

function Ger_avia_2()
StartThread( Ger_avia_2 );
end;

----------------------------------------------------- MAIN

StartThread( RevealObjective0 );
StartThread( RevealObjective1 );
StartThread( RevealObjective2 );
StartThread( RevealObjective3 );
StartThread( RevealObjective4 );

StartThread( Glory );
StartThread( Disgrace );

StartThread( A_Attack_1 );
StartThread( A_Attack_2 );
StartThread( A_Attack_3 );
StartThread( A_Attack_4 );

StartThread( Zen1 );
StartThread( Zen2 );
StartThread( Zen3 );
StartThread( SAU1 );
StartThread( SAU2 );
StartThread( SAU3 );

StartThread( Armortr_1 );
StartThread( Armortr_3 );
StartThread( Art_depl );
StartThread( D_L );
StartThread( D_L_2 );

StartThread( First_1 );
StartThread( First_2 );
StartThread( Ger_avia );

StartThread( Brg );