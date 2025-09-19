----------------------------------------Stalingrad
---------------------------German_attack
----------------------1
function Recon_1()
	Wait(2);
	LandReinforcementFromMap( 0, "RECON", 0, 201 );
	Wait(10);
	LandReinforcementFromMap( 0, "TIGERS", 0, 202 );
	Cmd( 3, 202, 0, GetScriptAreaParams( "S3" ) );
	Wait(10);
	LandReinforcementFromMap( 0, "ASLT", 8, 203 );
	ChangeFormation( 203, 2 );
	Cmd( 3, 203, 0, GetScriptAreaParams( "S1" ) );
	Wait(25);
	LandReinforcementFromMap( 0, "TANKS_1", 0, 204 );
	LandReinforcementFromMap( 0, "FHT", 0, 205 );
	Cmd( 3, 204, 0, GetScriptAreaParams( "S2" ) );
	Cmd( 0, 205, 0, GetScriptAreaParams( "S1" ) );
	Wait(35);
	LandReinforcementFromMap( 0, "ASLT", 8, 206 );
	Cmd( 0, 206, 0, GetScriptAreaParams( "S2" ) );
	Wait(15);
	LandReinforcementFromMap( 0, "AA", 8, 9187 );
end;
----------------------2
function Recon_2()
	Wait(90);
	LandReinforcementFromMap( 0, "TANKS_1", 1, 207 );
	Cmd( 3, 207, 0, GetScriptAreaParams( "S4" ) );
	Wait(5);
	LandReinforcementFromMap( 0, "ASLT", 1, 208 );
	Cmd( 3, 208, 0, GetScriptAreaParams( "S4" ) );
end;

function Recon_2_1()
	Wait(93);
	LandReinforcementFromMap( 0, "TANKS_1", 2, 209 );
	Cmd( 3, 209, 0, GetScriptAreaParams( "S5" ) );
	Wait(5);
	LandReinforcementFromMap( 0, "ASLT", 2, 210 );
	Cmd( 3, 210, 0, GetScriptAreaParams( "S5" ) );
end;

function Recon_2_2()
	Wait(125);
	LandReinforcementFromMap( 0, "TANKS_2", 1, 211 );
	Cmd( 3, 211, 0, GetScriptAreaParams( "S7" ) );
end;
---------------------3
function Recon_3()
	Wait(140);
	LandReinforcementFromMap( 0, "TANKS_1", 3, 212 );
	Cmd( 3, 212, 0, GetScriptAreaParams( "S6" ) );
	Wait(5);
	LandReinforcementFromMap( 0, "ASLT", 3, 213 );
	Cmd( 3, 213, 0, GetScriptAreaParams( "S6" ) );
	Wait(20);
	LandReinforcementFromMap( 0, "ING", 3, 214 );
	Wait(10);
	StartThread( RevealObjective0 );
	StartThread( RevealObjective1 );
	StartThread( R_Infantry_A );
	StartThread( R_Infantry_B );
	StartThread( R_T34 );
	StartThread( Winner );
	StartThread( Unlucky );
end;
------------------------------BONUS1
function Bonus1()
	Wait(145);
	LandReinforcementFromMap( 1, "KATY", 3, 701 );
	Cmd( 0, 701, 0, GetScriptAreaParams( "K1" ) );
	QCmd( 0, 701, 0, GetScriptAreaParams( "K2" ) );
	QCmd( 0, 701, 0, GetScriptAreaParams( "K3" ) );
	QCmd( 0, 701, 0, GetScriptAreaParams( "K4" ) );
	QCmd( 0, 701, 0, GetScriptAreaParams( "K5" ) );
	QCmd( 0, 701, 0, GetScriptAreaParams( "K6" ) );
	QCmd( 8, 701, 0, GetScriptAreaParams( "K7" ) );
	Wait(3);
	LandReinforcementFromMap( 1, "KATY", 3, 702 );
	Cmd( 0, 702, 0, GetScriptAreaParams( "K1" ) );
	QCmd( 0, 702, 0, GetScriptAreaParams( "K2" ) );
	QCmd( 0, 702, 0, GetScriptAreaParams( "K3" ) );
	QCmd( 0, 702, 0, GetScriptAreaParams( "K4" ) );
	QCmd( 0, 702, 0, GetScriptAreaParams( "K5" ) );
	QCmd( 0, 702, 0, GetScriptAreaParams( "K5_1" ) );
	QCmd( 8, 702, 0, GetScriptAreaParams( "K5_2" ) );
	StartThread( Kat_chk );
	StartThread( Kat_chk_2 );
