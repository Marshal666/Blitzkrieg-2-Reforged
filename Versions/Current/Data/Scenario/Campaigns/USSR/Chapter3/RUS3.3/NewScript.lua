CapturedOfficerID = 111;
EnemyOfficerID = 110;
TanksID = 1210;
TanksArray = GetObjectListArray(TanksID);
SwitchSquadLightFX(TanksID,0);
GlobalUniqID = {};
GlobalUniqID.n = 0;
objective0 = 0;
LeftDestroyed = 0;
RightDestroyed = 0;
SquadAlarm = 0;
terminate = 0;
biker_1 = 1150;
biker_2 = 1151;
biker_3 = 1152;
SouthSquadOfficer = 1161;
SouthSquadInfantry = 1160;
SouthSquadDog = 1162;
WestSquadOfficer = 1190;
WestSquadInfantry = 1191;
WestSquadDog = 1192;
EastSquadOfficer = 1186;
EastSquadInfantry = 1185;
EastSquadDog = 1187;
FireGuardOfficer = 1180;
FireGuardInfantry = 1181;
FireGuardMG = 1182;
RasstrelMG = 1195;
RasstrelOfficer = 1196;
RasstrelInfantry = 1197;
RasstrelElite = 1060;
RasstrelSniper = 1061;
PanzerGuardsInfantry = 1189;
PanzerGuardsOfficer = 1199;
FireGuardWestOfficer = 1178;
FireGuardWestInfantry = 1179;
SouthGuardsSquad = 1129;
EastGuardsSquad = 1128;
objective1 = 0;

WestAreaAlarmX, WestAreaAlarmY = GetScriptAreaParams("west_alarm");

South = {SouthSquadOfficer,3207, 2208,1100,1200,"village",SouthSquadInfantry};
West = {WestSquadOfficer,1880, 5400,1145,1245,"west_alarm",WestSquadInfantry};
East = {EastSquadOfficer,6621, 5084,1130,1230,"east_alarm",EastSquadInfantry};
Rasstrel = {RasstrelOfficer,WestAreaAlarmX, WestAreaAlarmY, 1145, 1245,"west_alarm"};
Panzer = {PanzerGuardsOfficer,WestAreaAlarmX, WestAreaAlarmY, 1145, 1245,"west_alarm"}
FirePanzer = {FireGuardWestOfficer ,WestAreaAlarmX, WestAreaAlarmY, 1145, 1245,"west_alarm"}

EastVillageGuardsPath = {
1013, 6514,
468, 5404,
1159, 4542,
2649, 4221,
3948, 5273,
2495, 6684,
1382, 7374
}
SouthVillageGuardsPath = 
{
3989, 3778,
2761, 3988,
2315, 3361,
1921, 2039,
2692, 729,
4209, 798,
5687, 1190,
5273, 2946,
4561, 3601
}
SouthWestPath = {6200, 5585,5379, 5540,5279, 4062,4302, 4309,	3883, 3603,	3413, 2473,	2863, 1875,	1705, 1463,	1125, 1105,	772, 563,	718, 237	};
WestPath = 	{	6610, 5616,	6461, 4339,	6191, 3907,	5760, 3876,	2602, 4867,	1247, 6057,	759, 7843	};
SouthPath = 	{	6471, 5560,	6602, 5002,	6410, 3312,	6683, 2479,	6863, 1060	};
SouthPathSquad = {2809, 1857,1513, 1369,829, 688,711, 249};
WestPathSquad = {2535, 4930,5223, 4064};
EastPathSquad = {
6355, 4082,
6414, 3346,
6736, 2154,
6878, 1011,
6282, 715,
4762, 1640,
4743, 4237,
3514, 6238,
4853, 6515
};

--Cmd(ACT_FOLLOW,1160,1161);
--Cmd(ACT_FOLLOW,1162,1161);



