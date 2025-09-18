x = 0
Obj0 = 0
Obj1 = 0

function Victory ()
        while 1 do 
         Wait (3)
            if Obj0 == 1 and Obj1 == 1 then
             Wait (5)
             Win (0)
             break;
            end;
        end;
    end;
    

function Caput ()
    while 1 do
     Wait (3)
        if (GetNUnitsInScriptGroup (222, 1) > 0) or (GetNUnitsInScriptGroup (333, 1) > 0) then
         Wait (5)
         Win (1)
         break;
        end;
    end;
end;
    

function Bridge1 () 
while 1 do 
     Wait (1)
        if (GetScriptObjectHPs (10) < 40000) then 
         DamageScriptObject (10, -1000);
        end;
    end;
end;

function Bridge2 () 
while 1 do 
     Wait (1)
        if (GetScriptObjectHPs (20) < 40000) then 
         DamageScriptObject (20, -1000);
        end;
    end;
end;

function Bridge3 () 
while 1 do 
     Wait (1)
        if (GetScriptObjectHPs (30) < 40000) then 
         DamageScriptObject (30, -1000);
        end;
    end;
end;

function Bridge4 () 
while 1 do 
     Wait (1)
        if (GetScriptObjectHPs (40) < 40000) then 
         DamageScriptObject (40, -1000);
        end;
    end;
end;

-----------------------------------------------------
function Attack1A ()
     while 1 do 
     Wait (20+Random (60))
     LandReinforcementFromMap (1, "Tanks1", 0, 100);
     Cmd (3, 100, 300, 1975, 6625);
     QCmd (3, 100, 300, 2845, 7368);
     break;
    end;
end;

function Attack1B ()
     while 1 do 
     Wait (20+Random (60))
     LandReinforcementFromMap (1, "Tanks1", 1, 101);
     Cmd (3, 101, 300, 4002, 6038);
     QCmd (3, 101, 300, 3050, 7362);
     break;
    end;
end;

function Attack1C ()
     while 1 do 
     Wait (20+Random (60))
     LandReinforcementFromMap (1, "Tanks1", 2, 102);
     Cmd (3, 102, 300, 5749, 6490);
     break;
    end;
end;

function Attack1D ()
     while 1 do 
     Wait (20+Random (60))
     LandReinforcementFromMap (1, "Tanks1", 3, 103);
     Cmd (3, 103, 300, 7380, 5849);
     QCmd (3, 103, 300, 5826, 7147);
     break;
    end;
end;
-------------------------------------------------------------------
function Attack1AA ()
     while 1 do 
     Wait (40)
     LandReinforcementFromMap (1, "Tanks1", 0, 110);
     Cmd (3, 110, 300, 1975, 6625);
     QCmd (3, 110, 300, 2845, 7368);
     break;
    end;
end;

function Attack1BB ()
     while 1 do 
     Wait (40)
     LandReinforcementFromMap (1, "Tanks1", 1, 111);
     Cmd (3, 111, 300, 4002, 6038);
     QCmd (3, 111, 300, 3050, 7362);
     break;
    end;
end;

function Attack1CC ()
     while 1 do 
     Wait (40)
     LandReinforcementFromMap (1, "Tanks1", 2, 112);
     Cmd (3, 112, 300, 5749, 6490);
     break;
    end;
end;

function Attack1DD ()
     while 1 do 
     Wait (40)
     LandReinforcementFromMap (1, "Tanks1", 3, 113);
     Cmd (3, 113, 300, 7380, 5849);
     QCmd (3, 113, 300, 5826, 7147);
     break;
    end;
end;
-------------------------------------------------------------------
function Attack2A ()
     while 1 do 
     Wait (70+Random (90))
     LandReinforcementFromMap (1, "Tanks2", 0, 200);
     Cmd (3, 200, 300, 1975, 6625);
     QCmd (3, 200, 300, 2845, 7368);
     break;
    end;
end;

