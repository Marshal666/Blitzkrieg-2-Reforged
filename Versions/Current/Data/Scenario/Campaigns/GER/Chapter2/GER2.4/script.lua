ReinfEnd = 0;
obj_1 = 0;
n = 0;

-- 1210 - italian tanks

-- 1200 - italian reinforcement

-- 1100 + i - british reinforcements


---------------- ENEMY REINFORCEMENTS --------- BEGIN

function crusaders()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(600,"crusaders",0) < 1) then
			if (GetNUnitsInScriptGroup(600) > 0) then
				Cmd(ACT_MOVE,600,0,2400,5900);
				else
				break;
			end;
		end;
	end;
end;


function DifficultyManager()
	Wait(2);
	if (GetDifficultyLevel() == 0) then
		RemoveScriptGroup(1800);
		RemoveScriptGroup(1801);
	end;
	if (GetDifficultyLevel() == 1) then
		RemoveScriptGroup(1800);
	end;
end;



function begin()
	Wait(2);
	Cmd(ACT_MOVE,1001,0,5378, 2757);
	Wait(6);
	QCmd(ACT_MOVE,1001,0,4655, 2690);
	Wait(6);
	QCmd(ACT_MOVE,1001,0,3875, 3092);
	Wait(6);
	QCmd(ACT_MOVE,1001,0,3705, 2898);
	Wait(6);
	QCmd(ACT_DEPLOY,1001, 0, 3744, 2935);
end;

function first_wave()
	Wait(10);
	LandReinforcementFromMap(1,"jeep",0,1101);
	Cmd(ACT_MOVE,1101,0,2651, 1558);
	QCmd(ACT_MOVE,1101,0,2452, 2264);
	QCmd(ACT_MOVE,1101,0,1867, 2701);
	QCmd(ACT_MOVE,1101,0,1367, 1529);
	StartThread(retreat_1);
	Wait(2);
	LandReinforcementFromMap(1,"jeep",0,1106);
	Cmd(ACT_MOVE,1106,0,2651, 1558);
	Wait(10);
	LandReinforcementFromMap(1,"infantry",0,1102);
	Cmd(ACT_SWARM,1102,0,4200, 3600);
	Wait(20);
	LandReinforcementFromMap(1,"humber",0,1103);
	Cmd(ACT_SWARM,1103,0,4200, 3600);
	Wait(45);
	LandReinforcementFromMap(1,"mech_infantry",0,1104);
	Cmd(ACT_SWARM,1104,0,4400, 2900);
	Wait(20);
	LandReinforcementFromMap(1,"humbers",0,1105);
	Cmd(ACT_SWARM,1105,0,4400, 2900);
	Wait(65);
	StartThread(second_wave);
end;

function retreat_1()
	while 1 do 
		Wait(1);
		if (GetNUnitsInScriptGroup(1101) == 0) then
			Cmd(ACT_MOVE,1106,0,1000,1000);
			Wait(10);
			Cmd(ACT_SWARM,1106,0,4200,3600);
			break;
		end;
	end;
end;

function second_wave()
	LandReinforcementFromMap(1,"jeep",3,1111);
	Cmd(ACT_MOVE,1111,0,5726, 5645);
	StartThread(retreat_2);
	Wait(2);
	LandReinforcementFromMap(1,"jeep",3,1116);
	Cmd(ACT_MOVE,1116,0,5574, 5945);
	Wait(10);
	LandReinforcementFromMap(1,"mech_infantry",3,1112);
	Cmd(ACT_SWARM,1112,0,4200, 3600);
	Wait(20);
	LandReinforcementFromMap(1,"humbers",3,1113);
	Cmd(ACT_SWARM,1113,0,4200, 3600);
	Wait(40);
	LandReinforcementFromMap(1,"crusaders",3,1114);
	Cmd(ACT_SWARM,1114,0,4400, 2900);
	Wait(1);
	LandReinforcementFromMap(1,"crusaders",4,1114);
	Cmd(ACT_SWARM,1114,0,4400, 2900);
	Wait(5);
	LandReinforcementFromMap(1,"mech_infantry",3,1115);
	Cmd(ACT_SWARM,1115,0,4400, 2900);
	Wait(60);
	StartThread(third_wave);
