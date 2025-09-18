Obj0 = 0
Obj1 = 0
Obj2 = 0
y = 0
b=0

function Victory ()
    while 1 do
      Wait (3)
        if Obj2 == 1 then
          Wait (5)
          Win (0)
          break;
        end;
    end;
end;

function Caput1 ()
    while 1 do
      Wait (2) 
        if (GetNUnitsInPlayerUF (0) < 1) and (IsReinforcementAvailable (0) < 1)  then 
	      Wait (5)
	      ChangePlayerForScriptGroup (50, 3);
	      Wait (5)
	      Win (1)
	      break;
	    end;
	end;
end;

function Caput2 ()
    while 1 do
      Wait (2) 
        if Obj1 == 0 and (GetNUnitsInScriptGroup (777,0) < 1)  then 
	      Wait (5)
	      Win (1)
	      break;
	    end;
	end;
end;

function Boats1 ()
    while 1 do
     Wait (100)
        if Obj0 == 0 then 
         StartThread (Boats2)
        end;
    end;
end; 

function Boats2 ()
    while 1 do
     Wait (5) 
     Cmd (3, 101, 100, 6017, 6968);
     QCmd (3, 101, 100, 4405, 3313);
     QCmd (3, 101, 100, 6017, 6968);
     QCmd (3, 101, 100, 4405, 3313);
     QCmd (3, 101, 100, 6017, 6968);
     QCmd (3, 101, 100, 4405, 3313);
     QCmd (3, 101, 100, 6017, 6968);
     QCmd (3, 101, 100, 4405, 3313);
     QCmd (3, 101, 100, 6017, 6968);
     QCmd (3, 101, 100, 4405, 3313);
     Wait (3)
     Cmd (3, 102, 100, 3089, 6878);
     QCmd (3, 102, 100, 3415, 3924);
     QCmd (3, 102, 100, 3089, 6878);
     QCmd (3, 102, 100, 3415, 3924);
     QCmd (3, 102, 100, 3089, 6878);
     QCmd (3, 102, 100, 3415, 3924);
     QCmd (3, 102, 100, 3089, 6878);
     QCmd (3, 102, 100, 3415, 3924);
     QCmd (3, 102, 100, 3089, 6878);
     QCmd (3, 102, 100, 3415, 3924);
     break;
    end;
end;

function US_Boats ()
    while 1 do
     Wait (5)
        if (GetNUnitsInScriptGroup (50,0) < 1) then
         Wait (1)
         LandReinforcementFromMap (2, "Torpedo", 0, 50)
         ChangePlayerForScriptGroup (50, 0);
         break;
        end;
    end;
end;

function Objective0 ()
    while 1 do
     Wait (3)
     if (GetNUnitsInScriptGroup (101,1) < 1) and
	 (GetNUnitsInScriptGroup (102,1) < 1) and (GetNUnitsInScriptGroup (103,1) < 1) then
	     Wait (3)
	     CompleteObjective(0)
	     Obj0 = 1
	     break;
	    end;
	end;
end;

function Objective1 ()
    while 1 do
     Wait (3)
        if (GetNUnitsInScriptGroup (123, 0) > 0) then
         Wait (3)
         CompleteObjective(1)
         Obj1 = 1
         break;
        end;
    end;
end;

function Objective2 ()
    while 1 do 
     Wait (5)
     if (GetNUnitsInArea (1, "Defense", 0) < 1) and (GetNUnitsInArea (1, "Base", 0) < 1) and
     (GetNUnitsInArea (0, "Base", 0) > 0) then 
          Wait (3)
          CompleteObjective(2)
          Obj2 = 1
          break;
        end;
    end;
end;

function Reinforcement1 ()
    while 1 do
     Wait (5)
        if Obj0 == 1 and Obj1 == 1 then
         Wait (1)
         LandReinforcementFromMap (2, "Transport", 1, 60);
         Cmd (0, 60, 100, 6389, 4396);
         QCmd (0, 60, 100, 3313, 7895);
         QCmd (ACT_DISAPPEAR, 60);
         break;
        end;
    end;
end;

