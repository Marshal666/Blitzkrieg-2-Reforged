success = 0;
sel = 0;
Objective_0 = 0;

function initial()
	cannons = GetObjectListArray(1100);
	for i=1,cannons.n do
		SetAmmo(cannons[i],0,0);
	end;
	StartThread(select);
end;



function DifficultyManager()
	Wait(2);
	if (GetDifficultyLevel() > 0) then
		Cmd(ACT_TAKE_ARTILLERY,1922,1921);
	end;
end;


function megatank()
	while 1 do
		Wait(3);
		if (IsAlive(GetObjectList(710)) == 0) then
			Trace("Snowman is dead");
			Wait(5);
			LandReinforcementFromMap(0,"megatank",0,711);
			Cmd(ACT_SWARM,711,100,7575, 1207);
			break;
		end;
	end;
end;

function megamost()
	while 1 do
		Wait(1);
		if (GetObjectHPs(GetObjectList(1101)) < 3999) then
			DamageScriptObject(1101, -(4000 - GetObjectHPs(GetObjectList(1101))));
		end;
	end;
end;



function poteha(n)
	Trace("n = %g",n);
	for i=n,5 do
		truck_x,truck_y = GetScriptObjCoord(1110+i)
		PlayEffect(2,truck_x,truck_y,300);
		DamageScriptObject(1110+i,0);
		Trace("Object %g was destroyed. First sequence.",1110+i);
		Wait(1);
	end;
	for i = n,1,-1 do
		truck_x,truck_y = GetScriptObjCoord(1110+i)
		PlayEffect(2,truck_x,truck_y,300);
		DamageScriptObject(1110+i,0);
		Trace("Object %g was destroyed. Secondary sequence.",1110+i);
		Wait(1);
	end;
end;



function BridgeCrush()
	Crush = 1;
	PlayEffect(2,6452, 6577,0);
	Wait(1);
	PlayEffect(2,6603, 6675,0);
	Wait(1);
	PlayEffect(2,6688, 6735,0);
	PlayEffect(2,6802, 6890,0);
	Wait(1);
	PlayEffect(3,6903, 6878,0);
	PlayEffect(2,6903, 6878,0);
	PlayEffect(2,6961, 6979,0);
	Wait(1);
	PlayEffect(2,7119, 7029,0);
	PlayEffect(2,6395, 6556,0);
	ViewZone("bridge",1);
	Wait(1);
	--for i=1,Bridge.n do
	--	DamageObject(Bridge[i],4000);
	--end;
	DamageScriptObject(1101,0);
	PlayEffect(0,6700,6800,0);
	Wait(1);
	PlayEffect(1,6700,6800,0);
	Wait(2);
	PlayEffect(0,6700,6800,0);
	PlayEffect(2,6452, 6577,0);
	Wait(1);
	PlayEffect(2,6603, 6675,0);
	Wait(4);
	ViewZone("bridge",0);
	StartThread(EnemyReinf);
end;



function lose()
 	while 1 do 
		if (GetNUnitsInPlayerUF(0)==0 and GetReinforcementCallsLeft(0)==0) then
 				Wait(2);
 				Win(1);
         return 1;
 		end;
 	Wait(5);
 	end;
end; 
 
function CompleteObjective0()
 	while 1 do
 		Wait (15);
         if (GetNUnitsInArea(1,"objective0",0) == 0 and GetNUnitsInArea(0,"objective0",0) > 0) then
            Wait (1);
 			CompleteObjective (0);
 			Objective_0 = 1;
			Wait(2);
			GiveObjective(1);
			StartThread(CompleteObjective1); 
			for i=1,5 do
				Cmd(ACT_MOVE,1110+i,0,5696, 6180);
				QCmd(ACT_MOVE,1110+i,0,7799, 7619);
				QCmd(ACT_RESUPPLY,1110+i,500,7799, 7619);
			end;
 			break;
 		end;
 	end;
end;  

