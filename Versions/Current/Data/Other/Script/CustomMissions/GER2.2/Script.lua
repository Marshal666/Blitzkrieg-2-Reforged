---------------- OBJECTIVE 0 ------------------ begin
---- force to Flaks
function RevealObjective0()
    Wait(1);
	ObjectiveChanged(0, 1);
	Wait(3);
	StartThread( lose );
end;


function Objective0()
	if (GetNUnitsInArea(0, "AntiAirArea",0) > 0 ) then
		return 1;
    end;
end;

function CompleteObjective0()
	StartThread(Change_player201);
	Wait(1);
	StartThread(Change_player202);
	Wait(1);
	ObjectiveChanged(0, 2);
	Wait(1);
	StartThread( RevealObjective1 );
	Trigger( Objective1, CompleteObjective1 );
	StartThread(attack2);
	StartThread(intercept);
end;
---------------- OBJECTIVE 0 ------------------ end

---------------- OBJECTIVE 1 ------------------ begin
---- Safe Flaks
function RevealObjective1()
    Wait(5);
	ObjectiveChanged(1, 1);
end;


function Objective1()
	if ( GetNScriptUnitsInArea(201, "KeyArea", 0) > 3) then
        return 1;
    end;
end;


function CompleteObjective1()
	Wait(5);
	ObjectiveChanged(1, 2);
	Wait(3);
	Win(0);
end;
---------------- OBJECTIVE 1 ------------------ end


---------------- ATTACK ----------------------- begin
function attack1()
	while 1 do 
	Wait(1);
		if (GetNUnitsInArea(0, "PlayerApproach", 0) > 0) then
			Wait(1);
			Cmd(ACT_SWARM, 114, 1, 4073, 4706);
			break;
		end;
	end;
end;
---------------- ATTACK ----------------------- end

---------------- ATTACK_2 --------------------- begin
function attack2()
	while 1 do 
	Wait(1);
		if (GetNScriptUnitsInArea(201, "AntiAirArea", 0) < 3) then
			Cmd(ACT_SWARM, 113, 1, 5975, 3920);
			Wait(1);
			Cmd(ACT_SWARM, 116, 1, 2020, 5815);
			QCmd(ACT_SWARM, 116, 1, 5975, 3920);
			Wait(1);
			StartThread(Reinforcement2);
			break;
		end;
	end;
end;
---------------- ATTACK_2 --------------------- end
function Reinforcement2()
	LandReinforcementFromMap(1, "tanks", 1, 155);
	Cmd(ACT_SWARM, 152, 1, 5975, 3920);
	while 1 do 
	Wait(1);
		if (GetNUnitsInScriptGroup(113) < 1 or GetNUnitsInScriptGroup(116) < 1) then
			LandReinforcementFromMap(1, "infantry", 1, 152);
			Cmd(ACT_SWARM, 152, 1, 5975, 3920);
			break;
		end;
	end;
end;

---------------- LOOSE ------------------------ begin
function lose()
	while 1 do
        if ( GetNUnitsInParty(0) < 1 or GetNUnitsInScriptGroup(201) < 4) then
                Trace("My proigrali!!!");
				Wait(2);
				Loose(0);
        return 1;
		end;
	Wait(5);
	end;
end;

---------------- LOOSE ------------------------ end
function Change_player201()
local Objects = {};
	Objects = GetObjectListArray( 201 );
	for i = 1, Objects.n do
		if (IsAlive(Objects[i]) == 1) then
			ChangePlayer( Objects[i], 0 );
		end;
	end;
end;

function Change_player202()
local Objects = {};
	Objects = GetObjectListArray( 202 );
	for i = 1, Objects.n do
		if (IsAlive(Objects[i]) == 1) then
			ChangePlayer( Objects[i], 0 );
		end;
	end;
end;


function intercept()
	LandReinforcementFromMap(1,"tanks",0,150);
	Wait(2);
	StartThread(intercept_tanks);
	Wait(4);
	LandReinforcementFromMap(1,"artillery",0,151);
	Wait(2);
	StartThread(intercept_artillery);
	Wait(10);
	LandReinforcementFromMap(1,"infantry",0,154);
	Wait(2);
	StartThread(intercept_infantry);
end;

function intercept_tanks()
	Cmd(ACT_SWARM, 150, 0, 3341, 1126);
	QCmd(ACT_SWARM, 150, 0, 4304, 1558);
	QCmd(ACT_SWARM, 150, 0, 5010, 1922);
	QCmd(ACT_SWARM, 150, 0, 5255, 2377);
	QCmd(ACT_SWARM, 150, 0, 5298, 3363);
	QCmd(ACT_SWARM, 150, 0, 5411, 4301);
	QCmd(ACT_ROTATE, 150, 0, 4304, 4615);
	QCmd(ACT_ENTRENCH, 150, 1);
end;

function intercept_artillery()
	Cmd(ACT_MOVE, 151, 0, 3071, 907);
	QCmd(ACT_MOVE, 151, 0, 3816, 1398);
	QCmd(ACT_MOVE, 151, 0, 4800, 1929);
	QCmd(ACT_MOVE, 151, 0, 5324, 2782);
	QCmd(ACT_MOVE, 151, 0, 5262, 4047);
	QCmd(ACT_DEPLOY, 151, 0, 5975, 3920);
	QCmd(ACT_ROTATE, 151, 0, 4304, 4615);
end;

function intercept_infantry()
	Cmd(ACT_SWARM, 154, 0, 3071, 907);
	QCmd(ACT_SWARM, 154, 0, 3816, 1398);
	QCmd(ACT_SWARM, 154, 0, 4800, 1929);
	QCmd(ACT_SWARM, 154, 0, 5324, 2782);
	QCmd(ACT_SWARM, 154, 0, 5162, 4147);
end;



StartThread(RevealObjective0);
Trigger( Objective0, CompleteObjective0 );
StartThread( attack1);