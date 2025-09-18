
Tanks1_ScriptId = 1010;
Tanks2_ScriptId = 1020;
DISPERSION = 300;

-----------------------------------------------------------------------------Chapter1
-----------------------------------------Objective0_PRIMARY_STAFF
function RevealObjective0()
    DisplayTrace("StartMission!!!");
    Wait(3);
	ObjectiveChanged(0, 1);
	Trace("Objective0_STAFF is reveal");
    DisplayTrace("Protect its staff");
end;

function Objective0()
	if ((GetNUnitsInArea(0, "Staff") <= 0) and (GetNUnitsInArea(2, "Staff") >= 1)) then
        return 1;
    end;
end;

function FailObjective0()
	ObjectiveChanged(0, 3);
	Wait(3);
	Loose(0);
	Trace("Objective0_STAFF fail");
end;
-----------------------------------------Objective1_PRIMARY_CANNES
function RevealObjective1()
    Wait(10);
	ObjectiveChanged(1, 1);
    Trace("Objective1_CANNES is reveal");
    DisplayTrace("Seize city in the east");
end;

function Objective1()
	if ((GetNUnitsInArea(2, "Cannes") <= 0) and (GetNUnitsInArea(0, "Cannes") >= 1)) then
    return 1;
    end;
end;

function CompleteObjective1()
	ObjectiveChanged(1, 2);
	Wait(3);
	Win(0);
	Trace("Objective1_CANNES complete");
end;
-----------------------------------------Objective2_SECOND_STATION
function RevealObjective2()
    Wait(18);
	ObjectiveChanged(2, 1);
    Trace("Objective2_STATION is reveal");
end;

function Objective2()
	if ((GetNUnitsInArea(2, "Station") <= 0) and (GetNUnitsInArea(0, "Station") >= 1)) then
    return 1;
    end;
end;

function CompleteObjective2()
	ObjectiveChanged(2, 2);
	EnableReinforcementPoint( 0, 4, 1 );
	Trace("Objective2_STATION complete");
end;
-----------------------------------------Objective3_SECOND_BRIDGE_1
function RevealObjective3()
    Wait(26);
	ObjectiveChanged(3, 1);
    Trace("Objective3_BRIDGE_1 is reveal");
    StartThread( Check_Staff_Attack );
    Trace("Start_Attack1");
end;

function Objective3()
	if ((GetNUnitsInArea(2, "Bridge_1") <= 0) and (GetNUnitsInArea(0, "Bridge_1") >= 1)) then
    return 1;
    end;
end;

function CompleteObjective3()
	ObjectiveChanged(3, 2);
	Trace("Objective2_BRIDGE_1 complete");
	Wait(2);
	StartThread( RevealObjective4 );
	Trigger( Objective4, CompleteObjective4 );
	StartThread( RevealObjective5 );
	Trigger( Objective5, CompleteObjective5 );
	StartThread( RevealObjective6 );
	Trigger( Objective6, CompleteObjective6 );

end;

------------------------------------------------------------------------------Chapter2
-------------------------------------------Objective4_A_FIELD
function RevealObjective4()
    Wait(3);
	ObjectiveChanged(4, 1);
    Trace("Objective4_A_field is reveal");
end;

function Objective4()
	if ((GetNUnitsInArea(2, "A_field") <= 0) and (GetNUnitsInArea(0, "A_field") >= 1)) then
    return 1;
    end;
end;

function CompleteObjective4()
	ObjectiveChanged(4, 2);
	EnableReinforcementPoint( 0, 5, 1 );
	EnableReinforcementPoint( 0, 6, 1 );
	SetIGlobalVar( "temp.Afield,objective", 2 );
	Wait(2);
	StartThread( Check_Afield_Attack );
	StartThread( Afield_incomplete );
	Trace("Objective2_A_field complete");
end;
-------------------------------------------Objective5_VILLAGE
function RevealObjective5()
    Wait(10);
	ObjectiveChanged(5, 1);
    Trace("Objective5_Village is reveal");
end;

function Objective5()
	if ((GetNUnitsInArea(2, "Village") <= 0) and (GetNUnitsInArea(0, "Village") >= 1)) then
    return 1;
    end;
end;

function CompleteObjective5()
	ObjectiveChanged(5, 2);
	SetIGlobalVar( "temp.Village,objective", 2 );
	Trace("Objective5_Village complete");
end;
-------------------------------------------Objective6_GUNS
function RevealObjective6()
    Wait(18);
	ObjectiveChanged(6, 1);
    Trace("Objective6_Guns is reveal");
end;

function Objective6()
	if (GetNUnitsInScriptGroup(299, 2) <= 0) then
    return 1;
    end;
end;

function CompleteObjective6()
	ObjectiveChanged(6, 2);
	SetIGlobalVar( "temp.Guns,objective", 2 );
	Trace("Objective6_Guns complete");
end;

--------------------------------------------Attacks
---------------------------------Staff

function Check_Staff_Attack()
	while 1 do
		Wait( 20 + RandomInt( 120 ) );
		if (( GetNUnitsInScriptGroup( Tanks1_ScriptId ) <= 0 ) and (GetIGlobalVar("temp.Guns,objective", 1) ~= 2)) then
			LandReinforcement2( 2, 166, 9, 1, Tanks1_ScriptId ); 
			Wait( 2 );
			CmdMultipleDisp( ACT_SWARM, Tanks1_ScriptId, DISPERSION, 444, 10950 );
		end;
	end;
end;
---------------------------------A_field_ATTACK
function Check_Afield_Attack()
	while 1 do
		Wait( 20 + RandomInt( 90 ) );
		if (( GetNUnitsInScriptGroup( Tanks2_ScriptId ) <= 0 ) and (GetIGlobalVar("temp.Afield,objective", 1) == 2) and (GetIGlobalVar("temp.Village,objective", 1) ~= 2)) then
			LandReinforcement2( 2, 165, 9, 2, Tanks2_ScriptId ); 
			Wait( 2 );
			CmdMultipleDisp( ACT_SWARM, Tanks2_ScriptId, DISPERSION, 808, 2502 );
		end;
	end;
end;
-------------------------------- Air_REINF
function Afield_incomplete()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "A_field") <= 0) and (GetNUnitsInArea(2, "A_field") >= 1)) then
			ObjectiveChanged(0, 1);
			StartThread( Afield_complete );
			EnableReinforcementPoint ( 0, 5, 0 );
			EnableReinforcementPoint ( 0, 6, 0 );
			Trace("Objective_AERFIELD reveal again!!!!!!!!");
			SetIGlobalVar( "temp.Afield,objective", 1 );
			break;
		end;	
	end;
end;

function Afield_complete()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "A_field") >= 1) and (GetNUnitsInArea(2, "A_field") <=0)) then
			ObjectiveChanged(0, 2);
			StartThread( Afield_incomplete );
			EnableReinforcementPoint ( 0, 5, 1 );
			EnableReinforcementPoint ( 0, 6, 1 );
			Trace("Objective_AERFIELD complete again!!!!!!!");
			SetIGlobalVar( "temp.Afield,objective", 2 );   
			break;
		end;	
	end;
end;



----------------------------MAIN

StartThread( RevealObjective0 );
Trigger( Objective0, FailObjective0 );
StartThread( RevealObjective1 );
Trigger( Objective1, CompleteObjective1 );
StartThread( RevealObjective2 );
Trigger( Objective2, CompleteObjective2 );
StartThread( RevealObjective3 );
Trigger( Objective3, CompleteObjective3 );






