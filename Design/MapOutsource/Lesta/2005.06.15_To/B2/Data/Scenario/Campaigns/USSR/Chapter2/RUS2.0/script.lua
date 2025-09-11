--Sevastopol
-------------------------------------------PARTY1
SetIGlobalVar( "temp.ship1", 1 );
SetIGlobalVar( "temp.ship2", 1 );
------------------------------------------
function RevealObjective0()   
	GiveObjective( 0 ); 
	StartThread( GER_AT_1 ); ------German_go!
end;


-----------------------------------First_Attacks
function GER_AT_1()
	Wait( 10 );
	Cmd(3, 501, 0, GetScriptAreaParams( "AT1" ) );
	QCmd(3, 501, 0, GetScriptAreaParams( "AT2" ) );
	Cmd(3, 502, 0, GetScriptAreaParams( "AT1_1" ) );
	QCmd(3, 502, 0, GetScriptAreaParams( "AT2" ) );
	Wait( 100 );
	StartThread( GER_AT_2 ); ---GER_AT_2
	StartThread( GER_AT_3 ); ---GER_AT_3
	Wait( 120 );
	StartThread( GER_AT_4 );
end;

function GER_AT_2()
	LandReinforcementFromMap(1, "GERINF", 0, 503);
	LandReinforcementFromMap(1, "GERINF", 1, 504);
	Wait( 2 );
	ChangeFormation( 503, 3 ); 
	ChangeFormation( 504, 3 ); 
	Cmd(3, 503, 0, GetScriptAreaParams( "AT1_1" ) );
	QCmd(3, 503, 0, GetScriptAreaParams( "AT2" ) );
	Cmd(3, 504, 0, GetScriptAreaParams( "AT1" ) );
	QCmd(3, 504, 0, GetScriptAreaParams( "AT2" ) );
end;

function GER_AT_3()
	LandReinforcementFromMap(1, "GSAU", 0, 601);
	LandReinforcementFromMap(1, "GSAU", 1, 602);
	Cmd(105, 601, 15 );
	Cmd(105, 602, 15 );
	QCmd(3, 601, 0, GetScriptAreaParams( "AT1_1" ) );
	QCmd(3, 601, 0, GetScriptAreaParams( "AT2" ) );
	QCmd(3, 602, 0, GetScriptAreaParams( "AT1" ) );
	QCmd(3, 602, 0, GetScriptAreaParams( "AT2" ) );
end;

function GER_AT_4()
	LandReinforcementFromMap(1, "GERINF", 0, 505);
	LandReinforcementFromMap(1, "GERINF", 1, 506);
	Wait( 2 );
	ChangeFormation( 505, 3 ); 
	ChangeFormation( 506, 3 ); 
	Cmd(3, 505, 0, GetScriptAreaParams( "AT1_1" ) );
	QCmd(3, 505, 0, GetScriptAreaParams( "AT2" ) );
	Cmd(3, 506, 0, GetScriptAreaParams( "AT1" ) );
	QCmd(3, 506, 0, GetScriptAreaParams( "AT2" ) );
end;
--------------------------------------------------PARTY2
function RevealObjective1()
	Wait( 240 );
	StartThread( Flack_go );
	Wait( 60 );
	GiveObjective( 1 );
end;

function Flack_go()
	LandReinforcementFromMap(2, "FLACK", 1, 555); ------------------Flack_go!
	Wait( 1 ); 
	Cmd(0, 555, 0, GetScriptAreaParams( "R3" ) );
	QCmd(0, 555, 0, GetScriptAreaParams( "R15" ) );
	QCmd(0, 555, 0, GetScriptAreaParams( "R14" ) );
	QCmd(0, 555, 0, GetScriptAreaParams( "F2" ) );
	QCmd(0, 555, 0, GetScriptAreaParams( "F1" ) );
	StartThread( Flack_play );
end;