end;

function Kat_chk()
	while 1 do
		Wait( 3 );
		if (( GetNUnitsInScriptGroup( 701 ) < 1 ) and ( GetNUnitsInScriptGroup( 702 ) < 1 ) and (GetIGlobalVar("temp.objective.3", 1) ~= 2)) then
			ObjectiveChanged(3, 1);
			Wait( 1 );
			ObjectiveChanged(3, 2);
			SetIGlobalVar( "temp.objective.3", 1 );
			Wait( 1 );
			break;
		end;
	end;
end;

function Kat_chk_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(701, "BM13") > 0) and (GetNScriptUnitsInArea(702, "BM13") > 0)then
			SetIGlobalVar( "temp.objective.3", 2 );
			Wait( 1 );
			break;
		end;
	end;
end;
--------------------------------------------BARICAD
function RevealObjective0()
	Wait(1);
	ObjectiveChanged(0, 1);
	StartThread( CompleteObjective0 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "BARICAD", 0) > 0) and (GetNUnitsInArea(1,"BARICAD", 0) < 1)) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective.0", 2 );
			StartThread( ReturnObjective0 );
			break;
		end;
	end;
end;

function ReturnObjective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "BARICAD", 0) < 1) and (GetNUnitsInArea(1,"BARICAD", 0) > 0)) then
			SetIGlobalVar( "temp.objective.0", 1 );
			Wait( 1 );
			StartThread( RevealObjective0 );
			break;
		end;
	end;
end;
------------------------------------------STZ
function RevealObjective1()
	Wait(1);
	ObjectiveChanged(1, 1);
	StartThread( CompleteObjective1 );
end;

function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "STZ", 0) > 0) and (GetNUnitsInArea(1,"STZ", 0) < 1)) then
			ObjectiveChanged(1, 2);
			SetIGlobalVar( "temp.objective.1", 2 );
			StartThread( ReturnObjective1 );
			break;
		end;
	end;
end;

function ReturnObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "STZ", 0) < 1) and (GetNUnitsInArea(1,"STZ", 0) > 0)) then
			SetIGlobalVar( "temp.objective.1", 1 );
			Wait( 1 );
			StartThread( RevealObjective1 );
			break;
		end;
	end;
end;
-------------------------------------------STAFF
function RevealObjective2()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective.0", 1) == 2) or (GetIGlobalVar("temp.objective.1", 1) == 2) or (GetNUnitsInArea(0, "STAFF", 0) > 0)) then
			ObjectiveChanged(2, 1);
			StartThread( CompleteObjective2 );
			Wait( 1 );
			break;
		end;
	end;
end;

function CompleteObjective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "STAFF", 0) > 0) and (GetNUnitsInArea(1,"STAFF", 0) < 1)) then
			ObjectiveChanged(2, 2);
			SetIGlobalVar( "temp.objective.2", 2 );
			Wait( 1 );
			break;
		end;
	end;
end;
--------------------------------------------RUS_ATTACKS
----------------------------------INF_1

function R_Infantry_A() 
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective.2", 1) ~= 2) and ( GetNUnitsInScriptGroup( 301 ) < 2 )) then
			Wait( 1 );
			StartThread( At1 );
			break;
		end;
	end;
end;

function At1()
	LandReinforcementFromMap( 1, "RUS_INF", 0, 301 );         
	Wait( 2 );
	ChangeFormation( 201, 3 );
	Wait( 4 );
	Cmd( 3, 301, 0, GetScriptAreaParams( "A1" ) );
	QCmd( 3, 301, 0, GetScriptAreaParams( "A2" ) );
	QCmd( 3, 301, 0, GetScriptAreaParams( "A3" ) );
	QCmd( 3, 301, 0, GetScriptAreaParams( "A4" ) );
	Wait( 260 + RandomInt( 140 ) );
	StartThread( R_Infantry_A );