function DontTouchMe(Uniq_ID)
	local InitialPrimaryAmmo, InitialSecondaryAmmo = GetAmmo(Uniq_ID);
	local InitialHP = GetObjectHPs(Uniq_ID);
	--Trace("Initial Ammo = %g. UniqID = %g", InitialPrimaryAmmo, Uniq_ID);
	--while CurrentPrimaryAmmo==InitialPrimaryAmmo and CurrentSecondaryAmmo==InitialSecondaryAmmo do
	while 1 do
		Wait(0.2);
		if (IsAlive(Uniq_ID) == 1) then
			local Current_PrimaryAmmo, CurrentSecondaryAmmo = GetAmmo(Uniq_ID);
			local CurrentHP = GetObjectHPs(Uniq_ID);
			--Trace("Current Ammo = %g. UniqID = %g", Current_PrimaryAmmo, Uniq_ID);
			--Trace("  Primary Ammo. Initial, Current - %g, %g", InitialPrimaryAmmo, Current_PrimaryAmmo, Uniq_ID);
			if (Current_PrimaryAmmo ~= InitialPrimaryAmmo or InitialSecondaryAmmo ~= CurrentSecondaryAmmo
				or InitialHP ~= CurrentHP) then
				--Trace("Our unit with ID %g has engaged by enemy!",Uniq_ID);
				--Trace("  Primary Ammo. Initial, Current - %g, %g", InitialPrimaryAmmo, Current_PrimaryAmmo, Uniq_ID);
				--Trace("Secondary Ammo. Initial, Current - %g, %g",InitialSecondaryAmmo, CurrentSecondaryAmmo);
				--Trace("HPs. Initial, Current %g, %g",InitialHP,CurrentHP);
				--Wait(2);
				--DamageObject(UniqID,0);
				break;
			else
				if (GetNUnitsNearObj(1,Uniq_ID,1200) > 0) then
					local x,y = ObjectGetCoord(Uniq_ID);
					local UnitsArray = GetArray(GetUnitListInArea(1,x,y,1200,0));
					for i = 1,UnitsArray.n do
						if (IsAlive(UnitsArray[i])==1) then
							Trace("EnemyCanSee our Unit");
							UnitCmd(ACT_STOP,UnitsArray[i]);
							--DamageObject(UnitsArray[i],0);
						end;
					end;
				end;
			end;
		else
			break;
		end;
	end;
end;

--StartThread(DontTouchMe);

function CompleteObjective0()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(CapturedOfficerID,2)==1) then
			objective0 = 1;
			CompleteObjective(0);
			GiveObjective(1);
			GiveObjective(2);
			StartThread(CompleteObjective1);
			StartThread(CompleteObjective2);
			break;
		end;
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(EnemyOfficerID)==0) then
			CompleteObjective(1);
			objective1 = 1;
			break;
		end;
	end;
end;

function CompleteObjective2()
	while 1 do
		Wait(1);
		if (LeftDestroyed == 1 and RightDestroyed == 1) then
			Wait(3);
			CompleteObjective(2);
			if objective1 == 0 then
				CompleteObjective(1);
			end;
			Wait(2);
			Win(0);
			break;
		end;
	end;
end;


function CaptureLanguage()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1104)==0) then
			Trace("Enemy officer has been captured...");
			Wait(5);
			ChangePlayerForScriptGroup(CapturedOfficerID,2);
			SetAmmo(GetObjectList(CapturedOfficerID),0,0);
			StartThread(follow);
			break;
		end;
	end;
end;

function follow()
	while 1 do
		Wait(2);
		local x,y = GetScriptObjCoord(CapturedOfficerID);
		local PlayerUnitsInArea = GetArray(GetUnitListInArea(0,x,y,400,0));
		if (IsUnitNearScriptObject(0,CapturedOfficerID,400)==1) then
			--local Player_x, Player_y = ObjectGetCoord(PlayerUnitsInArea[1]);
			UnitCmd(ACT_FOLLOW,GetObjectList(CapturedOfficerID),PlayerUnitsInArea[1]);
		end;
	end;
end;

function FindOfficer()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(CapturedOfficerID,"village",0)>0 or GetNUnitsInScriptGroup(CapturedOfficerID)==0) then
			Trace("For the glorious officer!!!");
			Cmd(ACT_MOVE,CapturedOfficerID,0,3413, 2597);
			StartThread(KillOfficer);
			StartThread(RevengeForOfficer);
			break;
		end;
	end;
end;

