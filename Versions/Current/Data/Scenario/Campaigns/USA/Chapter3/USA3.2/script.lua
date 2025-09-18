x=0
y=0
Objective1=0
Objective2=0
w=0
R=0

function Artillery ()
    while 1 do 
      Wait (2)
        if (GetNUnitsInScriptGroup (556, 1) < 1) then
          Wait (1)
          CompleteObjective(0) 
          y = 1
          Wait (3)
          GiveObjective(1)
          GiveObjective(2)
          Wait (1)
          StartThread (Wave1);
          StartThread (Landing1A);
          StartThread (Landing1B);
          StartThread (Wave2);
          StartThread (Landing2A);
          StartThread (Landing2B);
          StartThread (Wave3);
          StartThread (Landing3A);
          StartThread (Landing3B);
          StartThread (Wave4);
          StartThread (Landing4A);
          StartThread (Landing4B);
          StartThread (Wave5);
          StartThread (Landing5A);
          StartThread (Landing5B);
          break;
        end;
    end;
end;

function Objective1 ()
    while 1 do
      Wait (3)
        if (GetNUnitsInScriptGroup (777, 1) <1)   then
         Wait (2)
         CompleteObjective(1)
         Objective1=1
         Wait (5)
         Cmd (3, 502, 300, 7076, 3819);
         Cmd (3, 503, 300, 7076, 3819);
         break;
        end;
    end;
end;

function Objective2 ()
    while 1 do
      Wait (3)
        if (GetNUnitsInScriptGroup (888, 1) <1) and GetNUnitsInArea (1, "Village2", 0) == 0    then
         Wait (2)
         CompleteObjective(2)
         Objective2 = 1
         Wait (5)
         Cmd (3, 504, 300, 5952, 6945);
         break;
        end;
    end;
end;

function Victory ()
    
while 1 do
      Wait (2)
        if Objective1 == 1 and Objective2 == 1   then
         Wait (3) 
         Win (0)
         break;
        end;
    end;
end;

function Caput1 ()
    while 1 do
      Wait (3)
        if (x==1 and (GetNUnitsInPlayerUF (0) <1) and (IsReinforcementAvailable (0) == 0) and (GetNUnitsInScriptGroup (777, 1) > 0) and (GetNUnitsInScriptGroup (888, 1) > 0))  or 
		(x==1 and (GetNUnitsInPlayerUF (0) <1) and (GetNUnitsInScriptGroup (777, 1) > 0)) or
	    (x==1 and (GetNUnitsInPlayerUF (0) <1) and (GetNUnitsInScriptGroup (888, 1) > 0))then
          Wait (3)
          Win (1);
          break;
        end;
    end;
end;

function Caput2 ()
    while 1 do
      Wait (5)
        if  y == 0 and (GetNUnitsInPlayerUF (0) < 2) and (IsReinforcementAvailable(0) ==0)  then
          Wait (3)
          Win (1);
          break;
        end;
    end;
end;
--------------------------------------------------------------------------------------------------------------------
function Wave1 ()
   
    while 1 do 
     Wait (3)
        if w==0 and (GetNUnitsInScriptGroup (102) < 1) and (GetNUnitsInScriptGroup (103) < 1) and
	(GetNUnitsInScriptGroup (104) < 1) and (GetNUnitsInScriptGroup (105) < 1) and (GetNUnitsInScriptGroup (106) < 1) and 
	(GetNUnitsInScriptGroup (107) < 1) then
         Wait (1)
         LandReinforcementFromMap (2, "Boat", 0, 100)
         Cmd (0, 100, 50, 2845, 4694);
         QCmd (0, 100, 50, 163, 3832);
         QCmd (ACT_DISAPPEAR, 100)
         Wait (30)
         LandReinforcementFromMap (2, "Boat", 1, 101)
         Cmd (0, 101, 50, 4038, 2029);
         QCmd (0, 101, 50, 221, 1324);
         QCmd (ACT_DISAPPEAR, 101)
         break;
        end;
    end;