function Flack_play()
Wait( 30 );
ChangePlayerForScriptGroup( 555, 0 );
StartThread( Ship1 ); ----------------------Ship_start!
end;
------------------------Ships
function Ship1()
	LandReinforcementFromMap(2, "SHIP", 0, 401);
	SetIGlobalVar( "temp.ship1", 2 );
	Cmd(0, 401, 0, GetScriptAreaParams( "SR" ) );
	Wait( 20 );
	StartThread( Avia_str_1 );
	Wait( 760 );
	Cmd(0, 401, 0, GetScriptAreaParams( "SEA_EXIT" ) );
	StartThread( Ship1_1 );
end;

function Ship1_1()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(401, "SEA_EXIT") > 0) then
			SetIGlobalVar( "temp.ship1", 1 );
			Wait( 1 );
			RemoveScriptGroup( 401 );
			StartThread( Ship2 );
			break;
		end;	
	end;
end;

function Ship2()
	Wait( 3 );
	LandReinforcementFromMap(2, "SHIP", 0, 402);
	SetIGlobalVar( "temp.ship2", 2 );
	Cmd(0, 402, 0, GetScriptAreaParams( "SR" ) );
	Wait( 760 );
	Cmd(0, 402, 0, GetScriptAreaParams( "SEA_EXIT" ) );
	StartThread( Ship2_2 );
end;


function Ship2_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(402, "SEA_EXIT") > 0) then
			SetIGlobalVar( "temp.ship2", 1 );
			SetIGlobalVar( "temp.shipnet", 2 );
			SetIGlobalVar( "temp.shipfinale", 2 );
			Wait( 1 );
			RemoveScriptGroup( 402 );
			break;
		end;	
	end;
end;
--------------------------------Avia_str_1
function Avia_str_1()
	LandReinforcementFromMap(1, "G_BOMBS", 5, 2001);
	Cmd( 0, 2001, 500, 7175, 5927 );
	Wait( 5 );
	LandReinforcementFromMap(1, "JU87", 5, 2002);
	Cmd( 0, 2002, 0, 8649, 4500 );
	Wait( 8 );
	LandReinforcementFromMap(1, "G_BOMBS", 5, 2203);
	Cmd( 0, 2203, 500, 7175, 5927 );
	Wait( 60 );
	GiveObjective( 2 );
	StartThread( Evacuation );
	Wait( 120 );
	GiveObjective( 3 );
	StartThread( German_avia );
	StartThread( German_at_2 ); -----------------German_at
	StartThread( German_at_3 ); -----------------German_at
end;

---------------------------------German_at_2
--------------------------1
function German_at_2()
	while 1 do
		Wait( 3 );
		if (GetIGlobalVar("temp.shipnet", 1) ~= 2) then
			Wait( 1 );
			StartThread( Attack2 );
			break;
		end;	
	end;
end;

function Attack2()
local x = RandomInt(2);
	if x == 0 then
	StartThread( A_1 );
	end;
	if x == 1 then
	StartThread( A_2 );
	end;
end;

function A_1()
	LandReinforcementFromMap( 1, "GERINF", 2, 5001 );
	LandReinforcementFromMap( 1, "GERINF", 3, 5002 );
	ChangeFormation( 5001, 3 ); 
	ChangeFormation( 5002, 3 ); 
	Wait( 2 );
	Cmd( 3, 5001, 0, GetScriptAreaParams( "At_road1" ) );
	QCmd( 3, 5001, 0, GetScriptAreaParams( "At_road2" ) );
	QCmd( 3, 5001, 0, GetScriptAreaParams( "Port" ) );
	Cmd( 3, 5002, 0, GetScriptAreaParams( "At_road1" ) );
	QCmd( 3, 5002, 0, GetScriptAreaParams( "At_road2" ) );
	QCmd( 3, 5002, 0, GetScriptAreaParams( "Port" ) );
	Wait( 100 + RandomInt( 10 ) );
	StartThread( German_at_2 );
end;

