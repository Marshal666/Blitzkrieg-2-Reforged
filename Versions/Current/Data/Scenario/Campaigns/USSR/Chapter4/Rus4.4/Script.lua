hidden = 0;
--SetAmmo(GetObjectList(9001),3,3);
PalatkaHP = GetObjectHPs(GetObjectList(1210));
PushkaID = 9001;
ParovozID = 9000;
VagonID = 9002;
ParovozHP = GetObjectHPs(GetObjectList(9000));
PushkaHP = GetObjectHPs(GetObjectList(9001));
VagonHP = GetObjectHPs(GetObjectList(9002));
VillageTanks = 3000;
LastCityTanks3 = 3001;
LastCityTanks2 = 3002;
SecondCityTanks = 3003;
SecondCityTanks2 = 3004;
TempleTanks = 3005;

function CompleteObjective0()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(11,0)==1) then
			CompleteObjective(0);
			Wait(2);
			GiveObjective(1);
			StartThread(CompleteObjective1);
			StartThread(FirstCityPointAttack);
			Wait(5);
			
			LandReinforcementFromMap(0,"tank1",1,701);
			Cmd(ACT_SWARM,701,0,9257, 1966);
			Wait( 2 );
			LandReinforcementFromMap(0,"avto",1,700);
			Cmd(ACT_MOVE,700,0,9257, 1966);
			
			if (hidden == 1) then
				Wait(30);
				Trace("Hidden airsupport has arrived...");
				LandReinforcementFromMap(2,"bombers",0,532);
				Cmd(ACT_MOVE,532,0,581, 2724);
				Wait(60);
				LandReinforcementFromMap(2,"bombers",0,533);
				Cmd(ACT_MOVE,533,0,2931, 2885);
			end;
			Wait(30);
			LandReinforcementFromMap(2,"bombers",0,500);
			Cmd(ACT_MOVE,500,0,1646, 2772);
			Wait(60);
			LandReinforcementFromMap(2,"bombers",0,501);
			Cmd(ACT_MOVE,501,0,1751, 3777);
			StartThread(vozduh);
			break;
		end;
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(12,0)==1 and GetNUnitsInScriptGroup(14,0)==1) then
			CompleteObjective(1);
			Wait(4);
			GiveObjective(2);
			StartThread(CompleteObjective2);
			StartThread(SecondCityPointAttack);
			if (hidden == 1) then
				Trace("Hidden airsupport has arrived...");
				Wait(30);
				LandReinforcementFromMap(2,"bombers",0,542);
				Cmd(ACT_MOVE,542,0,1473, 7470);
				Wait(60);
				LandReinforcementFromMap(2,"bombers",0,543);
				Cmd(ACT_MOVE,543,0,4345, 9555);
			end;
			Wait(30);
			LandReinforcementFromMap(2,"bombers",0,500);
			Cmd(ACT_MOVE,500,0,1007, 8361);
			Wait(60);
			LandReinforcementFromMap(2,"bombers",0,501);
			Cmd(ACT_MOVE,501,0,1790, 9028);
			StartThread(vozduh2);
			break;
		end;
	end;
end;

function obj2()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(12,0)==1) then
			Wait(15);
			LandReinforcementFromMap(0,"sau",2,900);
			Cmd(ACT_MOVE,900,0,1136, 2750);
			Cmd(ACT_SWARM,900,0,1136, 2750);
			break;
		end;
	end;
end;

function CompleteObjective2()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(13,0)==1) then
			CompleteObjective(2);
			Wait(2);
			Win(0);
			break;
		end;
	end;
end;

function first_city_bombing()
	Wait(30);
	LandReinforcementFromMap(2,"bombers",0,500);
	Cmd(ACT_MOVE,500,0,9129, 2730);
	Wait(60);
	LandReinforcementFromMap(2,"bombers",0,501);
	Cmd(ACT_MOVE,501,0,8419, 1731);
	StartThread(mistake_bombing);
end;

function mistake_bombing()
	while 1 do 
		Wait(1);
		if (GetNUnitsInArea(0,"bombing",0)>0 and hidden == 0) then
			LandReinforcementFromMap(2,"bombers",0,522);
			Cmd(ACT_MOVE,522,0,9121, 2039);
			break;
		end;
	end
end;

function vozduh()
	while 1 do
	if (hidden == 1) then
		break;
	end;
	Wait(5);
		Units = GetArray(GetUnitListOfPlayer(0));
		for i=1,Units.n do
			if (GetNUnitsNearObj(0,Units[i],500) > 5) then
				x,y = ObjectGetCoord(Units[i]);
				LandReinforcementFromMap(2,"bombers",0,600);
				Cmd(ACT_MOVE,600,0,x,y);
				Wait(120);
				break;
			end;
		end;
	end;
end;

function hidden_objective()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"secret",0)>0 and GetNUnitsInArea(1,"secret",0) == 0) then
			CompleteObjective(3);
			hidden = 1;
			Wait(3);
			ChangePlayerForScriptGroup(1200,2);
			Cmd(ACT_LEAVE,1200,0,7089, 4306);
			Wait(3);
			--Cmd(ACT_ENTER,1200,1201);
			--StartThread(jeep);
			break;
		end;
	end;
end;

function column_bombing()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1100) < 2) then
			Trace("Column is under attack!!!");
			LandReinforcementFromMap(2,"bombers",0,580);
			Cmd(ACT_MOVE,580,0,5759,5242);
			break;
		end;
	end;
end;

