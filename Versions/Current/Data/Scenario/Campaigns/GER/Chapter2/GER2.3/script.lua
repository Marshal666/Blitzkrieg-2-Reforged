obj_2_MountPass = 0;
arr = {};
Survive = 0;
Obj1 = 0;
Obj2 = 0;
Complete1 = 0;
Complete2 = 0;
pass = 0;
Reinforcement = {"humber","crusader","crusader"};
Units = {};
Stats = {};
GroupID = 350;

-- 1101 - retreat group. (Blockpost) 
-- 1110 - City defence group. (Without artillery) 
-- 1111 - Pass defence group. (Without artillery) 
-- 1102 - British tanks reinforcements group 
-- 1103 - British infantry reinforcements group 
 
 
 
---------------- OBJECTIVE 0 ------------------ begin 
---- Destroy post
function DifficultyManager()
	Wait(1);
	if(GetDifficultyLevel()==0) then
		RemoveScriptGroup(351);
		RemoveScriptGroup(352);
		GroupID = 350;
	end;
	if(GetDifficultyLevel()==1) then
		RemoveScriptGroup(350);
		RemoveScriptGroup(352);
		GroupID = 351;
	end;
	if(GetDifficultyLevel()==2) then
		RemoveScriptGroup(350);
		RemoveScriptGroup(351);
		GroupID = 352;
	end;
end;


function approach_attack()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"approach",0)>1) then
			Cmd(ACT_SWARM,GroupID,500,5600,3800);
			break;
		end;
	end;
end;


function officer()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1140,"jeep",0)>0) then
			Wait(1);
			Cmd(ACT_MOVE,1142,0, 662, 6306);
			StartThread(willis);
			break;
		end;
	end;
end;

function willis()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1142,"jeep",0) > 0 and GetNScriptUnitsInArea(1140,"jeep",0) > 0) then
			Cmd(ACT_DISAPPEAR,1142);
			Cmd(ACT_MOVE,1140,0,237, 3153);
			QCmd(ACT_MOVE,1140,0,1446, 2195);
			QCmd(ACT_DEPLOY,1140,400,2054, 1648);
			break;
		end;
	end;
end;

function willis_arriving()
	while 1 do
		Wait(1);
		if ((GetNUnitsInScriptGroup(1120) == 0 or GetNUnitsInScriptGroup(1119) == 0 or GetNUnitsInScriptGroup(1122) == 0) and pass == 0) then
			Wait(1);
			Trace("Condition succesful...");
			Cmd(ACT_MOVE,1140,0,662, 6306);
			break;
		end
	end;
end;


function poehali()
	ammo = GetAmmo(GetObjectList(300));
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(300)==0 or GetAmmo(GetObjectList(300)) < ammo) then
			pass = 1;
			ChangePlayer(GetObjectList(1142),1);
			Cmd(ACT_MOVE,1122,0,269, 5597);
			QCmd(ACT_MOVE,1122,0,237, 3153);
			QCmd(ACT_MOVE,1122,0,1446, 2195);
			QCmd(ACT_DEPLOY,1122,0,2054, 1648);
			QCmd(ACT_MOVE,1122,400,1643, 1047);
			Wait(4);
			Cmd(ACT_MOVE,1119,0,269, 5597);
			QCmd(ACT_MOVE,1119,0,237, 3153);
			QCmd(ACT_MOVE,1119,0,1446, 2195);
			QCmd(ACT_DEPLOY,1119,0,1703, 2402);
			QCmd(ACT_MOVE,1119,400,1643, 1047);
			Wait(4);
			Cmd(ACT_MOVE,1120,0,269, 5597);
			QCmd(ACT_MOVE,1120,0,237, 3153);
			QCmd(ACT_MOVE,1120,0,1446, 2195);
			QCmd(ACT_DEPLOY,1120,0,1490, 2180);
			QCmd(ACT_MOVE,1120,400,1643, 1047);
			Wait(38);
			Cmd(ACT_ROTATE,1130,0,2688, 2890);
			Cmd(ACT_ROTATE,1131,0,2688, 2890);
			Cmd(ACT_ROTATE,1132,0,2688, 2890);
			break;
		end
	end;
end;

function CompleteObjective0()
	while 1 do
		Wait(3);
		if (GetNUnitsInArea(0,"Blockpost",0) > 0 and GetNUnitsInArea(1,"Blockpost",0) < 1) then
			CompleteObjective(0);
			GiveObjective(1);
			GiveObjective(2);
			StartThread(CompleteObjective1);
			StartThread(CompleteObjective2);
			--StartThread(capture_blockpost);
			break;
		end;
	end;
end; 


