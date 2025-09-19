a = 0
b = 0
c = 0
Obj0 = 0
Obj1 = 0
Obj2 = 0
--------------------------------------------------------------------------------
function Victory ()
    while 1 do 
      Wait (3)
        if Obj0 == 1 and Obj1 == 1 and Obj2 == 1 then 
         Wait (3)
         Win (0)
         break;
        end;
    end;
end; 

function Caput1 ()
    while 1 do
      Wait (3) 
        if Obj0 == 0  and (GetNUnitsInScriptGroup (99, 0) < 1) and (IsReinforcementAvailable (0) < 1)  then 
	      Wait (5)
	      Win (1)
	      break;
	    end;
	end;
end; 

function Caput2 ()
    while 1 do
      Wait (3) 
        if (GetNUnitsInPlayerUF (0) < 1) and (IsReinforcementAvailable (0) < 1)  then 
	      Wait (5)
	      Win (1)
	      break;
	    end;
	end;
end;	
------------------------------------------------------------------------------------

function Artillery1 ()
    while 1 do 
      Wait (2)
        if (GetNUnitsInScriptGroup (1001, 1) < 1) then
          ChangePlayerForScriptGroup (44, 0);
          break;
        end;
    end;
end; 

function Artillery2 ()
    while 1 do 
      Wait (2)
        if Obj0 == 1 and (GetNUnitsInScriptGroup (45, 1) > 0) then
          ChangePlayerForScriptGroup (44, 1);
          break;
        end;
    end;
end; 
-----------------------------------------------------------------------
function Objective0 ()
    while 1 do 
      Wait (3)
        if (GetNUnitsInScriptGroup (1001, 1) < 1) and (GetNUnitsInArea (0, "Artillery", 0) > 0) then
         Wait (3)
         CompleteObjective (0)
         Obj0 = 1
         break;
        end;
    end;
end;

function Objective1 ()
    while 1 do
      Wait (3)
        if (GetNUnitsInArea (1, "Village", 0) < 1) then 
         Wait (2)
         CompleteObjective (1)
         Obj1 = 1
         break;
        end;
    end;
end;

function Objective2_give ()
    while 1 do 
     Wait (5)
        if Obj0 == 1 and Obj1 == 1 then
         GiveObjective (2)
         break;
        end;
    end;
end;

function Objective2 ()
    while 1 do 
     Wait (5)
        if a == 1 and b == 1 and c == 1 and (GetNUnitsInScriptGroup (100, 1) <1)  and (GetNUnitsInScriptGroup (101, 1) <1) and
         (GetNUnitsInScriptGroup (200, 1) <1)  and (GetNUnitsInScriptGroup (201, 1) <1)  and
         (GetNUnitsInScriptGroup (300, 1) <1)  and (GetNUnitsInScriptGroup (301, 1) <1)  then
         Wait (3)
         CompleteObjective (2)
         Obj2 = 1
         break;
        end;
    end;
end;
-----------------------------
function CounterAttack1 ()
    while 1 do
     Wait (5)
        if Obj0 == 1 and Obj1 == 1 then
         Wait (3)
         GiveObjective (2)
         Wait (10)
         LandReinforcementFromMap (1, "Boat", 0, 100);
         Cmd (0, 100, 50, 8170, 8236);
         QCmd (0, 100, 50, 9939, 10006);
         QCmd (ACT_DISAPPEAR, 100);
         c = 1
         break;
        end;
    end;
end;

function Landing1 ()
    while 1 do 
     Wait (1)
        if (GetNScriptUnitsInArea (100,"C", 0) > 0) then
          Wait (5)
          LandReinforcementFromMap (1, "Attack", 3, 101);
          ChangeFormation (101, 3);
          Cmd (3, 101, 200, 3890, 8990);
          break;
        end;
    end;
