__AUTO_ID = 5000;

function AutoID ()
	__AUTO_ID = __AUTO_ID + 1;
	return __AUTO_ID;
end;

Enemy_GAP_ID = 6100;
Player_GAP_ID = 6101;
EndOfAttacks = 0;
PointID = 0;
BombingZone = {"bomb11","bomb14","bomb13","bomb5","bomb15"};
AttackZone = {"attack1","attack4","attack2","attack4","attack2"};
AttackZoneNext = {"attack11","attack14","attack12","attack14","attack12"};
PointIDsArray  = {0,1,0,1,0};
NforAvangard  = {2,3,3,4,4};
NforMain  = {2,2,3,3,4};

BomberID = AutoID();
ArtilleryLeftID = 1100;
ArtilleryRightID = 1200;
ArtilleryLeftArray = GetObjectListArray(ArtilleryLeftID);
ArtilleryRightArray = GetObjectListArray(ArtilleryRightID);
FirstWaveID = 150;
SecondWaveID = 170;
TheirdWaveID = 180;
f = 2;
J = 0;


for i=1,ArtilleryLeftArray.n do
	SetAmmo(ArtilleryLeftArray[i],0);
	Trace("Artillery Ammo Left = %g", GetAmmo(ArtilleryLeftArray[i]));
end;
for i=1,ArtilleryRightArray.n do
	SetAmmo(ArtilleryRightArray[i],0);
	Trace("Artillery Ammo Right = %g", GetAmmo(ArtilleryRightArray[i]));
end;

function begin()
	Wait(5);
	LandReinforcementFromMap(1,"recon",0,BomberID);
	Cmd(ACT_MOVE,BomberID ,0,4551, 3778);
	Wait(10);
	for i=1,5 do
		LandReinforcementFromMap(1,"Bomber",0,BomberID+i);
		Cmd(ACT_MOVE,BomberID+i,0,GetScriptAreaParams("bomb"..i));
		Wait(4);
	end;
	for i=1,ArtilleryLeftArray.n do
		SetAmmo(ArtilleryLeftArray[i],10);
		UnitCmd(ACT_SUPPRESS,ArtilleryLeftArray[i],300,GetScriptAreaParams("bomb"..i));
		Trace("Artillery Ammo Left = %g", GetAmmo(ArtilleryLeftArray[i]));
	end;	
	for i=1,ArtilleryRightArray.n do
		SetAmmo(ArtilleryRightArray[i],10);
		UnitCmd(ACT_SUPPRESS,ArtilleryRightArray[i],300,GetScriptAreaParams("bomb"..i));
		Trace("Artillery Ammo Right = %g", GetAmmo(ArtilleryRightArray[i]));
	end;	
	for i=0,3 do
		Entrench = GetObjectListArray(2000+i);
		Cmd(ACT_SWARM,FirstWaveID + i,0,GetScriptAreaParams("attack"..i+1));
		QCmd(ACT_SWARM,FirstWaveID + i,0,GetScriptAreaParams("attack1"..i+1));
		QCmd(ACT_SWARM,FirstWaveID + i,0,GetScriptAreaParams("end"));
		UnitCmd(ACT_ENTER,GetObjectList(160+i),Entrench[4]);
	end;
	Wait(30);
	for i=0,3 do
		Cmd(ACT_SWARM,SecondWaveID + i,0,GetScriptAreaParams("attack"..i+1));
		QCmd(ACT_SWARM,SecondWaveID + i,0,GetScriptAreaParams("attack1"..i+1));
		QCmd(ACT_SWARM,SecondWaveID + i,0,GetScriptAreaParams("end"));
		QCmd(ACT_ENTER,SecondWaveID + i,777);
	end;
	Wait(40);
	for i=0,3 do
		Cmd(ACT_SWARM,TheirdWaveID + i,0,GetScriptAreaParams("attack"..i+1));
		QCmd(ACT_SWARM,TheirdWaveID + i,0,GetScriptAreaParams("attack1"..i+1));
		QCmd(ACT_SWARM,TheirdWaveID + i,0,GetScriptAreaParams("end"));
		QCmd(ACT_ENTER,TheirdWaveID + i,777);
	end;
	StartThread(waves,0,BombingZone[1],AttackZone[1],AttackZoneNext[1],1,1);
end;



--StartThread(0,BombingZone[1],AttackZone[1],AttackZoneNext[1],1,1);