function jeep()
	while 1 do
		Wait(1);
		passangers = GetPassangersArray(GetObjectList(1201),2);
		if (passangers.n > 0) then
			Wait(3);
			if (GetNUnitsInArea(1,"area1",0) == 0) then
				
			end;
			if (GetNUnitsInArea(1,"area2",0) == 0) then
			
			end;
		end;
	end;
end;

function megapushka()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(14,0)==1) then
			ChangePlayerForScriptGroup(9000,2);
			ChangePlayerForScriptGroup(9001,2);
			ChangePlayerForScriptGroup(9002,2);
			Wait(3);
			LandReinforcementFromMap(0,"tanks",4,777);
			Cmd(ACT_MOVE,777,0,1450, 1011);
			Cmd(ACT_SWARM,777,0,1450, 1011);
			Cmd(ACT_SUPPRESS,9001,0,3145, 8076);
			Wait(2);
			Cmd(ACT_SUPPRESS,9001,0,2790, 8712);
			Wait(10);
			Cmd(ACT_MOVE,9000,0,2724, 338);
			Wait(5);
			Cmd(ACT_DISAPPEAR,9000);
			Cmd(ACT_DISAPPEAR,9001);
			Cmd(ACT_DISAPPEAR,9002);
			break;
		end;
	end;
end;

function megapalatka()
	while 1 do
		Wait(1);
		if (GetObjectHPs(GetObjectList(1210)) < (PalatkaHP - 1)) then
			DamageScriptObject(1210, -(PalatkaHP - GetObjectHPs(GetObjectList(1210))));
		end;
	end;
end;

function megaparovoz()
	while 1 do
		Wait(0.5);
		if (GetObjectHPs(GetObjectList(PushkaID)) < (PushkaHP - 1)) then
			DamageScriptObject(PushkaID, -(PushkaHP  - GetObjectHPs(GetObjectList(PushkaID))));
		end;
		if (GetObjectHPs(GetObjectList(ParovozID)) < (ParovozHP - 1)) then
			DamageScriptObject(ParovozID, -(ParovozHP  - GetObjectHPs(GetObjectList(ParovozID))));
		end;
		if (GetObjectHPs(GetObjectList(VagonID)) < (VagonHP - 1)) then
			DamageScriptObject(VagonID, -(VagonHP  - GetObjectHPs(GetObjectList(VagonID))));
		end;
	end;
end;

function vozduh2()
	while 1 do
	if (hidden == 0) then
		break;
	end;
	Wait(5);
		Units = GetArray(GetUnitListOfPlayer(1));
		for i=1,Units.n do
			if (GetNUnitsNearObj(1,Units[i],500) > 4) then
				x,y = ObjectGetCoord(Units[i]);
				LandReinforcementFromMap(2,"bombers",0,600);
				Cmd(ACT_MOVE,600,0,x,y);
				Wait(100);
				break;
			end;
		end;
	end;
end;

function kaput()
	while 1 do
		Wait(1);
		if (GetNUnitsInPlayerUF(0)==0 and GetReinforcementCallsLeft(0)==0) then
			Wait(3);
			Win(1);
			break;
		end;
	end;
end;

function StartPointAttack()
	Wait(80);
	Cmd(ACT_SWARM,VillageTanks ,0,GetScriptAreaParams("start_point"));
	QCmd(ACT_WAIT,VillageTanks,6);
	QCmd(ACT_SWARM,VillageTanks ,0,GetScriptAreaParams("first_city_point"));
	Trace("Enemy forces have attack our Start Point!!!");
	Trace("Start Point Coordinates: %g",GetScriptAreaParams("start_point"));
	Trace("First City Coordinates: %g",GetScriptAreaParams("first_city_point"));
end;

function FirstCityPointAttack()
	Cmd(ACT_SWARM,LastCityTanks3,0,GetScriptAreaParams("start_point"));
	QCmd(ACT_WAIT,LastCityTanks3,6);
	QCmd(ACT_SWARM,LastCityTanks3,0,GetScriptAreaParams("first_city_point"));
	QCmd(ACT_WAIT,LastCityTanks3,6);
	QCmd(ACT_SWARM,LastCityTanks3,0,GetScriptAreaParams("second_city_point"));
	Wait(30);
	Cmd(ACT_SWARM,TempleTanks,0,GetScriptAreaParams("first_city_point"));
	Wait(60);
	Cmd(ACT_SWARM,SecondCityTanks,0,GetScriptAreaParams("edge"));
	QCmd(ACT_SWARM,SecondCityTanks,0,GetScriptAreaParams("first_city_point"));
	QCmd(ACT_WAIT,SecondCityTanks,6);
	QCmd(ACT_SWARM,SecondCityTanks,0,GetScriptAreaParams("start_point"));
end;

function SecondCityPointAttack()
	Cmd(ACT_SWARM,LastCityTanks2,0,GetScriptAreaParams("start_point"));
	QCmd(ACT_WAIT,LastCityTanks2,6);
	QCmd(ACT_SWARM,LastCityTanks2,0,GetScriptAreaParams("first_city_point"));
	QCmd(ACT_WAIT,LastCityTanks2,6);
	QCmd(ACT_SWARM,LastCityTanks2,0,GetScriptAreaParams("second_city_point"));
	QCmd(ACT_WAIT,LastCityTanks2,6);
	QCmd(ACT_SWARM,LastCityTanks2,0,GetScriptAreaParams("last_point"));
end;

GiveObjective(0);
StartThread(StartPointAttack);
StartThread(CompleteObjective0);
StartThread(first_city_bombing);
StartThread(hidden_objective);
StartThread(column_bombing);
StartThread(megapalatka);
StartThread(megapushka);
StartThread(obj2);
StartThread(kaput);
StartThread(megaparovoz);
--StartThread(FirstCityPointAttack);