function Reinforcement2 ()
    while 1 do
     Wait (3)
        if (GetNScriptUnitsInArea (60, "Unload", 0) > 0) then
         Wait (4)
         LandReinforcementFromMap (2, "HeavyArmor1", 4, 70);
         LandReinforcementFromMap (2, "HeavyArmor2", 2, 71);
         ChangePlayerForScriptGroup (70, 0);
         ChangePlayerForScriptGroup (71, 0);
         y = 1
         break;
        end;
    end;
end;

function InfantryBoat1 ()
    while 1 do
     Wait (3)
        if y == 1 then
         Wait (2)
         LandReinforcementFromMap (2, "SmallBoat", 1, 80);
         Cmd (0, 80, 100, 6777, 5622);
         break;
        end;
    end;
end;
    
function InfantryBoat2 ()
    while 1 do
     Wait (3)
        if (GetNScriptUnitsInArea (80, "Unload2", 0) > 0) then
         Wait (3)
         LandReinforcementFromMap (2, "Infantry", 3, 81);
         ChangePlayerForScriptGroup (80, 0);
         ChangePlayerForScriptGroup (81, 0);
         break;
        end;
    end;
end;

function Attack1 ()
    Wait (2)
    while 1 do
     ChangeFormation (300, 3);
     ChangeFormation (301, 3);
     break;
    end;
end;

function Attack2A ()
    while 1 do
     Wait (5)
        if Obj1 == 1 and y == 0 then
         Wait (1)
         LandReinforcementFromMap (1, "Attack", 0, 400)
         ChangeFormation (400,3)
         Cmd (3, 400, 100, 1493, 4978)
         QCmd (3, 400, 100, 1180, 2512)
         QCmd (3, 400, 100, 2556, 1023)
         QCmd (3, 400, 100, 5690, 8584)
         QCmd (3, 400, 100, 7837, 1434)
         LandReinforcementFromMap (1, "Attack", 0, 401)
         ChangeFormation (401, 3);
         Cmd (3, 401, 100, 1494, 4978);
         QCmd (3, 401, 100, 1180, 2512);
         QCmd (3, 401, 100, 2556, 1023);
         QCmd (3, 401, 100, 5619, 1849);
         QCmd (3, 401, 100, 7307, 1728);
         break;
        end;
    end;
end;

function Attack3A ()
    while 1 do
     Wait (300)
        if Obj1 == 1 and y == 0 then
         LandReinforcementFromMap (1, "Attack", 0, 500)
         ChangeFormation (500, 3);
         Cmd (3, 500, 100, 1493, 4978)
         QCmd (3, 500, 100, 1180, 2512)
         QCmd (3, 500, 100, 2556, 1023)
         QCmd (3, 500, 100, 5690, 8584)
         QCmd (3, 500, 100, 7837, 1434)
         LandReinforcementFromMap (1, "Attack", 0, 501)
         ChangeFormation (501, 3);
         Cmd (3, 501, 100, 1494, 4978);
         QCmd (3, 501, 100, 1180, 2512);
         QCmd (3, 501, 100, 2556, 1023);
         QCmd (3, 501, 100, 5619, 1849);
         QCmd (3, 501, 100, 7307, 1728);
         break;
        end;
    end;
end;    

function Attack4A ()
    while 1 do
     Wait (600)
        if Obj1 == 1 and y == 0 then
         LandReinforcementFromMap (1, "Attack", 0, 600)
         ChangeFormation (600, 3);
         Cmd (3, 600, 100, 1493, 4978)
         QCmd (3, 600, 100, 1180, 2512)
         QCmd (3, 600, 100, 2556, 1023)
         QCmd (3, 600, 100, 5690, 8584)
         QCmd (3, 600, 100, 7837, 1434)
         LandReinforcementFromMap (1, "Attack", 0, 601)
         ChangeFormation (601, 3);
         Cmd (3, 601, 100, 1494, 4978);
         QCmd (3, 601, 100, 1180, 2512);
         QCmd (3, 601, 100, 2556, 1023);
         QCmd (3, 601, 100, 5619, 1849);
         QCmd (3, 601, 100, 7307, 1728);
         break;
        end;
    end;
