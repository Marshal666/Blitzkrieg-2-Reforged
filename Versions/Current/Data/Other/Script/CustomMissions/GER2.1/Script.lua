---------------- OBJECTIVE 0 ------------------ begin
---- capture building
function RevealObjective0()
    Wait(2);
	ObjectiveChanged(0, 1);
	Wait(3);
	StartThread( lose );
end;


function Objective0()
	if (GetNUnitsInArea(0, "KeyBuilding",0) > 0 and GetNUnitsInArea(1, "KeyBuilding",0) < 1) then
		return 1;
    end;
end;

function CompleteObjective0()
	ObjectiveChanged(0, 2);
	Wait(1);
	--LandReinforcement(0, 0, 1, 555);
	StartThread( RevealObjective1 );
	Trigger( Objective1, CompleteObjective1 );
end;
---------------- OBJECTIVE 0 ------------------ end

---------------- OBJECTIVE 1 ------------------ begin
---- destroy storage
function RevealObjective1()
    Wait(5);
	ObjectiveChanged(1, 1);
end;


function Objective1()
	if ( ( GetScriptObjectHPs( 1001 ) < 1 ) and ( GetScriptObjectHPs( 1002 ) < 1 ) and ( GetScriptObjectHPs( 1003 ) < 1 ) ) then
        return 1;
    end;
end;


function CompleteObjective1()
	Wait(5);
	ObjectiveChanged(1, 2);
	Wait(3);
	Win(0);
end;
---------------- OBJECTIVE 1 ------------------ end

---------------- WILLIS RETREAT --------------- begin
function willis_retreat()
	if (IsAlive(GetObjectList(113)) == 0) then
		return 1;
	end;
end;

function willis()
	DisplayTrace(GetObjectHPs(102));
	if ( GetObjectHPs(102) > 0) then
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
	Trace ("Humber attack!");
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
	StartThread(Patrol_Start);
	StartThread(Patrol_Start2);
end;

function Patrol_Start()
	while 1 do
		Wait(3);
		if (GetObjectHPs(112) > 0 and ((GetNScriptUnitsInArea(112, "JeepStart", 0) > 0) or (GetNScriptUnitsInArea(112, "DesertGuard2") > 0))) then
		Wait( 1 );
		StartThread( DesertPatrol );
		break;
		end;
	end;
end;


function DesertPatrol()
	Cmd (ACT_SWARM, 112, 1, 5560, 6733);
	Wait(5);
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
		Wait(3);
		if (GetObjectHPs(106) > 0 and ((GetNScriptUnitsInArea(106, "JeepStart", 0) > 0) or (GetNScriptUnitsInArea(106, "JeepPatrol", 0) > 0))) then
		Wait( 1 );
		StartThread( DesertPatrol2 );
		break;
		end;
	end;
end;

function DesertPatrol2()	
	Cmd (ACT_SWARM, 106, 1, 5560, 6733);
	Wait(5);
	QCmd (ACT_SWARM, 106, 1, 3481, 6785);
	Wait(5);
	QCmd (ACT_SWARM, 106, 1, 3087, 5034);
	Wait(5);
	QCmd (ACT_SWARM, 106, 1, 3880, 1595);
	Wait(5);
	QCmd (ACT_SWARM, 106, 1, 6502, 1890);
	Wait(5);
	QCmd (ACT_SWARM, 106, 1, 7260, 3876);
	Wait(5);
	QCmd (ACT_SWARM, 106, 1, 7094, 6631);
	Wait(5);
	StartThread(Patrol_Start2);
end;
---------------- DESERT PATROL ---------------- end

---------------- INFANTRY SWARM --------------- begin
function infantry()
	while 1 do 
		Wait(1);
		if (GetNScriptUnitsInArea(140, "JeepStart", 0) > 0) then
			Trace("banzai");
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

---------------- BOT -------------------------- begin
function bot()
	while 1 do
		Wait(3);
		if (IsAlive(GetObjectList(10001)) == 1 and GetNScriptUnitsInArea(10001, "bot",0) > 0) then
		Wait( 1 );
		StartThread( bot_go );
		break;
		end;
	end;
end;

function bot_go()
	Cmd (ACT_SWARM, 10001, 1, 1038, 1799);
	Wait(5);
	QCmd (ACT_SWARM, 10001, 1, 575, 7211);
	Wait(5);
end;

---------------- BOT -------------------------- end

---------------- TRUCK RETREAT ---------------- begin
function TruckRetreat()
	while 1 do 
	Wait(1);
		if (GetNUnitsInArea(0, "truckRetreat", 0) > 0) then
			Cmd(ACT_MOVE, 140, 1, 6915, 6535);
			QCmd(ACT_MOVE, 140, 1, 4402, 7614);
			StartThread(infantry);
			break;
		end;
	end;
end;

---------------- TRUCK RETREAT ---------------- end



---------------- WIN -------------------------- begin
function win()
	while 1 do
            if ( GetNUnitsInParty(1) < 1 ) then
				Wait(2);
				Win (0);
         return 1;
	end;
	Wait(5);
	end;
end;
---------------- WIN -------------------------- end

---------------- LOOSE ------------------------ begin
function lose()
	while 1 do
            if ( GetNUnitsInParty(0) < 1 and GetReinforcementCallsLeft(0) < 1) then
                Trace("My proigrali!!!");
				Wait(2);
				Loose(0);
         return 1;
	end;
	Wait(5);
	end;
end;
---------------- LOOSE ------------------------ end

StartThread(win);
StartThread(bot);
StartThread(Base_Guard);
StartThread(Desert_Guard);
StartThread(TruckRetreat);
StartThread(RevealObjective0);
Trigger(Objective0, CompleteObjective0);
Trigger(humber_swarm, humber_swarm_go);
Trigger (willis_retreat, willis);
Trigger(WillisArrive, start);