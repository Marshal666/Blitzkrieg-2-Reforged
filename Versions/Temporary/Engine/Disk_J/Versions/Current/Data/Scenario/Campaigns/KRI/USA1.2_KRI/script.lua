AI_on = 0;
objective_0_Completed = 0;
objective_1_Completed = 0;
TownCaptured = 0;



function CompleteObjective0()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(6000,0)==1) then
			CompleteObjective(0);
			objective_0_Completed = 1;
			Wait(3);
			if (TownCaptured == 0) then
				GiveObjective(1);
				StartThread(artillery_reinf);
				LandReinforcementFromMap(0,"unserwaffe",1,4500);
				Cmd(ACT_SWARM,4500,0,GetScriptAreaParams("vokzal_tanks"));
				Wait(5);
				LandReinforcementFromMap(0,"spg",1,4501);
				Cmd(ACT_SWARM,4501,0,GetScriptAreaParams("vokzal_spg"));
				if (AI_on == 0) then
					StartThread(AI_obj1);
				end;
			else
				Wait(3);
				GiveObjective(2);
				StartThread(Objective2);
			end;
			StartThread(reids);
			break;
		end;
	end;
end;



function CompleteObjective1()
	while 1 do
		Wait(1);
		--relation = GetNUnitsInArea(0,"town",0) / GetNUnitsInArea(1,"Town",0);
		local nPlayerUnits = GetNUnitsInArea(0,"town",0);
		if ((nPlayerUnits > 0 and GetNUnitsInArea(1,"town",0) < nPlayerUnits / 5) and GetNUnitsInScriptGroup(6002,0)==1) then
			if (objective_0_Completed == 1) then
				CompleteObjective(1);
				objective_1_Completed = 1;
				Wait(3);
				GiveObjective(2);
				StartThread(Objective2);
			else
				CompleteObjective(1);
				objective_1_Completed = 1;
				TownCaptured = 1;
				LandReinforcementFromMap(0,"townwaffe",3,7000);
				Cmd(ACT_MOVE,7000,0,GetScriptAreaParams("trucks"));
				Wait(2);
				Cmd(ACT_MOVE,7000,0,GetScriptAreaParams("trucks"));
				Wait(8);
				LandReinforcementFromMap(0,"spg",3,7002);
				Cmd(ACT_SWARM,7002,0,GetScriptAreaParams("spg"));
			end;
			Wait(4);
			break;
		end;
	end;
end;

function Objective2()
	StartThread(LoseCity);
	if (TownCaptured == 0) then
		LandReinforcementFromMap(0,"townwaffe",3,7000);
		Cmd(ACT_MOVE,7000,0,GetScriptAreaParams("trucks"));
		Wait(2);
		Cmd(ACT_MOVE,7000,0,GetScriptAreaParams("trucks"));
		Wait(8);
		LandReinforcementFromMap(0,"spg",3,7002);
		Cmd(ACT_SWARM,7002,0,GetScriptAreaParams("spg"));
	end;
	Wait(40);
	--LandReinforcementFromMap(1,"fighters",3,4999);
	--Cmd(ACT_MOVE,5000,0,6700,6800);
	--if (GetNUnitsInScriptGroup(6000,0)==1) then
--		LandReinforcementFromMap(1,"bombers",3,5000);
--		Cmd(ACT_MOVE,5000,0,6700,6800);
--		Wait(30);
--	end;
--	if (GetNUnitsInScriptGroup(6000,0)==1) then
--		LandReinforcementFromMap(1,"bombers",3,5001);
--		Cmd(ACT_MOVE,5001,0,1800,1300);
--		Wait(50);
--	end;
	LandReinforcementFromMap(1,"kampfwagen",1,5002);
	Cmd(ACT_SWARM,5002,1000,2500,6200);
	Wait(35);
	LandReinforcementFromMap(1,"panzerwagen",1,5003);
	Cmd(ACT_SWARM,5003,1000,2500,6200);
	Wait(30);
	LandReinforcementFromMap(1,"kampfwagen",0,5004);
	Cmd(ACT_SWARM,5004,1000,2500,6200);
	Wait(35);
	LandReinforcementFromMap(1,"panzerwagen",0,5005);
	Cmd(ACT_SWARM,5005,1000,2500,6200);
	if ((GetDifficultyLevel() == DLEVEL_NORMAL) or (GetDifficultyLevel() == DLEVEL_HARD)) then
		LandReinforcementFromMap(0,"townwaffe2",3,7001);
		Wait(50);
		LandReinforcementFromMap(1,"diaboliwaffen",0,5006);
		LandReinforcementFromMap(1,"diaboliwaffen",1,5006);
		Cmd(ACT_SWARM,5006,1000,2500,6200);
		StartThread(swarming,5006);
		ScriptID = 5006;
	else
		ScriptID = 5005;
		StartThread(swarming,5005);
	end;
	Wait(5);
	StartThread(CompleteObjective2,ScriptID);