end;

function retreat_2()
	while 1 do 
		Wait(1);
		if (GetNUnitsInScriptGroup(1111) == 0) then
			Cmd(ACT_MOVE,1116,0,6300,6800);
			Wait(10);
			Cmd(ACT_SWARM,1116,0,4200,3600);
			break;
		end;
	end;
end;

function third_wave()
	LandReinforcementFromMap(1,"jeep",1,1121);
	Cmd(ACT_MOVE,1121,0,4133, 5837);
	StartThread(retreat_4);
	Wait(2);
	LandReinforcementFromMap(1,"jeep",1,1126);
	Cmd(ACT_MOVE,1126,0,3910, 5967);
	Wait(10);
	LandReinforcementFromMap(1,"mech_infantry",1,1122);
	Cmd(ACT_SWARM,1122,0,4200, 3600);
	Wait(20);
	LandReinforcementFromMap(1,"crusaders",1,1123);
	Cmd(ACT_SWARM,1123,0,4200, 3600);
	Wait(1);
	LandReinforcementFromMap(1,"crusaders",5,1123);
	Cmd(ACT_SWARM,1123,0,4400, 2900);
	Wait(40);
	LandReinforcementFromMap(1,"vallentine",1,1124);
	Cmd(ACT_SWARM,1124,0,4400, 2900);
	Wait(1);
	LandReinforcementFromMap(1,"vallentine",5,1124);
	Cmd(ACT_SWARM,1124,0,4400, 2900);
	Wait(5);
	LandReinforcementFromMap(1,"mech_infantry",1,1125);
	Cmd(ACT_SWARM,1125,0,4400, 2900);
	if (GetDifficultyLevel() == 1) then
		Wait(30);
		LandReinforcementFromMap(1,"matildes",1,1126);
		LandReinforcementFromMap(5,"infantry",1,1126);
		Cmd(ACT_SWARM,1126,0,4400, 2900);
	end;
	Wait(65);
	if (GetDifficultyLevel() == 2) then
		StartThread(four_wave);
		else
		StartThread(CompleteObjective0);
	end;
end;

function retreat_3()
	while 1 do 
		Wait(1);
		if (GetNUnitsInScriptGroup(1121) == 0) then
			Cmd(ACT_MOVE,1126,0,2800,6600);
			Wait(10);
			Cmd(ACT_SWARM,1126,0,4200,3600);
			break;
		end;
	end;
end;

function four_wave()
	LandReinforcementFromMap(1,"jeep",2,1121);
	Cmd(ACT_MOVE,1121,0,2427, 2877);
	StartThread(retreat_4);
	Wait(2);
	LandReinforcementFromMap(1,"jeep",2,1126);
	Cmd(ACT_MOVE,1126,0,2217, 2981);
	Wait(10);
	LandReinforcementFromMap(1,"mech_infantry",2,1122);
	Cmd(ACT_SWARM,1122,0,4200, 3600);
	Wait(20);
	LandReinforcementFromMap(1,"vallentine",2,1123);
	Cmd(ACT_SWARM,1123,0,4200, 3600);
	Wait(1);
	LandReinforcementFromMap(1,"crusaders",6,1123);
	Cmd(ACT_SWARM,1123,0,4400, 2900);
	Wait(40);
	LandReinforcementFromMap(1,"vallentine",2,1124);
	Cmd(ACT_SWARM,1124,0,4400, 2900);
	Wait(1);
	LandReinforcementFromMap(1,"matildes",6,1124);
	Cmd(ACT_SWARM,1124,0,4400, 2900);
	Wait(5);
	LandReinforcementFromMap(1,"mech_infantry",2,1125);
	Cmd(ACT_SWARM,1125,0,4400, 2900);
	StartThread(CompleteObjective0);
end;