end;
-----------------------------------------------------
function CounterAttack2 ()
    while 1 do 
     Wait (5)
        if Obj0 == 1 and Obj1 == 1 then
         Wait (1)
         LandReinforcementFromMap (1, "Boat", 1, 200);
         Cmd (0, 200, 50, 8939, 2182);
         QCmd (0, 200, 50, 9979, 348);
         QCmd (ACT_DISAPPEAR, 200);
         b = 1
         break;
        end;
    end;
end;

function Landing2 ()
    while 1 do 
     Wait (1)
        if (GetNScriptUnitsInArea (200,"B", 0) > 0) then
          Wait (5)
          LandReinforcementFromMap (1, "Attack", 4, 201);
          ChangeFormation (201, 3);
          Cmd (3, 201, 200, 7691, 3899);
          break;
        end;
    end;
end;
---------------------------------------------------------
function CounterAttack3 ()
    while 1 do 
     Wait (5)
        if Obj0 == 1 and Obj1 == 1 then
         Wait (1)
         LandReinforcementFromMap (1, "Boat", 2, 300);
         Cmd (0, 300, 50, 3494, 5528);
         QCmd (0, 300, 50, 279, 5303);
         QCmd (ACT_DISAPPEAR, 300);
         a = 1
         break;
        end;
    end;
end;

function Landing3 ()
    while 1 do 
     Wait (1)
        if (GetNScriptUnitsInArea (300,"A", 0) > 0) then
          Wait (5)
          LandReinforcementFromMap (1, "Attack", 5, 301);
          ChangeFormation (101, 3);
          Cmd (3, 301, 200, 4275, 8748);
          QCmd (3, 301, 200, 3890, 8990);
          break;
        end;
    end;
end;   
----------------------------------------------------------
function SmallBoats ()
    while 1 do
      Wait (5)
        if Obj0 == 0 and Obj1 == 0 and (GetNUnitsInScriptGroup (50, 0 ) < 1) then 
          Wait (5)
          LandReinforcementFromMap (2, "SmallBoats", 0, 50);
          Cmd (0, 50, 300, 2701, 2249 )
          Wait (10)
          ChangePlayerForScriptGroup (50, 0);
          break;
        end;
    end;
end;

function Patrol ()
    while 1 do
      Wait (5)
      StartThread (Patrol1);
      StartThread (Patrol2);
      Wait (600);
    end;
end;

function Patrol1 ()
    while 1 do
     Wait (1)
     Cmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     QCmd (0, 10, 50, 7689, 786);
     QCmd (0, 10, 50, 842, 6854);
     break;
    end;
end; 

function Patrol2 ()
    while 1 do
     Wait (1)
     Cmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     QCmd (0, 20, 50, 496, 6242);
     QCmd (0, 20, 50, 7085, 623);
     break;
    end;
end;

function Recon ()
    while 1 do 
      Wait (1)
        if ((GetNUnitsInScriptGroup (911, 0) == 0) and Obj0 == 0 and Obj1 == 0) then
          Wait (5)
          LandReinforcementFromMap (2, "Recon", 0, 911);
          ChangePlayerForScriptGroup (911, 0);
          Cmd (0, 911, 100, 2450, 2039);
        end;
    end;
end;

function Stop1 ()
    while 1 do
     Wait (1)
     Cmd (ACT_STAND, 1000);
     break;
    end;
end;

function Stop2 ()
    while 1 do
     Wait (1)
     Cmd (ACT_STAND, 1001);
     break;
    end;
end;
-------------------------------------------------------------
GiveObjective (0)
GiveObjective (1)
StartThread (Victory);
StartThread (Caput1);
StartThread (Caput2);
StartThread (Artillery1); 
StartThread (Artillery2);
StartThread (Objective0);
StartThread (Objective1);
StartThread (Objective2_give);
StartThread (Objective2);
StartThread (CounterAttack1)
StartThread (CounterAttack2)
StartThread (CounterAttack3)
StartThread (Landing1);
StartThread (Landing2);
StartThread (Landing3);
StartThread (SmallBoats);
StartThread (Patrol)
StartThread (Recon);
StartThread (Stop1);
StartThread (Stop2);