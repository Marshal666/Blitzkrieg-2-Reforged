objective0 = 0;
objective1 = 0;
objective2 = 0;
objective3 = 0;


function initial()
	--Wait(60);
	GiveReinforcementCalls(1,10);
end;


function enemy_column()
	for i=0,2 do
		Wait(1);
		Cmd(ACT_MOVE,1100+i,0,10445, 3512);
		QCmd(ACT_MOVE,1100+i,0,11108, 3672);
		QCmd(ACT_MOVE,1100+i,0,11504, 2841);
		QCmd(ACT_MOVE,1100+i,0,11949, 2343);
	end;
end;

function trucks_retreat()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1100)==0) then
			Cmd(ACT_MOVE,1101,500,10380, 5411);
			QCmd(ACT_DEPLOY,1101,0,9915, 5653);
			Cmd(ACT_MOVE,1102,500,10380, 5411);
			QCmd(ACT_DEPLOY,1102,500,10667, 5650);
			break;
		end;
	end;
end;

function enemy_attack()
	Wait(1);
	while 1 do
		Wait(1);
		if ((GetNScriptUnitsInArea(1101,"trucks",0)==1 or GetNScriptUnitsInArea(1102,"trucks",0)==1)
			or (GetNUnitsInScriptGroup(1100)==0 and GetNUnitsInScriptGroup(1101)==0 and GetNUnitsInScriptGroup(1102)==0)) then
			Cmd(ACT_SUPPRESS,1130,0,11792, 2296);
			Cmd(ACT_SUPPRESS,1131,0,12958, 2908);
			Wait(25);
			Cmd(ACT_SUPPRESS,1130,0,12017, 1611);
			Cmd(ACT_SUPPRESS,1131,0,12120, 1925);
			Cmd(ACT_SUPPRESS,1132,0,12359, 2168);
			Cmd(ACT_SUPPRESS,1133,0,12550, 2409);
			Cmd(ACT_SWARM,1120,0,13309, 925);
			Wait(40);
			Cmd(ACT_SWARM,1121,0,13309, 925);
			Wait(25);
			Cmd(ACT_SWARM,1122,0,13309, 925);
			break;
		end;
	end;
end;

function truck()
	while 1 do
		Wait(1);
		if (PlayerCanSee(0,GetObjectList(1100))==1) then
			Wait(7);
			Cmd(ACT_MOVE,1100,500,10380, 5411);
			QCmd(ACT_DEPLOY,1100,500,10380, 5411);
			break;
		end;
	end;
end;

function CompleteObjective0()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1120)==0 and GetNUnitsInScriptGroup(1121)==0 and GetNUnitsInScriptGroup(1122)==0
			 and GetNUnitsInArea(1,"bridge",0)==0) then
			CompleteObjective(0);
			objective0 = 1;
			Wait(2);
			GiveObjective(1);
			GiveObjective(2);
			StartThread(Objective1);
			StartThread(CompleteObjective1);
			StartThread(CompleteObjective2);
			Wait(3);
			LandReinforcementFromMap(0,"reinf",0,1002);
			StartThread(GB_attack);
			Wait(30);
			GiveReinforcementCalls(1,15);
			break;
		end;
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(15,0)==1) then
			CompleteObjective(1);
			Cmd(ACT_SWARM,1140,0,13463, 11931);
			QCmd(ACT_SWARM,1140,0,13526, 10870);
			Cmd(ACT_SWARM,1141,0,13463, 11931);
			QCmd(ACT_SWARM,1141,0,13526, 10870);
			objective1 = 1;
			break;
		end;
	end;
end;

function CompleteObjective2()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(14,0)==1) then
			CompleteObjective(2);
			objective2 = 1;
			StartThread(TestCompleteObjective1and2);
			break;
		end;
	end;
end;

function TestCompleteObjective1and2()
	while 1 do
		Wait(1);
		if ((objective1 == 1) and (objective2 == 1)) then
			Wait(3);
			GiveObjective(3);
			StartThread(CompleteObjective3);
			LandReinforcementFromMap(1,"mobile",7,1170);
			Cmd(ACT_SWARM,1170,0,5777, 3247);
			break;
		end;
	end;
end;

function Objective1()
	LandReinforcementFromMap(0,"para",0,1000);
	Cmd(ACT_UNLOAD,1000,0,12695, 12839);
	Wait(10);
	LandReinforcementFromMap(0,"para",0,1001);
	Cmd(ACT_UNLOAD,1001,0,13135,12910);
end;

function point_bonus()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(16,0)==1) then
			LandReinforcementFromMap(0,"calliope",6,1003);
			break;
		end;
	end;
end;