function retreat_4()
	while 1 do 
		Wait(1);
		if (GetNUnitsInScriptGroup(1121) == 0) then
			Cmd(ACT_MOVE,1126,0,1000,3500);
			Wait(10);
			Cmd(ACT_SWARM,1126,0,4200,3600);
			break;
		end;
	end;
end;

function CompleteObjective0()
	while 1 do
		Wait(25);
		if (GetNUnitsInArea(1,"DefenceArea",0) == 0 and (GetNUnitsInArea(0,"DefenceArea",0)>0 or GetNUnitsInArea(2,"DefenceArea",0)>0)) then
			CompleteObjective(0);
			Wait(2);
			GiveObjective(1);
			Wait(1);
			StartThread(konvoi);
			break;
		end;
	end;
end;

function konvoi()
	Cmd(ACT_SWARM,1700,0,1800,6000);
	Wait(30);
	konvoi_units = {"PzIV","Opel_Flak38","Opel_Flak38","Opel_Flak38","sdkfz8_Flak18"};
	Wait(3);
	LandReinforcementFromMap(0,"inf_support",1,1002);
	ChangePlayerForScriptGroup(1002,2);
	Cmd(ACT_SWARM,1002,500,1331,6017);
	QCmd(ACT_SWARM,1002,500,2150, 6229);
	QCmd(ACT_SWARM,1002,500,4200, 3500);
	Wait(2);
	LandReinforcementFromMap(0,"inf_support",1,1002);
	ChangePlayerForScriptGroup(1002,2);
	Cmd(ACT_SWARM,1002,500,1331,6017);
	QCmd(ACT_SWARM,1002,500,2150, 6229);
	QCmd(ACT_SWARM,1002,500,4200, 3500);
	Wait(15);
	LandReinforcementFromMap(0,"support",1,1003);
	ChangePlayerForScriptGroup(1003,2);
	Cmd(ACT_SWARM,1003,500,1331,6017);
	QCmd(ACT_SWARM,1003,500,2150, 6229);
	QCmd(ACT_SWARM,1003,500,4200, 3500);
	StartThread(crusaders_swarm);
	Wait(15);
	LandReinforcementFromMap(0,konvoi_units[1],1,1004);
		ChangePlayerForScriptGroup(1004,2);
		Cmd(ACT_MOVE,1004,0,1046, 5871);
		QCmd(ACT_MOVE,1004,0,1673, 6143);
		QCmd(ACT_MOVE,1004,0,2831, 6294);
		QCmd(ACT_SWARM,1004,0,3777, 6683);
		QCmd(ACT_SWARM,1004,0,4387, 6646);
		QCmd(ACT_SWARM,1004,0,5068, 6260);
		QCmd(ACT_SWARM,1004,0,5790, 5427);
		QCmd(ACT_SWARM,1004,0,4392, 3666);
		Wait(4);
	for i = 2,5 do
		LandReinforcementFromMap(0,konvoi_units[i],1,1003+i);
		ChangePlayerForScriptGroup(1003+i,2);
		Cmd(ACT_MOVE,1003+i,0,1046, 5871);
		QCmd(ACT_MOVE,1003+i,0,1673, 6143);
		QCmd(ACT_MOVE,1003+i,0,2831, 6294);
		QCmd(ACT_MOVE,1003+i,0,3777, 6683);
		QCmd(ACT_MOVE,1003+i,0,4387, 6646);
		QCmd(ACT_MOVE,1003+i,0,5068, 6260);
		QCmd(ACT_MOVE,1003+i,0,5790, 5427);
		QCmd(ACT_MOVE,1003+i,0,4392, 3666);
		Wait(4);
	end;
	LandReinforcementFromMap(1,"humber",3,1601);
	Cmd(ACT_SWARM,1601,100,5700,6200);
--	StartThread(deploy_cannons);
	if (GetDifficultyLevel() == 0) then
		StartThread(easy_deploy);
	end;
	if (GetDifficultyLevel() == 1) then
		StartThread(normal_deploy);
	end;
	StartThread(lose_column);
	StartThread(CompleteObjective1);