function CompleteObjective1()
	while 1 do
		Wait(3);
		if (GetNUnitsInArea(0,"Objective_1",0) > 0 and GetNUnitsInArea(1,"Objective_1",0) < 1) then
			CompleteObjective(1);
			Complete1 = 1;
			break;
		end;
	end;
end; 

function CompleteObjective2()
	while 1 do
		Wait(3);
		if (GetNUnitsInArea(0,"Objective_2",0) > 0 and GetNUnitsInArea(1,"Objective_2",0) < 1) then
			CompleteObjective(2);
			Complete2 = 1;
			break;
		end;
	end;
end; 


 
function enemy_survive() 	
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1150,"Remove",0) > 0) then
			StartThread(repelling_blockpost);
			RemoveScriptGroup(1150);
			Wait(90);
			LandReinforcementFromMap(1, "tanks", 0, 1102);
			Obj1 = GetNUnitsInArea(0,"Objective_1",0);
			Obj2 = GetNUnitsInArea(0,"Objective_2",0);
			if ( Obj2 >= Obj1) then
				Cmd(ACT_SWARM,1102,500,1500, 2100);
				else
				Cmd(ACT_SWARM,1102,500,900,6200);
			end;
			Wait(160);
			LandReinforcementFromMap(1, "infantry", 0, 1103);
			Obj1 = GetNUnitsInArea(0,"Objective_1",0);
			Obj2 = GetNUnitsInArea(0,"Objective_2",0);
			if ( Obj2 >= Obj1) then
				Cmd(ACT_SWARM,1103,500,1500, 2100);
				else
				Cmd(ACT_SWARM,1103,500,900,6200);
			end;
			Survive = 1;
			break;
		end;
	end;
end;
 
function repelling_blockpost()
	Wait(30);
	n = 0;
	while (n <= GetDifficultyLevel()) do
		Wait(2);
		if (GetNUnitsInArea(0,"Blockpost",0) >= 0) then
			LandReinforcementFromMap(1,Reinforcement[GetDifficultyLevel()+1],0,900);
			Cmd(ACT_SWARM,900,500,5600,3800);
			Wait(4);
			LandReinforcementFromMap(1,Reinforcement[GetDifficultyLevel()+1],0,901);
			Cmd(ACT_SWARM,901,500,5600,3800);
			Wait(120-20*GetDifficultyLevel());
			if (GetNUnitsInScriptGroup(950)==0 and GetNUnitsInScriptGroup(951)==0) then
				StartThread(capture_blockpost);
			end;
			n = n + 1;
		end;
	end;
end;
 
function capture_blockpost()
	Trace("Thread capture_blockpost has started...");
	while 1 do
		Wait(2);
		if (GetNUnitsInArea(0,"Blockpost",0) == 0 ) then
			LandReinforcementFromMap(1,"humber",0,949);
			Cmd(ACT_SWARM,949,500,5600,3800);
			Wait(3);
			LandReinforcementFromMap(1,"truck",0,950);
			Units = GetObjectListArray(950);
			for i=1,GetNUnitsInScriptGroup(950) do
				Stats = GetArray(GetUnitRPGStats(Units[i]));
				if (Stats[3] == 11) then
					Trace("Unit is resupply truck");
					UnitCmd(ACT_MOVE,Units[i],0,5580, 4126);
					UnitQCmd(ACT_DEPLOY,Units[i],0,5908, 3380);
					UnitQCmd(ACT_MOVE,Units[i],0,5875, 3250);
					UnitQCmd(ACT_MOVE,Units[i],0,5578, 4275);
					StartThread(cannon_1_entrench);
				end;
			end;
			Wait(4);
			LandReinforcementFromMap(1,"truck",0,951);
			Units = GetObjectListArray(951);
			for i=1,GetNUnitsInScriptGroup(951) do
				Stats = GetArray(GetUnitRPGStats(Units[i]));
				if (Stats[3] == 11) then
					Trace("Unit 2 is resupply truck");
					UnitCmd(ACT_MOVE,Units[i],0,5650, 4548);
					UnitQCmd(ACT_DEPLOY,Units[i],0,5437, 3257);
					UnitQCmd(ACT_MOVE,Units[i],0,5667, 3124);
					UnitQCmd(ACT_MOVE,Units[i],0,5392, 3912);
					StartThread(cannon_2_entrench);
				end;
			end;
			break;
		end;
	end;
end;

function cannon_1_entrench()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(950,"cannon1",0)>0) then
			Units = GetObjectListArray(950);
			for i=1,GetNUnitsInScriptGroup(950) do
				Stats = GetArray(GetUnitRPGStats(Units[i]));
				if (Stats[3] == 4) then
					Trace("Unit is antitank artillery");
					Wait(8);
					UnitCmd(ACT_ROTATE,Units[i],0,6300,1600);
					UnitQCmd(ACT_ROTATE,Units[i],0,6300,1600);
					UnitQCmd(ACT_ENTRENCH,Units[i],1);
					StartThread(crew);
					break;
				end;
			end;
			break;
		end;
	end;