end;

function Landing1A ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (100, "A", 0)> 0 ) then 
         Wait (1)
         LandReinforcementFromMap (2, "Wave4_Inf", 2, 102);
         LandReinforcementFromMap (2, "Wave4_Inf", 3, 103);
         LandReinforcementFromMap (2, "Wave4_Light", 5, 104);
         LandReinforcementFromMap (2, "Wave4_Light", 6, 105);
         LandReinforcementFromMap (2, "Wave4_Med", 7, 106);
         LandReinforcementFromMap (2, "Wave4_Med", 8, 107);
         ChangePlayerForScriptGroup (102, 0);
         ChangePlayerForScriptGroup (103, 0);
         ChangePlayerForScriptGroup (104, 0);
         ChangePlayerForScriptGroup (105, 0);
         ChangePlayerForScriptGroup (106, 0);
         ChangePlayerForScriptGroup (107, 0);
         ChangeFormation (102, 3);
         ChangeFormation (103, 3);
         ChangeFormation (104, 3);
         ChangeFormation (105, 3);
         ChangeFormation (106, 3);
         ChangeFormation (107, 3);
         Cmd (ACT_STAND, 102)
         Cmd (ACT_STAND, 103)
         Cmd (ACT_STAND, 104)
         Cmd (ACT_STAND, 105)
         Cmd (ACT_STAND, 106)
         Cmd (ACT_STAND, 107)
         w=w+1
         break;
        end;
    end;
end;


function Landing1B ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (101, "B", 0) > 0 ) then 
        Wait (1)
         LandReinforcementFromMap (2, "Wave3", 4, 114);
         ChangeFormation (114, 3);
         Cmd (3, 114, 200, 5254, 2993);
         QCmd (3, 114, 400, 7076, 3819);
         break;
        end;
    end;
end;  
---------------------------------------------------------
function Wave2 ()
   
    while 1 do 
     Wait (3)
       if w==1 and (GetNUnitsInScriptGroup (102) < 1) and  (GetNUnitsInScriptGroup (103) < 1) and
	(GetNUnitsInScriptGroup (104) < 1) and (GetNUnitsInScriptGroup (105) < 1) and (GetNUnitsInScriptGroup (106) < 1) and 
	(GetNUnitsInScriptGroup (107) < 1) then
         LandReinforcementFromMap (2, "Boat", 0, 200)
         Cmd (0, 200, 50, 2845, 4694);
         QCmd (0, 200, 50, 163, 3832);
         QCmd (ACT_DISAPPEAR, 200)
         Wait (30)
         LandReinforcementFromMap (2, "Boat", 1, 201)
         Cmd (0, 201, 50, 4038, 2029);
         QCmd (0, 201, 50, 221, 1324);
         QCmd (ACT_DISAPPEAR, 201)
         break;
        end;
    end;
end;

function Landing2A ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (200, "A", 0)> 0 ) then 
         Wait (1)
         LandReinforcementFromMap (2, "Wave5_Inf", 2, 202);
         LandReinforcementFromMap (2, "Wave5_Inf", 3, 203);
         LandReinforcementFromMap (2, "Wave5_Light", 5, 204);
         LandReinforcementFromMap (2, "Wave5_Light", 6, 205);
         LandReinforcementFromMap (2, "Wave5_Med", 7, 206);
         LandReinforcementFromMap (2, "Wave5_Med", 8, 207);
         ChangePlayerForScriptGroup (202, 0);
         ChangePlayerForScriptGroup (203, 0);
         ChangePlayerForScriptGroup (204, 0);
         ChangePlayerForScriptGroup (205, 0);
         ChangePlayerForScriptGroup (206, 0);
         ChangePlayerForScriptGroup (207, 0);
         ChangeFormation (202, 3);
         ChangeFormation (203, 3);
         ChangeFormation (204, 3);
         ChangeFormation (205, 3);
         ChangeFormation (206, 3);
         ChangeFormation (207, 3);
         Cmd (ACT_STAND, 202)
         Cmd (ACT_STAND, 203)
         Cmd (ACT_STAND, 204)
         Cmd (ACT_STAND, 205)
         Cmd (ACT_STAND, 206)
         Cmd (ACT_STAND, 207)
         w=w+1
         break;
        end;
    end;
