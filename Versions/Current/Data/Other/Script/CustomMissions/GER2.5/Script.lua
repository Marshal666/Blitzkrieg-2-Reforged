NoReinfLeft = 0;

function TimeToDeath()
	while 1 do 
	Wait(4)
		if (GetGameTime() > 250) then
			StartThread(PanzerGrenaderenAttack);
			break;
		end;
	end;
end;

function PanzerGrenaderenAttack()
	Cmd(ACT_SWARM, 1200, 1500, 3656, 3343);
	Wait(1);
	LandReinforcementFromMap(1, "matildes", 0, 1103);
	Cmd(ACT_SWARM, 1103, 1500, 3523, 2368);
	Wait(20);
	LandReinforcementFromMap(2, "Infantry", 0, 1201);
	Cmd(ACT_SWARM, 1201, 1500, 3656, 3343);
	Wait(20);
	LandReinforcementFromMap(2, "tanks", 0, 1202);
	Cmd(ACT_SWARM, 1202, 1500, 3656, 3343);
	Wait(20);
	LandReinforcementFromMap(2, "tanks", 0, 1203);
	Cmd(ACT_SWARM, 1203, 1500, 3656, 3343);
	Wait(20);
	LandReinforcementFromMap(2, "Infantry", 0, 1204);
	Cmd(ACT_SWARM, 1204, 1500, 3656, 3343);
	Wait(20);
	LandReinforcementFromMap(2, "Infantry", 0, 1205);
	Cmd(ACT_SWARM, 1205, 1500, 3656, 3343);
	Wait(20);
	LandReinforcementFromMap(2, "tanks", 0, 1206);
	Cmd(ACT_SWARM, 1206, 1500, 3656, 3343);
	NoReinfLeft = 1;
end;

function GrantReinforcements()
	while 1 do
	Wait(3);
		if (GetNUnitsInArea(2, "Defence", 0) > 4) then
			StartThread(Grant);
			break;
		end;
	end
end;

function Grant()
	LandReinforcementFromMap(1, "tanks", 0, 1102);
	Cmd(ACT_SWARM, 1102, 1500, 3523, 2368);
end;

function lose()
	while 1 do
        if ((IsSomeUnitInParty(2) == 1 and NoReinfLeft == 1) or (GetNUnitsInParty(0) == 0 and GetReinforcementCallsLeft(0) == 0)) then
				Wait(2);
				Loose(0);
        return 1;
		end;
	Wait(5);
	end;
end;

function win()
	while 1 do
		Wait(2);
		if (GetNUnitsInArea(2, "Defence", 0) > 0 and GetNUnitsInArea(1, "Defence", 0) < 1) then
			Win(0);
		end;
	end;
end;

function CompleteObjective0()
	while 1 do
		Wait (2);
        if (GetNUnitsInScriptGroup(1100, 1) < 1) then
            Wait (1);
			CompleteObjective (0);
			break;
		end;
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait (2);
        if (GetNUnitsInScriptGroup( 1101 ) == 0) then
            Wait (1);
			CompleteObjective (1);
			break;
		end;
	end;
end;

GiveObjective(0);
GiveObjective(1);
StartThread(CompleteObjective0);
StartThread(CompleteObjective1);
StartThread(TimeToDeath);
StartThread(GrantReinforcements);
StartThread(lose);
StartThread(win);