function Attack2B ()
     while 1 do 
     Wait (70+Random (90))
     LandReinforcementFromMap (1, "Tanks2", 1, 201);
     Cmd (3, 201, 300, 4002, 6038);
     QCmd (3, 201, 300, 3050, 7362);
     break;
    end;
end;

function Attack2C ()
     while 1 do 
     Wait (70+Random (90))
     LandReinforcementFromMap (1, "Tanks2", 2, 202);
     Cmd (3, 202, 300, 5749, 6490);
     break;
    end;
end;

function Attack2D ()
     while 1 do 
     Wait (70+Random (90))
     LandReinforcementFromMap (1, "Tanks2", 3, 203);
     Cmd (3, 203, 300, 7380, 5849);
     QCmd (3, 203, 300, 5826, 7147);
     break;
    end;
end;
---------------------------------------------------------------
function Attack2AA ()
     while 1 do 
     Wait (105)
     LandReinforcementFromMap (1, "Tanks1", 0, 210);
     Cmd (3, 210, 300, 1975, 6625);
     QCmd (3, 210, 300, 2845, 7368);
     break;
    end;
end;

function Attack2BB ()
     while 1 do 
     Wait (105)
     LandReinforcementFromMap (1, "Tanks1", 1, 211);
     Cmd (3, 211, 300, 4002, 6038);
     QCmd (3, 211, 300, 3050, 7362);
     break;
    end;
end;

function Attack2CC ()
     while 1 do 
     Wait (105)
     LandReinforcementFromMap (1, "Tanks1", 2, 212);
     Cmd (3, 212, 300, 5749, 6490);
     break;
    end;
end;

function Attack2DD ()
     while 1 do 
     Wait (105)
     LandReinforcementFromMap (1, "Tanks1", 3, 213);
     Cmd (3, 213, 300, 7380, 5849);
     QCmd (3, 213, 300, 5826, 7147);
     break;
    end;
end;
----------------------------------------------------------------
function Attack3A ()
     while 1 do 
     Wait (160+Random (90))
     LandReinforcementFromMap (1, "Tanks3", 0, 300);
     Cmd (3, 300, 300, 1975, 6625);
     QCmd (3, 300, 300, 2845, 7368);
     break;
    end;
end;

function Attack3B ()
     while 1 do 
     Wait (160+Random (90))
     LandReinforcementFromMap (1, "Tanks3", 1, 301);
     Cmd (3, 301, 300, 4002, 6038);
     QCmd (3, 301, 300, 3050, 7362);
     break;
    end;
end;

function Attack3C ()
     while 1 do 
     Wait (160+Random (90))
     LandReinforcementFromMap (1, "Tanks3", 2, 302);
     Cmd (3, 302, 300, 5749, 6490);
     break;
    end;
end;

function Attack3D ()
     while 1 do 
     Wait (160+Random (90))
     LandReinforcementFromMap (1, "Tanks3", 3, 303);
     Cmd (3, 303, 300, 7380, 5849);
     QCmd (3, 303, 300, 5826, 7147);
     break;
    end;
end;
-----------------------------------------------------
function Attack3AA ()
     while 1 do 
     Wait (205)
     LandReinforcementFromMap (1, "Tanks1", 0, 310);
     Cmd (3, 310, 300, 1975, 6625);
     QCmd (3, 310, 300, 2845, 7368);
     break;
    end;
end;

function Attack3BB ()
     while 1 do 
     Wait (205)
     LandReinforcementFromMap (1, "Tanks1", 1, 311);
     Cmd (3, 311, 300, 4002, 6038);
     QCmd (3, 311, 300, 3050, 7362);
     break;
    end;
end;

function Attack3CC ()
     while 1 do 
     Wait (205)
     LandReinforcementFromMap (1, "Tanks1", 2, 312);
     Cmd (3, 312, 300, 5749, 6490);
     break;
    end;
end;

function Attack3DD ()
     while 1 do 
     Wait (205)
     LandReinforcementFromMap (1, "Tanks1", 3, 313);
     Cmd (3, 313, 300, 7380, 5849);
     QCmd (3, 313, 300, 5826, 7147);
     break;
    end;
