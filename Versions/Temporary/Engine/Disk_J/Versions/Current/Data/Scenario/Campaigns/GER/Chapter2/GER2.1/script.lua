NOfArtillery = 0;
TankCaptured = 0;
LandingBot = 0;
obj1_complete = 0;
Revenge = 0;
WillisNotArrive = 0;
NoReinfLeft = 0;
x = 0;
y = 0;
---------------- OBJECTIVE 0 ------------------ begin
function heavy_aa_alarm()
	Wait(1);
	ammo = GetAmmo(GetObjectList(1196));
	Wait(5);
	while 1 do
		Wait(1);
		if (GetAmmo(GetObjectList(1196)) < ammo or GetNUnitsInScriptGroup(1195)==0) then
			Cmd(ACT_LEAVE,1193,0,3600,6800);
			QCmd(ACT_TAKE_ARTILLERY,1193,1194);
			break;
		end;
	end;
end;

function ReinforcementManager()
	Wait(3);
	ChangeFormation(1101,1);
	ChangeFormation(110,1);
	ChangeFormation(109,1);
	if (GetDifficultyLevel() == 0) then
		StartThread(chudo_bogatyri_easy);
		ChangeFormation(103,1);
		ChangeFormation(106,1);
		ChangeFormation(112,1);
	end;
	if (GetDifficultyLevel() == 1) then
		ChangeFormation(112,1);
		DamageScriptObject(931,30);
		RemoveScriptGroup(112);
		RemoveScriptGroup(106);
		Wait(1);
		LandReinforcementFromMap(1,"jeep",1,103);
		LandReinforcementFromMap(1,"jeep",3,106);
		StartThread(chudo_bogatyri_easy);
	end;
	if (GetDifficultyLevel() == 2) then
		DamageScriptObject(931,50);
		RemoveScriptGroup(112);
		RemoveScriptGroup(103);
		RemoveScriptGroup(106);
		Wait(1);
		LandReinforcementFromMap(1,"jeep",1,103);
		LandReinforcementFromMap(1,"jeep",2,112);
		LandReinforcementFromMap(1,"jeep",3,106);
		StartThread(chudo_bogatyri_easy);
	end;
end;


function barbos()
	Trace("Thread barbos has been started");
	while 1 do
		Wait(3);
		if (GetNScriptUnitsInArea(145,"pes",0) > 0) then 
		Cmd(ACT_SWARM,145,0,3710, 1752);
		QCmd(ACT_SWARM,145,0,3112, 4795);
		QCmd(ACT_SWARM,145,0,3710, 1752);
		QCmd(ACT_SWARM,145,0,3291, 164);
		end;
	end
end;

function barbos_beholder()
	Trace("Thread barbos_beholder has been started");
	while 1 do
		Wait(1);
		if (IsUnitNearScriptObject(0,145,450) == 1) then
			Trace("dog have found us!!!");
			x,y = GetScriptObjCoord(145);
			Cmd(ACT_MOVE,145,0,5500, 5200);
			break;
		end;
	end;
end;

function barbos_revenge()	
	Trace("Thread barbos_revenge has been started");
	while 1 do
		Wait(3);
		if (GetNScriptUnitsInArea(145,"sobaki",0) > 0) then 
			Cmd(ACT_SWARM,142,500,x,y);
			break;
		end;
	end;
end;

function barbos_revenge2()	
	while 1 do
		Wait(4);
		if (GetNUnitsInScriptGroup(141) == 0) then
			Cmd(ACT_SWARM,142,500,7700,4400);
			break;
		end;
	end;
end;

function barbos_revenge3()	
	while 1 do
		Wait(4);
		if (GetNUnitsInScriptGroup(143) == 0) then
			Cmd(ACT_SWARM,142,500,7333, 1106);
			break;
		end;
	end;
end;


function jeep()
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup(1172) == 0 and WillisNotArrive == 0) then
			Cmd(ACT_MOVE, 112, 0,5678, 6727);
			break;
		end;
	end;
end;


function helpme()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1171) < 2 or GetNUnitsInArea(0,"helpme",0) > 0) then
			Cmd(ACT_TAKE_ARTILLERY,1190,1191);
			Cmd(ACT_MOVE,1170,0,6503, 2027);
			QCmd(ACT_MOVE,1170,0,7093, 6672);
			StartThread(revenge);
			break;
		end;
	end;