function waves(PointID,BombZoneName,AttackZoneName,AttackZoneNextName,NAvangards,NMain)
	Trace("Thread waves has started...");
	local FirstWaveID  = 8000+J;
	local SecondWaveID = 8100+J;
	local TheirdWaveID = 8200+J;
	local BombersID = 8300 + J;
	J = J + 1;
	if J == 4 then
		StartThread(PlayerReinforcement);
	end;
	if PointID == 0 then
		ArtID = ArtilleryLeftID;
		ArtArr = ArtilleryLeftArray;
		Trace("Attack from the Left has begun");
	else
		ArtID = ArtilleryRightID;
		ArtArr = ArtilleryRightArray;
		Trace("Attack from the Right has begun");
	end
	--for i=1,NAvangards do
		--Trace("NAvangards = %g",NAvangards);
		LandReinforcementFromMap(1,"avangard"..J,PointID,FirstWaveID);
		Trace("avangard"..J.." Reinforcement has been landed...");
		Cmd(ACT_SWARM,FirstWaveID,0,GetScriptAreaParams(AttackZoneName));
		QCmd(ACT_SWARM,FirstWaveID,0,GetScriptAreaParams(AttackZoneNextName));
		QCmd(ACT_SWARM,FirstWaveID,0,GetScriptAreaParams("end"));
		QCmd(ACT_ENTER,FirstWaveID,777);
		Wait(3);
	--end;
	Wait(15);
	LandReinforcementFromMap(1,"Bomber",0,BombersID);
	Cmd(ACT_MOVE,BombersID,0,GetScriptAreaParams(BombZoneName));
	for i=1,ArtArr.n do
		SetAmmo(ArtArr[i],15);
	end;
	if f ~= 6 then
		Cmd(ACT_SUPPRESS,ArtID,0,GetScriptAreaParams(BombZoneName));
	end;
	Wait(20);
	LandReinforcementFromMap(1,"razvedka",PointID,TheirdWaveID);
		Cmd(ACT_SWARM,TheirdWaveID,0,GetScriptAreaParams(AttackZoneName));
		QCmd(ACT_SWARM,TheirdWaveID,0,GetScriptAreaParams(AttackZoneNextName));
		QCmd(ACT_SWARM,TheirdWaveID,0,GetScriptAreaParams("end"));
	--for i=1,NMain do
		--Trace("NMain = %g",NMain);
		LandReinforcementFromMap(1,"mainforces"..J,PointID,SecondWaveID);
		Trace("mainforces"..J.." Reinforcement has been landed...");
		Cmd(ACT_SWARM,SecondWaveID,0,GetScriptAreaParams(AttackZoneName));
		QCmd(ACT_SWARM,SecondWaveID,0,GetScriptAreaParams(AttackZoneNextName));
		QCmd(ACT_SWARM,SecondWaveID,0,GetScriptAreaParams("end"));
		Wait(3);
	--end;
	Wait(10);
	time = GetGameTime();
	if f ~= 6 then
		StartThread(check_next_wave,time,FirstWaveID,SecondWaveID,TheirdWaveID);
	else
		Trace("All Waves have finished");
		StartThread(CompleteObjective0,FirstWaveID,SecondWaveID,TheirdWaveID);
	end;
end;

function check_next_wave(Time,FirstID,SecondID,TheirdID)
	while 1 do
		Wait(1);
		if ((GetNUnitsInScriptGroup(FirstID)==0 and 
			GetNUnitsInScriptGroup(SecondID)==0 and 
			GetNUnitsInScriptGroup(TheirdID)==0) 
			or
			(GetGameTime() > Time+60)) then
			StartThread(waves,PointIDsArray[f],BombingZone[f],AttackZone[f],AttackZoneNext[f],NforAvangard[f],NforMain[f]);
			Trace("NforMain = %g",NforMain[f]);
			f = f + 1;
			Trace("Wave Number %g has started...",f);
			break;
		end;
	end;
end;


function kaput()
	while 1 do
		Wait(1);
		if (GetNUnitsInPlayerUF(0)==0 and GetReinforcementCallsLeft(0)==0) then
			Wait(2);
			Win(1);
			break;
		end;
		--if (GetUnitListInArea(0,"bomb12",0)==0 and GetUnitListInArea(1,"bomb12",0) > 0) then
		if (GetPassangers(GetObjectList(777),0) == nil and GetPassangers(GetObjectList(777),1) ~= nil) then
			ViewZone("bomb12",1);
			Wait(4);
			Win(1);
			break;
		end;
	end;