function KillOfficer()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(CapturedOfficerID)>0) then
			if (GetNUnitsInArea(0,"officer",0)>0 and GetNScriptUnitsInArea(CapturedOfficerID,"officer",0)>0) then
				Cmd(ACT_MOVE,CapturedOfficerID,0,3322, 2663);
				Wait(4);
				Cmd(ACT_LEAVE,EnemyOfficerID,0,3308, 2608);
				Trace("Tuk-Tuk!");
				Wait(3);
				ChangePlayerForScriptGroup(EnemyOfficerID,1);
			break;
			end;
		else
			if (GetNUnitsInArea(0,"officer",0)>0) then
				Cmd(ACT_MOVE,CapturedOfficerID,0,3322, 2663);
				Wait(4);
				Cmd(ACT_LEAVE,EnemyOfficerID,0,3308, 2608);
				Trace("Tuk-Tuk2!");
				Wait(3);
				ChangePlayerForScriptGroup(EnemyOfficerID,1);
			break;
		end;
		end;
	end;
end;

function RevengeForOfficer()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(EnemyOfficerID)==0) then	
			Cmd(ACT_MOVE,101,0,1894,937);
			Wait(15);
			StartThread(alarm,3308, 2608,South);
			break;
		end;
	end;
end;

function alarm(Swarm_x, Swarm_y,AreaID)
	Trace("Alarm!!!");
	for i=0,2 do
		ChangePlayerForScriptGroup(AreaID[4]+i,1);
		QCmd(ACT_SWARM,AreaID[4]+i,300,Swarm_x, Swarm_y);
		QCmd(ACT_WAIT, AreaID[4]+i,30);
		QCmd(ACT_SWARM,AreaID[4]+i,300,AreaID[2],AreaID[3]);
		QCmd(ACT_ENTER,AreaID[4]+i,AreaID[5]+i);
	end;
	Wait(15);
	StartThread(change_player,AreaID);
end;

function change_player(AreaID)
	Trace("Thread change player has been started...");
	while 1 do
	Wait(3);
	z=0;
	for i=0,2 do
		if (GetNUnitsInScriptGroup(AreaID[4]+i)>0) then
			z = z+1;
		end;
	end;
	Trace("All Count of Script Group = %g",z);
	if z == 0 then
		break;
	end;
	j = 0;
	for i=0,2 do
		if (GetUnitState(GetObjectList(AreaID[4]+i))==8) then
			Trace("Unit in building");
			Wait(3);
			ChangePlayerForScriptGroup(AreaID[4]+i,3);
			j = j+1;
		end;
	end;
	Trace("Count of Success Conditions = %g",j);
	if j == z then
		Trace("All Script Groups in Buildings");
		break;
	end;
	end;
end;


function CaptureTanks()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"tanks",0)>0 and GetNUnitsInArea(1,"panzer",0)==0) then
			SwitchSquadLightFX(TanksID,1);
			Wait(2);
			ChangePlayerForScriptGroup(TanksID,0);
			CompleteObjective(4);
			Wait(1);
			Trace("Number of tanks = %g",TanksArray.n);
			for i=1,TanksArray.n do
				StartThread(DontTouchMe,TanksArray[i]);
				Trace("Tank with ID %g has been captured. Step %g",TanksArray[i],i);
			end;
			break;
		end;
	end;
end;

function poteha1()
	Explosive = 0;
	Smoke = 1;
	CoordsArray = 
	{
	7058, 7105,	
	7054, 6976,	
	7193, 7016,	
	7418, 7006,	
	7544, 6917,	
	7257, 7228,	
	7351, 7228,	
	7616, 6919,	
	7695, 6920,	
	7450, 7234,	
	7829, 7025,	
	}
	CoordsArray2 = 
	{
	7174, 7873,
	7046, 7965,
	6962, 7966,
	7201, 7470,
	7339, 7835,
	7600, 7726,
	}
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1141,1)==0 or GetNUnitsInScriptGroup(1140,1)==0) then
			ViewZone("factory1",1);
			ViewZone("factory11",1);
			for i=0,10 do
				DamageScriptObject(1300+i,0);
				Trace("Object Destroyed");
				PlayEffect(0,CoordsArray[i*2+1],CoordsArray[i*2+2],0);
				Wait(1);
				PlayEffect(1,CoordsArray[i*2+1],CoordsArray[i*2+2],0);
			end
			Wait(2);
			--ViewZone("factory",0);
			RightDestroyed = 1;
			ViewZone("factory2",1);
			ViewZone("factory22",1);
			for i=0,5 do
				DamageScriptObject(1320+i,0);
				Trace("Object Destroyed");
				PlayEffect(0,CoordsArray2[i*2+1],CoordsArray2[i*2+2],0);
				Wait(1);
				PlayEffect(1,CoordsArray2[i*2+1],CoordsArray2[i*2+2],0);
			end
			Wait(2);
			--ViewZone("factory",0);
			ViewZone("factory2",0);
			ViewZone("factory22",0);
			ViewZone("factory1",0);
			ViewZone("factory11",0);
			Wait(10);
			LeftDestroyed = 1;
			break;
		end;
	end;
