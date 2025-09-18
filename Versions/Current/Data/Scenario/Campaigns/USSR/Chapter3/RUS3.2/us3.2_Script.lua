X=0;
Y=0;
L=0;
R=0
Obj0=0
Obj1=0
Obj2=0
Pr = 0
Pl = 0
El = 0
Er =0
b1 = (GetScriptObjectHPs (10));
b2 = (GetScriptObjectHPs (20));
b3 = (GetScriptObjectHPs (30));
b4 = (GetScriptObjectHPs (40));
b5 = (GetScriptObjectHPs (50));
b6 = (GetScriptObjectHPs (61));
i1 = 0
i2 = 0
i3 = 0
i4 = 0
i5 = 0
i6 = 0
e1 = 0
e2 = 0
e3 = 0
e4 = 0
e5 = 0
e6 = 0
e7 = 0
e8 = 0
e9 = 0
e10 = 0
e11 = 0
e12 = 0
e13 = 0
t1 = 0
t2 = 0
t3 = 0
t4 = 0

function Victory ()
    while 1 do
       Wait (2)
       if Obj0 == 1 and Obj1 == 1 and Obj2 == 1 then
          Wait (5)
          Win(0)
          break;
        end;
    end;
end;

function Caput ()
    while 1 do 
        Wait (2)
       if (GetNUnitsInParty (0) < 1) and (IsReinforcementAvailable (0) == 0) then
         Wait (5)
         Win(1)
         break;
        end;
    end;
end;

function Dig ()
Wait (1)
Cmd (ACT_STAND, 1000, 0)
Cmd (ACT_STAND, 1001, 0)
Cmd (ACT_STAND, 1002, 0)
Cmd (ACT_STAND, 1003, 0)
Cmd (ACT_STAND, 1004, 0)
end;

function WarningL ()
    while 1 do
     Wait (2)
        if (GetNUnitsInArea (0, "Left", 0) > 4) and L < 1 and (GetNUnitsInScriptGroup (100) < 1) and (GetNUnitsInScriptGroup (101) < 1) then
         Wait (1)
         LandReinforcementFromMap (1, "Counter1", 0,  100)
         ChangeFormation (100, 3);
         Cmd (3, 100, 200, 4126, 2946); 
         QCmd (3, 100, 400, 6856, 2682); 
         Wait (1)
         --LandReinforcementFromMap (1, "Counter1", 0,  101)
         --ChangeFormation (101, 3);
         --Cmd (3, 101, 200, 4601, 3588); 
         --QCmd (3, 101, 400, 7059, 4162);
         L=L+1
         break;
        end;
    end;
end;

function WarningR ()
    while 1 do
     Wait (2)
        if (GetNUnitsInArea (0, "Right", 0) > 4) and R < 1 and (GetNUnitsInScriptGroup (200) < 1) and (GetNUnitsInScriptGroup (201) < 1)then
         Wait (1)
         LandReinforcementFromMap (1, "Counter1", 0,  200)
         ChangeFormation (200, 3);
         Cmd (3, 200, 200, 5008, 5706); 
         QCmd (3, 200, 400, 6843, 5017);
         Wait (1)
         --LandReinforcementFromMap (1, "Counter1", 0,  201)
         --ChangeFormation (201, 3);
         --Cmd (3, 201, 200, 4892, 6495); 
         --QCmd (3, 201, 400, 7320, 5564); 
         R=R+1
         break;
        end;
    end;
end;


function Object0 ()
   while 1 do
      Wait (2)
      Pr = (GetNUnitsInArea (0, "Right", 0)) 
      Er = (GetNUnitsInArea (1, "Right", 0))
      Pl = (GetNUnitsInArea (0, "Left", 0)) 
      El = (GetNUnitsInArea (1, "Left", 0))
        if (Pr > Er*2  and Er < 5) or (Pl > El*2  and El < 5) then
          Wait (3)
          CompleteObjective(0)
          Obj0 = 1
          --Wait (3)
          --GiveObjective(1)
          Wait (1)
          --GiveObjective(2)
          break;
        end;
    end;