function A_2()
	LandReinforcementFromMap( 1, "GSAU", 2, 5003 );
	LandReinforcementFromMap( 1, "GSAU", 3, 5004 );
	Wait( 2 );
	Cmd( 3, 5003, 0, GetScriptAreaParams( "At_road1" ) );
	QCmd( 3, 5003, 0, GetScriptAreaParams( "At_road2" ) );
	QCmd( 3, 5003, 0, GetScriptAreaParams( "Port" ) );
	Cmd( 3, 5004, 0, GetScriptAreaParams( "At_road1" ) );
	QCmd( 3, 5004, 0, GetScriptAreaParams( "At_road2" ) );
	QCmd( 3, 5004, 0, GetScriptAreaParams( "Port" ) );
	Wait( 100 + RandomInt( 10 ) );
	StartThread( German_at_2 );
end;
-----------------------2
function German_at_3()
	while 1 do
		Wait( 3 );
		if (GetIGlobalVar("temp.shipnet", 1) ~= 2) then
			Wait( 1 );
			StartThread( Attack_3 );
			break;
		end;	
	end;
end;

function Attack_3()
local x = RandomInt(2);
	if x == 0 then
	StartThread( B_1 );
	end;
	if x == 1 then
	StartThread( B_2 );
	end;
end;

function B_1()
	LandReinforcementFromMap( 1, "GERINF", 0, 6011 );
	LandReinforcementFromMap( 1, "GSAU", 1, 6012 );
	ChangeFormation( 6011, 3 ); 
	Wait( 2 );
	Cmd( 3, 6011, 0, GetScriptAreaParams( "AT1" ) );
	QCmd( 3, 6011, 0, GetScriptAreaParams( "AT2" ) );
	Cmd( 3, 6012, 0, GetScriptAreaParams( "AT1" ) );
	QCmd( 3, 6012, 0, GetScriptAreaParams( "AT2" ) );
	Wait( 90 + RandomInt( 20 ) );
	StartThread( German_at_3 );
end;

function B_2()
	LandReinforcementFromMap( 1, "GERINF", 0, 6013 );
	LandReinforcementFromMap( 1, "GSAU", 1, 6014 );
	ChangeFormation( 6013, 3 ); 
	Wait( 2 );
	Cmd( 3, 6013, 0, GetScriptAreaParams( "P" ) );
	QCmd( 3, 6013, 0, GetScriptAreaParams( "Port" ) );
	Cmd( 3, 6014, 0, GetScriptAreaParams( "P" ) );
	QCmd( 3, 6014, 0, GetScriptAreaParams( "Port" ) );
	Wait( 90 + RandomInt( 20 ) );
	StartThread( German_at_3 );
end;



---------------------------------------------------//////////////////////////Evacuation
function Evacuation()
	while 1 do
		if (GetIGlobalVar("temp.finita", 1) ~= 2) then
			Wait( 3 );
			StartThread( Inf_Go_1_1 );
			Wait( 10 );
			StartThread( Inf_Go_2_1 );
			Wait( 20 );
			StartThread( Inf_Go_3_1 );
			Wait( 30 );
			StartThread( Inf_Go_4_1 );
			Wait( 40 );
			StartThread( Inf_Go_5_1 );
			Wait( 50 );
			StartThread( Inf_Go_6_1 );
			Wait( 60 );
			StartThread( Inf_Go_7_1 );
			break;
		end;
	end;	
end;	
------------------------1
function Inf_Go_1_1()
	LandReinforcementFromMap(2, "WOUND", 1, 311);
	DamageScriptObject ( 311, 5 )
	ChangeFormation( 311, 1 ); 
	Wait( 2 );
	Cmd(0, 311, 0, GetScriptAreaParams( "R1" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R2" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R3" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R4" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R5" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R6" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R7" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R8" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R9" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "R10" ) );
	QCmd(0, 311, 0, GetScriptAreaParams( "LOADS" ) );
	StartThread( Inf_Go_1_2 );
end;