function first_city_reinf()
	Wait(2);
	scdrAmmo,prAmmo = GetAmmo(GetObjectList(1139));
	Wait(1);
	Trace("Tiger ammo is %g", prAmmo);
	Units = {"myaso","pantheren","dolgonosiki"};
	while 1 do
		Wait(1);
		scdrAmmo,curAmmo = GetAmmo(GetObjectList(1139));
		if (curAmmo < prAmmo or GetNUnitsInScriptGroup(1139)==0) then
			Trace("condition success...");
			for i=1,3 do
				if (GetNUnitsInScriptGroup(16,1)==1) then
					LandReinforcementFromMap(1,Units[i],6,1159+i);
					Trace("Reinforcement " .. Units[i] .. " has been landed...");
					Cmd(ACT_SWARM,1159+i,0,10979, 7047);
					QCmd(ACT_SWARM,1159+i,0,11014, 3492);
					QCmd(ACT_SWARM,1159+i,0,13367, 300);
					Wait(35);
				else
					Trace("Key Point 6 isn't available...");
					break;
				end;
			end;
			break;
		end;
	end;
end;

function CompleteObjective3()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(1,"city",0)==0) then
			if (GetNUnitsInArea(0,"city",0)>GetNUnitsInArea(2,"city",0)) then
				CompleteObjective(3);
				Wait(3);
				GiveObjective(4);
				StartThread(Objective4);
				StartThread(CompleteObjective4);
				GiveReinforcementCalls(1,6);
				StartThread(British_attack);
				objective3 = 1;
				break;
			else
				CompleteObjective(3);
				Wait(3);
				GiveObjective(5);
				StartThread(CompleteObjective5);
				GiveReinforcementCalls(1,6);
				StartThread(British_attack);
				objective3 = 1;
				break;
			end;
		end;
	end;
end;

function CompleteObjective5()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(17,1)==0) then
			CompleteObjective(5);
			Win(0);
			break;
		end;
	end;
end;

function CompleteObjective4()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(17,0)==1) then
			CompleteObjective(4);
			Win(0);
			break;
		end;
	end;
end;

function Objective4()
	Wait(3);
	if (GetNUnitsInScriptGroup(12,1))==0 then
		LandReinforcementFromMap(0,"centurion",2,1250);
		Cmd(ACT_SWARM,1250,0,3226, 9557);
	else
		LandReinforcementFromMap(0,"centurion",1,1250);
		Cmd(ACT_SWARM,1250,0,3226, 9557);
	end;
end;

function GB_attack()
	LandReinforcementFromMap(2,"infantry",1,1200);
	Cmd(ACT_MOVE,1200,0,833, 1551);
	Wait(15);
	LandReinforcementFromMap(2,"shermans",1,1201);
	Cmd(ACT_MOVE,1201,0,825, 1401);
	Wait(5);
	LandReinforcementFromMap(2,"bombers",1,1203);
	Cmd(ACT_MOVE,1203,700,830, 3797);
	LandReinforcementFromMap(2,"churchills",1,1202);
	Cmd(ACT_MOVE,1202,0,821, 1714);
	Wait(5);
	LandReinforcementFromMap(2,"sextons",1,1209);
	Cmd(ACT_MOVE,1209,0,500, 900);
	QCmd(ACT_STAND,1209);
	Wait(5);
	LandReinforcementFromMap(2,"trucks",1,1210);
	Cmd(ACT_MOVE,1210,0,600, 1100);
	QCmd(ACT_RESUPPLY,1210,0,500, 900);
	Wait(15);
	for i=0,3 do
		Cmd(ACT_SWARM,1200+i,0,909, 4233);
		QCmd(ACT_SWARM,1200+i,0,918, 7077);
		Wait(10);
	end;
	StartThread(german_counter_attack);
	Wait(70);
	LandReinforcementFromMap(2,"bombers",1,1203);
	Cmd(ACT_MOVE,1203,700,961, 5471);
	Wait(20);
	LandReinforcementFromMap(2,"infantry",1,1200);
	Cmd(ACT_MOVE,1200,0,825, 1401);
	Wait(15);
	LandReinforcementFromMap(2,"shermans",1,1201);
	Cmd(ACT_MOVE,1201,0,833, 1551);
	Wait(15);
	for i=0,2 do
		Cmd(ACT_SWARM,1200+i,0,909, 4233);
		QCmd(ACT_SWARM,1200+i,0,918, 7077);
		Wait(10);
	end;
	Wait(20);
	StartThread(permanent_attack);
	StartThread(german_permanent_attack);
end;