end;

function revenge()
	while 1 do
		Wait(3);
		if (GetNScriptUnitsInArea(1170,"JeepPatrol",0) > 0) then
			Cmd(ACT_SWARM,106, 500, 5165, 1919);
			Revenge = 1;
			break;
		end;
	end;
end;



function sniper()
	while 1 do
		Wait(2);
		if (GetNUnitsInArea(1,"zona",0) < 1 and GetNUnitsInArea(0,"zona",0) > 0) then
			Cmd(ACT_LEAVE,1162,150,7281,4267);
			Cmd(ACT_LEAVE,1163,150,7281,4267);
			Cmd(ACT_LEAVE,1168,150,7281,4267);
			Cmd(ACT_LEAVE,1169,150,7281,4267);
			Wait(8);
			Cmd(ACT_TAKE_ARTILLERY, 1162,1165);
			Cmd(ACT_TAKE_ARTILLERY, 1163,1166);
			ChangePlayer(GetObjectList(1162),0);
			ChangePlayer(GetObjectList(1163),0);
			ChangePlayer(GetObjectList(1168),0);
			ChangePlayer(GetObjectList(1169),0);
			break;
		end;
	end;
end;

function sniper2()
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup(1167) == 0 and GetNUnitsInArea(0,"sniper2",0) > 0) then
			Cmd(ACT_LEAVE,1164,0,6887,6971);
			ChangePlayer(GetObjectList(1164),0);
			break;
		end;
	end;
end;



function patrol_1()
	while 1 do
		Wait(5);
		if (GetNScriptUnitsInArea(1101,"1101",0) > 0) then
			QCmd(ACT_SWARM,1101,0,3696, 2852);
			QCmd(ACT_SWARM,1101,0,3036, 5138);
			QCmd(ACT_SWARM,1101,0,3178, 6252);
			QCmd(ACT_SWARM,1101,0,3036, 5138);
			QCmd(ACT_SWARM,1101,0,3696, 2852);
			QCmd(ACT_SWARM,1101,0,3685, 1581);
		end;
	end;
end;

function patrol_2()
	while 1 do
		Wait(5);
		if (GetNScriptUnitsInArea(1102,"1102",0) > 0) then
			Cmd(ACT_SWARM,1102,0,6561, 1943);
			QCmd(ACT_SWARM,1102,0,7733, 197);	
		end;
	end;
end;

function patrol_3()
	Wait(1);
	LandReinforcementFromMap(1,"sobak",4,1103);
	while 1 do
		Wait(5);
		if (GetNScriptUnitsInArea(1103,"1103",0) > 0) then
			Cmd(ACT_SWARM,1103,0,5013, 1752);
			QCmd(ACT_SWARM,1103,0,6496, 1954);	
			QCmd(ACT_SWARM,1103,0,3749, 1549);	
		end;
	end;
end;


function patrol_4()
	LandReinforcementFromMap(1,"sobak",5,1104);
	while 1 do
		Wait(5);
		if (GetNScriptUnitsInArea(1104,"1104",0) > 0) then
			Cmd(ACT_SWARM,1104,0,7258, 3628);
			QCmd(ACT_SWARM,1104,0,3713, 1573);	
		end;
	end;
end;





function CompleteObjective0()
	while 1 do
		Wait(2);
		if (GetNUnitsInArea(0,"sniper",0) > 0 and GetNUnitsInArea(1,"sniper",0) < 1) then
			CompleteObjective(0);
			GiveObjective(1);
			obj1_complete = 1;	
			GiveReinforcementCalls(1,-GetReinforcementCallsLeft(1));
			break;
		end;
	end;
end;

function Arriving()
	SetAmmo(1165,0,0);
	SetAmmo(1166,0,0);
	DamageScriptObject(1313,100);
	Wait(1);
	Cmd(ACT_MOVE, 1079, 1, 2193, 1366);
	QCmd(ACT_UNLOAD, 1079, 1, 2273, 1320);
	--ChangePlayer(GetObjectList(1080),0);
	Wait(25);
	Cmd(ACT_MOVE, 1079, 1, 100, 1400);
	QCmd(ACT_DISAPPEAR, 1079);
