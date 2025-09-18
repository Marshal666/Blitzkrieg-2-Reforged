Objective0 = 0

function KeyPoint ()
    while 1 do
     Wait (3)
        if (GetNUnitsInScriptGroup (777, 0)> 0) then
          Wait (3)
          CompleteObjective(0)
          Objective0 = 1
          break;
        end;
    end;
end;

function Victory ()
    while 1 do
      Wait (2)
        if Objective0 == 1 then
          Wait (3)
          Win (0)
         break;
        end;
    end;
end;

function Caput ()
    while 1 do
     Wait (3)
     if ((GetNUnitsInPlayerUF (0) <1) and (GetReinforcementCallsLeft (0) <1))
	 or ((GetNUnitsInPlayerUF (0) <1) and (IsReinforcementAvailable (0) < 1)) then
	     Wait (5)
	     Win (1)
	     break;
	    end;
	end;
end;

function Stop ()
    while 1 do
     Wait (1)
     Cmd (ACT_STAND, 1000);
     break;
    end;
end; 
--------------------------------------------------------------- Attacks on player
function Attack_1A ()
    while 1 do
     Wait (5)
     LandReinforcementFromMap (1, "J_Attack1", 1, 100)
     ChangeFormation (100, 1);
     Cmd (3, 100, 200, 969, 4326);
     Wait (40)
     ChangeFormation (100, 3);
     QCmd (3, 100, 200, 2443, 1040);
     QCmd (3, 100, 200, 4431, 1318);
     break;
    end;
end; 

function Attack_1AA ()
    while 1 do
     Wait (5)
     LandReinforcementFromMap (1, "J_Attack1", 2, 101)
     ChangeFormation (101, 1);
     Cmd (3, 101, 200, 1459, 4301);
     Wait (40)
     ChangeFormation (101, 3);
     QCmd (3, 101, 200, 3050, 1303);
     QCmd (3, 101, 200, 4431, 1318);
     break;
    end;
end; 

function Attack_1AAA ()
    while 1 do
     Wait (10)
     LandReinforcementFromMap (1, "J_Attack1", 2, 102)
     ChangeFormation (102, 1);
     Cmd (3, 102, 200, 2155, 4446);
     Wait (35) 
     ChangeFormation (102, 3);
     QCmd (3, 102, 200, 4431, 1318);
     break;
    end;
end;
---------------------------------------------------------------------------------------
function Attack_2A ()
    while 1 do
     Wait (300)
     LandReinforcementFromMap (1, "J_Attack2", 1, 200)
     ChangeFormation (200, 1);
     Cmd (3, 200, 200, 969, 4326);
     Wait (40)
     ChangeFormation (200, 3);
     QCmd (3, 200, 200, 2443, 1040);
     QCmd (3, 200, 200, 4431, 1318);
     break;
    end;
end; 

function Attack_2AA ()
    while 1 do
     Wait (305)
     LandReinforcementFromMap (1, "J_Attack2", 2, 201)
     ChangeFormation (201, 1);
     Cmd (3, 201, 200, 1459, 4301);
     Wait (40)
     ChangeFormation (201, 3);
     QCmd (3, 201, 200, 3050, 1303);
     QCmd (3, 201, 200, 4431, 1318);
     break;
    end;
end; 

function Attack_2AAA ()
    while 1 do
     Wait (310)
     LandReinforcementFromMap (1, "J_Attack2", 2, 202)
     ChangeFormation (202, 1);
     Cmd (3, 202, 200, 2155, 4446);
     Wait (35) 
     ChangeFormation (102, 3);
     QCmd (3, 202, 200, 4431, 1318);
     break;
    end;
end;
----------------------------------------------------------------
function Attack_3A ()
    while 1 do
     Wait (600)
     LandReinforcementFromMap (1, "J_Attack3", 1, 300)
     ChangeFormation (300, 1);
     Cmd (3, 300, 200, 969, 4326);
     Wait (40)
     ChangeFormation (300, 3);
     QCmd (3, 300, 200, 2443, 1040);
     QCmd (3, 300, 200, 4431, 1318);
     break;
    end;
end; 

function Attack_3AA ()
    while 1 do
     Wait (605)
     LandReinforcementFromMap (1, "J_Attack3", 2, 301)
     ChangeFormation (301, 1);
     Cmd (3, 301, 200, 1459, 4301);
     Wait (40)
     ChangeFormation (301, 3);
     QCmd (3, 301, 200, 3050, 1303);
     QCmd (3, 301, 200, 4431, 1318);
     break;
    end;
end; 

function Attack_3AAA ()
    while 1 do
     Wait (610)
     LandReinforcementFromMap (1, "J_Attack3", 2, 302)
     ChangeFormation (302, 1);
     Cmd (3, 302, 200, 2155, 4446);
     Wait (35) 
     ChangeFormation (302, 3);
     QCmd (3, 302, 200, 4431, 1318);
     break;
    end;