function german_counter_attack()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1202)==0) then
			Armor = GetObjectListArray(1150);
			Infantry = GetObjectListArray(1151);
			UnitCmd(ACT_SWARM,Armor[1],0,695, 3547);
			UnitCmd(ACT_SWARM,Armor[2],0,953, 3559);
			UnitCmd(ACT_SWARM,Armor[3],0,830, 3847);
			UnitQCmd(ACT_ENTRENCH,Armor[1],1);
			UnitQCmd(ACT_ENTRENCH,Armor[2],1);
			UnitCmd(ACT_SWARM,Infantry[1],300,830, 3847);
			UnitCmd(ACT_SWARM,Infantry[2],300,830, 3847);
			Cannons = GetObjectListArray(1152);
			for i=1,3 do
				if (IsAlive(Cannons[i])==1) then
					UnitQCmd(ACT_TAKE_ARTILLERY,Infantry[1],Cannons[i]);
				end;
			end;
			break;
		end;
	end;
end;

function permanent_attack()
	Trace("Thread permanent_attack has been started...");
	Reinforcemtns = {"tanks","pehota","planes"};
	while 1 do
		Wait(1);
		if (objective2 == 0) then
			if (GetNUnitsInScriptGroup(12,1)==1) then
				Rnd = Random(3);
				if (Rnd == 3) then
					Trace("Achtung! Samoleten!");
					LandReinforcementFromMap(2,"gap",1,1239);
					Cmd(ACT_MOVE,1239,1000,1349, 6796);
					Wait(30);
				end;
				LandReinforcementFromMap(2,Reinforcemtns[Rnd],1,1240);
				Cmd(ACT_SWARM,1240,1000,1349, 6796);
				Wait(80);
			end;
		else
			Trace("Objective 2 completed...");
			Trace("Mega attack has begun...");
			StartThread(mega_attack);
			break;
		end;
	end;
end;

function german_permanent_attack()
	Reinforcements = {"myaso","pantheren","medium"};
	while 1 do
		Wait(1);
		if (objective2 == 0) then
			if (GetNUnitsInScriptGroup(12,1)==0) then
				Trace("German tanks are attacking...");
				Rnd = Random(3);
				if (Rnd == 3) then
					Trace("Achtung! Unser Samoleten!");
					LandReinforcementFromMap(1,"gap",3,1239);
					Cmd(ACT_MOVE,1239,1000,1349, 6796);
					Wait(30);
				end;
				
				LandReinforcementFromMap(1,Reinforcements[Rnd],3,1240);
				Trace("German Reinforcement "..Reinforcements[Rnd].." has been landed...");
				Cmd(ACT_SWARM,1240,1000,1349, 6796);
				Wait(80);
			end;
		else
			Trace("German. Objective 2 completed...");
			break;
		end;
	end;
end;

function mega_attack()
	Trace("mega_attack");	
	LandReinforcementFromMap(2,"fighters",1,1220);
	Cmd(ACT_MOVE,1220,1000,3226, 9557);
	Wait(10);
	LandReinforcementFromMap(2,"bombers",1,1221);
	Cmd(ACT_MOVE,1221,500,3226, 9557);
	LandReinforcementFromMap(2,"infantry",1,1230);
	Cmd(ACT_SWARM,1230,1000,1349, 6796);
	QCmd(ACT_SWARM,1230,1000,3145, 10270);
	Wait(20);
	LandReinforcementFromMap(2,"shermans",1,1231);
	Cmd(ACT_SWARM,1231,1000,1349, 6796);
	QCmd(ACT_SWARM,1231,1000,3145, 10270);
	Wait(15);
	LandReinforcementFromMap(2,"churchills",1,1232);
	Cmd(ACT_SWARM,1232,1000,1349, 6796);
	QCmd(ACT_SWARM,1232,1000,3145, 10270);
	LandReinforcementFromMap(2,"bombers",1,1222);
	Cmd(ACT_MOVE,1222,500,912, 10482);
	Cmd(ACT_MOVE,1209,500,874,4398);
	Cmd(ACT_MOVE,1210,500,874,4398);
	QCmd(ACT_RESUPPLY,1210,0,874,4398);
	QCmd(ACT_STAND,1209);
	Wait(15);
	LandReinforcementFromMap(2,"infantry",1,1230);
	Cmd(ACT_SWARM,1230,1000,1349, 6796);
	QCmd(ACT_SWARM,1230,1000,3145, 10270);
	Wait(10);
	GB_Units = {"shermans","infantry","pehota"};
	while (objective3 == 0) do
		Wait(1);
		if (GetNUnitsInScriptGroup(1230)==0) then
			LandReinforcementFromMap(2,GB_Units[Random(3)],1,1230);
			Cmd(ACT_SWARM,1230,1000,1349, 6796);
			QCmd(ACT_SWARM,1230,1000,3145, 10270);
		end;
	end;