end;

function swarming(ScrID)
	while GetNUnitsInScriptGroup(ScrID,1) > 0 do
		Wait(15);
		Cmd(ACT_SWARM,ScrID,0,GetScriptAreaParams("key"));
	end;
end;

function CompleteObjective2(ID)
	BeginTime = GetGameTime();
	while 1 do
		Wait(2);
		if ((GetNUnitsInScriptGroup(ID)==0) or (GetGameTime()-BeginTime > 240 and GetNScriptUnitsInArea(ID,"town",0)==0)) then
			Wait(2);
			CompleteObjective(2);
			Wait(3);
			Win(0);
			break;
		end;
	end;
end;

function artillery()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(6001,0)==1 and AI_on == 0) then
			StartThread(AI_artillery);
			break;
		end;
	end;
end;

function AI_obj1()
	AI_on = 1;
	LandReinforcementFromMap(1,"panzerwaffe",1,1110);
	Cmd(ACT_SWARM,1110,500,7200,700);
	QCmd(ACT_SWARM,1110,500,1700,970);
	Wait(10);
	local nReinfs = 1;
	if (GetDifficultyLevel() == DLEVEL_NORMAL) then
		nReinfs = nReinfs + 2;
	end;
	if (GetDifficultyLevel() == DLEVEL_HARD) then
		nReinfs = nReinfs + 4;
	end;
	GiveReinforcementCalls(1, nReinfs);
end;

function forceTo_key_railroad()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(6000,0)==1) then
			Wait(20);
			Cmd(ACT_SWARM,1102,500,1700,970);
			if (GetDifficultyLevel() == DLEVEL_NORMAL) or (GetDifficultyLevel() == DLEVEL_HARD) then
				Cmd(ACT_SWARM,1103,500,1700,970);
			end;
			StartThread(capture_key_building_again);
			Cmd(ACT_MOVE,1111,0,1400,4100);
			--QCmd(ACT_SUPPRESS,1111,0,1800,1200);
			break;
		end;
	end;
end;

function capture_key_building_again()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(6000,1)==1) then
			local nReinfs = 1;
			if (GetDifficultyLevel() == DLEVEL_NORMAL) then
				nReinfs = nReinfs + 2;
			end;
			if (GetDifficultyLevel() == DLEVEL_HARD) then
				nReinfs = nReinfs + 4;
			end;
			GiveReinforcementCalls(1, nReinfs);
			break;
		end;
	end;
end;


function forceTo_key_building2()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(6001,0)==1) then
			Wait(10);
			Cmd(ACT_SWARM,1109,500,7300,6500);
			break;
		end;
	end;
end;

function AI_artillery()
	AI_on = 1;
	LandReinforcementFromMap(1,"panzerwaffe",0,1110);
	Cmd(ACT_SWARM,1110,500,7200,700);
	QCmd(ACT_SWARM,1110,500,6900,7100);
	Wait(10);
	local nReinfs = 1;
	if (GetDifficultyLevel() == DLEVEL_NORMAL) then
		nReinfs = nReinfs + 2;
	end;
	if (GetDifficultyLevel() == DLEVEL_HARD) then
		nReinfs = nReinfs + 4;
	end;
	GiveReinforcementCalls(1, nReinfs);
end;