end;
------------------------------------------------------
function Attack4A ()
     while 1 do 
     Wait (250+Random (90))
     LandReinforcementFromMap (1, "Tanks3", 0, 400);
     Cmd (3, 400, 300, 1975, 6625);
     QCmd (3, 400, 300, 2845, 7368);
     break;
    end;
end;

function Attack4B ()
     while 1 do 
     Wait (250+Random (90))
     LandReinforcementFromMap (1, "Tanks3", 1, 401);
     Cmd (3, 401, 300, 4002, 6038);
     QCmd (3, 401, 300, 3050, 7362);
     break;
    end;
end;

function Attack4C ()
     while 1 do 
     Wait (250+Random (90))
     LandReinforcementFromMap (1, "Tanks3", 2, 402);
     Cmd (3, 402, 300, 5749, 6490);
     break;
    end;
end;

function Attack4D ()
     while 1 do 
     Wait (250+Random (90))
     LandReinforcementFromMap (1, "Tanks3", 3, 403);
     Cmd (3, 403, 300, 7380, 5849);
     QCmd (3, 403, 300, 5826, 7147);
     break;
    end;
end;
-----------------------------------------------------------
function Attack4AA ()
     while 1 do 
     Wait (295)
     LandReinforcementFromMap (1, "Tanks1", 0, 410);
     Cmd (3, 410, 300, 1975, 6625);
     QCmd (3, 410, 300, 2845, 7368);
     break;
    end;
end;

function Attack4BB ()
     while 1 do 
     Wait (295)
     LandReinforcementFromMap (1, "Tanks1", 1, 411);
     Cmd (3, 411, 300, 4002, 6038);
     QCmd (3, 411, 300, 3050, 7362);
     break;
    end;
end;

function Attack4CC ()
     while 1 do 
     Wait (295)
     LandReinforcementFromMap (1, "Tanks1", 2, 412);
     Cmd (3, 412, 300, 5749, 6490);
     break;
    end;
end;

function Attack4DD ()
     while 1 do 
     Wait (295)
     LandReinforcementFromMap (1, "Tanks1", 3, 413);
     Cmd (3, 413, 300, 7380, 5849);
     QCmd (3, 413, 300, 5826, 7147);
     break;
    end;
end;
------------------------------------------------------------
function Attack5A ()
     while 1 do 
     Wait (340+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 0, 500);
     Cmd (3, 500, 300, 1975, 6625);
     QCmd (3, 500, 300, 2845, 7368);
     break;
    end;
end;

function Attack5B ()
     while 1 do 
     Wait (340+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 1, 501);
     Cmd (3, 501, 300, 4002, 6038);
     QCmd (3, 501, 300, 3050, 7362);
     break;
    end;
end;

function Attack5C ()
     while 1 do 
     Wait (340+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 2, 502);
     Cmd (3, 502, 300, 5749, 6490);
     break;
    end;
end;

function Attack5D ()
     while 1 do 
     Wait (340+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 3, 503);
     Cmd (3, 503, 300, 7380, 5849);
     QCmd (3, 503, 300, 5826, 7147);
     break;
    end;
end;
--------------------------------------------------
function Attack5AA ()
     while 1 do 
     Wait (385)
     LandReinforcementFromMap (1, "Tanks1", 0, 510);
     Cmd (3, 510, 300, 1975, 6625);
     QCmd (3, 510, 300, 2845, 7368);
     break;
    end;
end;

function Attack5BB ()
     while 1 do 
     Wait (385)
     LandReinforcementFromMap (1, "Tanks1", 1, 511);
     Cmd (3, 511, 300, 4002, 6038);
     QCmd (3, 511, 300, 3050, 7362);
     break;
    end;
end;

function Attack5CC ()
     while 1 do 
     Wait (385)
     LandReinforcementFromMap (1, "Tanks1", 2, 512);
     Cmd (3, 512, 300, 5749, 6490);
     break;
    end;
end;