function CompleteObjective1()
	while 1 do
 		Wait (2);
        if (GetNUnitsInScriptGroup(1100,1)==0) then
            Wait (2);
 			CompleteObjective (1);
 			Wait(3);
			Win(0);
 			break;
 		end;
 	end;
end; 


function CompleteHiddenObjective()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1111)==0 and GetNUnitsInScriptGroup(1112)==0 and GetNUnitsInScriptGroup(1113)==0 and GetNUnitsInScriptGroup(1114)==0 and GetNUnitsInScriptGroup(1115)==0) then
			CompleteObjective(2);
			break;
		end;
	end;
end;

function bridge()
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup( 1101 ) == 0)  then 
			BridgeDestroyed = 1;
			break;
		end;
	end;
end;


function trucks_retreat_north()
	while 1 do
		Wait(1);
		if (Objective_0 == 0) then
			if (GetNUnitsInScriptGroup(11,1)==0) then
				Trace("tank 11 lost");
				Cmd(ACT_SWARM,1120,300,3047, 6198);
				QCmd(ACT_SWARM,1120,300,3047, 6198);
				Wait(2);
				Cmd(ACT_MOVE,1126,0,3047, 6198);
				QCmd(ACT_MOVE,1126,0,3047, 6198);
				QCmd(ACT_DEPLOY,1126,0,4398, 4199);
				Wait(2);
				Cmd(ACT_MOVE,1125,0,3047, 6198);
				QCmd(ACT_MOVE,1125,0,3047, 6198);
				QCmd(ACT_DEPLOY,1125,0,4861, 5316);
				break;
			end;
		else
			Wait(10);
			Cmd(ACT_DEPLOY,1126,0,1318, 7030);
			Wait(2);
			Cmd(ACT_DEPLOY,1125,0,998, 7401);
			break;
		end;
	end;
end;

function trucks_retreat_east()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(12)==0) then
			Cmd(ACT_SWARM,1121,300,4692,3791);
			break;
		end;
	end;
end;

function trucks_bubuh()
	Wait(1);
	while 1 do
		if (Objective_0 == 0) then
			Wait(1);
			for i=1,5 do
				if (GetNUnitsInScriptGroup(1110+i)==0) then
					n = i;
					StartThread(poteha,n);
					Trace("Thread poteha has started...");
					success = 1;
					break;
				end;
			end;
			if success == 1 then
				break;
			end;
		else
			break;
		end;
	end;
end;

function select()
	Point_x = {5195,4235,4045};
	Point_y = {3673,4014,5451};
	Entrench = {1151,1153,1155};
	Units1 = GetObjectListArray(1130);
	Units2 = GetObjectListArray(1131);
	Units3 = GetObjectListArray(1132);
	InitialHP_1 = {GetObjectHPs(Units1[1]),GetObjectHPs(Units2[1]),GetObjectHPs(Units3[1])};
	InitialHP_2 = {GetObjectHPs(Units1[2]),GetObjectHPs(Units2[2]),GetObjectHPs(Units3[2])};
	InitialAmmo_1 = {GetAmmo(Units1[1]),GetAmmo(Units2[1]),GetAmmo(Units3[1])};
	InitialAmmo_2 = {GetAmmo(Units1[2]),GetAmmo(Units2[2]),GetAmmo(Units3[2])};
	
	while 1 do
		Wait(1);
		j = 0;
		for j=0,2 do
			units = GetObjectListArray(1130+j);
			if (GetObjectHPs(units[1])~=InitialHP_1[j+1] or GetAmmo(units[1])~= InitialAmmo_1[j+1] or GetObjectHPs(units[2])~=InitialHP_2[j+1] or GetAmmo(units[2])~= InitialAmmo_2[j+1]) then
				Cmd(ACT_SWARM,1140, 0, Point_x[j+1], Point_y[j+1]);
				QCmd(ACT_ENTER,1140,Entrench[j+1]);
				Cmd(ACT_SWARM,1141, 0, Point_x[j+1], Point_y[j+1]);
				QCmd(ACT_ENTER,1141,Entrench[j+1]);
				StartThread(retreat,j);
				Trace("Thread retreat has started. j = %g",j);
				sel = 1;
				break;
			end;
		end;
		if sel == 1 then
			Trace("Thread closed");
			break;
		end;
	end;