end;



function CompleteObjective0(First,Second,Theird)
	while 1 do
		Wait(3);
		if (
			GetNUnitsInScriptGroup(First)  == 0 and
			GetNUnitsInScriptGroup(Second) == 0 and
			GetNUnitsInScriptGroup(Theird) == 0 
			--GetNUnitsInScriptGroup(FirstWaveID+1)  == 0 and
			--GetNUnitsInScriptGroup(SecondWaveID+1) == 0 and
			--GetNUnitsInScriptGroup(TheirdWaveID+1) == 0 and
			--GetNUnitsInScriptGroup(FirstWaveID+2)  == 0 and
			--GetNUnitsInScriptGroup(SecondWaveID+2) == 0 and
			--GetNUnitsInScriptGroup(TheirdWaveID+2) == 0 and
			--GetNUnitsInScriptGroup(FirstWaveID+3)  == 0 and
			--GetNUnitsInScriptGroup(SecondWaveID+3) == 0 and
			--GetNUnitsInScriptGroup(TheirdWaveID+3) == 0
			) 
			then
			CompleteObjective(0);
			EndOfAttacks = 1;
			GiveObjective(1);
			StartThread(CompleteObjective1);	
			LandReinforcementFromMap(0,"tanks",0,6110);
			Cmd(ACT_SWARM,6110,0,GetScriptAreaParams("attack1"));
			break;
		end;
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(ArtilleryLeftID,1)  == 0 and
			GetNUnitsInScriptGroup(ArtilleryRightID,1) == 0) then
			Wait(2);
			CompleteObjective(1);
			Wait(2);
			Win(0);
			break;
		end;
	end;
end;

function EnemyGaps()
	Wait(45);
	while EndOfAttacks == 0 do
		Wait(1);
		if GetNUnitsInScriptGroup(Enemy_GAP_ID)==0 then
			LandReinforcementFromMap(1,"gap",0,Enemy_GAP_ID);
			Cmd(ACT_SWARM,Enemy_GAP_ID,0,GetScriptAreaParams("bomb12"));
			Wait(40);
		end;
	end;
end;

function PlayerGaps()
	Wait(55);
	while EndOfAttacks == 0 do
		Wait(1);
		if GetNUnitsInScriptGroup(Player_GAP_ID)==0 then
			LandReinforcementFromMap(2,"gap",0,Player_GAP_ID);
			Cmd(ACT_SWARM,Player_GAP_ID,0,GetScriptAreaParams("bomb12"));
			Wait(35);
		end;
	end;
end;

function PlayerReinforcement()
	Trace("Thread PlayerReinforcement has started");
	LandReinforcementFromMap(0,"infantry",0,6199);
	Cmd(ACT_SWARM,6199,0,GetScriptAreaParams("attack12"));
	Wait(10);
	LandReinforcementFromMap(0,"aa",0,6200);
	Cmd(ACT_DEPLOY,6200,0,GetScriptAreaParams("end"));
	Wait(8);
	LandReinforcementFromMap(0,"aa",0,6201);
	Cmd(ACT_DEPLOY,6201,0,GetScriptAreaParams("attack12"));
end;

function building_kaput()
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup(777)==0) then
			Wait(2);
			Win(1);
		end;
	end;
end;

function secret1()
	while 1 do
		Wait(1)
		if (GetNUnitsInArea(0,"cannon1",0)>0) then
			Trace("Cannon 1 has found!!!");
			CompleteObjective(2);
			LandReinforcementFromMap(0,"crew",0,8900);
			Cmd(ACT_TAKE_ARTILLERY,8900,9800);
			Wait(3);
			LandReinforcementFromMap(0,"crew",0,8902);
			Cmd(ACT_TAKE_ARTILLERY,8902,9802);
			break;
		end;
	end;
end;


GiveObjective(0);
--StartThread(CompleteObjective0);
StartThread(begin);
StartThread(kaput);
StartThread(EnemyGaps);
StartThread(PlayerGaps);
StartThread(building_kaput);
StartThread(secret1);

--StartThread(waves,0,BombingZone[1],AttackZone[1],AttackZoneNext[1],1,1);
--StartThread(waves,PointIDsArray[5],BombingZone[5],AttackZone[5],AttackZoneNext[5],NforAvangard[5],NforMain[5]);
--StartThread(kaput);
--StartThread(win2);
--StartThread(hidden);