end;

function crew()
	while 1 do
		Wait(1);
		if (IsSomeUnitInArea(0,"crew",0) > 0 and IsSomeUnitInArea(1,"crew",0) == 0) then
			Cmd(ACT_LEAVE,1311,0,7236,1221);
			Wait(6);
			Cmd(ACT_MOVE, 1311,100, 6314,1053);
			ChangePlayer(1311,2);
			break;
		end;
	end;
end;


function shore()
	while 1 do
		Wait(2);
		if (GetNUnitsInArea(0, "shore_area", 0) > 0) then
			if (IsSomeBodyAlive(1,950) == 1) then
				Cmd(ACT_SWARM, 950, 1000, 3650, 2368);
			end;
			Wait(1);
			if (IsSomeBodyAlive(1,110) == 1) then
				Cmd(ACT_SWARM, 110, 1000, 3650, 2368);
			end;
		end;
	end;
end;


function cover()
	while 1 do
		Wait(2);
		if (IsSomeBodyAlive(930) == 0) then
			Cmd(ACT_SWARM, 950,500,4750,4150);
		end;
	end;
end;


function LightOff()
	while 1 do 
		Wait(3);
		--Trace("LightOff...");
		SwitchSquadLightFX(901,0);
		Wait(1);
		SwitchSquadLightFX(930,0);
		Wait(1);
		if (TankCaptured == 0) then
			SwitchSquadLightFX(931,0);
		end;
	end;
end;


function CaptureTankTest()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(1311, "tanks", 0) > 0) then
			Wait(1);
			--UnitsArr = GetUnitListInAreaArray(0,"tanks",0);
			Cmd(ACT_DISAPPEAR, 1311);
			Trace("Unit has disappeared");
			SwitchSquadLightFX(931,1);
			TankCaptured = 1;
			ChangePlayer(GetObjectList(931), 0);
			Trace("Tank has captured");
			Wait(1);
			Cmd(ACT_MOVE,931,0,6433, 1035);
			Wait(3);
			Cmd(ACT_ROTATE,931,100,7310, 4550);
			break;
		end;
	end;
end;
---- capture building






---------------- WILLIS RETREAT --------------- begin

function willis_retreat()

	if (IsAlive(GetObjectList(113)) == 0) then

		return 1;

	end;

end;



function willis()

	if ( GetObjectHPs(102) > 0) then
		Wait(1);

		Cmd (ACT_MOVE, 102, 1, 2988, 5491);

		Wait(2);

		QCmd (ACT_MOVE, 102, 1, 3326, 6767);

		Wait(5);

		QCmd (ACT_MOVE, 102, 1, 5436, 6823);

		Wait(3);

	end;	

end;

---------------- WILLIS RETREAT --------------- end



---------------- HUMBER SWARM ----------------- begin

function humber_swarm()

	if (IsUnitInArea(1, "DesertGuard2", GetObjectList(102)) == 1) then

		return 1;

	end;

end;



function humber_swarm_go()

	--Trace ("Humber attack!");
	Wait(10);

	Cmd (ACT_SWARM, 103, 1, 3707, 1649);

end;

---------------- HUMBER SWARM ----------------- end





---------------- DESERT PATROL ---------------- begin

function WillisArrive()

	if (IsUnitInArea(1, "WillisArrive", GetObjectList(102)) == 1) then

		return 1;

	end;

end;



function start()
	--Trace("Willis has arrived...");
	Wait(30);
	StartThread(Patrol_Start);
	WillisNotArrive = 1;
end;



function Patrol_Start()

	while 1 do

		Wait(3);

		if (GetObjectHPs(112) > 0 and ((GetNScriptUnitsInArea(112, "JeepStart", 0) > 0) or (GetNScriptUnitsInArea(112, "DesertGuard2") > 0))) then

		Wait( 1 );
		--Trace("Jeep 112 start");

		StartThread( DesertPatrol );

		break;

		end;

	end;

end;





