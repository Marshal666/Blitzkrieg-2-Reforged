x = 0
y = 0
s = 0


function Victory ()
    while 1 do 
      Wait (3)
      if y == 2 and  (GetNUnitsInScriptGroup (100700) < 1) and (GetNUnitsInScriptGroup (100701) < 1) and (GetNUnitsInScriptGroup (100702) < 1) and
      (GetNUnitsInScriptGroup (100703) < 1) and (GetNUnitsInScriptGroup (100704) < 1) then
          Wait (5)
          CompleteObjective(0)
          Wait (10)
          Win (0)
          break;
        end;
    end;
end;

function Caput ()
    while 1 do
      Wait (3) 
      if (GetNUnitsInArea (1, "Town", 0) > 0) and  (GetNUnitsInArea (0, "Town", 0) < 1) and (GetNUnitsInArea (2, "Town", 0) < 1) then
      Wait (10)
      Win (1)
      break;
      end;
    end;
end;


function Boom ()
	Wait (1)
	DamageScriptObject (10050, 100000);
end;

function Secret ()
      while 1 do
      Wait (3)
        if (GetNUnitsInScriptGroup (10051) < 1) and (GetNUnitsInArea (0, "Bridge", 0) > 0) then  
         Wait (5)
         CompleteObjective(1)
         s = 1
         break;
        end;
    end;
end;

function Surprise ()
    while 1 do
       Wait (300)
        if s == 0 then
         DamageScriptObject (10050, -100000)
         Wait (10)
         LandReinforcementFromMap (1, "Attack2a", 5, 100111);
         ChangeFormation (3, 100111);
         Cmd (0, 100111, 50, 940, 2310);
         QCmd (3, 100111, 200, 1638, 696);
         QCmd (3, 100111, 200, 3746, 1183);
         QCmd (3, 100111, 200, 4821, 2949);
         QCmd (3, 100111, 200, 4603, 3761);
         break;
        end;
    end;
end;
    
    
--------------------------------1
function Wave1A ()
	Wait (60)
	LandReinforcementFromMap (1, "Attack1", 0, 100100);
	ChangeFormation (3, 100100);
	Cmd (3, 100100, 300, 2802, 2654);
	QCmd (3, 100100, 300, 4797, 2543);
end;


function Wave1B ()
	Wait (60)
	LandReinforcementFromMap (1, "Attack1", 1, 100101);
	ChangeFormation (100101, 3);
	Cmd (3, 100101, 300, 3731, 1129);
end;


function Wave1C ()
	Wait (60)
	LandReinforcementFromMap (1, "Attack1", 2, 100102);
	ChangeFormation (100102, 3);
	Cmd (3, 100102, 300, 4916, 1281);
end;


function Wave1D ()
	Wait (60)
	LandReinforcementFromMap (1, "Attack1", 3, 100103);
	ChangeFormation (100103, 3);
	Cmd (3, 100103, 300, 5461, 2575);
end;


function Wave1E ()
	Wait (60)
	LandReinforcementFromMap (1, "Attack1", 4, 100104);
	ChangeFormation (100104, 3);
	Cmd (3, 100104, 300, 6209, 1561);
end;
--------------------------------------2

function Wave2A ()
	Wait (100)
	LandReinforcementFromMap (1, "Attack2a", 0, 100200);
	ChangeFormation (100200, 3);
	Cmd (3, 100200, 300, 2802, 2654);
	QCmd (3, 100200, 300, 4797, 2543);
end;


function Wave2B ()
	Wait (100)
	LandReinforcementFromMap (1, "Attack2b", 1, 100201);
	ChangeFormation (100201, 3);
	Cmd (3, 100201, 300, 3731, 1129);
end;

function Wave2C ()
	Wait (100)
	LandReinforcementFromMap (1, "Attack2a", 2, 100202);
	ChangeFormation (100202, 3);
	Cmd (3, 100202, 300, 4916, 1281);
end;


function Wave2D ()
	Wait (100)
	LandReinforcementFromMap (1, "Attack2b", 3, 100203);
	ChangeFormation (100203, 3);
	Cmd (3, 100203, 300, 5461, 2575);
end;


function Wave2E ()
	Wait (100)
	LandReinforcementFromMap (1, "Attack2a", 4, 100204);
	ChangeFormation (100204, 3);
	Cmd (3, 100204, 300, 6209, 1561);
	SetIGlobalVar( "temp.general_reinforcement", 1 );
end;
--------------------------------------3
function Wave3A ()
	Wait (150)
	LandReinforcementFromMap (1, "Attack3a", 0, 100300);
	ChangeFormation (100300, 3);
	Cmd (3, 100300, 300, 2802, 2654);
	QCmd (3, 100300, 300, 4797, 2543);
end;