function artillery_reinf() 
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"vokzal",0)==0 and GetNUnitsInArea(1,"vokzal",0)>0 and TownCaptured == 0) then
		     Cmd(ACT_MOVE,1150,0,1700,6200);
		    QCmd(ACT_DEPLOY,1150,0,1900,1300);
			QCmd(ACT_MOVE,1150,0,1700,1700);
			 Cmd(ACT_MOVE,1151,0,1750,6270);
			QCmd(ACT_DEPLOY,1151,0,2400,590);
			QCmd(ACT_MOVE,1151,0,1700,1900);
			 Cmd(ACT_DEPLOY,1152,0,2100,2100);
			QCmd(ACT_MOVE,1152,0,1700,2100);
			 Cmd(ACT_DEPLOY,1153,0,1500,1200);
			QCmd(ACT_MOVE,1153,0,1700,2300);
			for i=1,3 do
				ChangeFormation(1139+i,1);
				Cmd(ACT_MOVE,1139+i,500,1700,1000);
			end;
			StartThread(cannon1);
			StartThread(cannon2);
			Wait(60);
			StartThread(defence);
			break;
		end;
	end;
end;

function cannon1()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1160,"cannon_1",0)>0) then
			Cmd(ACT_ROTATE,1160,0,3700,900);
			Cmd(ACT_ENTRENCH,1160,1);
			break;
		end;
	end;
end;

function cannon2()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1161,"cannon_2",0)>0) then
			Cmd(ACT_ROTATE,1161,0,3700,900);
			break;
		end;
	end;
end;

function defence()
	entrench = GetObjectListArray(2000);
	UnitCmd(ACT_ENTER,GetObjectList(1140),entrench[3]);
	UnitCmd(ACT_ENTER,GetObjectList(1141),entrench[5]);
	Cmd(ACT_ENTER,1142,1139);
end;

function reiders()
	for i=1,4 do
		Wait(80);
		Cmd(ACT_SWARM,1119+i,0,7200,700);
	end;
end;

function recon()
	Wait(120);
	if (GetDifficultyLevel() == DLEVEL_NORMAL) or (GetDifficultyLevel() == DLEVEL_HARD) then
		LandReinforcementFromMap(1,"recon",3,9000);
		Cmd(ACT_MOVE,9000,1000,7200,1100);
		Wait(250);
		LandReinforcementFromMap(1,"gap",3,9000);
		Cmd(ACT_MOVE,9000,1000,7200,1100);
	end;
end;

function wunderwaffe()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1180,1)==0 and GetNUnitsInArea(0,"aa",0)>0 and GetNUnitsInArea(1,"aa",0)==0 and objective_1_Completed == 0) then
			--if 1 then
			CompleteObjective(3);
			StartThread(planes);
			LandReinforcementFromMap(0,"bombers",2,9100);
			bombers = GetObjectListArray(9100);
			UnitCmd(ACT_MOVE,bombers[1],0,3600+150,5700-700);
			UnitCmd(ACT_MOVE,bombers[2],0,3600,5700);
			UnitCmd(ACT_MOVE,bombers[3],0,3600-150,5700+700);
			UnitQCmd(ACT_MOVE,bombers[3],0,0,4600);
			UnitQCmd(ACT_MOVE,bombers[2],0,0,3900);
			UnitQCmd(ACT_MOVE,bombers[1],0,0,3200);
			Wait(50);
			bombers = {};
			LandReinforcementFromMap(0,"bombers",2,9101);
			bombers = GetObjectListArray(9101);
			UnitCmd(ACT_MOVE,bombers[1],0,3800+150,7100-700);
			UnitCmd(ACT_MOVE,bombers[2],0,3800,7100);
			UnitCmd(ACT_MOVE,bombers[3],0,3800-150,7100+700);
			UnitQCmd(ACT_MOVE,bombers[3],0,0,4600);
			UnitQCmd(ACT_MOVE,bombers[2],0,0,3900);
			UnitQCmd(ACT_MOVE,bombers[1],0,0,3200);
			Wait(50);
			bombers = {};
			LandReinforcementFromMap(0,"bombers",2,9102);
			bombers = GetObjectListArray(9102);
			UnitCmd(ACT_MOVE,bombers[1],0,2700+150,6700-700);
			UnitCmd(ACT_MOVE,bombers[2],0,2700,6700);
			UnitCmd(ACT_MOVE,bombers[3],0,2700-150,6700+700);
			UnitQCmd(ACT_MOVE,bombers[3],0,0,4600);
			UnitQCmd(ACT_MOVE,bombers[2],0,0,3900);
			UnitQCmd(ACT_MOVE,bombers[1],0,0,3200);
			Wait(5);
			LandReinforcementFromMap(1,"fighters",3,4999);
			Cmd(ACT_MOVE,5000,0,4000,4000);
			break;
		end;
	end;