function DesertPatrol()

	Cmd (ACT_SWARM, 112, 1, 5560, 6733);

	Wait(5);
	--Trace("Thread DesertPatrol 1");

	QCmd (ACT_SWARM, 112, 1, 7094, 6631);

	Wait(5);

	QCmd (ACT_SWARM, 112, 1, 7260, 3876);

	Wait(5);

	QCmd (ACT_SWARM, 112, 1, 6502, 1890);

	Wait(5);

	QCmd (ACT_SWARM, 112, 1, 3880, 1595);

	Wait(5);

	QCmd (ACT_SWARM, 112, 1, 3087, 5034);

	Wait(5);

	QCmd (ACT_SWARM, 112, 1, 3481, 6785);

	Wait(5);

	StartThread(Patrol_Start);

end;



function Patrol_Start2()
	while 1 do
		Wait(2);
		if (GetNScriptUnitsInArea(106,"JeepPatrol",0) > 0 and Revenge == 0) then 
			Cmd(ACT_SWARM,106,0,7259, 4193);
			QCmd(ACT_SWARM,106,0,6541, 1944);
			QCmd(ACT_SWARM,106,0,7259, 4193);
			QCmd(ACT_SWARM,106,0,7093, 6672);
		end;
	end;
end;

---------------- DESERT PATROL ---------------- end



---------------- INFANTRY SWARM --------------- begin

function infantry()

	while 1 do 

		Wait(1);

		if (GetNScriptUnitsInArea(140, "trucks", 0) > 0) then

			--Trace("banzai");

			Cmd (ACT_SWARM, 108, 1, 7191, 6241);

			QCmd (ACT_SWARM, 108, 1, 7244, 4199);

			break;

		end;

	end;

end;

---------------- INFANTRY SWARM --------------- end





---------------- BASE GUARD ------------------- begin

function Base_Guard()

	while 1 do

		Wait(3);

		if (GetObjectHPs(110) > 0 and GetNScriptUnitsInArea(110, "BaseGuard",0) > 0) then

		Wait( 1 );

		StartThread( Base_Guard_go );

		break;

		end;

	end;

end;



function Base_Guard_go()

	Cmd (ACT_SWARM, 110, 1, 7093, 6678);

	Wait(5);

	QCmd (ACT_SWARM, 110, 1, 3532, 6837);

	Wait(5);

	StartThread(Base_Guard);

end;

---------------- BASE GUARD ------------------- end



---------------- DESERT GUARD ----------------- begin

function Desert_Guard()

	while 1 do

		Wait(3);

		if (IsAlive(GetObjectList(109)) == 1 and GetNScriptUnitsInArea(109, "DesertGuard",0) > 0) then

		Wait( 1 );

		StartThread( Desert_Guard_go );

		break;

		end;

	end;

end;



function Desert_Guard_go()

	Cmd (ACT_SWARM, 109, 1, 5793, 3878);

	Wait(5);

	QCmd (ACT_SWARM, 109, 1, 6403, 1965);

	Wait(5);

	QCmd (ACT_SWARM, 109, 1, 7637, 350);

	Wait(5);

	QCmd (ACT_SWARM, 109, 1, 7093, 6065);

	Wait(5);

	StartThread(Desert_Guard);

end;

---------------- DESERT GUARD ----------------- end


---------------- TRUCK RETREAT ---------------- begin

function TruckRetreat() 
	while 1 do  
	Wait(1);
		if (GetNUnitsInArea(0, "truckRetreat", 0) > 0) then 			
			Cmd(ACT_MOVE, 140, 1, 7000, 6602);
			QCmd(ACT_MOVE, 140, 1, 4424, 6757);
			StartThread(infantry);
			break; 
		end; 
	end; 
end; 




---------------- TRUCK RETREAT ---------------- end







---------------- WIN -------------------------- begin

function win()
	while 1 do
        if ( ( GetScriptObjectHPs( 1001 ) < 1 ) and ( GetScriptObjectHPs( 1002 ) < 1 ) and ( GetScriptObjectHPs( 1003 ) < 1 ) ) then
			Wait(2);
			CompleteObjective(1);
			Wait(3);
			if (obj1_complete == 0) then
				CompleteObjective(0);
			end;
			Wait(5);
			Win (0);
			break;
		end;
	Wait(5);
	end;
end;

---------------- WIN -------------------------- end



---------------- LOOSE ------------------------ begin