end;

function crusaders_swarm()
	if (GetDifficultyLevel() == 1) then
		Wait(5);
	end;
	if (GetDifficultyLevel() == 0) then
		Wait(12);
	end;
	Cmd(ACT_SWARM,1600,1000,1046, 5871);
	Wait(5);
	LandReinforcementFromMap(1,"crusaders",7,1600);
	Cmd(ACT_SWARM,1600,1000,1046, 5871);
end;


function CompleteObjective1()
	while 1 do
		Wait(5);
		if (GetNScriptUnitsInArea(1005,"DefenceArea",0)>0 or GetNScriptUnitsInArea(1006,"DefenceArea",0)>0 or GetNScriptUnitsInArea(1007,"DefenceArea",0)>0 or GetNScriptUnitsInArea(1008,"DefenceArea",0)>0) then
			Wait(6);
			CompleteObjective(1);
			Wait(3);
			GiveObjective(2);
			Wait(5);
			StartThread(italianReinf);
			obj_1 = 1;
			Wait(10);
			for i=1,7 do
				if(GetNUnitsInScriptGroup(1002+i) > 0) then
					ChangePlayerForScriptGroup(1002+i,0);
				end;
			end;
			break;
		end;
	end;
end;

function easy_deploy()
	StartThread(deploy_1005);
	StartThread(deploy_1006);
	StartThread(deploy_1007);
	StartThread(deploy_1008);
end;

function normal_deploy()
	StartThread(deploy_1006);
	StartThread(deploy_1007);
end;

function deploy_1005()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1005,"DefenceArea",0)>0) then
			Cmd(ACT_DEPLOY,1005,0,3332, 2272);
			break;
		end;
	end;
end;

function deploy_1006()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1006,"DefenceArea",0)>0) then
			Cmd(ACT_DEPLOY,1006,0,4253, 4952);
			break;
		end;
	end;
end;

function deploy_1007()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1007,"DefenceArea",0)>0) then
			Cmd(ACT_DEPLOY,1007,0,5359, 4722);
			break;
		end;
	end;
end;

function deploy_1008()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1008,"DefenceArea",0)>0) then
			Cmd(ACT_DEPLOY,1008,0,4296, 3605);
			break;
		end;
	end;
end;

function deploy_cannons()
	while 1 do
		for i=1,4 do
			if (GetNUnitsInScriptGroup(1004+i) == 2) then
				z = z+1;
			end;
		end;
		for i = 1,z do
			if (GetNScriptUnitsInArea(1004+i,"DefenceArea",0)>0) then
				Cmd(ACT_DEPLOY,1004+i,0,3332, 2272);
			end;
		end;
	end;
end;


function final_attack()
	LandReinforcementFromMap(1,"GAP",0,1170);
	Cmd(ACT_MOVE,1170,1000,4000,4000);
	Wait(5);
	LandReinforcementFromMap(1,"GAP",0,1170);
	Cmd(ACT_MOVE,1170,1000,4000,4000);
	LandReinforcementFromMap(1,"mech_infantry",0,1150);
	Wait(2);
	LandReinforcementFromMap(1,"mech_infantry",1,1150);
	Wait(5);
	LandReinforcementFromMap(1,"mech_infantry",2,1150);
	LandReinforcementFromMap(1,"mech_infantry",3,1150);
	Cmd(ACT_SWARM,1150,500,4200,3600);
	Wait(60);
	LandReinforcementFromMap(1,"matildes",0,1151);
	LandReinforcementFromMap(1,"matildes",3,1151);
	LandReinforcementFromMap(1,"infantry",4,1151);
	LandReinforcementFromMap(1,"vallentine",2,1152);
	LandReinforcementFromMap(1,"mech_infantry",5,1152);
	LandReinforcementFromMap(1,"vallentine",4,1152);
	LandReinforcementFromMap(1,"mech_infantry",6,1152);
	Cmd(ACT_SWARM,1151,500,4200,3600);
	Cmd(ACT_SWARM,1152,500,4200,3600);
	Wait(45);
	LandReinforcementFromMap(1,"grants",0,1153);
	LandReinforcementFromMap(1,"grants",3,1153);
	if (GetDifficultyLevel() == 1) then
		LandReinforcementFromMap(1,"grants",2,1153);
	end;
	if (GetDifficultyLevel() == 2) then
		LandReinforcementFromMap(1,"grants",4,1153);
	end;
	Cmd(ACT_SWARM,1153,500,4200,3600);
	StartThread(CompleteObjective2);
