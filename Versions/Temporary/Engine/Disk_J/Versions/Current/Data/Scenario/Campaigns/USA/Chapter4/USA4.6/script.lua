WestPoint = 0;
-- 0 -> 3
-- 1 -> 3
-- ScriptID 13
NorthWestPoint = 0;
-- 0 -> 2
-- 1 -> 2
-- ScriptID 12
NorthEastPoint = 0;
-- 0 -> 0
-- 1 -> 1
-- ScriptID 11
EastPoint = 0;
-- 0 -> 4
-- 1 -> 0
-- ScriptID 10
SouthPoint = 0;
-- 0 -> 1
-- 1 -> 4
-- ScriptID 50
--Points = {EastPoint,NorthEastPoint,NorthWestPoint,WestPoint};
l1 = 0;
l2 = 0;
l3 = 0;
l4 = 0;
l5 = 0;

function initial()
	PlayEffect(0,2027, 4976,150);
	PlayEffect(0,1812, 5081,150);
	PlayEffect(0,1706, 5323,150);
	Wait(30);
	PlayEffect(0,2027, 4976,150);
	PlayEffect(0,1812, 5081,150);
	PlayEffect(0,1706, 5323,150);
	Wait(120);
	StartThread(west);
	StartThread(north_west);
	StartThread(north_east);
	StartThread(east);
end;

function west()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(13,0)==1) then
		--if 1 then
			if (GetNUnitsInScriptGroup(12,1)==1) then
				LandReinforcementFromMap(1,"bombers",2,2000);
				LandReinforcementFromMap(1,"paratroopers",2,2001);
				Cmd(ACT_MOVE,2000,0,5100,500);
				Cmd(ACT_UNLOAD,2001,0,5100,500);
			else
				Trace("podmoga for West point is not available");
			end;
				WestPoint = WestPoint + 1;
			break;
		end;
	end;
end;

function north_west()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(12,0)==1) then
			if (GetNUnitsInScriptGroup(11,1)==1) then
				LandReinforcementFromMap(1,"nebelwerfer",1,1100);
				Cmd(ACT_MOVE,1100,0,600,3500);
				QCmd(ACT_SUPPRESS,1100,0,700,500);
				LandReinforcementFromMap(1,"sturmgruppe",1,1101);
				Cmd(ACT_SWARM,1101,0,700,500);
			else
				Trace("podmoga for NorthWest point is not available");
			end;
			NorthWestPoint = NorthWestPoint + 1;
			break;
		end;
	end;
end;

function north_east()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(11,0)==1) then
			if (GetNUnitsInScriptGroup(12,1)==1) then
				LandReinforcementFromMap(1,"nebelwerfer",2,1200);
				Cmd(ACT_MOVE,1200,0,600,3500);
				QCmd(ACT_SUPPRESS,1200,0,700,7300);
				LandReinforcementFromMap(1,"sturmgruppe",2,1201);
				Cmd(ACT_SWARM,1201,0,700,7300);
			else
				Trace("podmoga for NorthEast point is not available");
			end;
			NorthEastPoint = NorthEastPoint + 1;
			break;
		end;
	end;
end;

function east()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(10,0)==1) then
			if (GetNUnitsInScriptGroup(11,1)==1) then
				LandReinforcementFromMap(1,"nebelwerfer",1,1200);
				Cmd(ACT_MOVE,1200,0,2600,6500);
				QCmd(ACT_SUPPRESS,1200,0,5000,7600);
				LandReinforcementFromMap(1,"sturmgruppe",1,1201);
				Cmd(ACT_SWARM,1201,0,5000,7600);
			else
				Trace("podmoga for East point is not available");
			end;
			break;
		end;
	end;
end;

function first_point_recapture()
	Wait(80);
	if (GetNUnitsInArea(0,"northeastpoint",0) > 0) then
		LandReinforcementFromMap(1,"bombers",2,2001);
		Cmd(ACT_MOVE,2001,0,700,7300);
		Cmd(ACT_SWARM,1150,0,700,7300);
		QCmd(ACT_SWARM,1150,0,700,2200);
	end;
	Cmd(ACT_SWARM,1151,0,700,7300);
	Cmd(ACT_SWARM,1152,0,700,7300);
	QCmd(ACT_SWARM,1152,0,5000,7400);
	Wait(20);
	Cmd(ACT_MOVE,1151,0,700,7300);
	StartThread(waves);
end;