end;

function flak()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"attack",0)>0) then
			UnitCmd(ACT_TAKE_ARTILLERY,GetObjectList(1170),GetObjectList(1180))
			break;
		end;
	end;
end;

function town_key_building()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(6002,0)==1) then
			Cmd(ACT_SWARM,2100,500,1800,6300);
			break;
		end;
	end;
end;

function reids()
	Wait(100);
	Cmd(ACT_SWARM,1124,0,6800,5800);
	QCmd(ACT_SWARM,1124,0,7400,600);
	Wait(120);
	Cmd(ACT_SWARM,1125,0,6800,5800);
	QCmd(ACT_SWARM,1125,0,7400,600);
end;

function lose()
	while 1 do
		Wait(1);
		if ((GetNUnitsInPlayerUF(0)==0 and GetReinforcementCallsLeft(0)==0)
			or (GetNUnitsInScriptGroup(6000,0)==0 and GetNUnitsInScriptGroup(6001,0)==0 and GetNUnitsInScriptGroup(6002,0)==0 and GetNUnitsInScriptGroup(6003,0)==0)) then	
			Wait(2);
			Win(1);
			break;
		end;
	end;
end;

function train()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"train",0) > 0) then
		--	if 1 then
			Cmd(ACT_MOVE,9005,0,800,5600);
			Wait(5);
			Cmd(ACT_MOVE,9006,0,650,1300);
			break;
		end;
	end;
end;

function initial()
	
end;

function planes()
	while 1 do
		Wait(1);
		bombers1 = GetObjectListArray(9100);
		bombers2 = GetObjectListArray(9101);
		bombers3 = GetObjectListArray(9102);
		for i=1,3 do
			if (IsUnitInArea(0,"planes",bombers1[i])==1) then
				UnitCmd(ACT_DISAPPEAR,bombers[i]);
			end;
		end;
		for j=1,3 do
			if (IsUnitInArea(0,"planes",bombers2[j])==1) then
				UnitCmd(ACT_DISAPPEAR,bombers[j]);
			end;
		end;
		for z=1,3 do
			if (IsUnitInArea(0,"planes",bombers3[z])==1) then
				UnitCmd(ACT_DISAPPEAR,bombers[z]);
			end;
		end;
	end;
end;

function LoseCity()
	while 1 do
		Wait(1);
		--if (GetNUnitsInScriptGroup(6002,1)==1 and GetNUnitsInArea(0,"town",0) == 0 and GetNUnitsInArea(1,"town",0) > 0)) then
		if (GetNUnitsInScriptGroup(6002,1)==1) then
			StartThread(recapture_city);
			break;
		end;
	end;
end;

function recapture_city()
	local time = GetGameTime();
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(6002,1)==1) and (GetNUnitsInArea(1,"town",0)==0) then
			Wait(1);
			if (GetGameTime() > time+60) then
				Wait(2);
				FailObjective(2);
				Wait(3);
				Win(1);
				break;
			end;
		else
			StartThread(LoseCity);
			break;
		end;
	end;
end;


GiveObjective(0);
--StartThread(initial);
StartThread(CompleteObjective0);
StartThread(artillery);
StartThread(reiders);
StartThread(recon);
StartThread(wunderwaffe);
StartThread(flak);
StartThread(CompleteObjective1);
StartThread(forceTo_key_building2);
StartThread(town_key_building);
StartThread(forceTo_key_railroad);
StartThread(lose);
StartThread(train);