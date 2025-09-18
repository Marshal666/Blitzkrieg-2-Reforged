-- deploy templates id consts
Deploy_Tanks = 9;
Deploy_MainInf = 11;
Deploy_TD = 10;
Deploy_GA = 12;
Deploy_Fighters = 13;
Deploy_Artillery = 14;
Deploy_HeavyArtillery = 15;
Deploy_AssaultSPG = 17;
Deploy_LightTanks = 19;
Deploy_AssaultInf = 18;
Deploy_SingleShip = 20;

-- player reinf id consts
Reinf_Player_Tanks = 59;
Reinf_Player_Artillery = 48;
Reinf_Player_MainInf = 57;
Reinf_Player_HeavyArtillery = 55;
Reinf_Player_Fighters = 53;
Reinf_Player_GA = 54;
Reinf_Player_TD = 58;
Reinf_Player_AssaultInf = 49;
Reinf_Player_AssaultSPG = 50;
Reinf_Player_LightTanks = 56;
Reinf_Player_TransportShip = 109;


-- enemy reinf id consts
Reinf_Enemy_Tanks = 67;
Reinf_Enemy_TD = 69;
Reinf_Enemy_MainInf = 72;
Reinf_Enemy_GA = 75;
Reinf_Enemy_Fighters = 76;
Reinf_Enemy_AssaultInf = 68;
Reinf_Enemy_Artillery = 66;
Reinf_Enemy_HeavyArtillery = 71;
Reinf_Enemy_LightTanks = 70;
Reinf_Enemy_AssaultSPG = 77;



DISPERSION = 400;




-----------------------Obj1_Start_1Pl_reinf

function RevealObjective1()
    Wait(5);
	ObjectiveChanged(1, 1);
    Trace("Objective1 is reveal_Clean zone of the debarkation");
end;


function Objective1()
	if ((GetNUnitsInArea(0, "START") > 0) and (GetNUnitsInArea(1, "START") < 1)) then
        return 1;
    end;
end;


function CompleteObjective1()
	ObjectiveChanged(1, 2);
	Trace("Objective1 complete!Clean zone of the debarkation");
	Wait(10);
	LandReinforcement( 0, 59, 9, 1 );
    Trace("Pl_reinforcement_1_land!!!!");
    Wait(10);
    StartThread( RevealObjective2 );
	Trigger( Objective2, CompleteObjective2 );
	Wait(10);
end;

------------------------Obj2_Base_main_Winner!!!

function RevealObjective2()
	ObjectiveChanged(2, 1);
	Trace("Objective2 is reveal_Base");
	Wait(5);
	StartThread( RevealObjective3 );
	Trigger( Objective3, CompleteObjective3 );
	Wait(5);
	StartThread( RevealObjective4 );
	Trigger( Objective4, CompleteObjective4 );
	Wait(5);
	StartThread( RevealObjective5 );
end;

function Objective2()
	if ((GetNUnitsInArea(0, "BASE") > 0) and (GetNUnitsInArea(1, "BASE") < 1)) then
        return 1;
    end;
end;

function CompleteObjective2()
	ObjectiveChanged(2, 2);
	Trace("Objective2 complete_Base");
	Wait(3);
	ObjectiveChanged(5, 2);
	Wait(2);
    Win (0);
end;

-----------------------Obj3_Port_sec_2Pl_reinf

function RevealObjective3()
	ObjectiveChanged(3, 1);
    Trace("Objective3 is reveal_PORT");
end;

function Objective3()
	if ((GetNUnitsInArea(0, "PORT") > 0) and (GetNUnitsInArea(1, "PORT") < 1)) then
        return 1;
    end;
end;

function CompleteObjective3()
	ObjectiveChanged(3, 2);
	Wait(3);
	Trace("Objective3 complete_PORT");
	LandReinforcement( 0, 65, 9, 2 );
	Trace("Pl_reinforcement_2_land!!!!");
end;

-----------------------Obj4_RADAR_sec

function RevealObjective4()
    Wait(10);
	ObjectiveChanged(4, 1);
    Trace("Objective4 is reveal_RADAR");
end;

function Objective4()
	if ((GetNUnitsInArea(0, "RADAR") > 0) and (GetNUnitsInArea(1, "RADAR") < 1)) then
        return 1;
    end;
end;

function CompleteObjective4()
	ObjectiveChanged(4, 2);
	Wait(3);
	Trace("Objective4 complete_RADAR");
end;

-----------------------Obj5_BRIDGE_sec_LOSS_BRIDGE!!!

function RevealObjective5()
	LandReinforcement( 0, 117, 11, 3 );
	Trace("AirTroops_landed_bridge");
    Wait(20);
	ObjectiveChanged(5, 1);
    Trace("Objective5 is reveal_HOLD_BRIDGE");
    Wait(5);
	Trigger( Objective5, FailedObjective5 );
    Wait(200);
    StartThread( Attack1 );
	StartThread( Attack2 );
end;

function Objective5()
	if ((GetNUnitsInArea(0, "BRIDGE") < 1) and (GetNUnitsInArea(1, "BRIDGE") > 0)) then
        return 1;
    end;
end;

function FailedObjective5()
	ObjectiveChanged(5, 3);
	Wait(5);
	Trace("Objective5_Loss!!!_BRIDGE");
	StartThread( GReinf_Attack );
end;

----------------------German_attack_bridge_port

function Attack1()
        CmdMultipleDisp( ACT_SWARM, 500,DISPERSION, 6968,12812 );
        QCmdMultipleDisp( ACT_SWARM, 500,DISPERSION, 10172,7369 );
  	Trace ( "Attack500_run!!!" );
end;

function Attack2()
        CmdMultipleDisp( ACT_SWARM, 501,DISPERSION, 8127,3258 );
        QCmdMultipleDisp( ACT_SWARM, 501,DISPERSION, 10172,7369 );
  	Trace ( "Attack501_run!!!" );
end;

-----------------------German_attack_port_loss_bridge

function GReinf_Attack()
local Attack_Group = {};
	Wait( 20 );
	Trace("Enemy tank reinf landed");
	LandReinforcement( 1, 67, 9, 1 );
	Wait( 3 );
	Attack_Group = GetUnitListInAreaArray( 1, "Ger_reif1" );
	CmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION, GetScriptAreaParams( "Attack_2" ) );
end;

----------------------Loose

function Defeat()
        while 1 do
            if ( GetNUnitsInParty(0) < 1) then
            Loose(0);
        return 1;
	end;
	Wait(5);
end;
end;



--Main
StartThread( Defeat );
StartThread( RevealObjective1 );
Trigger( Objective1, CompleteObjective1 );