end;

----------------------------------INF_2

function R_Infantry_B() 
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective.2", 1) ~= 2) and ( GetNUnitsInScriptGroup( 302 ) < 2 )) then
			Wait( 1 );
			StartThread( Bt1 );
			break;
		end;
	end;
end;

function Bt1()
	LandReinforcementFromMap( 1, "RUS_INF", 1, 302 );         
	Wait( 2 );
	ChangeFormation( 202, 3 );
	Wait( 4 );
	Cmd( 3, 302, 0, GetScriptAreaParams( "B1" ) );
	QCmd( 3, 302, 0, GetScriptAreaParams( "B2" ) );
	QCmd( 3, 302, 0, GetScriptAreaParams( "B3" ) );
	QCmd( 3, 302, 0, GetScriptAreaParams( "B4" ) );
	Wait( 260 + RandomInt( 140 ) );
	StartThread( R_Infantry_B );
end;

-----------------------------------T34
function R_T34() 
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective.1", 1) ~= 2) and (GetNUnitsInArea(0, "T34",0) < 1) and ( GetNUnitsInScriptGroup( 303 ) < 1 )) then
			Wait( 1 );
			StartThread( T_PROD );
			break;
		end;
	end;
end;

function T_PROD()
local x = RandomInt(2);
	if x == 0 then
	StartThread( T34_1 );
	end;
	if x == 1 then
	StartThread( T34_2 );
	end;
end;

function T34_1()
	LandReinforcementFromMap( 1, "RUS_TANKS", 2, 303 );
	Wait( 2 );
	Cmd( 3, 303, 0, GetScriptAreaParams( "T1" ) );
	QCmd( 3, 303, 0, GetScriptAreaParams( "T2" ) );
	QCmd( 3, 303, 0, GetScriptAreaParams( "T3" ) );
	QCmd( 3, 303, 0, GetScriptAreaParams( "T4" ) );
	QCmd( 3, 303, 0, GetScriptAreaParams( "T5" ) );
	Wait( 200 + RandomInt( 120 ) );
	StartThread( R_T34 );
end;

function T34_2()
	LandReinforcementFromMap( 1, "RUS_TANKS", 2, 303 );
	Wait( 2 );
	Cmd( 3, 303, 0, GetScriptAreaParams( "T4" ) );
	QCmd( 3, 303, 0, GetScriptAreaParams( "T3" ) );
	QCmd( 3, 303, 0, GetScriptAreaParams( "T2" ) );
	QCmd( 3, 303, 0, GetScriptAreaParams( "T1" ) );
	QCmd( 3, 303, 0, GetScriptAreaParams( "T5" ) );
	Wait( 200 + RandomInt( 120 ) );
	StartThread( R_T34 );
end;
-------------------------------------------------Win_lose

function Winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective.0", 1) == 2) and (GetIGlobalVar("temp.objective.1", 1) == 2) and (GetIGlobalVar("temp.objective.2", 1) == 2)) then
			Wait( 2 );
			Win(0);
			break;
		end;
	end;
end;

function Unlucky()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) or ( IsReinforcementAvailable( 0 ) == 0 )) ) then
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;

--------------------------------------DL
function D_L()
	Wait(2);
	if (GetDifficultyLevel() == 1) then
	GiveReinforcementCalls ( 1, 6 );
	end;
	if (GetDifficultyLevel() == 2) then
	GiveReinforcementCalls ( 1, 15 );
	end;
end;

function D_L_2()
	Wait(2);
	if (GetDifficultyLevel() == 0) then
		RemoveScriptGroup(1001);
		RemoveScriptGroup(1002);
	end;
	if (GetDifficultyLevel() == 1) then
		RemoveScriptGroup(1002);
	end;
end;
----------------------------------------------------------MAIN

StartThread( Recon_1 );
StartThread( Recon_2 );
StartThread( Recon_2_1 );
StartThread( Recon_2_2 );
StartThread( Recon_3 );
StartThread( D_L );
StartThread( D_L_2 );
StartThread( RevealObjective2 );
StartThread( Bonus1 );