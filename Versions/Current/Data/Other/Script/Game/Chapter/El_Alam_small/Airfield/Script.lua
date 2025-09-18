

function RevealObjective0()
    Wait(3);
    SwitchSquadLightFX( 961, 0 );
	ObjectiveChanged(0, 1);
end;

function Objective0()
	if ((GetNUnitsInArea(0, "AF") >= 1) and (GetNUnitsInArea(1, "AF") <= 0)) then
        return 1;
    end;
end;

function CompleteObjective0()
	Wait(3);
	ObjectiveChanged(0, 2);
	SetIGlobalVar( "temp.AF,objective", 2 );
	Wait(2);
end;
----------------------------------------------------------------------

function Check_Obj()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "vill") > 0) or (GetIGlobalVar("temp.AF,objective", 1) == 2)) then
		StartThread( Rand_obj );
		break;
		end;
	end;
end;


function Rand_obj()
local x = RandomInt(2);
	if x == 0 then
	StartThread( Objective11 );
	Wait(3);
	ObjectiveChanged(1, 1);
	end;
	if x == 1 then
	StartThread( Objective12 );
	Wait(3);
	ObjectiveChanged(1, 1);
	end;
end;

----------------------------------------------------------------------

function Objective11()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "H1") >= 1) then
		ObjectiveChanged(1, 2);
		SetIGlobalVar( "temp.H,objective", 2 );
		break;
		end;
	end;
end;

------------2

function Objective12()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "H2") >= 1) then
		ObjectiveChanged(1, 2);
		SetIGlobalVar( "temp.H,objective", 2 );
		break;
		end;
	end;
end;

-----------------------------------------------------

function Casual_winn()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.H,objective", 1) == 2) and (GetIGlobalVar("temp.AF,objective", 1) == 2)) then
		Wait(3);
		Win(0);
		break;
		end;
	end;
end;

function Casual_caput()
        while 1 do
            if (( GetNUnitsInParty(0) < 1) and ( ( IsReinforcementAvailable( 0 ) == 0 ) or ( GetReinforcementCallsLeft( 0 ) == 0 ))) then
				Wait(3);
                Win(1);
         return 1;
	end;
	Wait(5);
	end;
end;

-----------------------------------------------------

function Patrol_Start()
	while 1 do
		Wait(5);
		if (( GetNUnitsInScriptGroup(110) > 0) and (GetNUnitsInArea(1, "Pos1") > 0))then
		Wait( 10 + RandomInt( 10 ) );
		StartThread( Patrol_GO);
		end;
	end;
end;

function Patrol_GO()
	Wait(10);
	Cmd(ACT_SWARM, 110, 0, 0, 5969, 3554);
	QCmd(ACT_SWARM, 110 , 0, 0, 2457, 3465);
	QCmd(ACT_SWARM, 110 , 0, 0, 5969, 3554);
	StartThread( Patrol_Start );
end;
------------------------------2
function Patrol2_Start2()
	while 1 do
		Wait(5);
		if (( GetNUnitsInScriptGroup(120) > 0) and (GetNUnitsInArea(1, "Pos2") > 0))then
		Wait( 10 + RandomInt( 10 ) );
		StartThread( Patrol2_GO);
		end;
	end;
end;

function Patrol2_GO()
	Wait(5);
	Cmd(ACT_SWARM, 120, 0, 0, 5466, 7238);
	QCmd(ACT_SWARM, 120, 0, 0, 3752, 6244);
	QCmd(ACT_SWARM, 120, 0, 0, 5466, 7338);
	Wait(5);
	StartThread( Patro2_Start2 );
end;
-----------------------------------------------------Shucher!--------
function Alert1()
	while 1 do
		Wait(3);
		if (GetNUnitsInArea(0, "W1") > 0)then
		Wait(2);
		StartThread( Alert11);
		break;
		end;
	end;
end;

function Alert11()
	Wait(2);
	LandReinforcementFromMap (1, 0, 0, 1500 ); 
	Wait( 2 );
	Cmd( 0, 1500, 0, 1834, 6125 );
	QCmd( 5, 1500, 0, 2490, 6605 );
end;
----------------------
function Alert2()
	while 1 do
		Wait(3);
		if (GetNUnitsInArea(0, "W2") > 0)then
		Wait(2);
		StartThread( Alert22);
		break;
		end;
	end;
end;

function Alert22()
	Wait(2);
	LandReinforcement( 1, 859, 1, 1600 );
	LandReinforcementFromMap (1, 0, 1, 1600 ); 
	Wait( 2 );
	Cmd( 0, 1600, 0, 7146, 6961 );
	QCmd( 5, 1600, 0, 6438, 7187 );
end;

-----------------------------------------------------------AUTO



function Tanks()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "ALLERT") > 0) then
		DisplayTrace("Alert!");
		SwitchSquadLightFX( 961, 1 );
		Wait(3);
		Cmd ( 4, 962, 961 );
		Cmd ( 4, 963, 961 );
		Cmd ( 7, 533, 0, 3835, 3949 );
		Wait(6);
		Cmd ( 0, 961, 0, 5078,4646 );
		QCmd ( 0, 961, 0, 7257,6861 );
		QCmd ( 0, 961, 0, 7560,7927 );
		StartThread( Tanks2 );
		break;
		end;
	end;
end;

function Tanks2()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "exit") > 0) then
		Wait(2);
		RemoveScriptGroup( 961 );
		Wait(3);
		StartThread( Tanks3 );
		Wait(6);
		StartThread( Tanks4 );
		break;
		end;
	end;
end;

function Tanks3()
	Wait(5);
	LandReinforcementFromMap (1, 1, 2, 2700 ); 
	Wait( 2 );
	Cmd( ACT_SWARM, 2700, 200, 6789,5879);
	QCmd( ACT_SWARM, 2700, 200, 3174,3625);
	QCmd( ACT_SWARM, 2700, 200, 5767,727);
	
end;

function Tanks4()
	Wait(5);
	LandReinforcementFromMap (1, 2, 0, 2750 );
	Wait( 2 );
	ChangeFormation( 2700, 3 );
	Cmd( ACT_SWARM, 2750, 200, 6789,5879);
	QCmd( ACT_SWARM, 2750, 200, 3174,3625);
	QCmd( ACT_SWARM, 2750, 200, 4699,6875);
	
end;


-----------------------------------------------------MAIN

StartThread( Tanks );

StartThread( Casual_caput );
StartThread( Casual_winn );
StartThread( Check_Obj );
StartThread( RevealObjective0 );
Trigger( Objective0, CompleteObjective0 );

StartThread( Patrol_Start );
StartThread( Patrol2_Start2 );

StartThread( Alert1 );
StartThread( Alert2 );