end;

function retreat(z)
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1130+z,1)==0) then
			if z == 0 then
				Cmd(ACT_MOVE,1140,0,1654, 6662);
				Cmd(ACT_MOVE,1141,0,1654, 6662);
				Cmd(ACT_MOVE,1161,0,1654, 6662);
				Trace("Retreat to the North");
			end;
			if z == 1 then
				Cmd(ACT_MOVE,1140,0,7039, 1900);
				Cmd(ACT_MOVE,1141,0,1654, 6662);
				Cmd(ACT_MOVE,1162,0,1654, 6662);
				Cmd(ACT_MOVE,1164,0,7039, 1900);
				Trace("Retreat to the North and to the East");
			end;
			if z == 2 then
				Cmd(ACT_MOVE,1140,0,7039, 1900);
				Cmd(ACT_MOVE,1141,0,7039, 1900);
				Cmd(ACT_MOVE,1163,0,7039, 1900);
				Trace("Retreat to the East");
			end;
			break;
		end;
	end;
end;

function north()
	Trace("North reinforcement thread has started");
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1161,"North",0)>0 or
			GetNScriptUnitsInArea(1162,"North",0)>0 or 
			GetNScriptUnitsInArea(1163,"North",0)>0 or 
			GetNScriptUnitsInArea(1164,"North",0)>0 or 
			GetNScriptUnitsInArea(1140,"North",0)>0 or 
			GetNScriptUnitsInArea(1141,"North",0)>0) then
			Trace("Condition for the North Reinforcement success");
			if (GetNUnitsInArea(1,"North",0) > 0) then
				if GetDifficultyLevel() == 1 then
					GiveReinforcementCalls(1,1);
					Trace("AI get one reinforcement. Difficulty Level is normal. East.");
				end;
			end;
			Cmd(ACT_SWARM,1120,500,4235, 4014);
			Wait(35);
			Cmd(ACT_SWARM,1171,500,4235, 4014);
			QCmd(ACT_SWARM,1171,500,5278, 5816);
			QCmd(ACT_SWARM,12,500,5278, 5816);
			Wait(5);
			QCmd(ACT_SWARM,1171,500,4235, 4014);
			Cmd(ACT_SWARM,12,500,500, 500);
			break;
		end;
	end;
end;

function east()
	Trace("East reinforcement thread has started");
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1161,"East",0)>0 or
			GetNScriptUnitsInArea(1162,"East",0)>0 or 
			GetNScriptUnitsInArea(1163,"East",0)>0 or 
			GetNScriptUnitsInArea(1164,"East",0)>0 or 
			GetNScriptUnitsInArea(1140,"East",0)>0 or 
			GetNScriptUnitsInArea(1141,"East",0)>0) then
			Trace("Condition for the East Reinforcement success");
			if (GetNUnitsInArea(1,"East",0) > 0) then
				if GetDifficultyLevel() == 1 then
					GiveReinforcementCalls(1,1);
					Trace("AI get one reinforcement. Difficulty Level is normal. East.");
				end;
				if GetDifficultyLevel() == 2 then
					GiveReinforcementCalls(1,2);
					Trace("AI get two reinforcements. Difficulty Level is hard. East.");
				end;
			end;
			Cmd(ACT_SWARM,1121,500,4235, 4014);
			Wait(35);
			Cmd(ACT_SWARM,1170,500,4235, 4014);
			Cmd(ACT_SWARM,12,500,4235, 4014);
			QCmd(ACT_SWARM,1170,500,5278, 5816);
			QCmd(ACT_SWARM,12,500,5278, 5816);
			Wait(5);
			QCmd(ACT_SWARM,1170,500,4235, 4014);
			break;
		end;
	end;