function Inf_Go_1_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(311, "LOADS") > 0) and ((GetNScriptUnitsInArea(401, "SR") > 0) or (GetNScriptUnitsInArea(402, "SR") > 0) or (GetNScriptUnitsInArea(403, "SR") > 0))then
			Wait( 2 );
			RemoveScriptGroup( 311 );
			StartThread( Inf_Go_1_1 );
			break;
		end;	
	end;
end;
--------------------------------2
function Inf_Go_2_1()
	LandReinforcementFromMap(2, "WOUND", 1, 312);
	DamageScriptObject ( 312, 5 )
	ChangeFormation( 312, 1 ); 
	Wait( 2 );
	Cmd(0, 312, 0, GetScriptAreaParams( "R1" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R2" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R3" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R4" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R5" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R6" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R7" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R8" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R9" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "R10" ) );
	QCmd(0, 312, 0, GetScriptAreaParams( "LOADS_2" ) );
	StartThread( Inf_Go_2_2 );
end;

function Inf_Go_2_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(312, "LOADS_2") > 0) and ((GetNScriptUnitsInArea(401, "SR") > 0) or (GetNScriptUnitsInArea(402, "SR") > 0) or (GetNScriptUnitsInArea(403, "SR") > 0))then
			Wait( 2 );
			RemoveScriptGroup( 312 );
			StartThread( Inf_Go_2_1 );
			break;
		end;	
	end;
end;
-------------------------------3
function Inf_Go_3_1()
	LandReinforcementFromMap(2, "WOUND", 1, 313);
	DamageScriptObject ( 313, 5 )
	ChangeFormation( 313, 1 ); 
	Wait( 2 );
	Cmd(0, 313, 0, GetScriptAreaParams( "R1" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R2" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R3" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R4" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R5" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R6" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R7" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R8" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R9" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "R10" ) );
	QCmd(0, 313, 0, GetScriptAreaParams( "LOADS" ) );
	StartThread( Inf_Go_3_2 );
end;

function Inf_Go_3_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(313, "LOADS") > 0) and ((GetNScriptUnitsInArea(401, "SR") > 0) or (GetNScriptUnitsInArea(402, "SR") > 0) or (GetNScriptUnitsInArea(403, "SR") > 0))then
			Wait( 2 );
			RemoveScriptGroup( 313 );
			StartThread( Inf_Go_3_1 );
			break;
		end;	
	end;
end;
-----------------------------4
function Inf_Go_4_1()
	LandReinforcementFromMap(2, "WOUND", 1, 314);
	DamageScriptObject ( 314, 5 )
	ChangeFormation( 314, 1 ); 
	Wait( 2 );
	Cmd(0, 314, 0, GetScriptAreaParams( "R1" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R2" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R3" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R4" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R5" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R6" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R7" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R8" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R9" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "R10" ) );
	QCmd(0, 314, 0, GetScriptAreaParams( "LOADS_2" ) );
	StartThread( Inf_Go_4_2 );
end;

function Inf_Go_4_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(314, "LOADS_2") > 0) and ((GetNScriptUnitsInArea(401, "SR") > 0) or (GetNScriptUnitsInArea(402, "SR") > 0) or (GetNScriptUnitsInArea(403, "SR") > 0))then
			Wait( 2 );
			RemoveScriptGroup( 314 );
			StartThread( Inf_Go_4_1 );
			break;
		end;	
	end;
end;
-----------------------------5
function Inf_Go_5_1()
	LandReinforcementFromMap(2, "WOUND", 1, 315);
	DamageScriptObject ( 315, 5 )
	ChangeFormation( 315, 1 ); 
	Wait( 2 );
	Cmd(0, 315, 0, GetScriptAreaParams( "R1" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R2" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R3" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R4" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R5" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R6" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R7" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R8" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R9" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "R10" ) );
	QCmd(0, 315, 0, GetScriptAreaParams( "LOADS" ) );
	StartThread( Inf_Go_5_2 );
end;

