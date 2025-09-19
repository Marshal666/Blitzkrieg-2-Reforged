Obj0 = 0
y = 0
l = 1

PatrolPath = 
{
	1677, 2629,
    1920, 2489,
    2420, 2885,
    2676, 2855,
    3043, 2535,
    3229, 2508
}

-----------------------------
function Victory ()
    while 1 do
     Wait (3)
       if Obj0 == 1 then
          Wait (3)
          CompleteObjective (0)
          Wait (5)
          Win (0)
          break;
        end;
    end;
end;

function Victory2 ()
   while 1 do 
        Wait (3)
        if (GetNUnitsInScriptGroup (769,2) > 0) and (GetNUnitsInScriptGroup (770, 2)> 0 ) then
          Wait (30)
          Win (0)
          break;
        end;
    end;
end;

    

function Caput ()
while 1 do 
     Wait (3)
      if ((GetNUnitsInPlayerUF (0) < 1) and (IsReinforcementAvailable (0) < 1))  or
	  (Obj0 == 0 and (GetNUnitsInScriptGroup (769) < 1)) or (Obj0 == 0 and (GetNUnitsInScriptGroup (770) < 1)) or
	  (Obj0 == 0 and (GetNUnitsInScriptGroup (771) < 1)) or (Obj0 == 0 and (GetNUnitsInScriptGroup (772) < 1)) or 
	  (Obj0 == 0 and (GetNUnitsInScriptGroup (773) < 1)) or (Obj0 == 0 and (GetNUnitsInScriptGroup (774) < 1)) then 
	      Wait (5)
	      Win (1)
	      break;
	    end;
	end;
end;

 
-------------------------------
function Object ()
    while 1 do
     Wait (3)
        if y ==  1 and (GetNUnitsInScriptGroup (600100) < 4) and (GetNUnitsInScriptGroup (600101) < 4) and (GetNUnitsInScriptGroup (600102) < 4) and
	     (GetNUnitsInScriptGroup (600103) < 4) and (GetNUnitsInScriptGroup (600104) < 4) and (GetNUnitsInScriptGroup (600105) < 4) then
         Wait (5);
         ChangePlayerForScriptGroup (769, 2);
         ChangePlayerForScriptGroup (770, 2);
         StartThread (Go);
         break;
	    end;
	end;
end;

function Go ()
    while 1 do 
      Wait (1)
      Cmd (0, 769, 200, 5720, 223);
      Wait (10)
    end;
end;
  
-----------------------------------

function Train ()
  while 1 do
        Wait (1)
        if (GetNScriptUnitsInArea (769, "Exit", 0) > 0) then
        Wait (3)
         Cmd (ACT_DISAPPEAR, 769);
         Cmd (ACT_DISAPPEAR, 770);
         Cmd (ACT_DISAPPEAR, 771);
         Cmd (ACT_DISAPPEAR, 772);
         Cmd (ACT_DISAPPEAR, 773);
         Cmd (ACT_DISAPPEAR, 774);
         Obj0 = 1
         break;
        end;
    end;
end;
    

function Wave1A ()
    while 1 do 
     Wait (60)
     LandReinforcementFromMap (1, "Attack1", 0, 100100)
     ChangeFormation (100100, 3);
     Cmd (3, 100100, 100, 3528, 2781);
     break;
    end;
end;

function Wave1B ()
 while 1 do
    Wait (60)
     LandReinforcementFromMap (1, "Attack1", 1, 100101)
     ChangeFormation (100101, 3);     
     Cmd (3, 100101, 100, 3734, 3450);
     QCmd (3, 100101, 100, 3070, 2570);
     break;
    end;
end;

function Wave1C ()
while 1 do 
     Wait (60)
     LandReinforcementFromMap (1, "Attack1",2, 100102);
     ChangeFormation (100102, 3);
     Cmd (3, 100102, 100, 3877, 4067);
     QCmd (3, 100102, 100, 3129, 2608);
     break;
    end;
end;

function Wave1D ()
while 1 do
     Wait (10)
     LandReinforcementFromMap (1, "Attack1",3, 100103);
     ChangeFormation (100103, 3);
     Cmd (3, 100103, 100, 2861, 3272);
     break;
    end;
end;

function Wave1E ()
while 1 do
     Wait (10)
     LandReinforcementFromMap (1, "Attack1",4, 100104);
     ChangeFormation (100104, 3);
     Cmd (3, 100104, 100, 3452, 3025);
     break;
    end;
end;

function Wave1F ()
while 1 do
     Wait (10)
     LandReinforcementFromMap (1, "Attack1",5, 100105);
     ChangeFormation (100105, 3);
     Cmd (3, 100105, 100, 3989, 2446);
     break;
    end;
