Objective0 = 0;
Objective1 = 0;
Objective2 = 0;
y1 = 0;
y3 = 0;
y4 = 0
y5 = 0
y6 = 0
y7 = 0
y11 = 0
y111 = 0
i1 = 0
i2 = 0
i3 = 0
x1 = 0;
x2 = 0;
x3 = 0;
x4 = 0;
x5 = 0;
--------------------------------------Loose conditions
function Caput ()
    while 1 do
        Wait( 3 );
        if ( GetNUnitsInPlayerUF ( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
		Wait(2);
		Win(1);
		return 1;
		end;
	end;
end;
-------------------------------------------Win conditions
function Victory ()

    while 1 do
        Wait ( 3 );
        if Objective0 == 1 and Objective1 == 1 and Objective2 ==1 then
        Wait (2);
        Win (0);
        return 1;
        end;
    end;
end;

------------------------------------------Retreat
--function Run1 ()
 
--    while 1 do
--      Wait (3) 
--      ChangeFormation ( 111, 1 );
--      ChangeFormation ( 222, 1 );
--      ChangeFormation ( 333, 1 );
--      Cmd ( 4, 111, 110 );
--      Cmd ( 4, 222, 220);
--      Cmd ( 4, 333, 330);
--      break;
--    end;
--end;

--function Run2 ()

--   while 1 do
--      Wait (40)
--      Cmd (0, 110, 50, 5845, 6468 );
--      QCmd (0, 110, 50, 3711, 5189 );
--      QCmd (0, 110, 50, 2645, 4319 );
--      QCmd (0, 110, 50, 2129, 1450 );
--      
--      Cmd (0, 220, 50, 5845, 6468 );
--      QCmd (0, 220, 50, 3711, 5189 );
--      QCmd (0, 220, 50, 2645, 4319 );
--      QCmd (0, 220, 50, 2129, 1450 );
--     
--      Cmd (0, 330, 50, 5845, 6468 );
--      QCmd (0, 330, 50, 3711, 5189 );
--      QCmd (0, 330, 50, 2645, 4319 );
--      QCmd (0, 330, 50, 2129, 1450 );
--      
--      break;
--    end;
--end;
-------------------------------------------Allies 
function Repair ()

while 1 do 
        Wait ( 5 );
        if Objective1 == 0 then
         DamageScriptObject (101, -200);
        end;
    end;
end;
----------------------------------------Allies 1
function Allies1A ()   
   
    while 1 do  
        Wait (4);
        if Objective1 == 0 and( GetNUnitsInScriptGroup ( 5000, 2 ) < 1 ) then 
          Wait (1);
          LandReinforcementFromMap( 2, "A1", 0, 5000 );
          Wait (1);
          StartThread( Step1 );
        end;
    end;
end;

function Step1 ()
    while 1 do
      Wait (1)
      Cmd (3, 5000, 300, 9217, 3113 );
      QCmd (8, 5000, 50, 8557, 2645 );
      QCmd (45, 5000, 300, 9217, 3113 );
      break;
    end
end;

function Allies1B ()
    while 1 do 
        Wait (5)
        if Objective1 == 1 and ( GetNUnitsInScriptGroup ( 5000, 2 ) > 0 ) and (GetNUnitsInArea ( 0, "Town", 0) > 0 ) then
          Wait (1)
          Cmd ( 3, 5000, 500, 2719, 1119 );
          break;
        end;
    end;
end;

-----------------------------Allies 2-0
function Allies2A ()

    while 1 do 
        Wait (4)
        if Objective0 == 1 then
         Wait (1);
         LandReinforcementFromMap( 2, "A4", 0, 6000 );
         Wait (1); 
         StartThread( Step2A );
         break;
        end;
    end;
end;

function Step2A ()
    
    while 1 do
       Wait (1)
       ChangeFormation (6000, 3);
       Cmd (3, 6000, 100, 7291, 1317 );
       QCmd ( 3, 6000, 300, 6805, 727 );
       QCmd ( 8, 6000, 50, 3536, 1392 );
       QCmd (50, 6000)
       break;
    end;
end;

function Allies2AA ()

    while 1 do 
        Wait (2)
        if Objective1 == 1 and (GetNScriptUnitsInArea ( 6000, 'Wait', 0) > 0 ) and (GetNUnitsInArea ( 0, 'Town', 0) > 0 ) then
         Wait (1)
         ChangeFormation (6000, 3);
         Cmd ( 3, 6000, 600, 2627, 737 );
         break;
        end;
    end;
end;

function Allies2_1A ()

    while 1 do 
        Wait (2)
        if Objective1 == 1 and  (GetNUnitsInArea ( 0, 'Town', 0) > 0 ) then
           Wait (5)
           LandReinforcementFromMap (2, "A6", 0, 2100)
           ChangeFormation (2100, 1)
           Cmd (0, 2100, 100, 9007, 3131);
           QCmd (0, 2100, 100, 7152, 1228);
           QCmd (0, 2100, 400, 6774, 904);
           QCmd (ACT_STAND, 2100);
           break; 
        end;
    end;
end;

function Allies2_1A_Go ()

    while 1 do 
    Wait (2)
        if (GetNScriptUnitsInArea ( 2100, 'Wait', 0) > 0 ) and (GetNScriptUnitsInArea ( 2101, 'Wait', 0) > 0 ) and (GetNScriptUnitsInArea ( 2102, 'Wait', 0) > 0 )then
          Wait (30)
          ChangeFormation (2100, 3)
          Cmd (3, 2100, 500, 3347, 774);
          break
        end;
    end;
end;

-----------------------------Allies 2-1
function Allies2B ()

    while 1 do 
        Wait (3)
        if Objective0 == 1 and ( GetNUnitsInScriptGroup ( 40000, 1 ) < 1 ) then
         Wait (1);
         LandReinforcementFromMap( 2, "A5", 1, 6001 );
         Wait (1); 
         StartThread( Step2B );
         break;
        end;
    end;
end;

function Step2B ()
    
    while 1 do
       Wait (1)
       ChangeFormation (6001, 3);
       Cmd (3, 6001, 100, 7291, 1317  );
       QCmd ( 3, 6001, 300, 6289, 1244 );
       QCmd( 8, 6001, 50, 3536, 1392 );
       QCmd ( 50, 6001 );
       break;
    end;
end;

function Allies2BB ()

    while 1 do 
        Wait (2)
        if Objective1 == 1 and (GetNScriptUnitsInArea ( 6001, 'Wait', 0) > 0 ) and (GetNUnitsInArea ( 0, 'Town', 0) > 0 ) then
         Wait (1)
         ChangeFormation (6001, 3);
         Cmd ( 3, 6001, 600, 2567, 1461 );
         break;
        end;
    end;
end;

function Allies2_1B ()

    while 1 do 
        Wait (2)
        if Objective1 == 1 and  (GetNUnitsInArea ( 0, 'Town', 0) > 0 ) then
           Wait (10)
           LandReinforcementFromMap (2, "A6", 0, 2101)
           ChangeFormation (2101, 1)
           Cmd (0, 2101, 100, 9007, 3131);
           QCmd (0, 2101, 100, 7152, 1228);
           QCmd (0, 2101, 400, 6140, 2015);
           QCmd (ACT_STAND, 2101);
           break; 
        end;
    end;
end;

function Allies2_1B_Go ()

    while 1 do 
    Wait (2)
        if (GetNScriptUnitsInArea ( 2100, 'Wait', 0) > 0 ) and (GetNScriptUnitsInArea ( 2101, 'Wait', 0) > 0 ) and (GetNScriptUnitsInArea ( 2102, 'Wait', 0) > 0 )then
          Wait (30)
          ChangeFormation (2101, 3)
          Cmd (3, 2101, 500, 3347, 774);
          break
        end;
    end;
end;

-----------------------------Allies 2-2
function Allies2C ()

    while 1 do 
        Wait (3)
        if Objective0 == 1 and ( GetNUnitsInScriptGroup ( 40000, 1 ) < 1 )then
         Wait (1);
         LandReinforcementFromMap( 2, "A5", 0, 6002 );
         Wait (1); 
         StartThread( Step2C );
         break;
        end;
    end;
end;

function Step2C ()
    
    while 1 do
       Wait (1)
       ChangeFormation (6002, 3);
       Cmd (3, 6002, 100, 7291, 1317  );
       QCmd ( 3, 6002, 300, 6213, 1859 );
       QCmd (8, 6002, 50, 3536, 1392 );
       QCmd (50, 6002 );
       break;
    end;
end;

function Allies2CC ()

    while 1 do 
        Wait (2)
        if Objective1 == 1 and (GetNScriptUnitsInArea ( 6002, 'Wait', 0) > 0 ) and (GetNUnitsInArea ( 0, 'Town', 0) > 0 ) then
         Wait (1)
         ChangeFormation (6002, 3);
         Cmd ( 3, 6002, 600, 2127, 2311 );
         break;
        end;
    end;
end;

function Allies2_1C ()

    while 1 do 
        Wait (2)
        if Objective1 == 1 and  (GetNUnitsInArea ( 0, 'Town', 0) > 0 ) then
           Wait (15)
           LandReinforcementFromMap (2, "A6", 0, 2102)
           ChangeFormation (2102, 1)
           Cmd (0, 2102, 100, 9007, 3131);
           QCmd (0, 2102, 100, 7152, 1228);
           QCmd (0, 2102, 400, 5393, 2856);
           QCmd (ACT_STAND, 2102);
           break; 
        end;
    end;
end;

function Allies2_1C_Go ()

    while 1 do 
    Wait (2)
        if (GetNScriptUnitsInArea ( 2100, 'Wait', 0) > 0 ) and (GetNScriptUnitsInArea ( 2101, 'Wait', 0) > 0 ) and (GetNScriptUnitsInArea ( 2102, 'Wait', 0) > 0 )then
          Wait (30)
          ChangeFormation (2102, 3)
          Cmd (3, 2102, 500, 3347, 774);
          break
        end;
    end;
end;
-------------------------------Allies 3-0
function Allies03A ()
Wait (3);
Cmd (0, 901, 100, 8003, 4071);
QCmd (3, 901, 300, 6101, 7028);
QCmd (3, 901, 500, 7028, 5804);
end; 

function Allies3A ()
while 1 do  
        Wait (28);
        if Objective1 == 0  then 
          Wait (1);
          LandReinforcementFromMap( 2, "A2", 1, 7000 );
          Wait (1);
          Cmd (0, 7000, 200, 10701, 2758 );
          QCmd (0, 7000, 200, 8532, 3798 );
          QCmd (3, 7000, 400, 6058, 6555 );
          QCmd (3, 7000, 400, 5597, 7407 );
          QCmd (ACT_STAND, 7000);
         break;
        end
    end;
end; 

--function Allies3AA ()
--while 1 do  
--        Wait (3);
--        if Objective1 == 0  then 
--          Wait (60);
--          LandReinforcementFromMap( 2, "A2", 1, 7100 );
--          Wait (1);
--          Cmd (0, 7100, 50, 10701, 2758 );
--          QCmd (0, 7100, 50, 8532, 3798 );
--          QCmd (3, 7100, 300, 6058, 6555 );
--          QCmd (3, 7100, 300, 5597, 7407 );
--          break;
--        end
--    end;
--end;
--------------------------------Allies 3-1
function Allies03B ()
Wait (3);
Cmd (0, 902, 100, 8361, 4355);
QCmd (3, 902, 300, 6377, 7072);
QCmd (3, 902, 500, 7920, 6375);
end;

function Allies3B ()
while 1 do  
        Wait (28);
        if Objective1 == 0 then 
          Wait (1);
          LandReinforcementFromMap( 2, "A2", 6, 7001 );
          Wait (1)
          Cmd (0, 7001, 200, 9955, 2682 );
          QCmd (0, 7001, 200, 8815, 4023 );
          QCmd (3, 7001, 400, 6518, 6808 );
          QCmd (3, 7001, 400, 6309, 5774 );
          QCmd (ACT_STAND, 7001);
          break;
       end
    end;
end; 

--function Allies3BB ()
--while 1 do  
--        Wait (3);
--        if Objective1 == 0 then 
--          Wait (60);
--          LandReinforcementFromMap( 2, "A2", 6, 7101 );
--          Wait (1)
--          Cmd (0, 7101, 50, 9955, 2682 );
--          QCmd (0, 7101, 50, 8815, 4023 );
--          QCmd (3, 7101, 300, 6518, 6808 );
--          QCmd (3, 7101, 300, 6309, 5774 );
--          break;
--       end
--    end;
--end;
--------------------------------Allies 3-2
function Allies03C ()
Wait (3);
Cmd (0, 903, 100, 8765, 4751);
QCmd (3, 903, 300, 6617, 7774);
QCmd (3, 903, 500, 5468, 7903);
end;

function Allies3C ()
while 1 do  
        Wait (28);
        if Objective1 == 0 then 
          Wait (1);
          LandReinforcementFromMap( 2, "A2", 1, 7002 );
          Wait (1);
          Cmd (0, 7002, 200, 10701, 2758 );
          QCmd (0, 7002, 200, 9088, 4188 );
          QCmd (3, 7002, 400, 6539, 7955 );
          QCmd (3, 7002, 400, 5448, 7128 );
          QCmd (ACT_STAND, 7002);
         break;
        end
    end;
end;

--function Allies3CC ()
--while 1 do  
--        Wait (3);
--        if Objective1 == 0 then 
--          Wait (60);
--          LandReinforcementFromMap( 2, "A2", 1, 7102 );
--          Wait (1);
--          Cmd (0, 7102, 50, 10701, 2758 );
--          QCmd (0, 7102, 50, 9088, 4188 );
--          QCmd (3, 7102, 300, 6539, 7955 );
--          QCmd (3, 7102, 300, 5448, 7128 );
--         break;
--        end
--    end;
--end;
--------------------------------Allies 3-3
function Allies03D ()
Wait (1);
Cmd (0, 904, 100, 9025, 5156);
QCmd (3, 904, 300, 6945, 7256);
QCmd (3, 904, 500, 8000, 6752);
end;

function Allies3D ()
while 1 do  
        Wait (28);
        if Objective1 == 0 then 
          Wait (1);
          LandReinforcementFromMap( 2, "A2", 6, 7003 );
          Wait (1)
          Cmd (0, 7003, 200, 9955, 2682 );
          QCmd (0, 7003, 200, 9371, 4449 );
          QCmd (3, 7003, 400, 7597, 7186 );
          QCmd (3, 7003, 400, 7593, 5943 );
          QCmd (ACT_STAND, 7003);
          break;
        end
    end;
end;

--function Allies3DD ()
--while 1 do  
--        Wait (3);
--        if Objective1 == 0 then 
--          Wait (60);
--          LandReinforcementFromMap( 2, "A2", 6, 7103 );
--          Wait (1)
--          Cmd (0, 7103, 50, 9955, 2682);
--          QCmd (0, 7103, 50, 9371, 4449 );
--          QCmd (3, 7103, 300, 7597, 7186 );
--         QCmd (3, 7103, 300, 7593, 5943 );
--          break;
--        end
--    end;
--end;
---------------------------------Allies4-0
function Allies4A ()
   while 1 do  
        Wait (3);
        if Objective1 == 0 then 
          Wait (1);
          LandReinforcementFromMap( 2, "A3", 4, 8000 );
          Wait (1)
          ChangeFormation (8000, 3);
          Cmd (3, 8000, 300, 6164, 7161 );
         break;
        end;
    end;
end; 

function Allies4AA ()
   while 1 do  
        Wait (3);
        if Objective1 == 0 then 
          Wait (60);
          LandReinforcementFromMap( 2, "A3", 4, 8100 );
          Wait (1)
          ChangeFormation (8100, 3);
          Cmd (3, 8100, 300, 6164, 7161 );
         break;
        end;
    end;
end;  
---------------------------------Allies4-1
function Allies4B ()
   while 1 do  
        Wait (3);
        if Objective1 == 0 then 
          Wait (1);
          LandReinforcementFromMap( 2, "A3", 2, 8001 );
          Wait (1)
          ChangeFormation (8001, 3);
          Cmd (3, 8001, 300, 7118, 6886 );
          break;
        end;
    end;
end;  

function Allies4BB ()
   while 1 do  
        Wait (3);
        if Objective1 == 0 then 
          Wait (60);
          LandReinforcementFromMap( 2, "A3", 2, 8101 );
          Wait (1)
          ChangeFormation (8101, 3);
          Cmd (3, 8101, 300, 7118, 6886 );
          break;
        end;
    end;
end; 
---------------------------------Allies4-2
function Allies4C ()
   while 1 do  
        Wait (3);
        if Objective1 == 0 then 
          Wait (1);
          LandReinforcementFromMap( 2, "A3", 5, 8002 );
          Wait (1)
          ChangeFormation (8002, 3);
          Cmd (3, 8002, 300, 7451, 7661 );
          break;
        end;
    end;
end; 

function Allies4CC ()
   while 1 do  
        Wait (3);
        if Objective1 == 0 then 
          Wait (60);
          LandReinforcementFromMap( 2, "A3", 5, 8102 );
          Wait (1)
          ChangeFormation (8102, 3);
          Cmd (3, 8102, 300, 7451, 7661 );
          break;
        end;
    end;
end; 
-----------------------------------------Cross
function Run ()
    
while 1 do 
     Wait (3)
        if Objective1 == 1 and (GetNUnitsInArea ( 0, 'Town', 0) > 0 ) then
         Cmd (3, 7000, 100, 2703, 4553 );
         QCmd (3, 7000, 300, 2115, 1307 );
         Cmd (3, 7001, 100, 2703, 4553 );
         QCmd (3, 7001, 300, 2115, 1307 );
         Cmd (3, 7002, 100, 2703, 4553 );
         QCmd (3, 7002, 300, 2115, 1307 );
         Cmd (3, 7003, 100, 2703, 4553 );
         QCmd (3, 7003, 300, 2115, 1307 );
         Cmd (3, 8000, 100, 2703, 4553 );
         QCmd (3, 8000, 300, 2115, 1307 );
         Cmd (3, 8001, 100, 2703, 4553 );
         QCmd (3, 8001, 300, 2115, 1307 );
         Cmd (3, 8002, 100, 2703, 4553 );
         QCmd (3, 8002, 300, 2115, 1307 );
         --Cmd (3, 7100, 100, 2703, 4553 );
         --QCmd (3, 7100, 300, 2115, 1307 );
         --Cmd (3, 7101, 100, 2703, 4553 );
         --QCmd (3, 7101, 300, 2115, 1307 );
         --Cmd (3, 7102, 100, 2703, 4553 );
         --QCmd (3, 7102, 300, 2115, 1307 );
         --Cmd (3, 7103, 100, 2703, 4553 );
         --QCmd (3, 7103, 300, 2115, 1307 );
         Cmd (3, 8100, 100, 2703, 4553 );
         QCmd (3, 8100, 300, 2115, 1307 );
         Cmd (3, 8101, 100, 2703, 4553 );
         QCmd (3, 8101, 300, 2115, 1307 );
         Cmd (3, 8102, 100, 2703, 4553 );
         QCmd (3, 8102, 300, 2115, 1307 );
         break;
        end;
    end;
end;
------------------------------------------Attack on player
function Attack1 ()

    while 1 do
        Wait ( 60+Random (60) ) ;
        if Objective1 == 0 and x1 < 30 then
        LandReinforcementFromMap( 1, "E1", 0, 11000 );
        x1 = x1+1;
        Wait ( 1 );
        Cmd (3, 11000, 100, 1132, 8518 );
        QCmd (3, 11000, 100, 1511, 6719 );
        QCmd (3, 11000, 100, 2692, 4513 );
        QCmd (3, 11000, 100, 3590, 4174 );
        QCmd (3, 11000, 100, 4164, 2408 );
        QCmd (3, 11000, 100, 5620, 706 );
        QCmd (3, 11000, 100, 6866, 931 );
        QCmd (3, 11000, 100, 9520, 3461 );
        QCmd (3, 11000, 300, 10516, 7013 );
        break;
        end;
    end;
end;
----------------------------------------2
function Attack2 () 

    while 1 do
        Wait (90+Random (120) );
        if Objective1 == 0 and x2 < 30 then 
        LandReinforcementFromMap( 1, "E2", 0, 12000 );
        x2 = x2+1;
        Wait ( 1 );
        Cmd (3, 12000, 100, 1132, 8518);
        QCmd (3, 12000, 100, 1511, 6719);
        QCmd (3, 12000, 100, 2692, 4513);
        QCmd (3, 12000, 100, 7248, 7221);
        QCmd (3, 12000, 300, 10516, 7013);
        break;
        end;
    end;
end;
-----------------------------------------3
--function Attack3 ()

--    while 1 do
--    Wait (120+Random (180) );
--    if Objective1 == 0 and x3 < 30 then
--        LandReinforcementFromMap( 1, "E3", 0, 13000 );
--        x3 = x3+1;
--        Wait ( 1 );
--        Cmd (3, 13000, 100, 4677, 10101);
--        QCmd (3, 13000, 100, 5601, 10022);
--        QCmd (3, 13000, 100, 6496, 7972);
--        QCmd (3, 13000, 300, 10897, 6613);
--        Wait (20);
--		break;
--		end;
--	end;
--end;
------------------------------------Bridge defence
function Defense2 ()

    while 1 do  
        Wait (50+Random (20) );
        if ( GetNScriptUnitsInArea ( 14000, "B",0 ) < 1 ) and Objective0 == 0 and x4 < 10 then
        Wait (5);
        LandReinforcementFromMap( 1, "D2", 0, 14000 );
        x4 = x4+1;
        Wait (1);
        Cmd (3, 14000, 100, 1160, 8149 );
        QCmd (3, 14000, 100, 1972, 5856 );
        QCmd (3, 14000, 100, 2761, 4588 );
        QCmd (3, 14000, 300, 6000, 6510 );
        QCmd (8, 14000, 50, 6919, 7062 );
        --QCmd (45, 14000, 300, 6000,6510);
        end;
    end;
end;
-------------------------------------3
function Defense3 ()

    while 1 do  
        Wait (50+Random (20) )
        if ( GetNScriptUnitsInArea ( 15000, "B",0 ) < 1 ) and Objective0 == 0 and x5 < 10 then
        Wait (5);
        LandReinforcementFromMap( 1, "D3", 0, 15000 );
        x5 = x5+1;
        Wait (1);
        Cmd (3, 15000, 100, 1634, 10611 );
        QCmd (8, 15000, 50, 5261, 10053 );
        --QCmd (45, 15000, 300, 4643, 10108 );
        end;
    end;
end;
-----------------------------------town bombardment
--function Bombers1 ()
--  while 1 do
--      Wait (10)
--      if Objective1 == 0 and ( GetNUnitsInScriptGroup ( 19000, 2 ) < 1 ) and y1 < 1 then
--     Wait (15);
--         LandReinforcementFromMap( 2, "Bombers", 3, 19000)
--        y1 = y1+1
--         Cmd ( 0, 19000, 400, 6791, 7156 );
--         end;
--    end;
--end;

function Bombers11 ()
  while 1 do
      Wait (1)
      if Objective1 == 0 and ( GetNUnitsInScriptGroup ( 19001, 2 ) < 1 ) and y11 < 1 then
      Wait (4);
         LandReinforcementFromMap( 2, "Bombers", 3, 19001)
         y11 = y11+1
         Cmd ( 0, 19001, 300, 7145, 7616 );
        end;
    end;
end;

function Bombers111 ()
  while 1 do
      Wait (1)
      if Objective1 == 0 and ( GetNUnitsInScriptGroup ( 19002, 2 ) < 1 ) and y111 < 1 then
      Wait (9);
         LandReinforcementFromMap( 2, "Bombers", 3, 19002)
         y111 = y111+1
         Cmd ( 0, 19002, 300, 6341, 7127 );
        end;
    end;
end;
    
function Bombers2 ()
while 1 do
      Wait (3)
      if Objective1 == 1 and ( GetNUnitsInScriptGroup ( 31000, 2 ) < 1 ) and ( GetNUnitsInArea ( 0, "Town", 0 )> 1 )  then
         Wait (1)
         LandReinforcementFromMap( 0, "Bombers", 0, 31000)
         Cmd ( 0, 31000, 100, 1191, 789 );
         break;
        end;
    end;
end;

--function Bombers3 ()
--while 1 do
--      Wait (5)
--      if Objective0 == 1 and ( GetNUnitsInArea ( 0, "Town", 0 )> 1 )  then 
--         Wait (1)
--         LandReinforcementFromMap( 2, "Bombers", 3, 33000)
--         Cmd ( 0, 33000, 500, 2719, 1119 );
--         break;
--        end;
--    end;
--end;
    
function Recon ()
while 1 do
      Wait (1)
      if ( GetNUnitsInScriptGroup ( 777, 0 ) < 1 ) and  ( GetNUnitsInScriptGroup ( 676, 1 ) < 1 ) and
	 ( GetNUnitsInScriptGroup ( 677, 1 ) < 1 ) and ( GetNUnitsInScriptGroup ( 678, 1 ) < 1 ) and ( GetReinforcementCallsLeft( 0 ) > 0 ) then
          LandReinforcementFromMap( 0, "Recon", 0, 777)
          StartThread ( Step0 );
        end;
    end;
end;

function Step0 ()

while 1 do 
     Cmd ( 0, 777, 100, 6753, 7162 );
     QCmd ( 0, 777, 100, 8608, 3008 );
     QCmd ( 0, 777, 100, 2733, 2107 );
     QCmd ( 0, 777, 100, 1909, 9894 );
     QCmd ( 0, 777, 100, 6753, 7162 );
     QCmd ( 0, 777, 100, 8608, 3008 );
     QCmd ( 0, 777, 100, 2733, 2107 );
     QCmd ( 0, 777, 100, 1909, 9894 );
     QCmd ( 0, 777, 100, 6753, 7162 );
     QCmd ( 0, 777, 100, 8608, 3008 );
     QCmd ( 0, 777, 100, 2733, 2107 );
     QCmd ( 0, 777, 100, 1909, 9894 );
     QCmd ( 0, 777, 100, 6753, 7162 );
     QCmd ( 0, 777, 100, 8608, 3008 );
     QCmd ( 0, 777, 100, 2733, 2107 );
     QCmd ( 0, 777, 100, 1909, 9894 );
     break;
    end;
end;
-----------------------------------------Tank combat

function Tanks1 ()
while 1 do 
      Wait ( 1 )
      if ( GetNScriptUnitsInArea ( 7000, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7001, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7002, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7003, "Go",0 ) > 0) then
         Wait ( 1 );
         QCmd (3, 887, 300, 8532, 3798);
         break;
        end;
    end;
end;

function Tanks2 ()
while 1 do 
      Wait ( 1 )
      if ( GetNScriptUnitsInArea ( 7000, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7001, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7002, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7003, "Go",0 ) > 0) then
         Wait ( 1 );
         QCmd (3, 888, 300, 8815, 4023);
         break;
        end;
    end;
end;

function Tanks3 ()
while 1 do 
      Wait ( 1 )
      if ( GetNScriptUnitsInArea ( 7000, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7001, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7002, "Go",0 ) > 0) or ( GetNScriptUnitsInArea ( 7003, "Go",0 ) > 0) then
         Wait ( 1 );
         QCmd (3, 889, 300, 9371, 4449);
         break;
        end;
    end;
end;
    
------------------------------------river forcing (Objective0)

function Bridge ()
  while 1 do
     Wait (1);
     if (( GetNUnitsInArea ( 0, "B1", 0 ) > 0 ) ) or 
     (( GetNUnitsInArea ( 0, "B2", 0 ) > 0 ) ) or
     (( GetNUnitsInArea ( 0, "B3", 0 ) > 0 ) ) then
     Wait (1);
     CompleteObjective( 0 );
     Objective0 = 1;
     Wait (3);
     GiveObjective (1);
     break;
     end;
   end;
end;

------------------------------------warehouse (Objective1)

function  Key_Building ()

while 1 do
    Wait (1)
        if ( GetNUnitsInScriptGroup ( 1777, 0 ) > 0 ) then
          Wait (1);
          CompleteObjective( 1 );
          Objective1 = 1;
          Wait (3);
          GiveObjective( 2 );
          Wait (5);
          LandReinforcementFromMap( 0, "Bonus", 1, 5555 );
          Cmd (3, 5555, 50, 1192, 10669);
          QCmd (3, 5555, 100, 1125, 9318);
          break;
        end;
    end;
end;
------------------------------------town (Objective2)

function Town ()
  while 1 do 
     Wait (2);
     if  ( GetNUnitsInArea ( 1, "Victory", 0 ) < 1 ) then
     Wait (1);
     CompleteObjective( 2 );
     Objective2 = 1
     break;
     end;
    end;
end;
--------------------------------------Fighters

function Fighters1 ()
    while 1 do
     Wait (5)
        if Objective0 == 1 then 
          Wait (5)
          LandReinforcementFromMap (1, "Fighters", 1, 676)
          Cmd (3, 676, 500, 2760, 5430)
          break;
        end;
    end;
end;

function Fighters2 ()
    while 1 do
     Wait (5)
        if Objective0 == 1 then
          Wait (180)
          LandReinforcementFromMap (1, "Fighters", 1, 677)
          Cmd (3, 677, 500, 2327, 9370)
          break;
        end;
    end;
end;


function Fighters3 ()
    while 1 do
     Wait (5)
     if Objective1 == 1 then
         Wait (5)
         LandReinforcementFromMap (1, "Fighters", 1, 678)
         Cmd (3, 678, 500, 3888, 2362)
         break;
        end;
    end;
end;
--------------------------------------Start thread

GiveObjective (0);
StartThread( Caput );
StartThread( Victory );
StartThread (Run );
StartThread ( Repair );
--StartThread( Run1 );
--StartThread( Run2 )
StartThread( Allies1A );
StartThread( Allies1B );
StartThread( Allies2A );
StartThread( Allies2AA );
StartThread( Allies2B );
StartThread( Allies2BB )
StartThread( Allies2C );
StartThread( Allies2CC );
StartThread( Allies03A );
StartThread ( Allies3A );
--StartThread ( Allies3AA );
StartThread( Allies03B );
StartThread ( Allies3B );
--StartThread ( Allies3BB );
StartThread( Allies03C );
StartThread ( Allies3C );
--StartThread ( Allies3CC );
StartThread( Allies03D );
StartThread ( Allies3D );
--StartThread ( Allies3DD );
StartThread ( Allies4A );
StartThread ( Allies4AA );
StartThread ( Allies4B );
StartThread ( Allies4BB );
StartThread ( Allies4C );
StartThread ( Allies4CC );
StartThread( Attack1 );
--StartThread( Moove );
StartThread( Attack2 );
--StartThread( Attack3 );
StartThread ( Defense2 );
StartThread ( Defense3 );
StartThread( Bridge );
StartThread( Key_Building);
StartThread( Town );
--StartThread ( Bombers1 );
StartThread ( Bombers2 );
StartThread ( Bombers11 );
StartThread ( Bombers111 );
--StartThread ( Bombers3 );
StartThread ( Recon );
StartThread ( Tanks1 );
StartThread ( Tanks2 );
StartThread ( Tanks3 );
StartThread ( Allies2_1A );
StartThread ( Allies2_1B );
StartThread ( Allies2_1C );
StartThread (Allies2_1A_Go);
StartThread (Allies2_1B_Go);
StartThread (Allies2_1C_Go);
StartThread (Fighters1);
StartThread (Fighters2);
StartThread (Fighters3);
 