end;


function Landing2B ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (201, "B", 0)> 0 ) then 
        Wait (1)
         LandReinforcementFromMap (2, "Wave4", 4, 214);
         ChangeFormation (214, 3);
         Cmd (3, 214, 200, 5254, 2993);
         QCmd (3, 214, 400, 7076, 3819);
         break;
        end;
    end;
end;
----------------------------------------------------------------
function Wave3 ()
   
    while 1 do 
     Wait (3)
        if w==2 and (GetNUnitsInScriptGroup (202) < 1) and (GetNUnitsInScriptGroup (203) < 1) and
	(GetNUnitsInScriptGroup (204) < 1) and (GetNUnitsInScriptGroup (205) < 1) and (GetNUnitsInScriptGroup (206) < 1) and 
	(GetNUnitsInScriptGroup (207) < 1) then
          Wait (1)
          LandReinforcementFromMap (2, "Boat", 0, 300)
          Cmd (0, 300, 50, 2845, 4694);
          QCmd (0, 300, 50, 163, 3832);
          QCmd (ACT_DISAPPEAR, 300)
          Wait (30)
          LandReinforcementFromMap (2, "Boat", 1, 301)
          Cmd (0, 301, 50, 4038, 2029);
          QCmd (0, 301, 50, 221, 1324);
          QCmd (ACT_DISAPPEAR, 301)
          break;
        end;
    end;
end;

function Landing3A ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (300, "A", 0)> 0 ) then 
         Wait (1)
         LandReinforcementFromMap (2, "Wave6_Inf", 2, 302);
         LandReinforcementFromMap (2, "Wave6_Inf", 3, 303);
         LandReinforcementFromMap (2, "Wave6_Light", 5, 304);
         LandReinforcementFromMap (2, "Wave6_Light", 6, 305);
         LandReinforcementFromMap (2, "Wave6_Med", 7, 306);
         LandReinforcementFromMap (2, "Wave6_Med", 8, 307);
         ChangePlayerForScriptGroup (302, 0);
         ChangePlayerForScriptGroup (303, 0);
         ChangePlayerForScriptGroup (304, 0);
         ChangePlayerForScriptGroup (305, 0);
         ChangePlayerForScriptGroup (306, 0);
         ChangePlayerForScriptGroup (307, 0);
         ChangeFormation (302, 3);
         ChangeFormation (303, 3);
         ChangeFormation (304, 3);
         ChangeFormation (305, 3);
         ChangeFormation (306, 3);
         ChangeFormation (307, 3);
         Cmd (ACT_STAND, 302)
         Cmd (ACT_STAND, 303)
         Cmd (ACT_STAND, 304)
         Cmd (ACT_STAND, 305)
         Cmd (ACT_STAND, 306)
         Cmd (ACT_STAND, 307)
         w=w+1
         break;
        end;
    end;
end;


function Landing3B ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (301, "B", 0)> 0 ) then 
        Wait (1)
         LandReinforcementFromMap (2, "Wave5", 4, 314);
         ChangeFormation (314, 3);
         Cmd (3, 314, 200, 5254, 2993);
         QCmd (3, 314, 400, 7076, 3819);
         break;
        end;
    end;