end;



function biker_selector()
	while 1 do
		Wait(4);
		if (GetNScriptUnitsInArea(biker_1,"bike",0) > 0) then
			StartThread(biker,biker_1,SouthWestPath,11);
		end;
		if (GetNScriptUnitsInArea(biker_2,"bike",0) > 0) then
			StartThread(biker,biker_2,WestPath,7);
		end;
		if (GetNScriptUnitsInArea(biker_3,"bike",0) > 0) then
			StartThread(biker,biker_3,SouthPath,5);
		end;
	end;
end;

function biker(Biker_Number,Path,N)
	for i=1,N do
		QCmd(ACT_SWARM,Biker_Number,0,Path[2*i - 1],Path[2*i]);
	end;
	for i=1,N do
		n = (N+1) - i;
		QCmd(ACT_SWARM,Biker_Number,0,Path[2*n - 1],Path[2*n]);
	end;
end;

function biker_zapalil(bikerID)
	local can_see = 0;
	while 1 do
		Wait(1);
		if (GetNUnitsNearScriptObj(0,bikerID,800) > 0) then
			Trace("Near biker is player units.");
			bike_x,bike_y = GetScriptObjCoord(bikerID);
			PlayerUnitsArray = GetArray(GetUnitListInArea(0,bike_x,bike_y,800,0));
			Trace("Number of Player Units = %g", PlayerUnitsArray.n);
			for i=1,PlayerUnitsArray.n do
				if (UnitCanSee(GetObjectList(bikerID),PlayerUnitsArray[i])==1) then
					Trace("biker can see Player Units");
					--Cmd(ACT_WAIT,bikerID,3);
					can_see = 1;
					break;
				else
					Trace("biker can't see Player Units");
				end;
			end;
			if can_see == 1 then
				Trace("can_see = %g",can_see);
				Cmd(ACT_MOVE,bikerID,0,6200, 5585);
				break;
			end;
		end;
	end;
end;

function follow_south_squad()
	Trace("South squad's officer state = %g",GetUnitState(GetObjectList(SouthSquadOfficer)));
	while GetUnitState(GetObjectList(SouthSquadOfficer)) ~= 32 do
		Wait(1);
		if (SquadAlarm == 0) then
			local x,y = GetScriptObjCoord(SouthSquadOfficer);
			Cmd(ACT_SWARM,SouthSquadInfantry,0,x,y);
			Cmd(ACT_MOVE,SouthSquadDog,100,x,y);
		else
			Trace("Zapalili!");
			break;
		end;
	end;
end;

function follow_west_squad()
	Trace("West squad's officer state = %g",GetUnitState(GetObjectList(WestSquadOfficer)));
	while GetUnitState(GetObjectList(WestSquadOfficer)) ~= 32 do
		Wait(1);
		if (SquadAlarm == 0) then
			local x,y = GetScriptObjCoord(WestSquadOfficer);
			Cmd(ACT_SWARM,WestSquadInfantry,0,x,y);
			Cmd(ACT_MOVE,WestSquadDog,100,x,y);
		else
			Trace("Zapalili!");
			break;
		end;
	end;
end;

function follow_east_squad()
	Trace("East squad's officer state = %g", GetUnitState(GetObjectList(EastSquadOfficer)));
	while GetUnitState(GetObjectList(EastSquadOfficer)) ~= 32 do
		Wait(1);
		if (SquadAlarm == 0) then
			local x,y = GetScriptObjCoord(EastSquadOfficer);
			Cmd(ACT_SWARM,EastSquadInfantry,0,x,y);
			Cmd(ACT_MOVE,EastSquadDog,100,x,y);
		else
			Trace("Zapalili!");
			break;
		end;
	end;
end;