function Attack5DD ()
     while 1 do 
     Wait (385)
     LandReinforcementFromMap (1, "Tanks1", 3, 513);
     Cmd (3, 513, 300, 7380, 5849);
     QCmd (3, 513, 300, 5826, 7147);
     break;
    end;
end;
---------------------------------------------------------------
function Attack6A ()
     while 1 do 
     Wait (430+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 0, 600);
     Cmd (3, 600, 300, 1975, 6625);
     QCmd (3, 600, 300, 2845, 7368);
     break;
    end;
end;

function Attack6B ()
     while 1 do 
     Wait (430+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 1, 601);
     Cmd (3, 601, 300, 4002, 6038);
     QCmd (3, 601, 300, 3050, 7362);
     break;
    end;
end;

function Attack6C ()
     while 1 do 
     Wait (430+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 2, 602);
     Cmd (3, 602, 300, 5749, 6490);
     break;
    end;
end;

function Attack6D ()
     while 1 do 
     Wait (430+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 3, 603);
     Cmd (3, 603, 300, 7380, 5849);
     QCmd (3, 603, 300, 5826, 7147);
     break;
    end;
end;
----------------------------------------------------
function Attack6AA ()
     while 1 do 
     Wait (475)
     LandReinforcementFromMap (1, "Tanks1", 0, 610);
     Cmd (3, 610, 300, 1975, 6625);
     QCmd (3, 610, 300, 2845, 7368);
     break;
    end;
end;

function Attack6BB ()
     while 1 do 
     Wait (475)
     LandReinforcementFromMap (1, "Tanks1", 1, 611);
     Cmd (3, 611, 300, 4002, 6038);
     QCmd (3, 611, 300, 3050, 7362);
     break;
    end;
end;

function Attack6CC ()
     while 1 do 
     Wait (475)
     LandReinforcementFromMap (1, "Tanks1", 2, 612);
     Cmd (3, 612, 300, 5749, 6490);
     break;
    end;
end;

function Attack6DD ()
     while 1 do 
     Wait (475)
     LandReinforcementFromMap (1, "Tanks1", 3, 613);
     Cmd (3, 613, 300, 7380, 5849);
     QCmd (3, 613, 300, 5826, 7147);
     break;
    end;
end;
----------------------------------------------------------------
function Attack7A ()
     while 1 do 
     Wait (520+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 0, 700);
     Cmd (3, 700, 300, 1975, 6625);
     QCmd (3, 700, 300, 2845, 7368);
     break;
    end;
end;

function Attack7B ()
     while 1 do 
     Wait (520+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 1, 701);
     Cmd (3, 701, 300, 4002, 6038);
     QCmd (3, 701, 300, 3050, 7362);
     break;
    end;
end;

function Attack7C ()
     while 1 do 
     Wait (520+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 2, 702);
     Cmd (3, 702, 300, 5749, 6490);
     break;
    end;
end;

function Attack7D ()
     while 1 do 
     Wait (520+Random (90))
     LandReinforcementFromMap (1, "Tanks4", 3, 703);
     Cmd (3, 703, 300, 7380, 5849);
     QCmd (3, 703, 300, 5826, 7147);
     break;
    end;
end;
----------------------------------------------------
function Attack7AA ()
     while 1 do 
     Wait (565)
     LandReinforcementFromMap (1, "Tanks1", 0, 710);
     Cmd (3, 710, 300, 1975, 6625);
     QCmd (3, 710, 300, 2845, 7368);
     break;
    end;
end;

function Attack7BB ()
     while 1 do 
     Wait (565)
     LandReinforcementFromMap (1, "Tanks1", 1, 711);
     Cmd (3, 711, 300, 4002, 6038);
     QCmd (3, 711, 300, 3050, 7362);
     break;
    end;
end;

function Attack7CC ()
     while 1 do 
     Wait (565)
     LandReinforcementFromMap (1, "Tanks1", 2, 712);
     Cmd (3, 712, 300, 5749, 6490);
     break;
    end;
end;