end;


function Object1 ()
    while 1 do
      Wait (2)
        if (GetNUnitsInScriptGroup (333, 0) > 0) then 
          Wait (2)
          CompleteObjective(1)
          Obj1 = 1
          break;
        end;
    end;
end;

function Object2 ()
    while 1 do 
      Wait (2)
        if (GetNUnitsInScriptGroup (444, 1) < 1) then
         Wait (2)
         CompleteObjective(2)
         Obj2 = 1
         break;
        end;
    end;
end;

function Reload ()
    while 1 do
      Wait (5)
        if (GetNUnitsInScriptGroup (51) < 1) and Obj0 == 0 then
         Wait (60+Random(100))
         LandReinforcementFromMap (1, "Truck1", 0, 51)
         Cmd (0, 51, 100, 1569, 2961);
        end;
        if (GetNUnitsInScriptGroup (52) < 1) and Obj0 == 0 then
         Wait (60+Random(100))
         LandReinforcementFromMap (1, "Truck2", 0, 52)
         Cmd (0, 52, 100, 1569, 2961);
        end;
    end;
end;

function Bunkers1 () 

while 1 do 
     Wait (1)
        if (GetScriptObjectHPs (10) < b1) and (GetScriptObjectHPs (10) > 0) and 
	   (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and (GetNUnitsInScriptGroup (10, 1) > 0)  and Obj0 == 0 then 
         DamageScriptObject (10, -1);
         Wait (1)
        end;
        if (GetScriptObjectHPs (20) < b2) and (GetScriptObjectHPs (20) > 0) and 
	   (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and (GetNUnitsInScriptGroup (20, 1) > 0)  and Obj0 == 0 then 
         DamageScriptObject (20, -1);
         Wait (1)
        end;
        if (GetScriptObjectHPs (30) < b3) and (GetScriptObjectHPs (30) > 0) and 
	   (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and (GetNUnitsInScriptGroup (30, 1) > 0)  and Obj0 == 0 then 
         DamageScriptObject (30, -1);
         Wait (1)
        end;
        if (GetScriptObjectHPs (40) < b4) and (GetScriptObjectHPs (40) > 0) and 
	   (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and (GetNUnitsInScriptGroup (40, 1) > 0)  and Obj0 == 0 then 
         DamageScriptObject (40, -1);
         Wait (1)
        end;
        if (GetScriptObjectHPs (61) < b6) and (GetScriptObjectHPs (61) > 0) and 
	   (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1)  and (GetNUnitsInScriptGroup (61, 1) > 0) and Obj0 == 0 then 
         DamageScriptObject (61, -1);
        end;
    end;
end;


function Bunkers2 ()

while 1 do
     Wait (1)
        if (GetNUnitsInScriptGroup (110, 1) < 1) and Obj0 == 0 and i1 < 3 then 
          Wait (5)
          LandReinforcementFromMap (1, "Infantry", 0, 110)
          ChangeFormation (110, 3)
          Cmd (ACT_ENTER, 110, 10);
          i1 = i1 + 1 
        end;
          if (GetNUnitsInScriptGroup (120, 1) < 1) and Obj0 == 0  and i2 < 3 then 
          Wait (5)
          LandReinforcementFromMap (1, "Infantry", 0, 120)
          ChangeFormation (120, 3)
          Cmd (ACT_ENTER, 120, 20);
          i2 = i2 + 1
        end;
        if (GetNUnitsInScriptGroup (130, 1) < 1) and Obj0 == 0  and i3 < 3 then 
          Wait (5)
          LandReinforcementFromMap (1, "Infantry", 0, 130)
          ChangeFormation (130, 3)
          Cmd (ACT_ENTER, 130, 30);
          i3 = i3 + 1
        end;
        if (GetNUnitsInScriptGroup (140, 1) < 1) and Obj0 == 0 and i4 < 3 then 
          Wait (5)
          LandReinforcementFromMap (1, "Infantry", 0, 140)
          ChangeFormation (140, 3)
          Cmd (ACT_ENTER, 140, 40);
          i4 = i4 + 1
        end;
        if (GetNUnitsInScriptGroup (160, 1) < 1) and Obj0 == 0 and i6 < 3 then 
          Wait (5)
          LandReinforcementFromMap (1, "Infantry", 0, 160)
          ChangeFormation (160, 3)
          Cmd (ACT_ENTER, 160, 61);
          i6 = i6 + 1
        end;
    end;
end;

function Entrenchments ()
    while 1 do
     Wait (1)
        if (GetNUnitsInScriptGroup (180, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e1 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 180)
         ChangeFormation (180, 1)
         Cmd (ACT_ENTER, 180, 80);
         e1=e1+1
        end;
        if (GetNUnitsInScriptGroup (181, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e2 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 181)
         ChangeFormation (181, 1)
         Cmd (ACT_ENTER, 181, 81);
         e2=e2+1
        end;
        if (GetNUnitsInScriptGroup (182, 1) <1 ) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e3 < 3 then
         LandReinforcementFromMap (1, "Infantry2", 0, 182)
         ChangeFormation (182, 1)
         Cmd (ACT_ENTER, 182, 82);
         e3=e3+1
        end;
        if (GetNUnitsInScriptGroup (183, 1) <1 ) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e4 < 3 then
         LandReinforcementFromMap (1, "Infantry2", 0, 183)
         ChangeFormation (183, 1)
         Cmd (ACT_ENTER, 183, 83);
         e4=e4+1
        end;
        if (GetNUnitsInScriptGroup (184, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e5 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 184)
         ChangeFormation (184, 1)
         Cmd (ACT_ENTER, 184, 84);
         e5=e5+1
        end;
        if (GetNUnitsInScriptGroup (185, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e6 < 3 then
         LandReinforcementFromMap (1, "Infantry2", 0, 185)
         ChangeFormation (185, 1)
         Cmd (ACT_ENTER, 185, 85);
         e6=e6+1
        end;
        if (GetNUnitsInScriptGroup (186, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e7 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 186)
         ChangeFormation (186, 1)
         Cmd (ACT_ENTER, 186, 86);
         e7=e7+1
        end;
        if (GetNUnitsInScriptGroup (187, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e8 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 187)
         ChangeFormation (187, 1)
         Cmd (ACT_ENTER, 187, 87);
         e8=e8+1
        end;
        if (GetNUnitsInScriptGroup (188, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e9 < 3 then
         LandReinforcementFromMap (1, "Infantry2", 0, 188)
         ChangeFormation (188, 1)
         Cmd (ACT_ENTER, 188, 88);
         e9=e9+1
        end;
        if (GetNUnitsInScriptGroup (189, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e10 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 189)
         ChangeFormation (189, 1)
         Cmd (ACT_ENTER, 189, 89);
         e10=e10+1
        end;
        if (GetNUnitsInScriptGroup (190, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e11 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 190)
         ChangeFormation (190, 1)
         Cmd (ACT_ENTER, 190, 90);
         e11=e11+1
         end;
        if (GetNUnitsInScriptGroup (191, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e12 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 191)
         ChangeFormation (191, 1)
         Cmd (ACT_ENTER, 191, 91);
         e12=e12+1
        end; 
        if (GetNUnitsInScriptGroup (192, 1) < 1) and (GetNUnitsInArea (0, "Left", 1) < 1) and (GetNUnitsInArea (0, "Right", 1) < 1) and Obj0 == 0 and e13 < 3 then
         LandReinforcementFromMap (1, "Infantry1", 0, 192)
         ChangeFormation (192, 1)
         Cmd (ACT_ENTER, 192, 92);
         e13=e13+1
        end;  
    end;
end;  

function Tanks ()
while 1 do
  Wait (2)
    if (GetNUnitsInScriptGroup (1001) < 1)  and Obj0==0 and (GetNUnitsInArea (0, "Left", 1) < 1)  and t1 < 3 then
     LandReinforcementFromMap (1, "Tank", 0, 1001)
     Cmd (0, 1001, 10, 4043, 3086);
     QCmd (8, 1001, 10, 5533, 2997);
     QCmd (45, 1001, 0);
     t1=t1+1
    end;
    if (GetNUnitsInScriptGroup (1002) < 1)  and Obj0==0 and (GetNUnitsInArea (0, "Left", 1) < 1) and  t2 < 3 then
     LandReinforcementFromMap (1, "Tank", 0, 1002)
     Cmd (0, 1002, 10, 3543, 3787);
     QCmd (8, 1002, 10, 5533, 2997);
     QCmd (45, 1002, 0);
     t2=t2+1
    end;
    if (GetNUnitsInScriptGroup (1003) < 1)  and Obj0==0 and (GetNUnitsInArea (0, "Right", 1) < 1)  and t3 < 3 then
     LandReinforcementFromMap (1, "Tank", 0, 1003)
     Cmd (0, 1003, 10, 4827, 5755);
     QCmd (8, 1003, 10, 6332, 5818);
     QCmd (45, 1003, 0);
     t3=t3+1
    end;
    if (GetNUnitsInScriptGroup (1004) < 1)  and Obj0==0 and (GetNUnitsInArea (0, "Right", 1) < 1)  and t4 < 3 then
     LandReinforcementFromMap (1, "Tank", 0, 1004)
     Cmd (0, 1004, 10, 4185, 6396);
     QCmd (8, 1004, 10, 6332, 5818);
     QCmd (45, 1004, 0);
     t4=t4+1
    end;
  end;
end;

function Addon ()
    while 1 do
       Wait (3)
        if Obj1 == 1 or Obj0 == 1 then
         LandReinforcementFromMap (1, "Tigers", 0, 707)
         Cmd (3, 707, 200, 2175, 3522); 
         break;
        end;
    end;
end;  

    
-------------------------------Temp

function Fighter ()
    while 1 do
     Wait (1)
     X = (GetNUnitsInArea (0, "AA", 0));
     Y = (GetNUnitsInArea (0, "AA", 1));
        if Y > X and (GetNUnitsInScriptGroup (123) < 1)  then
         LandReinforcementFromMap (1, "Fighters", 0, 123);
         break
        end;
    end;
end;  

function F ()
   while 1 do
     Wait (1)
        if (GetNUnitsInScriptGroup (123) < 1)  then
          LandReinforcementFromMap (1, "Fighters", 0, 123);
          Wait (2)
          LandReinforcementFromMap (1, "Fighters", 0, 123);
          Cmd (0, 123, 100, 3291, 4542);
          Wait (100)
        end;
    end;
end;

function EasyMode()
	guns = GetObjectListArray( 444 );
	for i = 1, 3 do
		UnitRemove( guns[i] );
	end;
	RemoveScriptGroup( 182 );
	RemoveScriptGroup( 183 );
	RemoveScriptGroup( 184 );
	RemoveScriptGroup( 185 );
	RemoveScriptGroup( 186 );
	RemoveScriptGroup( 188 );
	RemoveScriptGroup( 189 );
	RemoveScriptGroup( 192 );
	RemoveScriptGroup( 180 );
	RemoveScriptGroup( 181 );
	RemoveScriptGroup( 190 );
	RemoveScriptGroup( 191 );
	RemoveScriptGroup( 1002 );
	RemoveScriptGroup( 1003 );
end;

------------------------
if ( oldGetDifficultyLevel() == 3 ) then
	EasyMode();
else
	StartThread (Bunkers1)
	StartThread (Bunkers2);
	StartThread (Entrenchments);
	StartThread (Tanks);
end;

GiveObjective(0)
GiveObjective(1)
GiveObjective(2)
StartThread (Dig);
StartThread (WarningL);
StartThread (WarningR);
--StartThread (Fighter);
--StartThread (F)
StartThread (Victory);
StartThread (Caput);
StartThread (WarningR);
StartThread (WarningL);
StartThread (Object0);
StartThread (Object1);
StartThread (Object2);
StartThread (Reload);
StartThread (Addon);