end;
----------------------------------------------------------------
function Wave4 ()
   
    while 1 do 
     Wait (3)
        if w==3 and (GetNUnitsInScriptGroup (302) < 1) and (GetNUnitsInScriptGroup (303) < 1) and
	(GetNUnitsInScriptGroup (304) < 1) and (GetNUnitsInScriptGroup (305) < 1) and (GetNUnitsInScriptGroup (306) < 1) and 
	(GetNUnitsInScriptGroup (307) < 1) then
        Wait (1)
         LandReinforcementFromMap (2, "Boat", 0, 400)
         Cmd (0, 400, 50, 2845, 4694);
         QCmd (0, 400, 50, 163, 3832);
         QCmd (ACT_DISAPPEAR, 400)
         Wait (30)
         LandReinforcementFromMap (2, "Boat", 1, 401)
         Cmd (0, 401, 50, 4038, 2029);
         QCmd (0, 401, 50, 221, 1324);
         QCmd (ACT_DISAPPEAR, 401)
         break;
        end;
    end;
end;

function Landing4A ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (400, "A", 0)> 0 ) then 
         Wait (1)
         LandReinforcementFromMap (2, "Wave5_Inf", 2, 402);
         LandReinforcementFromMap (2, "Wave5_Inf", 3, 403);
         LandReinforcementFromMap (2, "Wave5_Light", 5, 404);
         LandReinforcementFromMap (2, "Wave5_Light", 6, 405);
         LandReinforcementFromMap (2, "Wave5_Med", 7, 406);
         LandReinforcementFromMap (2, "Wave5_Med", 8, 407);
         ChangePlayerForScriptGroup (402, 0);
         ChangePlayerForScriptGroup (403, 0);
         ChangePlayerForScriptGroup (404, 0);
         ChangePlayerForScriptGroup (405, 0);
         ChangePlayerForScriptGroup (406, 0);
         ChangePlayerForScriptGroup (407, 0);
         ChangeFormation (402, 3);
         ChangeFormation (403, 3);
         ChangeFormation (404, 3);
         ChangeFormation (405, 3);
         ChangeFormation (406, 3);
         ChangeFormation (407, 3);
         Cmd (ACT_STAND, 402)
         Cmd (ACT_STAND, 403)
         Cmd (ACT_STAND, 404)
         Cmd (ACT_STAND, 405)
         Cmd (ACT_STAND, 406)
         Cmd (ACT_STAND, 407)
         w=w+1
         break;  
        end;
    end;
end;


function Landing4B ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (401, "B", 0)> 0 ) then 
        Wait (1)
         LandReinforcementFromMap (2, "Wave4", 4, 414);
         ChangeFormation (414, 3);
         Cmd (3, 414, 200, 5254, 2993);
         QCmd (3, 414, 400, 7076, 3819);
         break;
        end;
    end;
end;
--------------------------------------------------------------------
function Wave5 ()
   
    while 1 do 
     Wait (3)
        if w==4 and (GetNUnitsInScriptGroup (402) < 1) and (GetNUnitsInScriptGroup (403) < 1) and
	(GetNUnitsInScriptGroup (404) < 1) and (GetNUnitsInScriptGroup (405) < 1) and (GetNUnitsInScriptGroup (406) < 1) and 
	(GetNUnitsInScriptGroup (407) < 1) then
         Wait (1)
         LandReinforcementFromMap (2, "Boat", 0, 500)
         Cmd (0, 500, 50, 2845, 4694);
         QCmd (0, 500, 50, 163, 3832);
         QCmd (ACT_DISAPPEAR, 500)
         Wait (5)
         LandReinforcementFromMap (2, "Boat", 1, 501)
         Cmd (0, 501, 50, 4038, 2029);
         QCmd (0, 501, 50, 221, 1324);
         QCmd (ACT_DISAPPEAR, 501)
         x=1
         break;
        end;
    end;
end;

