
DISPERSION = 400;

Eng_ScriptId = 2712;

----------------------------------CAMERA
function RevealObjective0()
	SetIGlobalVar( "HoldHelpScreen", 1 );	
	StartSequence ( )
	CameraMove ( 2,0 );
	Wait(3);
	CameraMove ( 3,20000 );
    Wait(35);
    RemoveScriptGroup( 100 );
    EndSequence ( )
    Wait(2);
	ObjectiveChanged(0, 1);
    Wait(2);
    ObjectiveChanged(0, 0);
    Wait(2);
    StartThread( RevealObjective1 );
	Trigger( Objective1, CompleteObjective1 );
end;

---------------------------------1_GB_POST

function RevealObjective1()
	LandReinforcement( 0, 142, 9, 1 );
	CameraMove ( 0,1000 );
	Wait(2);
	StartThread( Lose );
	ObjectiveChanged(1, 1);
    Trace("Objective1 is reveal");
end;

function Objective1()
	if ((GetNUnitsInArea(0, "Post") > 0) and (GetNUnitsInArea(2, "Post") < 1)) then
        return 1;
    end;
end;

function CompleteObjective1()
	Wait(2);
	ObjectiveChanged(1, 2);
	SetIGlobalVar( "temp.objective1", 2 );
	Trace("Objective1 complete");
	Wait(5);
	StartThread( RevealObjective2 );
	Trigger( Objective2, CompleteObjective2 );
end;

---------------------------------2_DE_DEFENSE

function RevealObjective2()
	LandReinforcement( 0, 143, 9, 2 );
	Wait(3);
	ObjectiveChanged(2, 1);
    Trace("Objective2 is reveal");
end;

function Objective2()
	if ((GetNUnitsInArea(0, "G_post") > 0) and (GetNUnitsInArea(2, "G_post") < 1)) then
        return 1;
    end;
end;

function CompleteObjective2()
	Wait(2);
	ObjectiveChanged(2, 2);
	SetIGlobalVar( "temp.objective2", 2 );
	Trace("Objective2 complete");
	Wait(5);
	StartThread( RevealObjective3 );
	Trigger( Objective3, CompleteObjective3 );
end;

---------------------------------3_REPAIR_BASE

function RevealObjective3()
	LandReinforcement( 0, 143, 9, 2 );
	Wait(4);
	ObjectiveChanged(3, 1);	
end;

function Objective3()
	if ((GetNUnitsInArea(0, "Base") > 0) and (GetNUnitsInArea(2, "Base") < 1)) then
        return 1;
    end;
end;

function CompleteObjective3()
	Wait(2);
	ObjectiveChanged(3, 2);
	SetIGlobalVar( "temp.objective3", 2 );
	Trace("Objective3 complete");
	Wait(3);
	StartThread( Lose2 );
	StartThread( RevealObjective4 );
	Trigger( Objective4, CompleteObjective4 );
	StartThread( CheckTanks );
	Wait(20);
	StartThread( RevealObjective5 );
	Wait(30);
	CmdMultiple( ACT_MOVE, 391, 2333,2697 );
	QCmdMultiple( ACT_MOVE, 391, 2173,8379 );
	QCmdMultiple( ACT_DEPLOY, 391, 1870,8933 );
end;

--------------------------------4_MATILDES

function RevealObjective4()
	Wait(1);
	LandReinforcement( 0, 149, 9, 4);
	LandReinforcement2( 0, 145, 9, 4, Eng_ScriptId );
	StartThread( CheckTrucks );
	ObjectiveChanged(4, 1)
    Trace("Objective4 is reveal");
end;

function Objective4()
	if ((GetScriptObjectHPs(111)>=80) or (GetScriptObjectHPs(112)>=80))then
        return 1;
    end;
end;

function CompleteObjective4()
	ObjectiveChanged(4, 2);
	SetIGlobalVar( "temp.repair", 2 );
	StartThread( Attack );
	Trace("Objective4 complete");
	ChangePlayerForScriptGroup( 111, 0 );
	ChangePlayerForScriptGroup( 112, 0 );
end;

-------------------------------5_GUNS

function RevealObjective5()
	ObjectiveChanged(5, 1);
	Trace("Objective5 is reveal");
		Wait(2);
		ViewZone( "Amb", 1 );
    StartThread( Art );
end;

function Art()
	while 1 do
		Wait( 10 );
		if (( GetNUnitsInScriptGroup( 311 )<=0 ) or (GetNUnitsInScriptGroup(391)<=0)) then
			Wait(2);
			ObjectiveChanged(5, 2);
			Trace("Objective5 complete");
			StartThread( RevealObjective6 );
			Trigger( Objective6, CompleteObjective6 );
			break;
		end;
		if ( GetNScriptUnitsInArea( 311, "City" ) >= 1 ) then
			Wait(2);
			ObjectiveChanged(5, 3);
			Trace("Objective5 fall");
			StartThread( RevealObjective6 );
			Trigger( Objective6, CompleteObjective6 );
			break;
		end;
	end;
end;

---------------------------------6_FINAL_CITY

function RevealObjective6()
	ViewZone( "Amb", 0 );
	Wait(4);
	ObjectiveChanged(6, 1);
    Trace("Objective7 is reveal");
    Wait(4);
    LandReinforcement( 0, 144, 11, 4 );
end;

function Objective6()
	if ((GetNUnitsInArea(0, "City") > 0) and (GetNUnitsInArea(2, "City") < 1)) then
        return 1;
    end;
end;

function CompleteObjective6()
	Wait(3);
	ObjectiveChanged(6, 2);
	Trace("Objective6 complete");
	Wait(3);
	Win (0);
end;

--------------------------------Lose

function Lose()
        while 1 do
            if ( GetNUnitsInParty(0) <= 3) and GetIGlobalVar("temp.objective3", 1) ~= 2 then
	Wait(3);
        StartThread( Reinf );
        return 1;
	end;
	Wait(5);
	end;
end;

function Reinf()
	LandReinforcement( 0, 142, 9, 1 );
	Wait(3);
	StartThread( Lose );
end;

------------------------------ Lose2

function Lose2()
        while 1 do
            if ( GetNUnitsInParty(0) <= 6) then
	Wait(3);
        StartThread( Reinf2 );
        return 1;
	end;
	Wait(5);
	end;
end;

function Reinf2()
	LandReinforcement( 0, 142, 9, 4 );
	Wait(3);
	StartThread( Lose2 );
end;

-------------------------------Attack

function Attack()
    CmdMultipleDisp( ACT_SWARM, 891,DISPERSION, 5748,4824 );
    QCmdMultipleDisp( ACT_SWARM, 891,DISPERSION, 9511,8641 );
end;

--------------------------------Matador

function CheckTrucks()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInScriptGroup( Eng_ScriptId ) <= 0 ) then
			LandReinforcement2( 0, 145, 9, 4, Eng_ScriptId );
		end;
	end;
end;

------------------------------CheckTanks
function CheckTanks()
	while 1 do
		Wait( 2 );
		if ((GetScriptObjectHPs(111)<=0) and (GetScriptObjectHPs(112)<=0) and (GetIGlobalVar("temp.repair", 1) ~= 2)) then
        ObjectiveChanged(4, 3);
        break;
        end;
    end;
end;

---------Main
StartThread( RevealObjective0 );