end;
---------------------------------------------------------------- Attacks on allied troops
function Attack_1B ()
    while 1 do
     Wait (30)
     LandReinforcementFromMap (1, "J_Attack1", 3, 400)
     ChangeFormation (400, 1);
     Cmd (3, 400, 200, 6804, 7427);
     Wait (20) 
     ChangeFormation (400, 3);
     QCmd (3, 400, 200, 7292, 823);
     QCmd (3, 400, 200, 4327, 418);
     break;
    end;
end;


function Attack_1BB ()
    while 1 do
     Wait (35)
     LandReinforcementFromMap (1, "J_Attack1", 3, 401)
     ChangeFormation (401, 1);
     Cmd (3, 401, 200, 6187, 7259);
     Wait (15) 
     ChangeFormation (401, 3);
     QCmd (3, 401, 200, 6928, 1212);
     QCmd (3, 401, 200, 4488, 1189);
     break;
    end;
end;


function Attack_1BBB ()
    while 1 do
     Wait (40)
     LandReinforcementFromMap (1, "J_Attack1", 3, 402)
     ChangeFormation (402, 1);
     Cmd (3, 402, 200, 5451, 7078);
     Wait (10) 
     ChangeFormation (402, 3);
     QCmd (3, 402, 200, 6715, 471);
     QCmd (3, 402, 200, 3471, 1556);
     break;
    end;
end;
-----------------------------------------------------
function Attack_2B ()
    while 1 do
     Wait (250)
     LandReinforcementFromMap (1, "J_Attack2", 3, 500)
     ChangeFormation (500, 1);
     Cmd (3, 500, 200, 6804, 7427);
     Wait (20) 
     ChangeFormation (500, 3);
     QCmd (3, 500, 200, 7292, 823);
     QCmd (3, 500, 200, 4327, 418);
     break;
    end;
end;


function Attack_2BB ()
    while 1 do
     Wait (255)
     LandReinforcementFromMap (1, "J_Attack2", 3, 501)
     ChangeFormation (501, 1);
     Cmd (3, 501, 200, 6187, 7259);
     Wait (15) 
     ChangeFormation (501, 3);
     QCmd (3, 501, 200, 6928, 1212);
     QCmd (3, 501, 200, 4488, 1189);
     break;
    end;
end;


function Attack_2BBB ()
    while 1 do
     Wait (260)
     LandReinforcementFromMap (1, "J_Attack2", 3, 502)
     ChangeFormation (502, 1);
     Cmd (3, 502, 200, 5451, 7078);
     Wait (10) 
     ChangeFormation (502, 3);
     QCmd (3, 502, 200, 6715, 471);
     QCmd (3, 502, 200, 3471, 1556);
     break;
    end;
end;
----------------------------------------------------
function Attack_3B ()
    while 1 do
     Wait (400)
     LandReinforcementFromMap (1, "J_Attack3", 3, 600)
     ChangeFormation (600, 1);
     Cmd (3, 600, 200, 6804, 7427);
     Wait (20) 
     ChangeFormation (600, 3);
     QCmd (3, 600, 200, 7292, 823);
     QCmd (3, 600, 200, 4327, 418);
     break;
    end;
end;


function Attack_3BB ()
    while 1 do
     Wait (405)
     LandReinforcementFromMap (1, "J_Attack3", 3, 601)
     ChangeFormation (601, 1);
     Cmd (3, 601, 200, 6187, 7259);
     Wait (15) 
     ChangeFormation (601, 3);
     QCmd (3, 601, 200, 6928, 1212);
     QCmd (3, 601, 200, 4488, 1189);
     break;
    end;
end;


function Attack_3BBB ()
    while 1 do
     Wait (410)
     LandReinforcementFromMap (1, "J_Attack3", 3, 602)
     ChangeFormation (602, 1);
     Cmd (3, 602, 200, 5451, 7078);
     Wait (10) 
     ChangeFormation (602, 3);
     QCmd (3, 602, 200, 6715, 471);
     QCmd (3, 602, 200, 3471, 1556);
     break;
    end;
end;
-----------------------------------------------------///DB_addon
function AI_Reinfout()
	Wait(2);
	if (GetNUnitsInArea(0, "VILLAGE",0) > 0) and (GetNUnitsInArea(1, "VILLAGE",0) < 1) then
	GiveReinforcementCalls ( 1, -10 );
	end;
end;
-----------------------------------------------------
GiveObjective (0)
StartThread(KeyPoint);
StartThread(Victory); 
StartThread(Caput);
StartThread (Stop); 
StartThread(Attack_1A);
StartThread(Attack_1AA);
StartThread(Attack_1AAA);
StartThread(Attack_2A);
StartThread(Attack_2AA);
StartThread(Attack_2AAA);
StartThread(Attack_3A);
StartThread(Attack_3AA);
StartThread(Attack_3AAA);
StartThread(Attack_1B);
StartThread(Attack_1BB);
StartThread(Attack_1BBB);
StartThread(Attack_2B);
StartThread(Attack_2BB);
StartThread(Attack_2BBB);
StartThread(Attack_3B);
StartThread(Attack_3BB);
StartThread(Attack_3BBB);

StartThread(AI_Reinfout);   ------------DB_addon