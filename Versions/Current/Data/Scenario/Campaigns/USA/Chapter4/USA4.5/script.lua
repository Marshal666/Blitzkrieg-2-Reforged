objective0 = 0;
barrels_1 = 0;
barrels_2 = 0;

function initial()
	a,initial_tiger_ammo = GetAmmo(GetObjectList(1130));
	Trace("Number of tiger's shells are %g",initial_tiger_ammo);
end;


function explosive_1()
	while 1 do
		Wait(1);
		if (IsAlive(GetObjectList(2001))==0) then
			Trace("condition successefull...");
			for i=1,5 do
				x,y = GetScriptObjCoord(2099+i);
				PlayEffect(0,x,y,0);
				DamageScriptObject(2099+i,0);
				Wait(1);
				PlayEffect(1,x,y,0);
				Wait(1);
			end;
			barrels_1 = 1;
			break;
		end;
	end
end;

function explosive_2()
	while 1 do
		Wait(1);
		if (IsAlive(GetObjectList(2002))==0) then
			for i=1,4 do
				x,y = GetScriptObjCoord(2199+i);
				PlayEffect(0,x,y,0);
				DamageScriptObject(2199+i,0);
				Wait(1);
				PlayEffect(1,x,y,0);
				Wait(2);
			end;
			barrels_2 = 1;
			break;
		end;
	end
end;

function CompleteObjective0()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(1,"mash",0)==0 and GetNUnitsInArea(0,"mash",0)>0) then
			objective0 = 1;
			CompleteObjective(0);
			ChangePlayerForScriptGroup(1000,0);
			StartThread(nebelwerfer);
			GiveObjective(1);
			StartThread(CompleteObjective1);
			StartThread(CounterAttack);
			break;
		end;
	end;
end;

function nebelwerfer()
	Wait(10);
	LandReinforcementFromMap(1,"vanyusha",0,1120);
	Cmd(ACT_SUPPRESS,1120,0,1900,700);
	Wait(5);
	LandReinforcementFromMap(1,"vanyusha",1,1121);
	Cmd(ACT_SUPPRESS,1121,0,3100,1800);
	Wait(80)
	Cmd(ACT_SUPPRESS,1120,200,2400,1100);
	Wait(10);
	Cmd(ACT_SUPPRESS,1121,300,2400,1100);
end;

function direct_attack()
	while 1 do
		Wait(1);
		if (objective0==0) then
			if (GetNUnitsInArea(0,"mine2",0)>1 and (GetAmmo(GetObjectList(1130))<initial_tiger_ammo or GetNUnitsInScriptGroup(1130)==0)) then
				--panzerschrek soldaten sind sturmen.
				Cmd(ACT_SWARM,1131,300,3400,2000);
				--cannon deploing 
				Cmd(ACT_DEPLOY,1101,0,2660,1540);
				QCmd(ACT_MOVE,1101,0,2640,1800);
				Cmd(ACT_DEPLOY,1103,0,3300,670);
				QCmd(ACT_MOVE,1103,0,3560,630);
				Cmd(ACT_DEPLOY,1102,0,2300,1000);
				QCmd(ACT_MOVE,1102,0,2400,1300);
				Wait(10);
				--rotating antitank cannon 
				Cmd(ACT_ROTATE,1112,0,3400,2000);
				break;
			end;
		else
			break;
		end;
	end;
end;

function backattack()
	Units = {1101,1102,1103,1111,1112,1113};
	while 1 do
		Wait(1);
		if (objective0==0) then
			n = 0;
			for i=1,6 do
				if (GetNUnitsInScriptGroup(Units[i])>0) then
					n = n+1;
				end;
			end;
			if (GetNUnitsInArea(0,"mine1",0)>0 and n < 6) then
				Cmd(ACT_SWARM,1131,300,2550,1400);
				break;
			end;
		else
			break;
		end;
	end;
end;

function CounterAttack()
	if (GetNUnitsInScriptGroup(600,1)==1) then
		LandReinforcementFromMap(1,"intercepttanks",2,1141);
		Cmd(ACT_MOVE,1141,0,4741, 577);
		QCmd(ACT_MOVE,1141,0,4783, 1598);
		QCmd(ACT_MOVE,1141,0,5800, 3200);
		QCmd(ACT_SWARM,1141,0,5251, 4742);
		QCmd(ACT_ROTATE,1141,0,5000, 2900);
		QCmd(ACT_ENTRENCH,1141,1);
		Wait(10);
		LandReinforcementFromMap(1,"citytanks",2,1140);
		Cmd(ACT_SWARM,1140,0,4741, 577);
		QCmd(ACT_SWARM,1140,0,2440, 1182);
		QCmd(ACT_SWARM,1140,0,4500,2300);
		QCmd(ACT_SWARM,1140,0,5400,4200);
		QCmd(ACT_SWARM,1140,0,5300,5600);
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1000,"vic",0) > 1) then
			CompleteObjective(1);
			Wait(3)
			Win(0);
			break;
		end;
	end;
end;

function kaput()
	while 1 do
		Wait(1);
		if ((GetNUnitsInPlayerUF(0)==0 and GetReinforcementCallsLeft(0)==0) or (GetNUnitsInScriptGroup(1000)<2)) then
			Wait(2);
			Win(1);
			break;
		end;
	end;
end;

function hidden_objective()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(600,0)==1 and barrels_1 == 1 and barrels_2 == 1) then
			Wait(5);
			CompleteObjective(2);
			LandReinforcementFromMap(0,"pershing",1,10);
			Cmd(ACT_SWARM,10,0,5400,450);
			break;
		end;
	end;
end;



GiveObjective(0);
StartThread(explosive_1);
StartThread(explosive_2);
StartThread(CompleteObjective0);
StartThread(backattack);
StartThread(direct_attack);
StartThread(kaput);
StartThread(initial);
StartThread(hidden_objective);
--StartThread(CounterAttack);