function Attack7DD ()
     while 1 do 
     Wait (565)
     LandReinforcementFromMap (1, "Tanks1", 3, 713);
     Cmd (3, 713, 300, 7380, 5849);
     QCmd (3, 713, 300, 5826, 7147);
     break;
    end;
end;
------------------------------------------------
function Attack8A ()
     while 1 do 
     Wait (610+Random (60))
     LandReinforcementFromMap (1, "Tanks4", 0, 800);
     Cmd (3, 800, 300, 1975, 6625);
     QCmd (3, 800, 300, 2845, 7368);
     break;
    end;
end;

function Attack8B ()
     while 1 do 
     Wait (610+Random (60))
     LandReinforcementFromMap (1, "Tanks4", 1, 801);
     Cmd (3, 801, 300, 4002, 6038);
     QCmd (3, 801, 300, 3050, 7362);
     break;
    end;
end;

function Attack8C ()
     while 1 do 
     Wait (610+Random (60))
     LandReinforcementFromMap (1, "Tanks4", 2, 802);
     Cmd (3, 802, 300, 5749, 6490);
     break;
    end;
end;

function Attack8D ()
     while 1 do 
     Wait (610+Random (60))
     LandReinforcementFromMap (1, "Tanks4", 3, 803);
     Cmd (3, 803, 300, 7380, 5849);
     QCmd (3, 803, 300, 5826, 7147);
     break;
    end;
end;
-----------------------------------------------
function Attack9A ()
     while 1 do 
     Wait (650)
     LandReinforcementFromMap (1, "Tanks5", 0, 900);
     Cmd (3, 900, 300, 1975, 6625);
     QCmd (3, 900, 300, 2845, 7368);
     x=1
     break;
    end;
end;

function Attack9B ()
     while 1 do 
     Wait (650)
     LandReinforcementFromMap (1, "Tanks5", 1, 901);
     Cmd (3, 901, 300, 4002, 6038);
     QCmd (3, 901, 300, 3050, 7362);
     x=1
     break;
    end;
end;

function Attack9C ()
     while 1 do 
     Wait (650)
     LandReinforcementFromMap (1, "Tanks5", 2, 902);
     Cmd (3, 902, 300, 5749, 6490);
     x=1
     break;
    end;
end;

function Attack9D ()
     while 1 do 
     Wait (650)
     LandReinforcementFromMap (1, "Tanks5", 3, 903);
     Cmd (3, 903, 300, 7380, 5849);
     QCmd (3, 903, 300, 5826, 7147);
     x=1
     SetIGlobalVar( "temp.general_reinforcement", 0 );
     StartThread (Check1);
     break;
    end;
end;
------------------------------------------------
function SPG0 ()
   while 1 do 
     Wait (600)
     LandReinforcementFromMap (1, "SPG", 0, 880)
     Cmd (0, 880, 100, 1478, 2623);
     QCmd (ACT_SUPPRESS, 880, 200, 1986, 2623);
     Wait (100)
     QCmd (ACT_STOP, 880)
     QCmd (0, 880, 100, 1150, 71)
     QCmd (ACT_DISAPPEAR, 880);
     break;
    end;
end;

function SPG1 ()
   while 1 do 
     Wait (600)
     LandReinforcementFromMap (1, "SPG", 1, 881)
     Cmd (0, 881, 100, 2803, 2851);
     QCmd (ACT_SUPPRESS, 881, 200, 3610, 5144);
     Wait (100)
     Cmd (0, 881, 100, 3038, 123)
     QCmd (ACT_DISAPPEAR, 881);
     break;
    end;
end;

function SPG2 ()
   while 1 do 
     Wait (601)
     LandReinforcementFromMap (1, "SPG", 2, 882)
     Cmd (0, 882, 100, 5359, 2814);
     QCmd (ACT_SUPPRESS, 882, 200, 5496, 4966);
     Wait (100)
     Cmd (0, 882, 100, 4723, 73)
     QCmd (ACT_DISAPPEAR, 882);
     break;
    end;
end;