end;

function CompleteObjective2()
	Now = GetGameTime();
	while 1 do
		Wait(3);
		if (GetNUnitsInScriptGroup(1153)==0 and 
				(GetGameTime() - Now) > 80 and 
				(GetNUnitsInArea(1,"DefenceArea",0) == 0 and (GetNUnitsInArea(0,"DefenceArea",0)>0 or GetNUnitsInArea(2,"DefenceArea",0)>0))
			or (GetNUnitsInPlayerUF(1)==0 and (GetGameTime() - Now)>10)) then
			CompleteObjective(2);
			Wait(3);
			Win(0);
			break;
		end;
	end;
end;

function lose()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(1,"DefenceArea",0) > 0 and GetNUnitsInArea(0,"DefenceArea",0) == 0 and GetNUnitsInArea(2,"DefenceArea",0) == 0) then
			Win(1);
			break;
		end;
	end;
end;

function lose_column()
	while 1 do
		Wait(1);
		if (obj_1 == 1) then
			break;
		end;
		for i=1,4 do
			if (GetNUnitsInScriptGroup(1004+i,2)>0) then
				n = n+1;
			end;
		end;
		if (n == 0) then
			Win(1);
		end;
		n = 0;
	end;
end;



function italianReinf()	
	Trace("Italian reinforcements has arrived...");
	Wait(5);
	LandReinforcementFromMap(2,"infantry",0,1205);
	Cmd(ACT_MOVE,1205,400,3400,1200);
	Cmd(ACT_SWARM,1205,400,3400,1200);
	InfantryArray = GetObjectListArray(1205);
	Entrench1_Array = GetObjectListArray(1500);
	UnitQCmd(ACT_ENTER,InfantryArray[1],Entrench1_Array[2]);
	UnitQCmd(ACT_ENTER,InfantryArray[2],Entrench1_Array[5]);
	LandReinforcementFromMap(2,"crew",0,1230);
	Cmd(ACT_SWARM,1230,400,3400,1200);
	QCmd(ACT_TAKE_ARTILLERY,1230,1220);		
	Wait(10);
	LandReinforcementFromMap(2,"infantry",0,1206);
	Cmd(ACT_MOVE,1206,400, 3209, 2834);
	Cmd(ACT_SWARM,1206,400, 3209, 2834);
	InfantryArray = GetObjectListArray(1206);
	Entrench2_Array = GetObjectListArray(1501);
	UnitQCmd(ACT_ENTER,InfantryArray[1],Entrench2_Array[7]);
	UnitQCmd(ACT_ENTER,InfantryArray[2],Entrench2_Array[12]);
	LandReinforcementFromMap(2,"crew",0,1231);
	Cmd(ACT_SWARM,1231,400, 3209, 2834);
	QCmd(ACT_TAKE_ARTILLERY,1231,1221);		
	Wait(10);
	LandReinforcementFromMap(2,"infantry",0,1207);
	Cmd(ACT_MOVE,1207,400,4178, 4687);
	Cmd(ACT_SWARM,1207,400,4178, 4687);
	InfantryArray = GetObjectListArray(1207);
	Entrench3_Array = GetObjectListArray(1502);
	UnitQCmd(ACT_ENTER,InfantryArray[1],Entrench3_Array[5]);
	UnitQCmd(ACT_ENTER,InfantryArray[2],Entrench3_Array[8]);
	LandReinforcementFromMap(2,"crew",0,1232);
	Cmd(ACT_SWARM,1232,400,4178, 4687);
	QCmd(ACT_TAKE_ARTILLERY,1232,1222);		
	Wait(10);
	LandReinforcementFromMap(2,"infantry",0,1208);
	Cmd(ACT_MOVE,1208,400,5677, 4515);
	Cmd(ACT_SWARM,1208,400,5677, 4515);
	InfantryArray = GetObjectListArray(1208);
	Entrench4_Array = GetObjectListArray(1503);
	UnitQCmd(ACT_ENTER,InfantryArray[1],Entrench4_Array[6]);
	UnitQCmd(ACT_ENTER,InfantryArray[2],Entrench4_Array[12]);
	LandReinforcementFromMap(2,"crew",0,1233);
	Cmd(ACT_SWARM,1233,400,5677, 4515);
	QCmd(ACT_TAKE_ARTILLERY,1233,1223);		
	Wait(10);
	Trace("SelfPropelled Guns has arrived...");
	LandReinforcementFromMap(0,"spg",0,1002);
	Cmd(ACT_SWARM,1002,0,4250,3600);
	Wait(3);
	LandReinforcementFromMap(2,"italian",0,1209);
	Cmd(ACT_SWARM,1209,0,3209, 2834);
	QCmd(ACT_ROTATE,1209,0,2310,2217);
	QCmd(ACT_ENTRENCH,1209,1);
	Wait(4);
	LandReinforcementFromMap(2,"italian",0,1210);
	Cmd(ACT_SWARM,1210,0,3510, 2127);
	QCmd(ACT_ROTATE,1210,0,2310,2217);
	Wait(4);
	LandReinforcementFromMap(2,"italian",0,1211);
	Cmd(ACT_SWARM,1211,0,3124, 3451);
	Wait(4);
	LandReinforcementFromMap(2,"italian",0,1212);
	Cmd(ACT_SWARM,1212,0,4282, 4964);
	QCmd(ACT_ROTATE,1212,0,3074,6445);
	QCmd(ACT_ENTRENCH,1212,1);
	Wait(4);
	LandReinforcementFromMap(2,"italian",0,1213);
	Cmd(ACT_SWARM,1213,0,3905, 4543);
	QCmd(ACT_ROTATE,1213,0,3074,6445);
	Wait(4);
	LandReinforcementFromMap(2,"italian",0,1214);
	Cmd(ACT_SWARM,1214,0,5136, 4753);
	QCmd(ACT_ROTATE,1214,0,6327,5767);
	QCmd(ACT_ENTRENCH,1214,1);
	Wait(4);
	LandReinforcementFromMap(2,"italian",0,1215);
	Cmd(ACT_SWARM,1215,0,5520, 4582);
	QCmd(ACT_ROTATE,1215,0,6327,5767);
	Wait(4);
	LandReinforcementFromMap(2,"spg",0,1216);
	Cmd(ACT_SWARM,1216,0,3468,2547);
	QCmd(ACT_ROTATE,1216,0,2310,2217);
	Wait(3);
	LandReinforcementFromMap(2,"spg",0,1217);
	Cmd(ACT_SWARM,1217,0,4101, 4904);
	Wait(3);
	LandReinforcementFromMap(2,"spg",0,1218);
	Cmd(ACT_SWARM,1218,0,5313, 4571);
	Wait(90);
	ChangeFormation(1205,2);
	ChangeFormation(1206,2);
	ChangeFormation(1207,2);
	ChangeFormation(1208,2);
	Wait(10);
	StartThread(final_attack);
end;



GiveObjective(0);
StartThread(begin);
StartThread(DifficultyManager);
StartThread(crusaders);
--StartThread(final_attack);
--StartThread(konvoi);
StartThread(first_wave);
--StartThread(four_wave);
--StartThread(third_wave);
StartThread(lose);
--StartThread(enemyreinforcements);
--StartThread(italianReinf);
--StartThread(final_attack);
--StartThread(time);