function squad_alarm(AreaID)
	while 1 do
		Wait(1);
		if (GetNUnitsNearScriptObj(0,AreaID[1],800) > 0) then
			Trace("Near SouthSquadOfficer is player's units");
			local x,y = GetScriptObjCoord(AreaID[1]);
			local UnitsArray = GetArray(GetUnitListInArea(0,x,y,800,0));
			--for i=1,UnitsArray.n do
				if ((UnitCanSee(GetObjectList(AreaID[1]),UnitsArray[1]) == 1)
					or (GetNUnitsInScriptGroup(AreaID[7])) < 3) then
					local Player_x,Player_y = ObjectGetCoord(UnitsArray[1]);
					Trace("Our forces is under Attack!");
					--SquadAlarm = 1;
					Cmd(ACT_MOVE,AreaID[1],0,AreaID[2],AreaID[3]);
					StartThread(ChipAndDale,Player_x,Player_y,AreaID);
					break;
				else
					Trace("Officer can't see our forces...");
				end;
			--end;
		end;
	end;
end;

function ChipAndDale(Px,Py,AreaID)
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(AreaID[1],AreaID[6],0)>0) then
			StartThread(alarm,Px,Py,AreaID);
			break;
		end;
	end;
end;

function squads()
	while 1 do
		Wait(3);
		if (GetNScriptUnitsInArea(SouthSquadInfantry,"SSquads",0) > 0 or GetNScriptUnitsInArea(SouthSquadInfantry,"village",0) > 0) then
			StartThread(biker,SouthSquadOfficer,SouthPathSquad,4);
		end;
		if (GetNScriptUnitsInArea(WestSquadInfantry,"WSquads",0) > 0)  then
			StartThread(biker,WestSquadOfficer,WestPathSquad,2);
		end;
		if (GetNScriptUnitsInArea(EastSquadInfantry,"ESquads",0) > 0)  then
			StartThread(biker,EastSquadOfficer,EastPathSquad,9);
		end;
		if (GetNScriptUnitsInArea(EastGuardsSquad,"EGSquads",0) > 0)  then
			StartThread(biker,EastGuardsSquad,EastVillageGuardsPath,7);
		end;
		if (GetNScriptUnitsInArea(SouthGuardsSquad,"SGSquads",0) > 0)  then
			StartThread(biker,SouthGuardsSquad,SouthVillageGuardsPath,9);
		end;
	end;
end;


function fire_alarm()
	Trace("Thread fire_alarm started");
	while terminate == 0 do
		Wait(1);
		if (GetNUnitsNearScriptObj(0,FireGuardOfficer,800) > 0) then
			Trace("Fire guards has detected our units...");
			local x,y = GetScriptObjCoord(FireGuardOfficer);
			local TempArray = GetArray(GetUnitListInArea(0,x,y,800,0));
			Trace("Count of detected player's units %g",TempArray.n);
			for i=1,TempArray.n do
				if (UnitCanSee(GetObjectList(FireGuardOfficer),TempArray[i])==1
					or GetNUnitsInScriptGroup(FireGuardMG,1)==0) then
					Trace("Fire Guard Officer can see our units");
					Cmd(ACT_MOVE,FireGuardOfficer,0,3207, 2208);
					local X,Y = ObjectGetCoord(TempArray[i]);
					Wait(10);
					if (IsAlive(GetObjectList(FireGuardOfficer))==1) then
						Trace("Enemy officer has called reinforcements...");
						StartThread(alarm,X,Y,South);
					end;
					terminate = 1;
					break;
				end;
			end;
		end;	
	end;
end;


function rasstrel_()
	while 1 do
		Wait(1);
		if (PlayerCanSee(0,GetObjectList(1196))==1) then
			Cmd(ACT_SWARM,RasstrelOfficer,0,1810, 3997);
			QCmd(ACT_WAIT,2);
			QCmd(ACT_SWARM,RasstrelOfficer,0,1814, 3784);
			Wait(6);
			Cmd(ACT_ATTACKUNIT,RasstrelInfantry,RasstrelElite);
			QCmd(ACT_ATTACKUNIT,RasstrelInfantry,RasstrelSniper);
			break;
		end;
	end;
end;

function rasstrel_alarm()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(RasstrelInfantry) < 2) then
			Cmd(ACT_MOVE,RasstrelOfficer,0,Rasstrel[2],Rasstrel[3]);
			local of_x,of_y = GetScriptObjCoord(RasstrelOfficer);
			local PlayerUnits = GetArray(GetUnitListInArea(0,of_x,of_y,1000,0));
			local x,y = ObjectGetCoord(PlayerUnits[1]);
			StartThread(rasstrel_revenge,x,y);
			break;
		end;
	end;