function Wave3B ()
	Wait (150)
	LandReinforcementFromMap (1, "Attack3a", 1, 100301);
	ChangeFormation (100301, 3);
	Cmd (3, 100301, 300, 3731, 1129);
end;

function Wave3C ()
	Wait (150)
	LandReinforcementFromMap (1, "Attack3a", 2, 100302);
	ChangeFormation (100302, 3);
	Cmd (3, 100302, 300, 4916, 1281);
end;


function Wave3D ()
	Wait (200)
	LandReinforcementFromMap (1, "Attack3b", 3, 100303);
	ChangeFormation (100303, 3);
	Cmd (3, 100303, 300, 5461, 2575);
end;


function Wave3E ()
	Wait (200)
	LandReinforcementFromMap (1, "Attack3b", 4, 100304);
	ChangeFormation (100304, 3);
	Cmd (3, 100304, 300, 6209, 1561);
end;

--------------------------------------4
function Wave4A ()
	Wait (250)
	LandReinforcementFromMap (1, "Attack4b", 0, 100400);
	ChangeFormation (100400, 3);
	Cmd (3, 100400, 300, 2802, 2654);
	QCmd (3, 100400, 300, 4797, 2543);
end;


function Wave4B ()
	Wait (250)
	LandReinforcementFromMap (1, "Attack4b", 1, 100401);
	ChangeFormation (100401, 3);
	Cmd (3, 100401, 300, 3731, 1129);
end;

function Wave4C ()
	Wait (250)
	LandReinforcementFromMap (1, "Attack4b", 2, 100402);
	ChangeFormation (100402, 3);
	Cmd (3, 100402, 300, 4916, 1281);
end;


function Wave4D ()
	Wait (300)
	LandReinforcementFromMap (1, "Attack4a", 3, 100403);
	ChangeFormation (100403, 3);
	Cmd (3, 100403, 300, 5461, 2575);
end;


function Wave4E ()
	Wait (300)
	LandReinforcementFromMap (1, "Attack4a", 4, 100404);
	ChangeFormation (100404, 3);
	Cmd (3, 100404, 300, 6209, 1561);
end;
--------------------------------------5
function Wave5A ()
	Wait (350)
	LandReinforcementFromMap (1, "Attack4a", 0, 100500);
	ChangeFormation (100500, 3);
	Cmd (3, 100500, 300, 2802, 2654);
	QCmd (3, 100500, 300, 4797, 2543);
end;


function Wave5B ()
	Wait (400)
	LandReinforcementFromMap (1, "Attack4b", 1, 100501);
	ChangeFormation (100501, 3);
	Cmd (3, 100501, 300, 3731, 1129);
end;

function Wave5C ()
	Wait (350)
	LandReinforcementFromMap (1, "Attack4a", 2, 100502);
	ChangeFormation (100502, 3);
	Cmd (3, 100502, 300, 4916, 1281);
end;


function Wave5D ()
	Wait (400)
	LandReinforcementFromMap (1, "Attack4b", 3, 100503);
	ChangeFormation (100503, 3);
	Cmd (3, 100503, 300, 5461, 2575);
end;


function Wave5E ()
	Wait (350)
	LandReinforcementFromMap (1, "Attack4a", 4, 100504);
	ChangeFormation (100504, 3);
	Cmd (3, 100504, 300, 6209, 1561);
end;
-----------------------------------------------6
function Wave6A ()
	Wait (450)
	LandReinforcementFromMap (1, "Attack5", 0, 100600);
	ChangeFormation (100600, 3);
	Cmd (3, 100600, 300, 2802, 2654);
	QCmd (3, 100600, 300, 4797, 2543);
end;


function Wave6B ()
	Wait (450)
	LandReinforcementFromMap (1, "Attack5", 1, 100601);
	ChangeFormation (100601, 3);
	Cmd (3, 100601, 300, 3731, 1129);
end;

function Wave6C ()
	Wait (450)
	LandReinforcementFromMap (1, "Attack5", 2, 100602);
	ChangeFormation (100602, 3);
	Cmd (3, 100602, 300, 4916, 1281);
end;


function Wave6D ()
	Wait (450)
	LandReinforcementFromMap (1, "Attack5", 3, 100603);
	ChangeFormation (100603, 3);
	Cmd (3, 100603, 300, 5461, 2575);
end;


function Wave6E ()
	Wait (450)
	LandReinforcementFromMap (1, "Attack5", 4, 100604);
	ChangeFormation (100604, 3);
	Cmd (3, 100604, 300, 6209, 1561);
	y = 1