function recon(j)
	n=0;
	for i=0,3 do
		if (GetNUnitsInScriptGroup(10+i,1)==1) then
			n = n+1;
		end;
	end;
	Trace("Enemy has got %g Key Points",n);
	for z=0,3 do
		if (GetNUnitsInScriptGroup(10+z,1)==1) then
			--name = "infantry_sync"
			LandReinforcementFromMap(1,"recon_infantry",z,3000+z+10*j);
			StartThread(infantry_sync,z,j);
		end;
	end;
	while 1 do
		Wait(1);
		N = 0;
		PointID = 0;
		for i=0,3 do
			if (IsSomeBodyAlive(1,3000+i+10*j)==1) then
				N = N + 1;
				PointID = i;
			end;
		end;
		--Trace("Enemy has got %g infantry squads",N);
		if (N == 1) then
			Trace("Enemy is swarming from %g Key Point",PointID);
			TempPointID = PointID;
			LandReinforcementFromMap(1,"recon_armor"..j,TempPointID,3100);
			Cmd(ACT_SWARM,3100,0,GetScriptAreaParams("cross"));
			QCmd(ACT_SWARM,3100,0,GetScriptAreaParams("end"));
			Wait(20);
			LandReinforcementFromMap(1,"main_armor"..j,TempPointID,3101);
			Cmd(ACT_SWARM,3101,0,GetScriptAreaParams("cross"));
			QCmd(ACT_SWARM,3101,0,GetScriptAreaParams("end"));
			break;
		end;
	end;
end;

function infantry_sync(z,j)
	if (z == 2) then
		Wait(15);
	end;
	if (z == 0) then
		Wait(18);
	end;
	if (z == 3) then
		Wait(45);
	end;
	Trace("Enemy infantry has swarmed from %g Key Point",z);
	Cmd(ACT_SWARM,3000+z+10*j,0,4700,3400);
end;

function waves()
	for j = 1,5 do
		StartThread(recon,j);
		if j == 3 then
			LandReinforcementFromMap(1,"paratroopers",2,9100);
			Cmd(ACT_UNLOAD,9100,0,7000,1700);
			Wait(3);
			LandReinforcementFromMap(1,"paratroopers",2,9101);
			Cmd(ACT_UNLOAD,9101,0,6800,5000);
			StartThread(para,9100);
			StartThread(para,9101);
		end;
		if j == 5 then
			Wait(40);
			Cmd(ACT_SWARM,1150,0,5300,3300);
			Cmd(ACT_SWARM,1151,0,5300,3300);
		end;
		if (j==5) then
			Wait(90);
			StartThread(win);
		end;
		Wait(170+10*j);
	end;
end;

function para(ScriptID)
	Wait(45);
	Units = GetObjectListArray(ScriptID);
	for i=1,5 do 
		stats = GetArray(GetUnitRPGStats(Units[i]));
		if (stats[1]~=1) then
			UnitQCmd(ACT_MOVE,Units[i],0,7200,3600)
			if (stats[3]==3) then
				UnitQCmd(ACT_ENTER,Units[i],GetObjectList(15));
			end;
		end;
	end;
end;

function test()
	LandReinforcementFromMap(1,"paratroopers",2,9100);
	Cmd(ACT_UNLOAD,9100,0,7000,1700);
	Wait(3);
	LandReinforcementFromMap(1,"paratroopers",2,9101);
	Cmd(ACT_UNLOAD,9101,0,6800,5000);
	StartThread(para,9100);
	Wait(1);
	StartThread(para,9101);
end;

function start_recapturing()
	EnemyPoints = {0,1,2,3,4};
	PlayerPoints = {4,0,2,3,1};
	--EnemyPoints = {3,2,1,0,4};
	--PlayerPoints = {3,2,0,4,1};
	Markers = {l1,l2,l3,l4,l5};
	for i=1,5 do
		StartThread(recapturing,9+i,PlayerPoints[i],EnemyPoints[i],0);
	end;
end;

function recapturing(PointScriptID,PlayerPoint,EnemyPoint,marker)
	Trace("Thread recapturing has been started");
	Trace(GetNUnitsInScriptGroup(PointScriptID,0));
	if (GetNUnitsInScriptGroup(PointScriptID,0)==1) then
		Trace("Condition success...");
		Owner = 0;
		if marker~=0 then 
			LandReinforcementFromMap(0,"player_bonus_tanks",PlayerPoint,5500);
			LandReinforcementFromMap(0,"player_bonus_spg",PlayerPoint,5500);
			Trace("Player has got bonus!!!");
		end;
		marker = marker+1;
		StartThread(GiveBonus,Owner,PointScriptID,PlayerPoint,EnemyPoint,marker);
	else
		Trace("Condition unsuccess...");
		Owner = 1;
		if marker~=0 then
			LandReinforcementFromMap(1,"enemy_bonus",EnemyPoint,5600);
			Cmd(ACT_SWARM,5600,0,5300,3300);
			Trace("Enemy has got bonus :(");
		end;
		marker = marker+1;
		StartThread(GiveBonus,Owner,PointScriptID,PlayerPoint,EnemyPoint,marker);
	end;
