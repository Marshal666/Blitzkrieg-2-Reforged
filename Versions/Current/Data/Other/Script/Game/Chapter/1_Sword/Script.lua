-- deploy templates id consts
Deploy_Tanks = 9;
Deploy_MainInf = 11;
Deploy_TD = 10;
Deploy_GA = 12;
Deploy_Fighters = 13;
Deploy_Artillery = 14;
Deploy_HeavyArtillery = 15;

-- player reinf id consts
Reinf_Player_Tanks = 59;
Reinf_Player_Artillery = 48;
Reinf_Player_MainInf = 57;
Reinf_Player_HeavyArtillery = 55;
Reinf_Player_Fighters = 53;
Reinf_Player_GA = 54;
Reinf_Player_TD = 58;


-- enemy reinf id consts
Reinf_Enemy_Tanks = 67;
Reinf_Enemy_TD = 69;
Reinf_Enemy_Inf = 72;
Reinf_Enemy_GA = 75;



-- other

DISPERSION = 500;

-----------------------------Obj0_Station_sec

function RevealObjective0()
    Trace("StartMission Run.");
    Wait(5);
	ObjectiveChanged(0, 1);
    Trace("Objective0 is reveal");
end;

function Objective0()
	if ((GetNUnitsInArea(0, "Station") > 0) and (GetNUnitsInArea(1, "Station") < 1)) then
        return 1;
    end;
end;

function CompleteObjective0()
	ObjectiveChanged(0, 2);
	Wait(6);
	LandReinforcement( 0, 65, 9, 1 );
	SetIGlobalVar( "temp.Sword,objective0", 2 );
	Trace("Objective0 complete");
end;

-----------------------------Obj1_Town_hall_Fr_infant

function RevealObjective1()
    Wait(10);
	ObjectiveChanged(1, 1);
    Trace("Objective1 is reveal");
end;

function Objective1()
	if (GetNUnitsInArea(0, "Town_hall") > 0) then
        return 1;
    end;
end;

function CompleteObjective1()
	ObjectiveChanged(1, 2);
	Wait(3);
	LandReinforcement( 0, 117, 11, 2 );
	SetIGlobalVar( "temp.Sword,objective1" ,2 );
	Trace("Objective1 complete");
end;

-----------------------------Obj2_Lighthouse_Germ_artillery

function RevealObjective2()
    Wait(15);
	ObjectiveChanged(2, 1);
    Trace("Objective2 is reveal");
end;

function Objective2()
	if ((GetNUnitsInArea(1, "Lighthouse") < 1) and (GetNUnitsInScriptGroup(200, 1) < 1)) then
    return 1;
    end;
end;

function CompleteObjective2()
	ObjectiveChanged(2, 2);
	Trace("Objective2 complete");
	StartThread( RevealObjective5 );
	Trigger( Objective5, CompleteObjective5 );
end;

------------------------------Open_obj3_and_Obj4_main

function Well_done()
	while 1 do
      if GetIGlobalVar("temp.Sword,objective0",0 ) == 2 or GetIGlobalVar("temp.Sword,objective1", 1) == 2 then
		StartThread( RevealObjective3 );
		Trigger( Objective3, CompleteObjective3 );
		StartThread( RevealObjective4 );
		Trigger( Objective4, CompleteObjective4 );
        return 1;
      end;
   Wait(5);
	end;
end;

-----------------------------Obj3_Station_MAIN

function RevealObjective3()
    Wait(5);
	ObjectiveChanged(3, 1);
    Trace("Objective3 is reveal");
end;

function Objective3()
	if ((GetNUnitsInArea(0, "Station_2") > 0) and (GetNUnitsInArea(1, "Station_2") < 1)) then
        return 1;
    end;
end;

function CompleteObjective3()
	ObjectiveChanged(3, 2);
	SetIGlobalVar( "temp.Sword,objective3", 2 );
	Trace("Objective3 complete");
end;

------------------------------Obj4_Manor_MAIN

function RevealObjective4()
    Wait(10);
	ObjectiveChanged(4, 1);
    Trace("Objective4 is reveal");
end;

function Objective4()
	if ((GetNUnitsInArea(0, "Manor") > 0) and (GetNUnitsInArea(1, "Manor") < 1)) then
        return 1;
    end;
end;

function CompleteObjective4()
	ObjectiveChanged(4, 2);
	SetIGlobalVar( "temp.Sword,objective4", 2 );
	Trace("Objective4 complete");
end;

-------------------------------Second_Obj5_SeaBase

function RevealObjective5()
    Wait(3);
	ObjectiveChanged(5, 1);
    Trace("Objective5 is reveal");
end;

function Objective5()
	if ((GetNUnitsInArea(0, "Sea_base") > 0) and (GetNUnitsInArea(1, "Sea_base") < 1)) then
        return 1;
    end;
end;

function CompleteObjective5()
	ObjectiveChanged(5, 2);
	Trace("Objective5 complete");
end;

--------------------------------Winn_Loose

function Winner()
	while 1 do
      if GetIGlobalVar("temp.Sword,objective3",0 ) == 2 and GetIGlobalVar("temp.Sword,objective4", 1) == 2 then
		Win(0);
        return 1;
      end;
   Wait(5);
	end;
end;



function Lose()
        while 1 do
            if ( GetNUnitsInParty(0) < 1) then
				Wait(3);
                Loose(0);
         return 1;
	end;
	Wait(5);
	end;
end;

------------------------------Ger_Attack_main_objectives

function GAllert()
	while 1 do
      if ((GetNUnitsInArea(0, "Manor") > 0) or (GetNUnitsInArea(0, "Station_2") > 0)) then
		StartThread( GReinf_Attack );
        return 1;
      end;
    Wait(5);
	end;
end;



function GReinf_Attack( k )
local Attack_Group = {};
	Wait( 20 );
	Trace("Enemy reinf landed");
	LandReinforcement( 1, 67, 9, 2 );
	Trace("German allert run");
	Wait( 3 );
	Attack_Group = GetUnitListInAreaArray( 1, "GER_Reinf2" );
	CmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION, GetScriptAreaParams( "Manor" ) );
	QCmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION, GetScriptAreaParams( "Station_2" ) );
	QCmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION, GetScriptAreaParams( "Station" ) );
end;



--Main

StartThread( GAllert );
StartThread( Winner );
StartThread( Lose );
StartThread( Well_done );
StartThread( RevealObjective0 );
Trigger( Objective0, CompleteObjective0 );
StartThread( RevealObjective1 );
Trigger( Objective1, CompleteObjective1 );
StartThread( RevealObjective2 );
Trigger( Objective2, CompleteObjective2 );