end;

function rasstrel_revenge(X,Y)
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(RasstrelOfficer, "west_alarm", 0) > 0) then
			StartThread(alarm,X,Y,Rasstrel);
			break;
		end;
	end;
end;


function rescue_elite()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"rasstrel",0)>0 and GetNUnitsInArea(1,"rasstrel",0)==0) then
			ChangePlayerForScriptGroup(RasstrelElite,0);
			ChangePlayerForScriptGroup(RasstrelSniper,0);
			CompleteObjective(3);
			break;
		end;
	end;
end;

function pig_killing()
	while 1 do
		Wait(2);
		if (PlayerCanSee(0,GetObjectList(3031))==1) then
			Cmd(ACT_ATTACKUNIT,3031,3030);
			Wait(2);
			DamageScriptObject(3030,0);
			break;
		end;
	end;
end;

function panzer_guards()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(PanzerGuardsInfantry) < 4) then
			local x,y = GetScriptAreaParams("west_alarm");
			local Officers = GetObjectListArray(PanzerGuardsOfficer);
			for i = 1,Officers.n do
				UnitCmd(ACT_MOVE,Officers[i], 0, x,y);
			end
			StartThread(panzer_guards_revenge);
			break;
		end;
	end; 
end;

function panzer_guards_revenge()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(PanzerGuardsOfficer,"west_alarm",0)>0) then
			Trace("Enemy officer is in west_alarm area");
			StartThread(alarm,840, 6651,Panzer);
			break;
		end;
	end;
end;

function fire_guards_west()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(FireGuardWestInfantry,1) < 2) then
			local x,y = GetScriptAreaParams("west_alarm");
			Cmd(ACT_MOVE,FireGuardWestOfficer, 0, x,y);
			StartThread(fire_guards_west_revenge);
			break;
		end;
	end; 
end;

function fire_guards_west_revenge()	
	while 1 do
	Wait(1);
	if (GetNScriptUnitsInArea(FireGuardWestOfficer,"west_alarm",0)>0) then
			Trace("Enemy officer is in west_alarm area (Fire)");
			StartThread(alarm,2575, 4347,FirePanzer);
			break;
		end;
	end;
end;

function LeaveAndSwarm(SquadID,HataID,x,y)
	Trace("Thread LeaveAndSwarm has started");
	local X,Y = GetScriptObjCoord(SquadID);
	Cmd(ACT_SWARM,SquadID,0,x,y);
	QCmd(ACT_WAIT,SquadID,20);
	QCmd(ACT_SWARM,SquadID,0,X+200,Y+200);
	QCmd(ACT_ENTER,SquadID,HataID);
end;

function PointControl(PointSquadID)
	local x,y = GetScriptObjCoord(PointSquadID);
	Trace("In %g SctiptID group is %g units",PointSquadID,GetNUnitsInScriptGroup(PointSquadID));
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup(PointSquadID) < 3) then
			for i=0,5 do
				if (IsAlive(GetObjectList(1900+i))==1) then
					--Trace("Squad %g is Alive",1900+i);
					Trace("ObjectCoords = %g, %g", x,y);
					StartThread(LeaveAndSwarm,1900+i,2000+i,x,y);
				else
					Trace("Squad %g is Dead",1900+i);
				end;
			end;
			break;
		end;
	end;
end;

function buildings()
	while 1 do
		Wait(1);
		local arr = GetObjectListArray(1209);
		local PlayerPassangers = GetArray(GetPassangers(arr[1],0));
		local EnemyPassangers = GetArray(GetPassangers(arr[1],3));
		if (PlayerPassangers.n > 0 and EnemyPassangers.n > 0) then
			for i=1,EnemyPassangers.n do
				ChangePlayer(EnemyPassangers[1],1);
			end;
			break;
		end;
	end;
end;

function buildings_state()
	for i=0,3 do
		StartThread(buildings,1200+i);
	end;
	StartThread(buildings,1245);
	StartThread(buildings,1246);
	StartThread(buildings,1247);
end;

function bycycle()	
	while 1 do
		Wait(2);
		local x,y = GetScriptObjCoord(1139);
		local TempArray = GetArray(GetUnitListInArea(0,x,y,800,0));
		if (UnitCanSee(GetObjectList(1139),TempArray[1])==1) then
			Trace("Biker see our units!!!");
			StartThread(alarm,x,y,West);
			break;
		end;
	end;