end;

function GiveBonus(Owner,PointScriptID,PlayerPoint,EnemyPoint,marker)
	Trace("Thread GiveBonus has been started");
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(PointScriptID,Owner)==0) then
			Trace("Thread GiveBonus has started");
			Trace("Owner is %g",Owner);
			StartThread(recapturing,PointScriptID,PlayerPoint,EnemyPoint,marker);
			break;
		end;
	end;
end;

function kaput()
	while 1 do
		Wait(3);
		if ((GetNUnitsInPlayerUF(0)==0 and GetNUnitsInPlayerUF(2)==0 and GetReinforcementCallsLeft(0)==0)
			or GetNUnitsInScriptGroup(6000)==0) then
				Win(1);
			break;
		end;
	end;
end;

function bridge_kaput()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(1,"Most",0)>0 and GetNUnitsInArea(0,"Most",0)==0) then
			Wait(30);
			if (GetNUnitsInArea(1,"Most",0)>0 and GetNUnitsInArea(0,"Most",0)==0) then
				Win(1);
				break;
			end;
		end;
	end;
end;

function win()
	while 1 do
		Wait(1);
		if ((GetNUnitsInScriptGroup(3101)==0 and GetNUnitsInScriptGroup(3100)==0)
			 or (GetNUnitsInArea(1,"city",0)==0)
			 or (GetNUnitsInPlayerUF(1)==0)) then
			CompleteObjective(0);
			Wait(3);
			Win(0);
		end;
	end;
end;

function flags_win()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(10,0)==1 and GetNUnitsInScriptGroup(11,0)==1 and GetNUnitsInScriptGroup(12,0)==1 and GetNUnitsInScriptGroup(13,0)==1 and GetNUnitsInScriptGroup(14,0)==1) then
			CompleteObjective(0);
			Wait(3);
			Win(0);
		end;
	end;
end;

function hidden_objective()
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup(10,0)==1) then
			CompleteObjective(1);
			Wait(3);
			LandReinforcementFromMap(0,"column",4,3090);
			Cmd(ACT_MOVE,3090,0,5000,7300);
			break;
		end;
	end;
end;

function arriving()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"city",0)>0) then
			PlayerUnits = GetArray(GetUnitListOfPlayer(2));
			for i=1,PlayerUnits.n do
				ChangePlayer(PlayerUnits[i],0);
				Trace("Unit %g is mine! :)",i);
			end;
			StartThread(anti_spg_action);
			Trace("We have control under all allies units...");
			break;
		end;
	end;
end;

function anti_spg_action()
	while 1 do
		Wait(1);
		if (    GetNUnitsInScriptGroup(10,1)==1 
			and GetNUnitsInScriptGroup(11,1)==1 
			and GetNUnitsInScriptGroup(12,1)==1 
			and GetNUnitsInScriptGroup(13,1)==1
			and IsSomeUnitInArea(0,"spg", 0)==1) then
			Trace("All Key-Points In The Enemy hands and near the Bridge is spg...")
			local PlayerUnitsInArea = GetArray(GetUnitListInArea(0,"spg",0));
			for i=1,PlayerUnitsInArea.n do
				local UnitStats = GetArray(GetUnitRPGStats(PlayerUnitsInArea[i]));
				if (UnitStats[1]==1 and (UnitStats[3] == 25 or UnitStats[3] == 4 or UnitStats[3] == 24)) then
					Trace("SPG detected! The Bombers have been flown and soon will bombing...");
					LandReinforcementFromMap(1,"bombers",2,2000);
					Cmd(ACT_MOVE,2000,0,GetScriptAreaParams("spg"));
					Wait(120);
					break;
				end;
			end;
		end;
	end;
end;

GiveObjective(0);
StartThread(first_point_recapture);
StartThread(start_recapturing);
--StartThread(test);
StartThread(initial);
StartThread(kaput);
StartThread(hidden_objective);
StartThread(arriving);
StartThread(flags_win);
StartThread(bridge_kaput);