b1=0
b2=0
b3=0
p1=0
i1=0
x1=0
N=0
A=0
B=0
C=0
D=0
E=0
R=0
Objective0=0
Objective1=0

level = GetDifficultyLevel();
if level == DLEVEL_VERY_EASY then
	SaveCars = 1;
end;

if level == DLEVEL_EASY then
	SaveCars = 2;
end;

if level == DLEVEL_NORMAL then
	SaveCars = 3;
end;

if level == DLEVEL_HARD then
	SaveCars = 4;
end;

ALLY_DEFENCE_SCRIPT_ID = 10000;

if level == DLEVEL_NORMAL or level == DLEVEL_HARD then
	RemoveScriptGroup( ALLY_DEFENCE_SCRIPT_ID );
end;

--------------------------------Loose conditions
function Caput ()

   while 1 do
        Wait( 3 );
        if (Objective0 == 0 and ( GetNUnitsInScriptGroup (777, 2) < 5 )) or 
			(Objective0 == 1 and  ( GetNUnitsInScriptGroup (777, 0) < SaveCars )) or 
			(( GetNUnitsInPlayerUF ( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
		  Wait(2);
		  Win(1);
		  return 1;
		end;
	end;
end;
------------------------------Victory
function Victory ()

    while 1 do
    Wait (2);
        if Objective1 == 1 then
          Wait (1);
          Win (0);
          return 1; 
        end;
    end;
end;
-----------------------------Ground attack planes
function GAP1 ()

    while 1 do
        Wait (5)
        if ( GetNUnitsInScriptGroup ( 100, 1 ) < 2 ) and b1 < 4 then
          Wait ( 30+RandomInt (30)) ;
          LandReinforcementFromMap( 1, "GAP", 0, 100 );
          b1 = b1+1
          Wait ( 1 );
          Cmd (0, 100, 100, 2320, 5805 );
        end;
    end;
end;

function GAP2 ()

    while 1 do
        Wait (5)
        if ( GetNUnitsInScriptGroup ( 200, 1 ) < 2 ) and b2 < 4 then
          Wait ( 30+RandomInt (30)) ;
          LandReinforcementFromMap( 1, "GAP", 1, 200 );
          b2 = b2+1
          Wait ( 1 );
          Cmd (0, 200, 100, 2320, 5805 );
        end;
    end;
end;

function GAP3 ()

    while 1 do
        Wait (5)
        if ( GetNUnitsInScriptGroup ( 201, 1 ) < 2 ) and b3 < 4 then
          Wait ( 30+RandomInt (30)) ;
          LandReinforcementFromMap( 1, "GAP", 7, 201 );
          b3 = b3+1
          Wait ( 1 );
          Cmd (3, 201, 100, 2320, 5805 );
        end;
    end;
end;
-----------------------------Infantry
function Infantry1A ()
    while 1 do
        Wait ( 10+RandomInt (45));
        LandReinforcementFromMap (1, "Infantry", 0, 500)
        Wait (1);
        ChangeFormation (3, 500);
        Cmd (3, 500, 100, 5762, 6943);
        QCmd (3, 500, 100, 5033, 7812);
        QCmd (3, 500, 100, 3290, 7701);
        QCmd (3, 500, 200, 2079, 6015);
        break;
    end;
end; 

function Infantry1AA ()
    while 1 do
        Wait ( 100+RandomInt (45));
        LandReinforcementFromMap (1, "Infantry", 0, 501)
        Wait (1);
        ChangeFormation (3, 501);
        Cmd (3, 501, 100, 5762, 6943);
        QCmd (3, 501, 100, 5033, 7812);
        QCmd (3, 501, 100, 3290, 7701);
        QCmd (3, 501, 200, 2079, 6015);
        break;
    end;
end;

function Infantry1AAA ()
    while 1 do
        Wait ( 150+RandomInt (10));
        LandReinforcementFromMap (1, "InfantryF", 0, 502)
        Wait (1);
        ChangeFormation (3, 502);
        Cmd (3, 502, 100, 5762, 6943);
        QCmd (3, 502, 100, 5033, 7812);
        QCmd (3, 502, 100, 3290, 7701);
        QCmd (3, 502, 200, 2079, 6015);
        break;
    end;
end;
----------------------------------------------- 

function Infantry1B ()
      while 1 do
        Wait ( 10+RandomInt (45));
        LandReinforcementFromMap (1, "Infantry", 0, 601)
        Wait (1);
        ChangeFormation (3, 601);
        Cmd (3, 601, 100, 5796, 6833);
        QCmd (3, 601, 100, 4607, 6372);
        QCmd (3, 601, 100, 3711, 5593);
        QCmd (3, 601, 200, 2185, 5808);
        break;
    end;
end;

function Infantry1BB ()
      while 1 do
        Wait ( 100+RandomInt (45));
        LandReinforcementFromMap (1, "Infantry", 0, 602)
        Wait (1);
        ChangeFormation (3, 602);
        Cmd (3, 602, 100, 5796, 6833);
        QCmd (3, 602, 100, 4607, 6372);
        QCmd (3, 602, 100, 3711, 5593);
        QCmd (3, 602, 200, 2185, 5808);
        break;
    end;
end;

function Infantry1BBB ()
      while 1 do
        Wait ( 150+RandomInt (10));
        LandReinforcementFromMap (1, "InfantryF", 0, 603)
        Wait (1);
        ChangeFormation (3, 603);
        Cmd (3, 603, 100, 5796, 6833);
        QCmd (3, 603, 100, 4607, 6372);
        QCmd (3, 603, 100, 3711, 5593);
        QCmd (3, 603, 200, 2185, 5808);
        break;
    end;
end;

---------------------------------------------

function Infantry1C ()
      while 1 do
      Wait ( 10+RandomInt (45));
      LandReinforcementFromMap (1, "Infantry", 0, 700)
      Wait (1);
      ChangeFormation (3, 700);
      Cmd (3, 700, 100, 5308, 5371);
      QCmd (3, 700, 100, 4076, 4250);
      QCmd (3, 700, 200, 2508, 6062);
      break;
    end;
end;

function Infantry1CC ()
      while 1 do
      Wait ( 100+RandomInt (45));
      LandReinforcementFromMap (1, "Infantry", 0, 701)
      Wait (1);
      ChangeFormation (3, 701);
      Cmd (3, 701, 100, 5308, 5371);
      QCmd (3, 701, 100, 4076, 4250);
      QCmd (3, 701, 200, 2508, 6062);
      break;
    end;
end;

function Infantry1CCC ()
      while 1 do
        Wait ( 150+RandomInt (10));
        LandReinforcementFromMap (1, "InfantryF", 0, 702)
        Wait (1);
        ChangeFormation (3, 702);
        Cmd (3, 702, 100, 5308, 5371);
        QCmd (3, 702, 100, 4076, 4250);
        QCmd (3, 702, 200, 2508, 6062);
        break;
    end;
end;

-----------------------------------------------------

function Infantry2A ()
      while 1 do
        Wait ( 10+RandomInt (45));
        LandReinforcementFromMap (1, "Infantry", 1, 800)
        Wait (1);
        ChangeFormation (3, 800);
        Cmd (0, 800, 100, 5955, 1229);
        QCmd (3, 800, 100, 3019, 2444);
        QCmd (3, 800, 200, 1652, 6509);
        break;
    end;
end;

function Infantry2AA ()
      while 1 do
        Wait ( 100+RandomInt (45));
        LandReinforcementFromMap (1, "Infantry", 1, 801)
        Wait (1);
        ChangeFormation (3, 801);
        Cmd (0, 801, 100, 5955, 1229);
        QCmd (3, 801, 100, 3019, 2444);
        QCmd (3, 801, 200, 1652, 6509);
        break;
    end;
end;

function Infantry2AAA ()
      while 1 do
        Wait ( 150+RandomInt (10));
        LandReinforcementFromMap (1, "InfantryF", 1, 802)
        Wait (1);
        ChangeFormation (3, 802);
        Cmd (0, 802, 100, 5955, 1229);
        QCmd (3, 802, 100, 3019, 2444);
        QCmd (3, 802, 200, 1652, 6509);
        break;
    end;
end;

------------------------------------------------------

function Infantry2B ()
      while 1 do
      Wait ( 10+RandomInt (45));
      LandReinforcementFromMap (1, "Infantry", 1, 900)
      Wait (1);
      ChangeFormation (3, 900);
      Cmd (0, 900, 100, 2238, 1883);
      QCmd (3, 900, 200, 1717, 6444);
      break;
    end;
end;

function Infantry2BB ()
      while 1 do
      Wait ( 100+RandomInt (45));
      LandReinforcementFromMap (1, "Infantry", 1, 901)
      Wait (1);
      ChangeFormation (3, 901);
      Cmd (0, 901, 100, 2238, 1883);
      QCmd (3, 901, 200, 1717, 6444);
      break;
    end;
end;

function Infantry2BBB ()
      while 1 do
      Wait ( 150+RandomInt (10));
      LandReinforcementFromMap (1, "InfantryF", 1, 902)
      Wait (1);
      ChangeFormation (3, 902);
      Cmd (0, 902, 100, 2238, 1883);
      QCmd (3, 902, 200, 1717, 6444);
      break;
    end;
end;
---------------------------------------
function Infantry2C ()
      while 1 do
      Wait ( 10+RandomInt (45));
      LandReinforcementFromMap (1, "Infantry", 1, 990)
      Wait (1);
      ChangeFormation (3, 990);
      Cmd (0, 990, 100, 5368, 3839);
      QCmd (3, 990, 200, 1917, 6816);
      break;
    end;
end;

function Infantry2CC ()
      while 1 do
      Wait ( 10+RandomInt (45));
      LandReinforcementFromMap (1, "Infantry", 1, 991)
      Wait (1);
      ChangeFormation (3, 991);
      Cmd (0, 991, 100, 5368, 3839);
      QCmd (3, 991, 200, 1917, 6816);
      break;
    end;
end;

function Infantry2CCC ()
      while 1 do
      Wait ( 10+RandomInt (45));
      LandReinforcementFromMap (1, "InfantryF", 1, 992)
      Wait (1);
      ChangeFormation (3, 992);
      Cmd (0, 992, 100, 5368, 3839);
      QCmd (3, 992, 200, 1917, 6816);
      break;
    end;
end;

---------------------------Paratroopers
function Paratroopers1 ()
    while 1 do
      Wait (5)
        if b1 == 4 and b2 == 4 then
         Wait (1);
         LandReinforcementFromMap (1, "Paratroopers", 2, 300)
         Cmd (5, 300, 100, 1875, 5245);
         Wait (20)
         p1=p1+1
         break;
        end;
    end;
end;

function Paratroopers2 ()
    while 1 do
      Wait (5)
        if b1 == 4 and b2 == 4 then
         Wait (2);
         LandReinforcementFromMap (1, "Paratroopers", 8, 301)
         Cmd (5, 301, 100, 2821, 5372);
         break;
        end;
    end;
end;

---------------------------------------------------------Bridges
    
function Bridge1 ()
    
    while 1 do 
     Wait (1)
        if (GetScriptObjectHPs (77) < 40000) then 
         DamageScriptObject (77, -10000);
        end;
    end;
end;  

function Bridge2 ()
    
    while 1 do 
     Wait (1)
        if (GetScriptObjectHPs (88) < 40000) then 
         DamageScriptObject (88, -10000);
        end;
    end;
end;
---------------------------------------------------------Evacuation
function Escape ()
 
    while 1 do
     Wait (5)
        if p1 == 1 and b1 == 4 and b2 == 4  and ( GetNUnitsInScriptGroup ( 777, 2 ) >= 5 )  and
		( GetNUnitsInScriptGroup ( 502, 1 ) < 3 ) and  ( GetNUnitsInScriptGroup ( 603, 1 ) < 3 ) and
		( GetNUnitsInScriptGroup ( 702, 1 ) < 3 ) and  ( GetNUnitsInScriptGroup ( 802, 1 ) < 3 ) and
		( GetNUnitsInScriptGroup ( 902, 1 ) < 3 ) then
         CompleteObjective(0)
         Objective0 = 1
         ChangePlayerForScriptGroup (777, 0 );
         Wait (3)
         GiveObjective(1)
         Wait (1)
         StartThread( Finish );
         break;
        end;
    end;
end; 

function Calculation ()

    while 1 do
     Wait (3)
     N = (GetNUnitsInScriptGroup (777));
    end;
end;

function Finish ()

    while 1 do
     Wait (3)
        if (GetNScriptUnitsInArea (777, "Rock") >= SaveCars) then
			Wait (1)
			CompleteObjective(1)
			Objective1 = 1
			DamageScriptObject (102, 100);
			break;
        end;
    end;
end;
----------------------------------------------
function Bombers ()
 
    while 1 do
     Wait (5)
        if Objective0 == 1 and (GetNScriptUnitsInArea (777, "Base") < SaveCars)  then 
			Wait (5)
			LandReinforcementFromMap (1, "Bombers", 3, 100003);
			Cmd (0, 100003, 300, 3227, 5305); 
			LandReinforcementFromMap (1, "Bombers", 4, 100004);
			Cmd (0, 100004, 300, 3224, 6139);
			LandReinforcementFromMap (1, "Bombers", 5, 100005);
			Cmd (0, 100005, 300, 1490, 6040);
			LandReinforcementFromMap (1, "Bombers", 6, 100006);
			Cmd (0, 100006, 300, 1506, 5244);
			StartThread (Bombers2);
			break;
        end;
    end;
end;

function Bombers2 ()
 
    while 1 do
     Wait (5)
        if Objective0 == 1 and (GetNScriptUnitsInArea (777, "Base") < 1) and x1 < 2 then 
         Wait (60)
         LandReinforcementFromMap (1, "Bombers", 3, 100003);
         Cmd (0, 100003, 300, 3227, 5305); 
         LandReinforcementFromMap (1, "Bombers", 4, 100004);
         Cmd (0, 100004, 300, 3224, 6139);
         LandReinforcementFromMap (1, "Bombers", 5, 100005);
         Cmd (0, 100005, 300, 1490, 6040);
         LandReinforcementFromMap (1, "Bombers", 6, 100006);
         Cmd (0, 100006, 300, 1506, 5244);
         x1=x1+1
        end;
    end;
end;
--------------------------------------------------
function Bombers_A ()
    while 1 do 
     Wait (1)
        if Objective0 == 1 and (GetNUnitsInArea (0, "A") > 0) and (GetNUnitsInArea (1, "A") > 0) then
         LandReinforcementFromMap (1, "Bombers", 3, 50)
         Cmd (0, 50, 200, 3455, 3706);
         Wait (7)
         LandReinforcementFromMap (1, "Paratroopers", 2, 51)
         Cmd (5, 51, 200, 3455, 3706);
         break;
        end;
    end;
end;

function Paratroopers_A ()
    while 1 do
     Wait (5)
        if Objective0 == 1 and A < 2  then
         Wait (90 + Random (90))
         LandReinforcementFromMap (1, "Paratroopers", 2, 511);
         A = A+1
         Cmd (5, 511, 200, 3455, 3706);
         break;
        end;
    end;
end;

function Patrol_A ()
    while 1 do
     Wait (1)
        if Objective0 == 1 then
          LandReinforcementFromMap (1, "Elite", 1, 52);
          ChangeFormation (1, 52)
          Cmd (3, 52, 50, 3455, 3706);
          ChangeFormation (3, 52);
          break;
        end;
    end;
end; 
------------------------------------------------------------

function Bombers_B ()
    while 1 do 
     Wait (1)
        if Objective0 == 1 and (GetNUnitsInArea (0, "B",0) > 0) and (GetNUnitsInArea (1, "B") > 0) then
         LandReinforcementFromMap (1, "Bombers", 3, 60)
         Cmd (0, 60, 200, 5381, 2765);
         Wait (7)
         LandReinforcementFromMap (1, "Paratroopers", 2, 61)
         Cmd (5, 61, 200, 5381, 2765);
         break;
        end;
    end;
end;

function Paratroopers_B ()
    while 1 do
      Wait (5)
        if Objective0 == 1 and B < 2  then
         Wait (90 + Random (90))
         LandReinforcementFromMap (1, "Paratroopers", 2, 611);
         B = B+1
         Cmd (5, 611, 200, 5381, 2765);
         break;
        end;
    end;
end;

function Patrol_B ()
    while 1 do
     Wait (1)
        if Objective0 == 1 then
          LandReinforcementFromMap (1, "Elite", 1, 62);
          ChangeFormation (1, 62)
          Cmd (3, 62, 50, 5381, 2765);
          ChangeFormation (3, 62);
          break;
        end;
    end;
end;
---------------------------------------------------------------------------
function Bombers_C ()
    while 1 do 
     Wait (1)
        if Objective0 == 1 and (GetNUnitsInArea (0, "C", 0) > 0) and (GetNUnitsInArea (1, "C") > 0) then
         LandReinforcementFromMap (1, "Bombers", 3, 70)
         Cmd (0, 70, 200, 3115, 2302);
         Wait (7)
         LandReinforcementFromMap (1, "Paratroopers", 2, 71)
         Cmd (5, 71, 200, 3115, 2302);
         break;
        end;
    end;
end;

function Paratroopers_C ()
    while 1 do
      Wait (5)
        if Objective0 == 1 and C < 2  then
         Wait (90 + Random (90))
         LandReinforcementFromMap (1, "Paratroopers", 2, 711);
         C = C+1
         Cmd (5, 711, 200, 3115, 2302);
         break;
        end;
    end;
end;

function Patrol_C ()
    while 1 do
     Wait (1)
        if Objective0 == 1 then
          LandReinforcementFromMap (1, "Elite", 1, 72);
          ChangeFormation (1, 72)
          Cmd (3, 72, 50, 3115, 2302);
          ChangeFormation (3, 72);
          break;
        end;
    end;
end;
-----------------------------------------------------------------------------
function Bombers_D ()
    while 1 do 
     Wait (1)
        if Objective0 == 1 and (GetNUnitsInArea (0, "D", 0) > 0) and (GetNUnitsInArea (1, "D") > 0) then
         LandReinforcementFromMap (1, "Bombers", 3, 80)
         Cmd (0, 80, 200, 1997, 2767);
         Wait (7)
         LandReinforcementFromMap (1, "Paratroopers", 2, 81)
         Cmd (5, 81, 200, 1997, 2767);
         break;
        end;
    end;
end;

function Paratroopers_D ()
    while 1 do
      Wait (5)
        if Objective0 == 1 and D < 2  then
         Wait (90 + Random (90))
         LandReinforcementFromMap (1, "Paratroopers", 2, 811);
         D = D+1
         Cmd (5, 811, 200, 3115, 2302);
         break;
        end;
    end;
end; 

function Patrol_D ()
    while 1 do
     Wait (1)
        if Objective0 == 1 then
          LandReinforcementFromMap (1, "Elite", 1, 82);
          ChangeFormation (1, 82)
          Cmd (3, 82, 50, 1997, 2767);
          ChangeFormation (3, 82);
          break;
        end;
    end;
end;  
--------------------------------------------------------------------------------
function Bombers_E ()
    while 1 do 
     Wait (1)
        if Objective0 == 1 and (GetNUnitsInArea (0, "E", 0) > 0) and (GetNUnitsInArea (1, "E") > 0) then
         LandReinforcementFromMap (1, "Bombers", 3, 90)
         Cmd (0, 90, 200, 4741, 6933);
         Wait (7)
         LandReinforcementFromMap (1, "Paratroopers", 2, 91)
         Cmd (5, 91, 200, 4741, 6933);
         break;
        end;
    end;
end;

function Paratroopers_E ()
    while 1 do
      Wait (5)
        if Objective0 == 1 and E < 2  then
         Wait (90 + Random (90))
         LandReinforcementFromMap (1, "Paratroopers", 2, 911);
         E = E+1
         Cmd (5, 911, 200, 3115, 2302);
         break;
        end;
    end;
end;

function Patrol_E ()
    while 1 do
     Wait (1)
        if Objective0 == 1 then
          LandReinforcementFromMap (1, "Elite", 0, 92);
          ChangeFormation (1, 92)
          Cmd (3, 92, 50, 4741, 6933);
          ChangeFormation (3, 92);
          break;
        end;
    end;
end;   
-----------------------------------------Jeep1
function Jeep1 ()
    while 1 do
     Wait (5)
     Cmd (3, 1001, 50, 2821, 4888);
     QCmd (3, 1001, 50, 2932, 6635);
     QCmd (3, 1001, 50, 5384, 6941);
     break;
    end;
end;

function Jeep2 ()
    while 1 do
     Wait (1)
     Cmd (3, 1002, 50, 2821, 4888)
     QCmd (3, 1002, 50, 3588, 3276)
     QCmd (3, 1002, 50, 3051, 2338)
     QCmd (ACT_WAIT, 1002, 3);
     QCmd (3, 1002, 50, 3588, 3276)
     QCmd (3, 1002, 50, 4413, 3150)
     QCmd (3, 1002, 50, 5269, 4744)
     QCmd (ACT_WAIT, 1002, 3)
     QCmd (3, 1002, 50, 5269, 4744)
     QCmd (3, 1002, 50, 4413, 3150)
     QCmd (3, 1002, 50, 3588, 3276)
     QCmd (3, 1002, 50, 3051, 2338)
     QCmd (3, 1002, 50, 3588, 3276)
     QCmd (3, 1002, 50, 2821, 4888)
     QCmd (ACT_WAIT, 1002, 3)
     QCmd (3, 1002, 50, 2821, 4888)
     QCmd (3, 1002, 50, 3588, 3276)
     QCmd (3, 1002, 50, 3051, 2338)
     QCmd (ACT_WAIT, 1002, 3);
     QCmd (3, 1002, 50, 3588, 3276)
     QCmd (3, 1002, 50, 4413, 3150)
     QCmd (3, 1002, 50, 5269, 4744)
     QCmd (ACT_WAIT, 1002, 3)
     break;
    end;
end;
----------------------------------------------
function Recon ()
    while 1 do 
     Wait (5)
     if Objective0 == 1 and (GetNUnitsInScriptGroup (979, 1) <1) and R <3 then
         Wait (30)
         LandReinforcementFromMap (1, "Recon", 2, 979);
         R=R+1
         Cmd (0, 979, 100, 4741, 6933);
         QCmd (0, 979, 100, 1997, 2767);
         QCmd (0, 979, 100, 4741, 6933);
         QCmd (0, 979, 100, 1997, 2767);
         QCmd (0, 979, 100, 4741, 6933);
         QCmd (0, 979, 100, 1997, 2767);
         QCmd (0, 979, 100, 4741, 6933);
         QCmd (0, 979, 100, 1997, 2767);
         QCmd (0, 979, 100, 4741, 6933);
         QCmd (0, 979, 100, 1997, 2767);
         QCmd (0, 979, 100, 4741, 6933);
         QCmd (0, 979, 100, 1997, 2767);
         break;
        end;
    end;
end;
----------------------------------------------------------
function Secret ()
    while 1 do
      Wait (3)
        if Objective0 == 1 and ( GetNUnitsInScriptGroup ( 777, 0 ) > 9 ) then 
          Wait (10)
          CompleteObjective(2)
          break;
        end;
    end;
end;
 
-----------------------------------------------------------
GiveObjective(0)
StartThread (Victory);
StartThread (Caput);
StartThread (GAP1);
StartThread (GAP2);
--StartThread (GAP3);
StartThread (Infantry1A);
StartThread (Infantry1AA);
StartThread (Infantry1AAA);
StartThread (Infantry1B);
StartThread (Infantry1BB);
StartThread (Infantry1BBB);
StartThread (Infantry1C);
StartThread (Infantry1CC);
StartThread (Infantry1CCC);
StartThread (Infantry2A);
StartThread (Infantry2AA);
StartThread (Infantry2AAA);
StartThread (Infantry2B);
StartThread (Infantry2BB);
StartThread (Infantry2BBB);
StartThread (Infantry2C);
StartThread (Infantry2CC);
StartThread (Infantry2CCC);
StartThread (Paratroopers1);
StartThread (Paratroopers2);
StartThread (Bridge1);
--StartThread (Bridge2);
StartThread (Escape);
StartThread (Bombers);
StartThread (Bombers_A);
StartThread (Patrol_A);
StartThread (Bombers_B);
StartThread (Patrol_B);
StartThread (Bombers_C);
StartThread (Patrol_C);
StartThread (Bombers_D);
StartThread (Patrol_D);
StartThread (Bombers_E);
StartThread (Patrol_E);
StartThread (Calculation);
StartThread (Jeep1);
StartThread (Jeep2);
StartThread (Paratroopers_A)
StartThread (Paratroopers_B)
StartThread (Paratroopers_C)
StartThread (Paratroopers_D)
StartThread (Paratroopers_E)
StartThread (Recon);
StartThread (Secret);