end;

---------------------------------------------------------------------2
function Wave2A ()
    while 1 do 
     Wait (120)
     LandReinforcementFromMap (1, "Attack2", 0, 200100)
     ChangeFormation (200100, 3);
     Cmd (3, 200100, 100, 3528, 2781);
     break;
    end;
end;


function Wave2B ()
    while 1 do
     Wait (120)
     LandReinforcementFromMap (1, "Attack2", 1, 200101)
     ChangeFormation (200101, 3);     
     Cmd (3, 200101, 100, 3734, 3450);
     QCmd (3, 200101, 100, 3070, 2570);
     break;
    end;
end;

function Wave2C ()
while 1 do
     Wait (180)
     LandReinforcementFromMap (1, "Attack2",2, 200102);
     ChangeFormation (200102, 3);
     Cmd (3, 200102, 100, 3877, 4067);
     QCmd (3, 200102, 100, 3129, 2608);
     break;
    end;
end;

function Wave2D ()
while 1 do
     Wait (180)
     LandReinforcementFromMap (1, "Attack2",3, 200103);
     ChangeFormation (200103, 3);
     Cmd (3, 200103, 100, 2861, 3272);
     break;
    end;
end;

function Wave2E () 
while 1 do 
     Wait (120)
     LandReinforcementFromMap (1, "Attack2",4, 200104);
     ChangeFormation (200104, 3);
     Cmd (3, 200104, 100, 3452, 3025);
     break;
    end;
end;

function Wave2F ()
while 1 do
    Wait (120)
     LandReinforcementFromMap (1, "Attack2",5, 200105);
     ChangeFormation (200105, 3);
     Cmd (3, 200105, 100, 3989, 2446);
     ChangePlayerForScriptGroup (774, 2)
     l = 2
     break;
    end;
end;
----------------------------------------------------------------------------3
function Wave3A ()
    while 1 do 
     Wait (300)
     LandReinforcementFromMap (1, "Attack3a", 0, 300100)
     ChangeFormation (300100, 3);
     Cmd (3, 300100, 100, 3528, 2781);
     break;
    end;
end;


function Wave3B ()
    while 1 do
     Wait (300)
     LandReinforcementFromMap (1, "Attack3a", 1, 300101)
     ChangeFormation (300101, 3);     
     Cmd (3, 300101, 100, 3734, 3450);
     QCmd (3, 300101, 100, 3070, 2570);
     break;
    end;
end;

function Wave3C ()
while 1 do
     Wait (240)
     LandReinforcementFromMap (1, "Attack3b",2, 300102);
     ChangeFormation (300102, 3);
     Cmd (3, 300102, 100, 3877, 4067);
     QCmd (3, 300102, 100, 3129, 2608);
     break;
    end;
end;

function Wave3D ()
while 1 do
     Wait (240)
     LandReinforcementFromMap (1, "Attack3b",3, 300103);
     ChangeFormation (300103, 3);
     Cmd (3, 300103, 100, 2861, 3272);
     break;
    end;
end;

function Wave3E () 
while 1 do 
     Wait (300)
     LandReinforcementFromMap (1, "Attack3a",4, 300104);
     ChangeFormation (300104, 3);
     Cmd (3, 300104, 100, 3452, 3025);
     break;
    end;
end;

function Wave3F ()
while 1 do
    Wait (300)
     LandReinforcementFromMap (1, "Attack3a",5, 300105);
     ChangeFormation (300105, 3);
     Cmd (3, 300105, 100, 3989, 2446);
     ChangePlayerForScriptGroup (773, 2)
     l = 3
     break;
    end;
end;
-----------------------------------4
function Wave4A ()
    while 1 do 
     Wait (360)
     LandReinforcementFromMap (1, "Attack4a", 0, 400100)
     ChangeFormation (400100, 3);
     Cmd (3, 400100, 100, 3528, 2781);
     break;
    end;
end;


function Wave4B ()
    while 1 do
     Wait (360)
     LandReinforcementFromMap (1, "Attack4a", 1, 400101)
     ChangeFormation (400101, 3);     
     Cmd (3, 400101, 100, 3734, 3450);
     QCmd (3, 400101, 100, 3070, 2570);
     break;
    end;
end;

function Wave4C ()
while 1 do
     Wait (420)
     LandReinforcementFromMap (1, "Attack4a",2, 400102);
     ChangeFormation (400102, 3);
     Cmd (3, 400102, 100, 3877, 4067);
     QCmd (3, 400102, 100, 3129, 2608);
     break;
    end;
end;

function Wave4D ()
while 1 do
     Wait (420)
     LandReinforcementFromMap (1, "Attack4b",3, 400103);
     ChangeFormation (400103, 3);
     Cmd (3, 400103, 100, 2861, 3272);
     break;
    end;