function Inf_Go_5_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(315, "LOADS") > 0) and ((GetNScriptUnitsInArea(401, "SR") > 0) or (GetNScriptUnitsInArea(402, "SR") > 0) or (GetNScriptUnitsInArea(403, "SR") > 0))then
			Wait( 2 );
			RemoveScriptGroup( 315 );
			StartThread( Inf_Go_5_1 );
			break;
		end;	
	end;
end;
------------------------------6
function Inf_Go_6_1()
	LandReinforcementFromMap(2, "WOUND", 1, 316);
	DamageScriptObject ( 316, 5 )
	ChangeFormation( 316, 1 ); 
	Wait( 2 );
	Cmd(0, 316, 0, GetScriptAreaParams( "R1" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R2" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R3" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R4" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R5" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R6" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R7" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R8" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R9" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "R10" ) );
	QCmd(0, 316, 0, GetScriptAreaParams( "LOADS" ) );
	StartThread( Inf_Go_6_2 );
end;

function Inf_Go_6_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(316, "LOADS") > 0) and ((GetNScriptUnitsInArea(401, "SR") > 0) or (GetNScriptUnitsInArea(402, "SR") > 0) or (GetNScriptUnitsInArea(403, "SR") > 0))then
			Wait( 2 );
			RemoveScriptGroup( 316 );
			StartThread( Inf_Go_6_1 );
			break;
		end;	
	end;
end;
-----------------------------7
function Inf_Go_7_1()
	LandReinforcementFromMap(2, "WOUND", 1, 317);
	DamageScriptObject ( 317, 5 )
	ChangeFormation( 317, 1 ); 
	Wait( 2 );
	Cmd(0, 317, 0, GetScriptAreaParams( "R1" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R2" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R3" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R4" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R5" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R6" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R7" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R8" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R9" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "R10" ) );
	QCmd(0, 317, 0, GetScriptAreaParams( "LOADS" ) );
	StartThread( Inf_Go_7_2 );
end;

function Inf_Go_7_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(317, "LOADS") > 0) and ((GetNScriptUnitsInArea(401, "SR") > 0) or (GetNScriptUnitsInArea(402, "SR") > 0) or (GetNScriptUnitsInArea(403, "SR") > 0))then
			Wait( 2 );
			RemoveScriptGroup( 317 );
			StartThread( Inf_Go_7_1 );
			break;
		end;	
	end;
end;

-------------------------------------------DEFEAD
function Unlucky()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
		Wait(3);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;

function F_Objective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "BAT", 0) > 0) and (GetNUnitsInArea(0, "BAT", 0) < 1) and(GetNUnitsInArea(2, "BAT", 0) < 1)) then
			FailObjective( 0 );
			Wait(3);
			Win( 1 );
			break;
		end;	
	end;
end;

function F_Objective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "At_road2", 0) > 0) and (GetNUnitsInArea(0, "At_road2", 0) < 1)) then
			FailObjective( 2 );
			Wait(3);
			Win( 1 );
			break;
		end;	
	end;
end;

function F_Objective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "Port", 0) > 0) and (GetNUnitsInArea(0, "Port", 0) < 1) and (GetNUnitsInArea(2, "Port", 0) < 1)) then
			FailObjective( 3 );
			Wait(3);
			Win( 1 );
			break;
		end;	
	end;
end;
---------------------
function Ship_ded1()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.ship1", 1) == 2) and ( GetNUnitsInScriptGroup( 401 ) < 1 )) then
			FailObjective( 1 );
			Wait(5);
			Win( 1 );
			break;
		end;	
	end;
end;

function Ship_ded2()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.ship2", 1) == 2) and ( GetNUnitsInScriptGroup( 402 ) < 1 )) then
			FailObjective( 1 );
			Wait(5);
			Win( 1 );
			break;
		end;	
	end;
end;
--------------------------------------/////////////WINNERS!
function Inf_finita() 
	Wait( 1000 );
	SetIGlobalVar( "temp.finita", 2 );
end;