function lose()
 	while 1 do
        if (GetNUnitsInPlayerUF(0) == 0 and NoReinfLeft == 1 and GetReinforcementCallsLeft(0) == 0) then
                Trace("My proigrali!!!");
 				Wait(2);
 				Loose(0);
 				return 1;
 			end;
 	Wait(5);
 	end;
end; 



---------------- LOOSE ------------------------ end

function bofors_1()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(3000) < 2) then
			Trace("time to take artillery 1...");
			Cmd(ACT_TAKE_ARTILLERY, 4800,4700);
			break;
		end;
	end;
end;

function bofors_2()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(3001) == 0) then
			Trace("time to take artillery 2...");
			Cmd(ACT_TAKE_ARTILLERY, 4802,4702);
			break;
		end;
	end;
end;


function aa_alarm()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(8000) < 5) then
			Cmd(ACT_TAKE_ARTILLERY, 4803,4703);
			Cmd(ACT_TAKE_ARTILLERY, 4804,4704);
		end;
	end;
end;

function chudo_bogatyri_easy()
	N = 0;
	while 1 do
		Wait(5);
		if (GetNUnitsInScriptGroup(1080) < 1) then
			if (N < 3) then
				Trace("Chernomor and 33 bogatyrs has landed...");
				LandReinforcementFromMap(0,"chudo_bogatyri",0,1080);
				ReinfArr = GetObjectListArray(1080);
				for i=1,ReinfArr.n do
					Stats = GetArray(GetUnitRPGStats(ReinfArr[i]));
					if (Stats[1] == 1) then
						Trace("Stats array element value = %g",Stats[1]);
						ShipUniqID = ReinfArr[i];
						break;
					end;
				end;
				Trace("Ship ID = %g", ShipUniqID);
				ChangePlayer(ShipUniqID,2);
				Cmd(ACT_UNLOAD, 1080, 1, 2273, 1320);
				Wait(35);
				UnitCmd(ACT_MOVE, ShipUniqID, 1, 100, 1400);
				UnitQCmd(ACT_DISAPPEAR, ShipUniqID);
				N = N + 1;
			else
				NoReinfLeft = 1;
				break;
			end;
		end;
	end;
end;

function count_of_player_units()
	while 1 do
		Wait(2);
		NOfArtillery = 0;
		local PlayerUnits = GetArray(GetUnitListOfPlayer(0));
		--Trace(PlayerUnits.n);
		for i=1,PlayerUnits.n do
			UnitStats = GetArray(GetUnitRPGStats(PlayerUnits[i]));
			UnitState = GetUnitState(PlayerUnits[i]);
			if (   (UnitStats[1]==1 and UnitStats[3]==1)
				or (UnitStats[1]==1 and UnitStats[3]==2)
				or (UnitStats[1]==0 and UnitState == 25)) then
				NOfArtillery = NOfArtillery + 1;
			end;
		end;
		if (PlayerUnits.n == NOfArtillery and GetReinforcementCallsLeft(0)==0) then
			Wait(1);
			Trace("Player has only immobilize units. CountMatchingValues of this units = %g",NOfArtillery);
			Trace("Enemy win...");
			Wait(3);
			Win(1);
			break;
		end;
	end;
end;

GiveObjective(0);
StartThread(count_of_player_units);
StartThread(heavy_aa_alarm);
StartThread(barbos);
--StartThread(barbos_beholder);
--StartThread(barbos_revenge);
--StartThread(barbos_revenge2);
--StartThread(barbos_revenge3);
StartThread(Patrol_Start2);
StartThread(jeep);
StartThread(helpme);
StartThread(CompleteObjective0);
StartThread(bofors_1);
StartThread(bofors_2);
StartThread(ReinforcementManager);
StartThread(lose);
StartThread(CaptureTankTest);
StartThread(Arriving);
StartThread(patrol_1);
StartThread(patrol_2);
StartThread(patrol_3);
StartThread(patrol_4);
StartThread(cover);
StartThread(sniper);
StartThread(sniper2);
StartThread(shore);
StartThread(crew);
StartThread(aa_alarm);
StartThread(LightOff);
StartThread(win);
StartThread(Base_Guard);
StartThread(Desert_Guard);
StartThread(TruckRetreat);
Trigger(humber_swarm, humber_swarm_go);
Trigger (willis_retreat, willis);
Trigger(WillisArrive, start);