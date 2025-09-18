Obj1 = 0
x=0

function Caput ()
    while 1 do
      Wait (2) 
        if (GetNUnitsInPlayerUF (0) < 1) and (IsReinforcementAvailable (0) < 1)  then 
	      Wait (5)
	      Win (1)
	      break;
	    end;
	end;
end;	

function Victory ()
    while 1 do 
      Wait (3)
        if Obj1 == 1 then
          Wait (3)
          Win (0)
          break;
        end;
    end;
end;

function Artillery ()
    while 1 do
      Wait (3)
        if (GetNUnitsInScriptGroup (44, 1) < 1) then
          Wait (3)
          CompleteObjective(0)
          x=1
          Wait (5)
          LandReinforcementFromMap (2, "Boat", 0, 988)
          Cmd (0, 988, 100, 6725, 3219);
          QCmd (0, 988, 100, 6773, 144);
          QCmd (ACT_DISAPPEAR, 988);
          break;
        end;
    end;
end;

function KeyPoint ()
    while 1 do 
      Wait (3)
        if (GetNUnitsInScriptGroup (123, 0) > 0) then
          Wait (2)
          CompleteObjective (1)
          Obj1 = 1
          break;
        end;
    end;
end;
 
function Attack1 ()
    while 1 do
     Wait (10)
     ChangeFormation (100, 3)
     Cmd (3, 100, 100, 1541, 1453);
     ChangeFormation (101, 3)
     Cmd (3, 101, 100, 2184, 958);
     ChangeFormation (102, 3)
     Cmd (3, 102, 100, 2823, 982);
     break;
    end;
end;

function Attack2 ()
    while 1 do
     Wait (180)
     ChangeFormation (300, 3)
     Cmd (3, 300, 100, 2040, 1166);
     break;
    end;
end;

function Attack3 ()
    while 1 do
     Wait (360)
     ChangeFormation (200, 3)
     Cmd (3, 200, 100, 2040, 1166);
     break;
    end;
end;

function Attack4 ()
    while 1 do
        Wait (3)
        if x == 1 then
        Wait (60)
         ChangeFormation (400, 3)
         Cmd (3, 400, 200, 6627, 6613);
         break;
        end;
    end;
end;

function Attack5 ()
    while 1 do
        Wait (3)
        if x == 1 then
        Wait (180)
         Cmd (3, 444, 200, 6627, 6613);
         break;
        end;
    end;
end;

function Landing1 ()
    while 1 do
      Wait (1)
      LandReinforcementFromMap (2, "Boat", 0, 98)
      Cmd (0, 98, 100, 6725, 3219);
      QCmd (0, 98, 100, 6773, 144);
      QCmd (ACT_DISAPPEAR, 98);
      Wait (30)
      LandReinforcementFromMap (2, "Boat", 0, 99)
      Cmd (0, 99, 100, 7356, 3490);
      QCmd (0, 99, 100, 7634, 172);
      QCmd (ACT_DISAPPEAR, 99);
      break;
    end;
end;

function Landing2 ()
    while 1 do
      Wait (1)
        if (GetNScriptUnitsInArea (98, "Land", 0) > 0) then
          Wait (2)          
          LandReinforcementFromMap (2, "Infantry", 2, 555);
          ChangePlayerForScriptGroup (555, 0);
          ChangeFormation (555, 3);
          break;
        end;
    end;
end;

function Landing22 ()
    while 1 do
      Wait (1)
        if (GetNScriptUnitsInArea (99, "Land", 0) > 0) then
          Wait (2)          
          LandReinforcementFromMap (2, "SpecialInfantry", 1, 556);
          ChangePlayerForScriptGroup (556, 0);
          ChangeFormation (556, 3);
          break;
        end;
    end;
end;

function Landing3 ()
    while 1 do
      Wait (1)
        if (GetNScriptUnitsInArea (988, "Land", 0) > 0) then
          Wait (2)          
          LandReinforcementFromMap (2, "Infantry", 2, 5555);
          ChangePlayerForScriptGroup (5555, 0);
          ChangeFormation (5555, 3);
          break;
        end;
    end;
end;


function Stop ()
    while 1 do 
     Wait (1)
     Cmd (50, 200);
     Wait (1)
     Cmd (50, 300);
     Wait (1)
     Cmd (50, 400);
     Wait (1)
     Cmd (50, 1000);
     Wait (1)
     Cmd (444, 1000);
     break;
    end;
end;  

function Auto ()
    while 1 do 
     Wait (3)
        if (GetNUnitsInArea (1, "Artillery", 0) < 1) then
        Wait (5)
          ChangePlayerForScriptGroup (560, 0);
          StartThread (Landing1);
          x=1
          break;
        end;
    end;
end;


function Secret ()
    while 1 do
     Wait (3)
        if (GetNUnitsInScriptGroup (44, 0) >0) then
         Wait (3)
         CompleteObjective(2)
         break;
        end;
    end;
end;
 
-----------------------------------
GiveObjective (0)
GiveObjective (1)
StartThread (Caput);
StartThread (Victory);
StartThread (KeyPoint);
StartThread (Artillery);
StartThread (Attack1);
StartThread (Attack2);
StartThread (Attack3);
StartThread (Attack4);
StartThread (Attack5);
StartThread (Landing1);
StartThread (Landing2);
StartThread (Landing22);
StartThread (Landing3);
--StartThread (Stop);
StartThread (Auto);
StartThread (Secret);