function SPG3 ()
   while 1 do 
     Wait (602)
     LandReinforcementFromMap (1, "SPG", 0, 883)
     Cmd (0, 883, 100, 6790, 3078);
     QCmd (ACT_SUPPRESS, 883, 200, 7329, 5619);
     Wait (100)
     Cmd (0, 883, 100, 6821, 256)
     QCmd (ACT_DISAPPEAR, 883);
     break;
    end;
end;

function GAP ()
    while 1 do
      Wait (300)
      LandReinforcementFromMap (1, "GAP", 0, 911);
      Cmd (3, 911, 200, 4839, 5219);
      break;
    end;
end; 

function Step2 ()
      while 1 do
      Wait (3)
      if (x == 1 and (GetNUnitsInScriptGroup (900, 1) < 1) and (GetNUnitsInScriptGroup (901, 1) < 1) and
	  (GetNUnitsInScriptGroup (902, 1) < 1) and (GetNUnitsInScriptGroup (903, 1) < 1)  and 
	  (GetNUnitsInScriptGroup (222, 0) > 0) and (GetNUnitsInScriptGroup (333, 0) > 0)) or ((GetNUnitsInScriptGroup (1001, 0) > 0)
	  and (GetNUnitsInScriptGroup (1002, 0) > 0) and (GetNUnitsInScriptGroup (1003, 0) > 0) and (GetNUnitsInScriptGroup (1004, 0) > 0)) then
	     Wait (3)
	     CompleteObjective(0)
	     Obj0 = 1
	     Wait (5)
	     GiveObjective (1)
         ChangePlayerForScriptGroup (888, 1);
         Wait (1)
         units = GetObjectListArray( 444 );
         for u = 1, units.n do
         SetAmmo( units[u], 40, 40 );
         end;
         Wait (1)
         units = GetObjectListArray( 445 );
         for u = 1, units.n do
         SetAmmo( units[u], 40, 40 );
         end;
         Wait (1)
         units = GetObjectListArray( 446 );
         for u = 1, units.n do
         SetAmmo( units[u], 40, 40 );
         end;
         Wait (5)
         StartThread (Artillery1);
         Wait (1)
         StartThread (Artillery2);
         Wait (1)
         StartThread (Artillery3);
         Wait (1)
         StartThread (Artillery);
         Wait (5)
         LandReinforcementFromMap (0, "Recon", 0, 911);
         Cmd (0, 911, 100, 4636, 5376);
	     break;
	    end;
	end;
end;

function Artillery ()
    while 1 do
     Wait (3)
        if (GetNUnitsInScriptGroup (444, 1) < 1) and (GetNUnitsInScriptGroup (445, 1) < 1) and (GetNUnitsInScriptGroup (446, 1) < 1) then 
         Wait (3)
         CompleteObjective (1)
         Obj1 = 1
         break;
        end;
    end;
end;

function Artillery1 ()
    while 1 do 
     Wait (5)
     Cmd (ACT_SUPPRESS, 444, 1000, 1166, 6113)
     Wait (15);
     Cmd (ACT_SUPPRESS, 444, 1000, 2651, 7336)
     Wait (10)
    end;
end;

function Artillery2 ()
    while 1 do 
     Wait (5)
     Cmd (ACT_SUPPRESS, 445, 1000, 5979, 6532)
     Wait (15);
     Cmd (ACT_SUPPRESS, 445, 1000, 3506, 6417)
     Wait (10)
    end;
end;

function Artillery3 ()
    while 1 do 
     Wait (5)
     Cmd (ACT_SUPPRESS, 446, 1000, 3386, 6327)
     Wait (15);
     Cmd (ACT_SUPPRESS, 446, 1000, 6994, 6105)
     Wait (10)
    end;