function Landing5A ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (500, "A", 0)> 0 ) then 
         Wait (1)
         LandReinforcementFromMap (2, "Wave4_Inf", 2, 502);
         LandReinforcementFromMap (2, "Wave4_Inf", 3, 503);
         LandReinforcementFromMap (2, "Wave4_Light", 5, 504);
         LandReinforcementFromMap (2, "Wave4_Light", 6, 505);
         LandReinforcementFromMap (2, "Wave4_Med", 7, 506);
         LandReinforcementFromMap (2, "Wave4_Med", 8, 507);
         ChangePlayerForScriptGroup (502, 0);
         ChangePlayerForScriptGroup (503, 0);
         ChangePlayerForScriptGroup (504, 0);
         ChangePlayerForScriptGroup (505, 0);
         ChangePlayerForScriptGroup (506, 0);
         ChangePlayerForScriptGroup (507, 0);
         ChangeFormation (502, 3);
         ChangeFormation (503, 3);
         ChangeFormation (504, 3);
         ChangeFormation (505, 3);
         ChangeFormation (506, 3);
         ChangeFormation (507, 3);
         Cmd (ACT_STAND, 502)
         Cmd (ACT_STAND, 503)
         Cmd (ACT_STAND, 504)
         Cmd (ACT_STAND, 505)
         Cmd (ACT_STAND, 506)
         Cmd (ACT_STAND, 507)
         w=w+1
         break;  
        end;
    end;
end;


function Landing5B ()

   while 1 do
     Wait (1)
        if (GetNScriptUnitsInArea (501, "B", 0)> 0 ) then 
        Wait (1)
         LandReinforcementFromMap (2, "Wave3", 4, 514);
         ChangeFormation (514, 3);
         Cmd (3, 514, 200, 5254, 2993);
         QCmd (3, 514, 400, 7076, 3819);
         break;
        end;
    end;
end;
----------------------------------------------------------------
function Tanks1 ()

   while 1 do
     Wait (3)
        if (GetNUnitsInArea (2, "Village1",0) > 0) or (GetNUnitsInArea (0, "Village1", 0) > 0) then
         Cmd (3, 123, 100, 3359, 7357);
         QCmd (3, 123, 200, 4203, 6262);
         break;
        end;
    end;
end;

function Tanks2 ()

   while 1 do
     Wait (3)
        if (GetNUnitsInArea (2, "Village2", 0) > 0) or (GetNUnitsInArea (0, "Village2", 0) > 0) then
         Cmd (3, 234, 200, 6977, 3484);
         break;
        end;
    end;
end;

function Tanks22 ()
   while 1 do
     Wait (1)
     Cmd (ACT_STAND, 234);
     break;
    end;
end;

function Dig ()
   while 1 do 
     Wait (1)
     Cmd (ACT_ENTRENCH, 1000, 1);
     break;
    end;
end;

function Recon1 ()
    while 1 do
     Wait (1)
        if (GetNUnitsInScriptGroup (911, 0) < 1) and R==0 then
         Wait (3)
         LandReinforcementFromMap (0, "Recon", 3, 911);
         Cmd (0, 911, 100, 1760, 2203)
         --Cmd (0, 911, 100, 2248, 7123);
         --QCmd (0, 911, 100, 4027, 5477);
         --QCmd (0, 911, 100, 5161, 3052);
         --QCmd (0, 911, 100, 6714, 1942);
         --QCmd (0, 911, 100, 2248, 7123);
         --QCmd (0, 911, 100, 4027, 5477);
         --QCmd (0, 911, 100, 5161, 3052);
         --QCmd (0, 911, 100, 6714, 1942);
         --QCmd (0, 911, 100, 2248, 7123);
         --QCmd (0, 911, 100, 4027, 5477);
         --QCmd (0, 911, 100, 5161, 3052);
         --QCmd (0, 911, 100, 6714, 1942);
         --QCmd (0, 911, 100, 2248, 7123);
         --QCmd (0, 911, 100, 4027, 5477);
         --QCmd (0, 911, 100, 5161, 3052);
         --QCmd (0, 911, 100, 6714, 1942);
        end;
    end;
end;

