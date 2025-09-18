-------------------------------------------------Defeat
function Defeat()
	while 1 do
        Wait (1);
		if  (((GetNUnitsInParty (0) <= 0) and (GetReinforcementCallsLeft (0) == 0)) or 
			 ((GetNUnitsInArea (1, "Base", 0) > 0) and (GetNUnitsInArea (0, "Base", 0) < 1))) then
            Wait(10);
			Trace("Defeat");
			Win (1);
			return 1;
		end;
		Wait (2);
	end;
end;
-------------------------------------------------Win
function Winner()
	while 1 do
		Wait (1);
		if ((GetNUnitsInScriptGroup (280) <1) and (GetNUnitsInArea (1, "Japan_Base", 0 ) < 1) and
			(GetNUnitsInArea (0, "Base", 0) > 0) and (GetNUnitsInArea (1, "Base", 0) < 1)) then
			Wait (3);
			CompleteObjective (2);
			Wait (5);
			Win (0);
			return 1;
		end;
		Wait (1);
	end;
end;
-------------------------------------------------CompleteObjective0
function CompleteObjective0()
	while 1 do
		Wait (1);
        if (GetNUnitsInScriptGroup (280) <1) then
            Wait(1);
			CompleteObjective (0);
			Wait (5+Random (10));
			Cmd(ACT_SWARM, 55, 20, "Pat3");
			break;
		end;
		Wait (1);	
	end;
end;
-------------------------------------------------GiveObjective1
function GiveObjective1()
	while 1 do
		Wait (1);
        if  ((GetNUnitsInArea (0, "Japan_Base", 0) > 0) or
			(GetIGlobalVar( "temp.objective.0", 0 ) == 2)) then
            Wait (1);
			GiveObjective (1);
			break;
		end;
		Wait (1);	
	end;
end;
------------------------------------------------GiveObjective2
--function GiveObjective2()
--while 1 do
--		Wait (1);
--        if  ((GetNUnitsInArea (1, "Base", 0) > 0) and
--			(GetNUnitsInArea (0, "Base", 0) < 1)) then
--           Wait (1);
--			GiveObjective (2);
--			StartThread (CompleteObjective2);
--			break;
--		end;
--		Wait (1);	
--	end;
--end;
------------------------------------------------CompleteObjective2
--function CompleteObjective2()
--while 1 do
--		Wait (1);
--       if  ((GetNUnitsInArea (0, "Base", 0) > 0) and
--			(GetNUnitsInArea (1, "Base", 0) < 1)) then
--           Wait (1);
--			CompleteObjective (2);
--			StartThread (GiveObjective2);
--			break;
--		end;
--		Wait (1);	
--	end;
--end;	
------------------------------------------------NorthLanding
function NorthLand()
	while 1 do
		Wait (1);
		if (GetIGlobalVar( "temp.objective.0", 0 ) == 2) then
			Wait (2);
			LandReinforcementFromMap (0, "North", 0, 240);
			break;
		end;
	end;
end;
--------------------------------------------------CompleteObjective1
function CompleteObjective1()
	while 1 do
		Wait (1);
        if (GetNUnitsInArea (1, "Japan_Base", 0 ) < 1) then
            Wait (10);
			CompleteObjective (1);
			break;
		end;
		Wait (2);
	end;
end;
--------------------------------------------------BoatsLost
function BoatsLost()
	while 1 do
		Wait (1);
		if (GetNUnitsInScriptGroup (15) <1) then
			Wait (2);
		    LandReinforcementFromMap (0, "Boats", 2, 16);
		    StartThread (BoatsLost2);
			break;
		end;
		Wait (2);
	end;
end;
--------------------------------------------------BoatsLost2
function BoatsLost2()
	while 1 do
		Wait (1);
		if (GetNUnitsInScriptGroup (16) <1) then
			Wait (2);
		    LandReinforcementFromMap (0, "Boats", 2, 17);
		    break;
		end;
		Wait (2);
	end;
end;
--------------------------------------------------------SeaPatrol_1
function SeaPatrol1()
	while 1 do
		Wait (1);
		Cmd(ACT_SWARM, 72, 50, GetScriptAreaParams("Pat2"));
		QCmd(ACT_SWARM, 72, 50, GetScriptAreaParams("Pat3"));
		QCmd(ACT_SWARM, 72, 50, GetScriptAreaParams("Pat4"));
		QCmd(ACT_SWARM, 72, 50, GetScriptAreaParams("Pat1"));
		Wait (20);
	end;
