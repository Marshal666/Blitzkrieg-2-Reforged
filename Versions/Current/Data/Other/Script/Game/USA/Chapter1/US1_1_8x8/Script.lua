sid = 10000;
did = 5000;
-----------------------------------------------------Winning
function Winning()
	while 1 do
		Wait (1);
			if (GetGameTime() == 900) then
			CompleteObjective (0);
				if ((GetNUnitsInArea (0, "hqzone", 0) > 0) and 
					(GetNUnitsInArea (1, "hqzone", 0) < 1)) then
				Wait (1);
				CompleteObjective (1);
				Wait (2);
				Win (0);
				return 1;
				end;
			end;
		Wait (1);
	end;
end;
-----------------------------------------------------Defeat
function Defeat()
	while 1 do
		Wait (1);
			if ((GetNUnitsInArea (1, "hqzone", 0) > 0) and 
				(GetNUnitsInArea (0, "hqzone", 0) < 1)) then
				FailObjective (1);
				Wait (2);
				FailObjective (0);
				Win (1);
				return 1;
			end;
		Wait (1);	
	end;
end;
-----------------------------------------------------Japan Atack
function JapanSea()
	Wait (1);
	while 1 do
		Wait (120 + Random (10));
		LandReinforcementFromMap (1, "JapLand", 1, 45);
		Cmd(ACT_MOVE, 45, 50, GetScriptAreaParams ("Sea_ground"));
		StartThread (JapanAtack);
		break;
	end;
end;

function JapanAtack()
	Wait (1);
	while 1 do
	Wait (1);
		if (GetNScriptUnitsInArea (45, "Sea_ground", 0) > 0 ) then
			Wait (5);
			LandReinforcementFromMap (1, "JapAtack", 0, sid);
			Wait (1);
			Cmd(ACT_SWARM, sid, 50, GetScriptAreaParams ("hqzone"));
			Cmd(ACT_MOVE, 45, 50, GetScriptAreaParams ("Sea_exit"));
			StartThread (JapanBack);
			sid = sid + 1;
			break;
		end;
	end;
end;

function JapanBack()
	Wait (1);
	while 1 do
	Wait (1);
		if (GetNScriptUnitsInArea (45, "Sea_exit", 0) > 0) then
			Wait (5);
			RemoveScriptGroup (45);
			StartThread (JapanSea);
			break;
		end;
	end;
end;
-----------------------------------------------------Japan Atack_1
function JapanSea_1()
	Wait (1);
	while 1 do
		Wait (120 + Random (10));
		LandReinforcementFromMap (1, "JapLand", 3, 55);
		Cmd(ACT_MOVE, 55, 50, GetScriptAreaParams ("Sea_ground_1"));
		StartThread (JapanAtack_1);
		break;
	end;
end;

function JapanAtack_1()
	Wait (1);
	while 1 do
	Wait (1);
		if (GetNScriptUnitsInArea (55, "Sea_ground_1", 0) > 0 ) then
			Wait (5);
			LandReinforcementFromMap (1, "JapAtack", 2, did);
			Wait (1);
			Cmd(ACT_SWARM, did, 50, GetScriptAreaParams ("hqzone"));
			Cmd(ACT_MOVE, 55, 50, GetScriptAreaParams ("Sea_exit_1"));
			StartThread (JapanBack_1);
			did = did + 1;
			break;
		end;
	end;
end;

function JapanBack_1()
	Wait (1);
	while 1 do
	Wait (1);
		if (GetNScriptUnitsInArea (55, "Sea_exit_1", 0) > 0) then
			Wait (5);
			RemoveScriptGroup (55);
			StartThread (JapanSea_1);
			break;
		end;
	end;
end;
---------------------------------------------------------


Wait (2);
GiveObjective (0);
Wait (2);
GiveObjective (1);
StartThread (Winning);
StartThread (Defeat);
StartThread (JapanSea);
Wait (60);
StartThread (JapanSea_1);