end;
-------------------------------------
function Attack2B ()
    while 1 do
     Wait (5)
        if Obj1 == 1 and y == 1 then
         Wait (1)
         LandReinforcementFromMap (1, "AttackMedium", 0, 4000)
         ChangeFormation (4000,3)
         Cmd (3, 4000, 100, 1493, 4978)
         QCmd (3, 4000, 100, 1180, 2512)
         QCmd (3, 4000, 100, 2556, 1023)
         QCmd (3, 4000, 100, 5690, 8584)
         QCmd (3, 4000, 100, 7837, 1434)
         LandReinforcementFromMap (1, "AttackMedium", 0, 4001)
         ChangeFormation (4001, 3);
         Cmd (3, 4001, 100, 1494, 4978);
         QCmd (3, 4001, 100, 1180, 2512);
         QCmd (3, 4001, 100, 2556, 1023);
         QCmd (3, 4001, 100, 5619, 1849);
         QCmd (3, 4001, 100, 7307, 1728);
         break;
        end;
    end;
end;

function Attack3B ()
    while 1 do
     Wait (300)
        if Obj1 == 1 and y == 1 then
         LandReinforcementFromMap (1, "AttackMedium", 0, 5000)
         ChangeFormation (5000, 3);
         Cmd (3, 5000, 100, 1493, 4978)
         QCmd (3, 5000, 100, 1180, 2512)
         QCmd (3, 5000, 100, 2556, 1023)
         QCmd (3, 5000, 100, 5690, 8584)
         QCmd (3, 5000, 100, 7837, 1434)
         LandReinforcementFromMap (1, "AttackMedium", 0, 5001)
         ChangeFormation (5001, 3);
         Cmd (3, 5001, 100, 1494, 4978);
         QCmd (3, 5001, 100, 1180, 2512);
         QCmd (3, 5001, 100, 2556, 1023);
         QCmd (3, 5001, 100, 5619, 1849);
         QCmd (3, 5001, 100, 7307, 1728);
         break;
        end;
    end;
end;    

function Attack4B ()
    while 1 do
     Wait (600)
        if Obj1 == 1 and y == 1 then
         LandReinforcementFromMap (1, "AttackMedium", 0, 6000)
         ChangeFormation (6000, 3);
         Cmd (3, 6000, 100, 1493, 4978)
         QCmd (3, 6000, 100, 1180, 2512)
         QCmd (3, 6000, 100, 2556, 1023)
         QCmd (3, 6000, 100, 5690, 8584)
         QCmd (3, 6000, 100, 7837, 1434)
         LandReinforcementFromMap (1, "Attack", 0, 6001)
         ChangeFormation (6001, 3);
         Cmd (3, 6001, 100, 1494, 4978);
         QCmd (3, 6001, 100, 1180, 2512);
         QCmd (3, 6001, 100, 2556, 1023);
         QCmd (3, 6001, 100, 5619, 1849);
         QCmd (3, 6001, 100, 7307, 1728);
         break;
        end;
    end;
end;
---------------------
function Kill ()
    while 1 do 
      Wait (3)
        if Obj0 == 1 and (GetNUnitsInScriptGroup (50) > 0) and (GetNUnitsInScriptGroup (100111) < 4) and b <5 then
          Wait (10)
          --x,y = GetScriptObjCoord (50)
          LandReinforcementFromMap (1, "GAP", 0, 100111);
          Cmd (ACT_ATTACKUNIT, 100111, 50);
          b = b+1
          Wait (30)
        end;
    end;
end;
   


GiveObjective(0);
GiveObjective(1);
GiveObjective(2);
StartThread (Victory);
StartThread (Caput1);
StartThread (Caput2);
StartThread (Boats1);
StartThread (US_Boats);
StartThread (Objective0);
StartThread (Objective1);
StartThread (Objective2);
StartThread (Reinforcement1);
StartThread (Reinforcement2);
--StartThread (InfantryBoat1);
--StartThread (InfantryBoat2);
StartThread (Attack1);
StartThread (Attack2A);
StartThread (Attack3A);
StartThread (Attack4A);
StartThread (Attack2B);
StartThread (Attack3B);
StartThread (Attack4B);
StartThread (Kill);