end;
--------------------------------------------------------SeaPatrol_2
function SeaPatrol2()
	while 1 do
		Wait (1);
		Cmd(ACT_SWARM, 73, 50, GetScriptAreaParams("Pat2"));
		QCmd(ACT_SWARM, 73, 50, GetScriptAreaParams("Pat3"));
		QCmd(ACT_SWARM, 73, 50, GetScriptAreaParams("Pat4"));
		QCmd(ACT_SWARM, 73, 50, GetScriptAreaParams("Pat1"));
		Wait (20);
	end;
end;
--------------------------------------------------------SeaPatrol_3
function SeaPatrol3()
	while 1 do
		Wait (1);
		Cmd(ACT_SWARM, 74, 50, GetScriptAreaParams("Pat1"));
		QCmd(ACT_SWARM, 74, 50, GetScriptAreaParams("Pat2"));
		QCmd(ACT_SWARM, 74, 50, GetScriptAreaParams("Pat3"));
		QCmd(ACT_SWARM, 74, 50, GetScriptAreaParams("Pat4"));
		Wait (20);
	end;
end;
-------------------------------------------------------JapanAtack
function JapAtack()
	while 1 do
		Wait (180 + Random(60));
		if (GetNUnitsInArea (1, "Japan_Base", 0) > 0) then
		LandReinforcementFromMap (1, "Infantry", 0, 27);
		Wait (2);
		Cmd(ACT_SWARM, 27, 50, GetScriptAreaParams ("Base"));
		LandReinforcementFromMap (1, "Infantry", 0, 28);
		Wait (2);
		Cmd(ACT_SWARM, 28, 50, GetScriptAreaParams ("Base"));
		Wait (35 + Random(100));
		else break;
		end;
	end;
end;
-------------------------------------------------------CounterAtack1
function CounterA1()
	while 1 do
		Wait (240 + Random(240));
		LandReinforcementFromMap (1, "Counter", 1, 201);
		Wait (1);
		Cmd(ACT_SWARM, 201, 50, GetScriptAreaParams ("Base"));
		Wait (5);
		LandReinforcementFromMap (1, "Counter", 1, 202);
		Wait (1);
		Cmd(ACT_SWARM, 202, 50, GetScriptAreaParams ("Base"));
		Wait (5);
		LandReinforcementFromMap (1, "Counter", 1, 203);
		Wait (1);
		Cmd(ACT_SWARM, 203, 50, GetScriptAreaParams ("Base"));
		Wait (5);
		LandReinforcementFromMap (1, "Counter", 1, 204);
		Wait (1);
		Cmd(ACT_SWARM, 204, 50, GetScriptAreaParams ("Base"));
		Wait (2);
		break;
	end;
end;
-------------------------------------------------------GAP_Atack
function GapAtack1()
	while 1 do
		Wait (1);
		if (GetIGlobalVar( "temp.objective.0", 0 ) == 2) then
			Wait (1);
			LandReinforcementFromMap (1, "Planes", 0, 221);
			Wait (1);
			Cmd(ACT_SWARM, 221, 160, GetScriptAreaParams ("Sea_Zone"));
			Wait (120);
			LandReinforcementFromMap (1, "Planes", 0, 241);
			Cmd(ACT_SWARM, 241, 160, GetScriptAreaParams ("Base"));
			Wait (1);
		break;
		end;
	end;
end;
---------------------------------------------------Main
Wait(2);
GiveObjective (2);
Wait (10);
GiveObjective (0);
StartThread (Defeat); --
StartThread (Winner); --
StartThread (CompleteObjective0); -- 
StartThread (GiveObjective1); --
StartThread (CompleteObjective1); --
--StartThread (GiveObjective2);
StartThread (BoatsLost); --
StartThread (SeaPatrol1);
StartThread (SeaPatrol2);
StartThread (SeaPatrol3);
StartThread (NorthLand); --
StartThread (CounterA1);
StartThread (GapAtack1);
StartThread (JapAtack);