end;
------------------------------------
function Check1 ()
    while 1 do 
      Wait (180)
      if (GetNUnitsInArea (1, "B1", 0) > 2) or ((GetNUnitsInArea (1, "B2", 0) > 2)) or
      (GetNUnitsInArea (1, "B3", 0) > 2) or (GetNUnitsInArea (1, "B4", 0) > 2) then 
         Wait (1)
         Cmd (0, 800, 100, 1150, 71);
         QCmd (ACT_DISAPPEAR, 800);
         Cmd (0, 900, 100, 1150, 71);
         QCmd (ACT_DISAPPEAR, 900);
         Cmd (0, 801, 100, 3038, 123);
         QCmd (ACT_DISAPPEAR, 801);
         Cmd (0, 901, 100, 3038, 123);
         QCmd (ACT_DISAPPEAR, 901);
         Cmd (0, 802, 100, 4723, 73);
         QCmd (ACT_DISAPPEAR, 802);
         Cmd (0, 902, 100, 4723, 73);
         QCmd (ACT_DISAPPEAR, 902);
         Cmd (0, 803, 100, 6821, 256);
         QCmd (ACT_DISAPPEAR, 803);
         Cmd (0, 903, 100, 6821, 256);
         QCmd (ACT_DISAPPEAR, 903);
         break;
        end;
    end;
end;
--------------------------------
function Dig ()
    while 1 do 
     Wait (1)
     Cmd (ACT_ENTRENCH, 555, 0);
     break;
    end;
end;

--------------------------------------------------
GiveObjective(0);
SetIGlobalVar( "temp.general_reinforcement", 0 );

units = GetObjectListArray( 444 );
for u = 1, units.n do
SetAmmo( units[u], 0, 0 );
end;

units = GetObjectListArray( 445 );
for u = 1, units.n do
SetAmmo( units[u], 0, 0 );
end;

units = GetObjectListArray( 446 );
for u = 1, units.n do
SetAmmo( units[u], 0, 0 );
end;

StartThread (Victory);
StartThread (Caput);
--StartThread (Bridge1);
--StartThread (Bridge2);
--StartThread (Bridge3);
--StartThread (Bridge4);
StartThread (Attack1A);
StartThread (Attack1B);
StartThread (Attack1C);
StartThread (Attack1D);
StartThread (Attack2A);
StartThread (Attack2B);
StartThread (Attack2C);
StartThread (Attack2D);
StartThread (Attack3A);
StartThread (Attack3B);
StartThread (Attack3C);
StartThread (Attack3D);
StartThread (Attack4A);
StartThread (Attack4B);
StartThread (Attack4C);
StartThread (Attack4D);
StartThread (Attack5A);
StartThread (Attack5B);
StartThread (Attack5C);
StartThread (Attack5D);
StartThread (Attack6A);
StartThread (Attack6B);
StartThread (Attack6C);
StartThread (Attack6D);
StartThread (Attack7A);
StartThread (Attack7B);
StartThread (Attack7C);
StartThread (Attack7D);
StartThread (Attack8A);
StartThread (Attack8B);
StartThread (Attack8C);
StartThread (Attack8D);
StartThread (Attack9A);
StartThread (Attack9B);
StartThread (Attack9C);
StartThread (Attack9D);
StartThread (Attack1AA);
StartThread (Attack1BB);
StartThread (Attack1CC);
StartThread (Attack1DD);
StartThread (Attack2AA);
StartThread (Attack2BB);
StartThread (Attack2CC);
StartThread (Attack2DD);
StartThread (Attack3AA);
StartThread (Attack3BB);
StartThread (Attack3CC);
StartThread (Attack3DD);
StartThread (Attack4AA);
StartThread (Attack4BB);
StartThread (Attack4CC);
StartThread (Attack4DD);
StartThread (Attack5AA);
StartThread (Attack5BB);
StartThread (Attack5CC);
StartThread (Attack5DD);
StartThread (Attack6AA);
StartThread (Attack6BB);
StartThread (Attack6CC);
StartThread (Attack6DD);
--StartThread (Attack7AA);
--StartThread (Attack7BB);
--StartThread (Attack7CC);
--StartThread (Attack7DD);
StartThread (SPG0);
StartThread (SPG1);
StartThread (SPG2);
StartThread (SPG3);
StartThread (GAP);
StartThread (Step2);
StartThread (Dig);