end;
---------------------------------------------
function Bomb ()
	while 1 do
		Wait (3)
		if x == 1 and (GetNUnitsInScriptGroup (100600)< 2) and (GetNUnitsInScriptGroup (100601)< 2) and (GetNUnitsInScriptGroup (100603)< 2) and
		(GetNUnitsInScriptGroup (100604)< 2) then
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 0, 200100);
		   Cmd (0, 200100, 100, 2575, 3778);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 1, 200200);
		   Cmd (0, 200200, 100, 3693, 4011);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 2, 200300);
		   Cmd (0, 200300, 100, 5245, 4143);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 3, 200400);
		   Cmd (0, 200400, 100, 5297, 4175);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 4, 200500);
		   Cmd (0, 200500, 100, 5625, 3597);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 0, 200600);
		   Cmd (0, 200600, 100, 3013, 3962);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 1, 200700);
		   Cmd (0, 200700, 100, 4432, 4298);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 2, 200800);
		   Cmd (0, 200800, 100, 6470, 4273);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 3, 200900);
		   Cmd (0, 200900, 100, 3900, 3462);
		   Wait (5)
		   LandReinforcementFromMap (1,"Bombers", 4, 200901);
		   Cmd (0, 200901, 100, 5085, 2933);
		   y = 1
		   break;
	   end;
	end;
end;  
----------------------------------------------------
function Final ()
    while 1 do 
		Wait (5)
		if y == 1 then
			Wait (30)
			LandReinforcementFromMap (1, "Attack6", 0, 100700);
			ChangeFormation (100700, 3);
			Cmd (3, 100700, 300, 2802, 2654);
			QCmd (3, 100700, 300, 4797, 2543);
			QCmd (3, 100700, 300, 4084, 2337);
			Wait(1)
			LandReinforcementFromMap (1, "Attack6", 1, 100701);
			ChangeFormation (100701, 3);
			Cmd (3, 100701, 300, 3731, 1129);
			QCmd (3, 100701, 300, 4731, 3083);
			Wait (1)
			LandReinforcementFromMap (1, "Attack6", 2, 100702);
			ChangeFormation (100702, 3);
			Cmd (3, 100702, 300, 4916, 1281);
			QCmd (3, 100702, 300, 5364, 2518);
			Wait (1)
			LandReinforcementFromMap (1, "Attack6", 3, 100703);
			ChangeFormation (100703, 3);
			Cmd (3, 100703, 300, 5461, 2575);
			QCmd (3, 100703, 300, 4866, 1966);
			Wait (1)
			LandReinforcementFromMap (1, "Attack6", 4, 100704);
			ChangeFormation (100704, 3);
			Cmd (3, 100704, 300, 6209, 1561);
			QCmd (3, 100704, 300, 4795, 2482);
			y = 2
			break;
		end;
    end;
end;
 
function Help ()
    while 1 do
		Wait (5)
		if y > 0 and (GetNUnitsInPlayerUF (0) < 5) then
			Wait (5)
			LandReinforcementFromMap (0, "HeavyMetall1", 0, 100777);
			Cmd (3, 100777, 100, 4480, 3948);
			Wait (5)
			LandReinforcementFromMap (0, "HeavyMetall2", 0, 100778);
			Cmd (3, 100778, 100, 4480, 3948);
			break;
        end;
    end;
end;

function Allies ()
    while 1 do
     Wait (5)
        if y == 0 and (GetNUnitsInArea (0, "Defense", 0))+(GetNUnitsInArea (2, "Defense", 0)) < (GetNUnitsInArea (1, "Defense", 0)) then
         Wait (1)
         LandReinforcementFromMap (2, "Support", 0, 100123)
         ChangeFormation (100123, 3)
         Cmd (3, 100123, 100, 3218, 4437);
         Wait (5)
         LandReinforcementFromMap (2, "Support", 0, 100124)
         ChangeFormation (100124, 3);
         Cmd (3, 100124, 100, 5390, 4557);
         Wait (5)
         break
        end;
    end;
end;


------------------------------------------------------------------
SetIGlobalVar( "temp.general_reinforcement", 0 );

GiveObjective(0)

StartThread (Secret);
--StartThread (Surprise);

StartThread (Victory);
StartThread (Caput);

StartThread (Boom);
--StartThread (Bomb);

StartThread (Wave1A);
StartThread (Wave1B);
StartThread (Wave1C);
StartThread (Wave1D);
StartThread (Wave1E);

StartThread (Wave2A);
StartThread (Wave2B);
StartThread (Wave2C);
StartThread (Wave2D);
StartThread (Wave2E);

StartThread (Wave3A);
StartThread (Wave3B);
StartThread (Wave3C);
StartThread (Wave3D);
StartThread (Wave3E);

StartThread (Wave4A);
StartThread (Wave4B);
StartThread (Wave4C);
StartThread (Wave4D);
StartThread (Wave4E);

StartThread (Wave5A);
StartThread (Wave5B);
StartThread (Wave5C);
StartThread (Wave5D);
StartThread (Wave5E);

StartThread (Wave6A);
StartThread (Wave6B);
StartThread (Wave6C);
StartThread (Wave6D);
StartThread (Wave6E);

StartThread (Final);
StartThread (Help);
StartThread (Allies);