end;

function kaput()
	while 1 do
		Wait(3);
		if (GetNUnitsInPlayerUF(0)==0 and GetReinforcementCallsLeft(0)==0) then
			Wait(2);
			Win(1);
			break;
		end;
	end;
end;

function offense_area()
	while 1 do
		Wait(1);
		if (i==1) then
		end;
	end;
end;

function test()
	while 1 do
		Wait(2);
		if (GetNUnitsInArea(0,"test",0)>0) then
			local UnitsArray = GetArray(GetUnitListInArea(0,"test",0));
				comparison = 0;
				if (GlobalUniqID.n > 0) then
					for i=1,GlobalUniqID.n do
						if GlobalUniqID[i] == UnitsArray[1] then
							comparison = 1;
						end;
					end;
				end;
				if (GlobalUniqID.n == 0 or comparison == 0) then
					GlobalUniqID[GlobalUniqID.n+1] = UnitsArray[1];
					--Trace("GlobalUniqID.n = %g",GlobalUniqID.n+1);
					Trace("Next Uniq ID in GlobalUniqID = %g",UnitsArray[1]);
					StartThread(ShootsCheck,UnitsArray[1],GlobalUniqID.n+1);
				end;
		end;
	end;
end;

function ShootsCheck(UniqID,NumberInArray)
	GlobalUniqID[1] = UniqID;
	--local InitialAmmoArray = GetArray(GetAmmo(UniqID));
	local InitialAmmo = GetAmmo(UniqID);
	--for i=1,InitialAmmoArray.n-1 do
		--InitialAmmo = InitialAmmo + InitialAmmoArray[2*i-1];
	--end;
	--Trace("InitialAmmo = %g",InitialAmmo );
	Trace("Initial Ammo = %g. SquadID = %g", InitialAmmo,UniqID);
	while 1 do
		if (IsUnitInArea(0,"test",UniqID) == 1) then
			Wait(1);
		--	local CurrentAmmoArray = GetArray(GetAmmo(UniqID));
			--for i=1,InitialAmmoArray.n-1 do
				--local CurrentAmmo = CurrentAmmoArray[i] + CurrentAmmoArray[i+1];
			--end;
			local CurrentAmmo = GetAmmo(UniqID)
			Trace("Current Squad Ammo = %g",GetAmmo(UniqID));
			if (CurrentAmmo < InitialAmmo) then
				Trace("Condition success! Current Squad Ammo = %g",GetAmmo(UniqID));
				break;
			end;
		else
			GlobalUniqID[NumberInArray] = 0;
			break;
		end;
	end;
end;

function beginlose()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(111)==0 and objective0 == 0) then
			Trace("my proigrali! :((");
			Wait(2);
			FailObjective(0);
			Wait(3);
			Win(1);
			break;
		end;
	end;
end;

StartThread(bycycle);
StartThread(kaput);
--StartThread(buildings);
--StartThread(buildings,1246);
--StartThread(buildings,1247);
--StartThread(buildings,1200);
--StartThread(buildings,1201);
--StartThread(buildings,1202);
--StartThread(buildings,1203);

--StartThread(buildings_state);
StartThread(PointControl,1800);
StartThread(PointControl,1801);
StartThread(PointControl,1802);
StartThread(PointControl,1803);
StartThread(PointControl,1804);

GiveObjective(0);
StartThread(CompleteObjective0);
StartThread(CaptureLanguage);
StartThread(FindOfficer);
--StartThread(LightOff);
StartThread(CaptureTanks);
StartThread(poteha1);
StartThread(biker_selector);
StartThread(follow_south_squad);
StartThread(follow_west_squad);
StartThread(follow_east_squad);
StartThread(squad_alarm,South);
StartThread(squad_alarm,East);
StartThread(squads);
StartThread(fire_alarm);
StartThread(rasstrel_);
StartThread(rasstrel_revenge);
StartThread(rasstrel_alarm);
StartThread(rescue_elite);
StartThread(panzer_guards);
StartThread(fire_guards_west);
StartThread(pig_killing);
StartThread(beginlose);

--StartThread(test);
--StartThread(biker_zapalil,biker_1);
--StartThread(biker_zapalil,biker_2);
--StartThread(biker_zapalil,biker_3);