end;

function Wave4E () 
while 1 do 
     Wait (420)
     LandReinforcementFromMap (1, "Attack4b",4, 400104);
     ChangeFormation (400104,  3);
     Cmd (3, 400104, 100, 3452, 3025);
     break;
    end;
end;

function Wave4F ()
while 1 do
    Wait (360)
     LandReinforcementFromMap (1, "Attack4b",5, 400105);
     ChangeFormation (400105, 3);
     Cmd (3, 400105, 100, 3989, 2446);
     ChangePlayerForScriptGroup (772, 2)
     l = 4
     break;
    end;
end;

---------------------------------------------------5
function Wave5A ()
    while 1 do 
     Wait (480)
     LandReinforcementFromMap (1, "Attack4a", 0, 500100)
     ChangeFormation (500100, 3);
     Cmd (3, 500100, 100, 3528, 2781);
     break;
    end;
end;


function Wave5B ()
    while 1 do
     Wait (540)
     LandReinforcementFromMap (1, "Attack4b", 1, 500101)
     ChangeFormation (500101, 3);     
     Cmd (3, 500101, 100, 3734, 3450);
     QCmd (3, 500101, 100, 3070, 2570);
     break;
    end;
end;

function Wave5C ()
while 1 do
     Wait (480)
     LandReinforcementFromMap (1, "Attack4a",2, 500102);
     ChangeFormation (500102, 3);
     Cmd (3, 500102, 100, 3877, 4067);
     QCmd (3, 500102, 100, 3129, 2608);
     break;
    end;
end;

function Wave5D ()
while 1 do
     Wait (540)
     LandReinforcementFromMap (1, "Attack4b",3, 500103);
     ChangeFormation (500103, 3);
     Cmd (3, 500103, 100, 2861, 3272);
     break;
    end;
end;

function Wave5E () 
while 1 do 
     Wait (480)
     LandReinforcementFromMap (1, "Attack4a",4, 500104);
     ChangeFormation (500104, 3);
     Cmd (3, 500104, 100, 3452, 3025);
     break;
    end;
end;

function Wave5F ()
while 1 do
    Wait (540)
     LandReinforcementFromMap (1, "Attack4b",5, 500105);
     ChangeFormation (500105, 3);
     Cmd (3, 500105, 100, 3989, 2446);
     break;
    end;
end;

function Wave5G ()
while 1 do
     Wait (500)
     LandReinforcementFromMap (0, "Bt7", 1 , 700100);
     Cmd (0, 700100, 100, 2658, 1146);
     QCmd (0, 700100, 100, 3382, 1392);
     QCmd (0, 700100, 100, 4555, 2514);
     QCmd (ACT_STAND, 700, 100);
     break;
    end;
end;
----------------------------------------------
function Wave6A ()
    while 1 do 
     Wait (600)
     LandReinforcementFromMap (1, "Attack5a", 0, 600100)
     ChangeFormation (600100, 3);
     Cmd (3, 600100, 100, 3528, 2781);
     break;
    end;
end;


function Wave6B ()
    while 1 do
     Wait (600)
     LandReinforcementFromMap (1, "Attack5b", 1, 600101)
     ChangeFormation (600101, 3);     
     Cmd (3, 600101, 100, 3734, 3450);
     QCmd (3, 600101, 100, 3070, 2570);
     break;
    end;
end;

function Wave6C ()
while 1 do
     Wait (600)
     LandReinforcementFromMap (1, "Attack5a",2, 600102);
     ChangeFormation (600102, 3);
     Cmd (3, 600102, 100, 3877, 4067);
     QCmd (3, 600102, 100, 3129, 2608);
     break;
    end;
end;

function Wave6D ()
while 1 do
     Wait (600)
     LandReinforcementFromMap (1, "Attack5b",3, 600103);
     ChangeFormation (600103, 3);
     Cmd (3, 600103, 100, 2861, 3272);
     break;
    end;
end;

function Wave6E () 
while 1 do 
     Wait (600)
     LandReinforcementFromMap (1, "Attack5a",4, 600104);
     ChangeFormation (600104, 3);
     Cmd (3, 600104, 100, 3452, 3025);
     break;
    end;
end;

function Wave6F ()
while 1 do
    Wait (600)
     LandReinforcementFromMap (1, "Attack5b",5, 600105);
     ChangeFormation (600105, 3);
     Cmd (3, 600105, 100, 3989, 2446);
     ChangePlayerForScriptGroup (771, 2)
     y = 1
     break;
    end;
end;
--------------------------------------------------------------