end;

function capture_aa()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"aa",0)>0 or (GetNUnitsInArea(0,"avia",0)~=GetNUnitsInArea(0,"avia",1))) then
			Trace("in area aa has detected Player units")
			Cmd(ACT_TAKE_ARTILLERY,1165,1175);
			break;
		end;
	end;
end;

function capture_aa2()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"aa2",0)>0) then
			Trace("in area aa2 has detected Player units")
			Cmd(ACT_TAKE_ARTILLERY,1166,1176);
			break;
		end;
	end;
end;

function capture_aa3()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"aa3",0)>0) then
			Trace("in area aa3 has detected Player units")
			Cmd(ACT_TAKE_ARTILLERY,1167,1177);
			break;
		end;
	end;
end;

function selector(R)
	while 1 do
		Wait(1);
		for i=1,4 do
			if (GetNUnitsNearObj(0,GetObjectList(1160+i),R)>0) then
				if (IsAlive(GetObjectList(1160+i))==1) then
					StartThread(boyus_boyus,1160+i,R);
					Trace("Enemy detected. ID = %g",1160+i);
				end;
			end;
		end;
	end;
end;


function boyus_boyus(ScriptID,Radius)
		Wait(1);
			if (GetNUnitsNearObj(0,GetObjectList(ScriptID),Radius)>0) then
				player_x,player_y = GetScriptObjCoord(ScriptID);
				vrag = GetArray(GetUnitListInArea(0,player_x,player_y,Radius,0));
				enemy_x,enemy_y = ObjectGetCoord(vrag[1]);
				Trace("Enemy_x = %g", enemy_x);
				Trace("Enemy_y = %g", enemy_y);
				Trace("Player_x = %g", player_x);
				Trace("Player_y = %g", player_y);
				dif_x = player_x - enemy_x;
				dif_y = player_y - enemy_y;
				Trace("x difference = %g",dif_x);
				Trace("y difference = %g",dif_y);
				radius = sqrt(dif_x*dif_x+dif_y*dif_y);
				Trace("Radius = %g",radius);
				relation = dif_x/dif_y;
				Retreat_point_x = player_x + dif_x;
				Trace("Retreat point x = %g",Retreat_point_x);
				Retreat_point_y = player_y + dif_y;
				Trace("Retreat point y = %g",Retreat_point_y);
				Cmd(ACT_MOVE,ScriptID,0,Retreat_point_x,Retreat_point_y);
			end;
end;

function italians()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(600,0)==1) then
			Wait(2);
			LandReinforcementFromMap(0,"italian",2,601);
			Cmd(ACT_SWARM,601,0,7098, 1818);
			Wait(3);
			LandReinforcementFromMap(0,"italian",2,602);
			Cmd(ACT_SWARM,602,0,7248, 1631);
			Wait(3);
			LandReinforcementFromMap(0,"italian",2,603);
			Cmd(ACT_SWARM,603,0,7379, 1484);
			Wait(3);
			LandReinforcementFromMap(0,"italian",2,604);
			Cmd(ACT_SWARM,604,0,7538, 1405);
			Wait(3);
			LandReinforcementFromMap(0,"italian",2,605);
			Cmd(ACT_SWARM,605,0,7729, 1342);
			break;
		end;
	end;
end;



GiveObjective(0);
StartThread(CompleteObjective0);
StartThread(trucks_retreat_east);
StartThread(trucks_retreat_north);
StartThread(initial);
StartThread(trucks_bubuh);
StartThread(CompleteHiddenObjective);
StartThread(capture_aa);
StartThread(capture_aa2);
StartThread(capture_aa3);
StartThread(lose);
StartThread(north);
StartThread(east);
StartThread(megamost);
StartThread(megatank);
StartThread(selector,600);
StartThread(italians);