end;

function British_attack()
	--LandReinforcementFromMap(2,"bombers",1,1251);
	--Cmd(ACT_MOVE,1251,0,3966,4511);
	--Wait(15);
	--BritishUnits = GetUnitListOfPlayerArray(2);
	--for i=1,BritishUnits.n do
	--	UnitCmd(ACT_SWARM,BritishUnits[i],1500,5970,1787);
	--end;
	Cmd(ACT_SUPPRESS,1209,1000,4502, 5488);
	Wait(25);
	Cmd(ACT_SUPPRESS,1209,1000,4502, 5488);
	Wait(25);
	if (GetNUnitsInScriptGroup(12,1)==0) then
		LandReinforcementFromMap(2,"infantry",2,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
		Wait(10);
		LandReinforcementFromMap(2,"infantry",2,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
	else
		LandReinforcementFromMap(2,"infantry",1,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
		Wait(10);
		LandReinforcementFromMap(2,"infantry",1,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
	end;
	Cmd(ACT_SUPPRESS,1209,1000,4502, 5488);
	Wait(40);
	Cmd(ACT_SUPPRESS,1209,1000,4502, 5488);
	if (GetNUnitsInScriptGroup(12,1)==0) then
		LandReinforcementFromMap(2,"infantry",2,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
		Wait(10);
		LandReinforcementFromMap(2,"infantry",2,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
		Wait(70);
		LandReinforcementFromMap(2,"shermans",2,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
	else
		LandReinforcementFromMap(2,"infantry",1,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
		Wait(10);
		LandReinforcementFromMap(2,"infantry",1,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
		Wait(70);
		LandReinforcementFromMap(2,"shemans",1,1280);
		Cmd(ACT_SWARM,1280,0,5164, 3883);
		QCmd(ACT_SWARM,1280,0,5970, 1787);
	end;
	Cmd(ACT_STOP,1209);
end;

function pre_attack_defence()
	while 1 do
		Wait(1);
		if (objective3 == 0) then
			if (GetNUnitsInArea(0,"bunkers",0)>0 and GetNUnitsInScriptGroup(600,1)==0) then
				LandReinforcementFromMap(1,"mobile",7,600);
				Trace("German tanks mobile group 600 has landed...");
				Cmd(ACT_SWARM,600,0,8259, 3516);
				Wait(30);
			end;
		else
			if (GetNUnitsInScriptGroup(600,1)>0) then
				Cmd(ACT_DISAPPEAR,600);
				Trace("German tanks has disappeared...");
			end;
			break;
		end;
	end;
end;

function panzer_patrol()
	while 1 do
		Wait(90);
		if (GetNUnitsInScriptGroup(610)>0) then
			StartThread(patrol);
		else
			Trace("Script group 610 was destroyed...");
			break;
		end;
	end;
end;

function patrol()
	Cmd(ACT_SWARM,610,0,6509,11008);
	Wait(10);
	QCmd(ACT_SWARM,610,0,3827,10905);
end;

function player_key_point3_bonus()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(13,0)==1) then
			LandReinforcementFromMap(0,"bonus",3,620);
			Cmd(ACT_SWARM,620,0,GetScriptAreaParams("bonus"));
			Wait(3);
			LandReinforcementFromMap(0,"bonus_heavy",3,621);
			Cmd(ACT_SWARM,621,0,GetScriptAreaParams("bonus_heavy"));
			break;
		end;
	end;
end;

function hetzer()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1195)~=0) then
			if (GetNUnitsInArea(0,"para",0)>0) then
				Wait(55);
				Cmd(ACT_SWARM,1195,500,13300,13300);
				break;
			end;
		else
			Trace("Hetzers have been destroyed...");
			break;
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

function kaput2()
	while 1 do
		Wait(1);
		if (objective0 == 0) then
			if (GetNUnitsInScriptGroup(10,0)==0) then
				Wait(3);
				Win(1);
				break;
			end;
		else
			break;
		end;
	end;
end;


GiveObjective(0);
StartThread(kaput2);
--StartThread(initial);
--GiveObjective(1);
--StartThread(Objective1);
--StartThread(CompleteObjective1);
--StartThread(CompleteObjective2);
StartThread(pre_attack_defence);
StartThread(enemy_column);
StartThread(trucks_retreat);
StartThread(enemy_attack);
StartThread(truck);
StartThread(CompleteObjective0);
StartThread(point_bonus);
StartThread(first_city_reinf);
StartThread(player_key_point3_bonus);
StartThread(hetzer);
StartThread(kaput);
--StartThread(GB_attack);
--StartThread(mega_attack);
--StartThread(permanent_attack);