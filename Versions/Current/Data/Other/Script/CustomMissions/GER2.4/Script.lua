-- 1210 - italian tanks
-- 1200 - italian reinforcement
-- 1100 + i - british reinforcements


---------------- OBJECTIVE 0 ------------------ begin
function RevealObjective0()
    Wait(1);
	ObjectiveChanged(0, 1);
	Cmd(ACT_ENTRENCH, 1210,1);
	StartThread( lose );
	StartThread(enemyreinforcements);
	StartThread(italianReinf);
	Wait(10);
	StartThread(swarm);
end;


function Objective0()
	if (GetNUnitsInArea(2, "DefenceArea",0) > 0  and GetGameTime() > 500 and GetNUnitsInParty(1) < 3) then
		return 1;
    end;
end;

function CompleteObjective0()
	ObjectiveChanged(0, 2);
	Wait(1);
	Win(0);
end;
---------------- OBJECTIVE 0 ------------------ end

---------------- ENEMY REINFORCEMENTS --------- BEGIN
function enemyreinforcements()
	ReinfArr = {"0","1","2","3"};
	Trace("Thread EnemyReinforcements started");
	i=0;
	j=1;
	while (GetGameTime() < 400) do
		for i=j,j+3 do
			LandReinforcementFromMap(1, ReinfArr[RandomInt(4)], RandomInt(4), 1100+i);
			Trace (ReinfArr[RandomInt(4)]);
			Cmd(ACT_SWARM, 1100+i, 1, 4239, 3481);
			z=i;
			Wait(9 + RandomInt(10));
		end;
		j=z+1;
		Trace(j);
		Wait(40 + RandomInt(30));
	end;
	StartThread(win);
end;
---------------- ENEMY REINFORCEMENTS --------- end

------------------- SWARM --------------------- BEGIN
function swarm()
	for i=1,25 do
		if (IsAlive(1100+i)==1) then
			Wait(6);
			Cmd(ACT_SWARM, 1100+i, 1, 4239, 3481);
		end;
	end;
end;

------------------- SWARM --------------------- end

------------------- ITALIAN REINFORCEMENTS ---- BEGIN
function italianReinf()
		Wait(250);
		LandReinforcementFromMap(2, "italian", 0, 1200);
		Cmd(ACT_SWARM, 1200, 2, 4239, 3481);
end;

------------------- ITALIAN REINFORCEMENTS ---- end

---------------- LOOSE ------------------------- begin
function lose()
	while 1 do
        if ( GetNUnitsInArea(2, "DefenceArea", 0) < 3 and GetNUnitsInArea(1, "DefenceArea", 0) > 2) then
				Wait(1);
				Loose(0);
        return 1;
		end;
	Wait(3);
	end;
end;

---------------- LOOSE ------------------------ end
function win()
	while 1 do 
		if (GetGameTime() > 400 and GetNUnitsInParty(1) < 1) then
			Win(0);
			return 1;
		end;
	Wait(3);
	end;
end;

function time()
	Wait(1);
	GetGameTime()
end;
--main
StartThread(RevealObjective0);
StartThread(time);
Trigger(Objective0, CompleteObjective0);