function Recon2 ()
    while 1 do
     Wait (1)
        if (GetNUnitsInScriptGroup (912, 0) < 1)   then
         Wait (5)
         LandReinforcementFromMap (0, "Recon", 3, 912);
         Cmd (0, 912, 100, 6943, 3587);
         QCmd (0, 912, 100, 5954, 6888);
         QCmd (0, 912, 100, 4814, 4849);
         QCmd (0, 912, 100, 6943, 3587);
         QCmd (0, 912, 100, 5954, 6888);
         QCmd (0, 912, 100, 4814, 4849);
         QCmd (0, 912, 100, 6943, 3587);
         QCmd (0, 912, 100, 5954, 6888);
         QCmd (0, 912, 100, 4814, 4849);
         QCmd (0, 912, 100, 6943, 3587);
         QCmd (0, 912, 100, 5954, 6888);
         QCmd (0, 912, 100, 4814, 4849);
         QCmd (0, 912, 100, 6943, 3587);
         QCmd (0, 912, 100, 5954, 6888);
         QCmd (0, 912, 100, 4814, 4849);
        end;
    end;
end;
---------------------------------------------
function SPG ()
    while 1 do
     Wait (1)
     Cmd (ACT_STAND, 1001);
     break;
    end;
end;
---------------------------------------------
function Fighters ()
   while 1 do
     Wait (180)
     LandReinforcementFromMap (1, "Fighters", 0, 998);
     Cmd (0, 998, 300, 3939, 34010);
     break;
    end;
end;
-------------------------------------------------
function Noise ()
    while 1 do
     Wait (3)
     if (GetNUnitsInScriptGroup (100, 2) > 0) or (GetNUnitsInScriptGroup (101, 2) > 0) or (GetNUnitsInScriptGroup (200, 2) > 0)
	 or (GetNUnitsInScriptGroup (201, 2) > 0) or (GetNUnitsInScriptGroup (300, 2) > 0) or (GetNUnitsInScriptGroup (301, 2) > 0)
	 or (GetNUnitsInScriptGroup (400, 2) > 0) or (GetNUnitsInScriptGroup (401, 2) > 0) or (GetNUnitsInScriptGroup (500, 2) > 0)
	 or (GetNUnitsInScriptGroup (501, 2) > 0) or (GetNUnitsInScriptGroup (600, 2) > 0) or (GetNUnitsInScriptGroup (601, 2) > 0)
	 or (GetNUnitsInScriptGroup (700, 2) > 0) or (GetNUnitsInScriptGroup (701, 2) > 0) or (GetNUnitsInScriptGroup (800, 2) > 0)
	 or (GetNUnitsInScriptGroup (801, 2) > 0) then
	     Cmd (ACT_SUPPRESS, 10, 300, 1439, 5173);
	     Wait (10+Random (30))
	     QCmd (ACT_STOP, 10);
	     Cmd (ACT_SUPPRESS, 20, 300, 2782, 3137);
	     Wait (10+Random (20) )
	     QCmd (ACT_STOP, 30);
         Cmd (ACT_SUPPRESS, 30, 300, 4807, 779);
         Wait (10+Random (30));
         QCmd (ACT_STOP, 30);
         break;
        end;
    end;
end;

function Recon11 ()
    while 1 do
      Wait (3)
        if (GetNUnitsInPlayerUF (0) <2) and (IsReinforcementAvailable (0) ==0) and y == 1 then
          ChangePlayerForScriptGroup (911, 2);
          Cmd (0, 911, 50, 163, 3832);
          QCmd (ACT_DISAPPEAR, 911)
          R = 1
          break;
        end;
    end;
end;
    
------------------------------------------------------
GiveObjective(0)
StartThread (Artillery);
StartThread (Objective1);
StartThread (Objective2);
StartThread (Victory);
StartThread (Caput1);
StartThread (Caput2);
StartThread (Tanks1);
StartThread (Tanks2);
StartThread (Tanks22);
--StartThread (Dig);
StartThread (Recon1);
--StartThread (Recon2);
StartThread (SPG);
StartThread (Noise);
--StartThread (Fighters);
StartThread (Recon11);