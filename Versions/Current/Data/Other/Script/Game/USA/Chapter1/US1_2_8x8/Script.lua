---------------------------------------------------------Variabales
sid = 0;
did = 0;
jc = 0;
jc1 = 0;
---------------------------------------------------------Winning
function Winning()
	while 1 do
	Wait (1);
		if  (GetNUnitsInScriptGroup (103) == 0) and 
			(GetNUnitsInScriptGroup (102) == 0) and 
			(GetNUnitsInScriptGroup (101) == 0) and
			(sid == 1) then
			Wait (3);
			Win (0);
		end;
	end;
end;

---------------------------------------------------------Warehouses captured
function Captured()
	while 1 do
	Wait (1);
		if  ( ((GetPassangers ( GetObjectList (103), 1 )) and 
			  (GetNUnitsInArea (1, "Base_11", 0) > 0))  or
			  ((GetPassangers ( GetObjectList (102), 1 )) and 
			  (GetNUnitsInArea (1, "Base_22", 0) > 0)) or
			  ((GetPassangers ( GetObjectList (101), 1 )) and
			  (GetNUnitsInArea (1, "Base_33", 0) > 0))) then
			Wait (2);
			FailObjective (0);
			Wait (2);
			Win (1);
		end;
	end;
end;

---------------------------------------------------------Demolition Way
function Demway()
	while 1 do
		Wait (5);
		if (GetNUnitsInScriptGroup (999) == 1) then
		Cmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_1"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_2"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("base3"));
		QCmd (ACT_ENTER, 999, 103);
		while did == 0 do
			Wait (1);
		end;
		Cmd (ACT_LEAVE, 999 , 50, GetScriptAreaParams ("base3"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_2"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_3"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_4"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_5"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_6"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("base2"));
		QCmd (ACT_ENTER, 999, 102);
		while did == 1 do
			Wait (1);
		end;
		QCmd (ACT_LEAVE, 999 , 50, GetScriptAreaParams ("base2"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_6"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_7"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_8"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_9"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_10"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_11"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("base1"));
		QCmd (ACT_ENTER, 999, 101);
		while did == 2 do
			Wait (1);
		end;
		QCmd (ACT_LEAVE, 999 , 50, GetScriptAreaParams ("base1"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_11"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_12"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_13"));
		QCmd (ACT_MOVE, 999, 70, GetScriptAreaParams ("Step_14"));
		Wait (1600);
		else
		break;
		end;
	end;
end;
---------------------------------------------------------Demolition's Death
function Demdead()
	while 1 do
	Wait (1);
		if ((GetNUnitsInScriptGroup (999) == 0) and (sid == 0)) then
			Wait (4);
			FailObjective (1);
			Wait (3);
			Win (1);
			break;
		end;
	end;
end;
---------------------------------------------------------Complete Objective0
function Complete0()
	while 1 do
	Wait (1);
		if  (GetNUnitsInScriptGroup (103) == 0) and 
			(GetNUnitsInScriptGroup (102) == 0) and 
			(GetNUnitsInScriptGroup (101) == 0) then
			Wait (3);
			CompleteObjective (0);
			break;
		end;
	end;
end;
---------------------------------------------------------Complete Objective1
function Complete1()
	while 1 do
	Wait (1);
		if  (GetNScriptUnitsInArea (999, "Step_14", 0) > 0) then
			Wait (1);
			sid = sid +1;
			Wait (2);
			RemoveScriptGroup (999);
			CompleteObjective (1);
			break;
		end;
	end;
end;
---------------------------------------------------------Blow up 1
function Blow1()
	while 1 do
	Wait (1);
		if (GetPassangers ( GetObjectList (103), 2 )) then
		Wait (8);
		did = did +1;
		Wait (6);
		DamageScriptObject (103, 0);
		break;
		end;
	end;
end;
---------------------------------------------------------Blow up 2
function Blow2()
	while 1 do
	Wait (1);
		if (GetPassangers ( GetObjectList (102), 2 )) then
		Wait (8);
		did = did +1;
		Wait (6);
		DamageScriptObject (102, 0);
		break;
		end;
	end;
end;
---------------------------------------------------------Blow up 3
function Blow3()
	while 1 do
	Wait (1);
		if (GetPassangers ( GetObjectList (101), 2 )) then
		Wait (8);
		did = did +1;
		Wait (6);
		DamageScriptObject (101, 0);
		break;
		end;
	end;
end;
--------------------------------------------------------Japan 1
function Jap1()
	while jc == 0 do
	Wait (1);
		LandReinforcementFromMap (1, "Japan", 0, 5000);
		Cmd(ACT_SWARM, 5000, 100, GetScriptAreaParams ("base1"));
		Wait (35);
	end;
end;
--------------------------------------------------------Japan 2
function Jap2()
	while 1 do
	Wait (1);
		LandReinforcementFromMap (1, "Japan", 1, 6000);
		Cmd(ACT_SWARM, 6000, 100, GetScriptAreaParams ("base1"));
		Wait (40);
	end;
end;
--------------------------------------------------------Japan 3
function Jap3()
	while jc1 == 0 do
	Wait (1);
		LandReinforcementFromMap (1, "Japan", 2, 7000);
		Cmd(ACT_SWARM, 7000, 100, GetScriptAreaParams ("base2"));
		Wait (35);
	end;
end;
--------------------------------------------------------Japan 4
function Jap4()
	while 1 do
	Wait (1);
		LandReinforcementFromMap (1, "Japan", 3, 8000);
		Cmd(ACT_SWARM, 8000, 100, GetScriptAreaParams ("base2"));
		Wait (40);
	end;
end;
-------------------------------------------------------Japan Capture1
function JapCap1()
	while 1 do
	Wait (1);
		if ((GetNScriptUnitsInArea (5000, "Base_11", 0) > 0) and 
			(GetNUnitsInArea (1, "Step_14", 0) > 0)) then
			jc = jc + 1;
			Cmd(ACT_ENTER, 5000, 101);
			Wait (15);
		end;
	end;
end;
-------------------------------------------------------Japan Capture2
function JapCap2()
	while 1 do
	Wait (1);
		if ((GetNScriptUnitsInArea (7000, "Base_22", 0) > 0) and 
			(GetNUnitsInArea (1, "Step_14", 0) > 0)) then
			jc1 = jc1 + 1;
			Cmd(ACT_ENTER, 7000, 102);
			Wait (15);
		end;
	end;
end;

Wait (1);
GiveObjective (0);
Wait (2);
GiveObjective (1);
StartThread (Winning);
StartThread (Captured);
StartThread (Demway);
StartThread (Demdead);
StartThread (Complete0);
StartThread (Complete1);
StartThread (Blow1);
StartThread (Blow2);
StartThread (Blow3);
StartThread (JapCap1);
StartThread (JapCap2);
Wait (40);
StartThread (Jap3);
StartThread (Jap4);
Wait (10);
StartThread (Jap1);
StartThread (Jap2);