function Run1 ()
while 1 do
     Wait (120)
     Cmd (ACT_LEAVE, 3737, 100, 2855, 3896);
     ChangeFormation (3737, 1)
     QCmd (0, 3737, 200, 3045, 2587);
     QCmd (6, 3737, 4747);
     break;
    end;
end;

function Run2 ()
while 1 do
     Wait (125)
     Cmd (ACT_LEAVE, 3738, 100, 4368, 3706);
     ChangeFormation (3738,1)
     QCmd (0, 3738, 200, 3045, 2587);
     QCmd (6, 3738, 4747);
     break;
    end;
end;

function Run3 ()
while 1 do
     Wait (130)
     Cmd (ACT_LEAVE, 3739, 100, 3761, 4085);
     ChangeFormation (3739, 1)
     QCmd (0, 3739, 200, 3045, 2587);
     QCmd (6, 3739, 4747);
     break;
    end;
end;
-----------------------

function patrol(ScriptID,Path,N)
	for i=1,N do
		QCmd(ACT_MOVE,ScriptID,0,Path[2*i - 1],Path[2*i]);
		if i == N then
			QCmd(ACT_WAIT,ScriptID,25);
			--Trace("Stoim :)");
		end;
	end;
	for i=1,N do
		n = (N+1) - i;
		QCmd(ACT_MOVE,ScriptID,0,Path[2*n - 1],Path[2*n]);
		if i == N then
			QCmd(ACT_WAIT,ScriptID,5);
			--Trace("Stoim :(");
		end;
	end;
end;

function patrol_smb()
	while 1 do
		Wait(3);
		if (GetNScriptUnitsInArea(100100,"Load",0) > 0) then
			--Trace("priehali :)");
			StartThread(patrol,100100,PatrolPath,6);
		end;
	end;
end;

function Service ()
    while 1 do
      Wait (1)
      if (GetNScriptUnitsInArea (100100,"Unload1", 0) > 0) then 
      Wait (1)
      Cmd (0, 100111, 50, 3229, 2508);
      QCmd (0, 100111, 50, 3324, 2584);
      QCmd (0, 100111, 50, 3229, 2508);
      QCmd (0, 100111, 50, 3324, 2584);
      QCmd (0, 100111, 50, 3229, 2508);
      QCmd (0, 100111, 50, 3324, 2584);
      QCmd (0, 100111, 50, 3084, 2744);
      Wait (40)
      --elseif (GetNScriptUnitsInArea (100100,"Unload1", 0) > 0) and l == 2 then 
      --Cmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3298, 2681);
      --QCmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3298, 2681);
      --QCmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3298, 2681);
      --QCmd (0, 100111, 50, 3084, 2744);
      --Wait (40)
      --elseif (GetNScriptUnitsInArea (100100,"Unload1", 0) > 0) and l == 3 then 
      --Cmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3429, 2549);
      --QCmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3429, 2549);
      --QCmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3429, 2549);
      --QCmd (0, 100111, 510, 3084, 2744);
      --Wait (40)
      --elseif (GetNScriptUnitsInArea (100100,"Unload1", 0) > 0) and l == 4 then 
      --Cmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3563, 2416);
      --QCmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3563, 2416);
      --QCmd (0, 100111, 50, 3229, 2508);
      --QCmd (0, 10111, 50, 3563, 2416);
      --QCmd (0, 100111, 50, 3084, 2744);
      --Wait (40)
      end;
    end;
end;

------------------------
GiveObjective(0)
StartThread (Victory);
StartThread (Object);
StartThread (Caput);
StartThread (Wave1A);
StartThread (Wave1B);
StartThread (Wave1C);
StartThread (Wave1D);
StartThread (Wave1E);
StartThread (Wave1F);

StartThread (Wave2A);
StartThread (Wave2B);
StartThread (Wave2C);
StartThread (Wave2D);
StartThread (Wave2E);
StartThread (Wave2F);

StartThread (Wave3A);
StartThread (Wave3B);
StartThread (Wave3C);
StartThread (Wave3D);
StartThread (Wave3E);
StartThread (Wave3F);

StartThread (Wave4A);
StartThread (Wave4B);
StartThread (Wave4C);
StartThread (Wave4D);
StartThread (Wave4E);
StartThread (Wave4F);

StartThread (Wave5A);
StartThread (Wave5B);
StartThread (Wave5C);
StartThread (Wave5D);
StartThread (Wave5E);
StartThread (Wave5F);
StartThread (Wave5G);

StartThread (Wave6A);
StartThread (Wave6B);
StartThread (Wave6C);
StartThread (Wave6D);
StartThread (Wave6E);
StartThread (Wave6F);

StartThread (Train);
StartThread (Run1)
StartThread (Run2);
StartThread (Run3);
StartThread(patrol_smb);
StartThread (Service);
StartThread (Victory2);