end;

function cannon_2_entrench()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(951,"cannon2",0)>0) then
			Units = GetObjectListArray(951);
			for i=1,GetNUnitsInScriptGroup(951) do
				Stats = GetArray(GetUnitRPGStats(Units[i]));
				if (Stats[3] == 4) then
					Trace("Unit 2 is antitank artillery");
					Wait(8);
					UnitCmd(ACT_ROTATE,Units[i],0,6300,1600);
					UnitQCmd(ACT_ROTATE,Units[i],0,6300,1600);
					UnitQCmd(ACT_ENTRENCH,Units[i],1);
					break;
				end;
			end;
			break;
		end;
	end;
end;

function crew()
	if (GetNUnitsInScriptGroup(1150)>0) then
		Trace("Thread Crew has started...");
		Cannons = GetObjectListArray(1150);
		for i=1,GetNUnitsInScriptGroup(1150) do
			ScriptID = 952+i;
			LandReinforcementFromMap(1,"crew",0,ScriptID);
			Cmd(ACT_SWARM,ScriptID,500,5600,3800);
			UnitQCmd(ACT_TAKE_ARTILLERY,GetObjectList(ScriptID),Cannons[i]);
			Wait(3);
		end;
	end;
end;


function officer_survive()
	while 1 do
		Wait(3);
		if (GetNScriptUnitsInArea(1140,"Objective_2",0) > 0) then
			StartThread(GroundAttackPlane);
			break;
		end;
	end;
end; 

function hidden_objective()
	while 1 do
		Wait(3);
		if (GetNUnitsInScriptGroup(1140) == 0 and GetNUnitsInArea(1,"officer",0)==0 and GetNUnitsInArea(0,"officer",0)>0 and GetNUnitsInScriptGroup(1142)>0) then
			--if (1) then
			GiveObjective(3);
			Wait(5);
			ChangePlayer(GetObjectList(1142),0);
			Cmd(ACT_MOVE,1142,0,590,6600);
			StartThread(call_planes);
			break;
		end;
	end;
end; 


function lose() 
	while 1 do 
        if ( GetNUnitsInParty(0) < 1 and GetReinforcementCallsLeft(0) < 1) then 
				Wait(2); 
				Loose(0); 
        return 1; 
		end; 
	Wait(5); 
	end; 
end; 

function GroundAttackPlane()
	LandReinforcementFromMap(1, "gap", 1, 1104);
	Cmd(ACT_MOVE, 1104, 1, 3928, 3968);
	Wait(30);
	LandReinforcementFromMap(1, "fighters", 1, 1104);
	Cmd(ACT_MOVE, 1104, 1, 3928, 3968);
	Wait(120);
	LandReinforcementFromMap(1, "gap", 1, 1104);
	Cmd(ACT_MOVE, 1104, 1, 3928, 3968);
end; 

function call_planes()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1142,"domik",0) > 0) then
			if (IsAlive(GetObjectList(1145))==1) then
				CompleteObjective (3);
				Trace("Enemy Communication center has captured!");
				Wait(5);
				LandReinforcementFromMap(0,"planes",1,1009);
				Cmd(ACT_MOVE,1009,500,1600,2300);
				Wait(25);
				arr = GetArray(GetObjectList(1009));
				ChangePlayerForArray(arr,1);
				Wait(100);
				LandReinforcementFromMap(1,"planes",0,1109);
				Cmd(ACT_MOVE,1109,500,800,6600);
				break;
			else
				CompleteObjective(3);
				Trace("building was destroyed...");
				break;
			end;
		end;
		if (GetNUnitsInScriptGroup(1142)==0) then
			CompleteObjective(3);
			break;
		end;
	end;
end; 

function retreat()
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup(1150,1)<3) then	
			Cmd(ACT_MOVE,1150,0,6300,7100);
			Wait(12);
			--ChangeFormation(1150,1);
			break;
		end;
	end;
end;

function win()
	while 1 do
		Wait(3);
		if (Complete1 == 1 and Complete2 == 1) then
			Win(0);
			break;
		end;
	end;
end;

--main 

GiveObjective(0);
StartThread(hidden_objective);
StartThread(DifficultyManager);
StartThread(approach_attack);
StartThread(retreat);
StartThread(CompleteObjective0);
StartThread(enemy_survive);
StartThread(poehali); 
StartThread(officer); 
StartThread(willis_arriving);
StartThread(officer_survive);
--StartThread(officer_captured);
StartThread(lose);
StartThread(win);