function Glory()
	while 1 do
		Wait( 3 );
		if (GetIGlobalVar("temp.shipfinale", 1) == 2) then
			Wait( 1 );
			CompleteObjective( 0 );
			CompleteObjective( 1 );
			CompleteObjective( 2 );
			CompleteObjective( 3 );
			Wait( 2 );
			Win( 0 );
			break;
		end;	
	end;
end;


---------------------------------------//////////////BONUSES
function Karlos()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "KARL", 0) > 0) and ( GetNUnitsInScriptGroup( 9991 ) < 1 )) then
			GiveObjective( 4 );
			Wait( 1 );
			CompleteObjective( 4 );
			break;
		end;	
	end;
end;

function Armor_tr()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "A_TRAIN", 0) > 0) then
			ChangePlayerForScriptGroup( 8881, 0 );
			GiveObjective( 5 );
			Wait( 1 );
			CompleteObjective( 5 );
			break;
		end;	
	end;
end;
----------------------------------------SEA
function Sea_beasts()
	Wait( 400 + RandomInt( 100 ) );
	LandReinforcementFromMap(1, "R_BOAT", 6, 39);
	Wait( 2 );
	Cmd(0, 39, 0, GetScriptAreaParams( "Sea1" ) );
	QCmd(0, 39, 0, GetScriptAreaParams( "Sea2" ) );
end;

function Sea_beasts_2()
	Wait( 600 + RandomInt( 100 ) );
	LandReinforcementFromMap(1, "R_BOAT", 6, 39);
	Wait( 2 );
	Cmd(0, 39, 0, GetScriptAreaParams( "Sea1" ) );
	QCmd(0, 39, 0, GetScriptAreaParams( "Sea2" ) );
end;

----------------------------------------D_L
function D_L()
	Wait(300);
	if (GetDifficultyLevel() == 1) then
	GiveReinforcementCalls ( 1, 6 );
	end;
	if (GetDifficultyLevel() == 2) then
	GiveReinforcementCalls ( 1, 12 );
	end;
end;

-----------------------------------BOMB_XXX
function Bomb_2()
	Wait( 700 + RandomInt( 200 ) );
	LandReinforcementFromMap(1, "G_BOMBS", 5, 2204);
	Cmd( 0, 2204, 500, 8649, 4500 );
end;

----------------------------------AVIA_Sp
function German_avia()
	Wait( 200 + RandomInt( 100 ) );
	LandReinforcementFromMap(1, "SPEC", 5, 4141);
	Cmd( 5, 4141, 0, 5289, 4013 );
	Wait( 120 );
	StartThread(SP_GO);
end;

function SP_GO()
	ChangeFormation( 4141, 3 ); 
	Cmd( 3, 4141, 0, 8032, 4996 );
	StartThread(German_avia);
end;
------------------------------------Stress_attack
function Str_at()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "Stress1",0) > 1) or (GetNUnitsInArea(0, "Stress2",0) > 1)then
			Wait( 1 );
			LandReinforcementFromMap(1, "STRES", 4, 8903);
			Cmd(3, 8903, 0, GetScriptAreaParams( "Stress1" ) );
			QCmd(3, 8903, 0, GetScriptAreaParams( "Stress2" ) );
			QCmd(3, 8903, 0, GetScriptAreaParams( "AT2" ) );
			QCmd(3, 8903, 0, GetScriptAreaParams( "Port" ) );
			break;
		end;	
	end;
end;
------------------------////MAIN


StartThread(RevealObjective0);
StartThread(RevealObjective1);

StartThread( Unlucky );

StartThread( F_Objective0 ); 
StartThread( F_Objective2 ); 
StartThread( F_Objective3 ); 

StartThread( Glory );
StartThread( Inf_finita );

StartThread( Karlos );
StartThread( Armor_tr );
StartThread( Sea_beasts );
StartThread( Sea_beasts_2 );

StartThread(Ship_ded1);   ---------------SHIP1_DEAD
StartThread(Ship_ded2);   ---------------SHIP2_DEAD

StartThread( D_L );
StartThread( Bomb_2 );

StartThread( Str_at );   --------------KillPlayer