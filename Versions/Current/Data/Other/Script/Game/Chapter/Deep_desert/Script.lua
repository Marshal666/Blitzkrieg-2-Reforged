DISPERSION = 700;

-------------------------------------------------------Patrols

function Patrol_Start()
	if ( GetNUnitsInScriptGroup(100) > 0) then
		StartThread( Patrol_GO);
	end;
end;


function Patrol_GO()
	Wait( 20 );
	GiveCommand(ACT_SWARM, 100, 453, 2506);
	Wait( 20 );
	QCmd(ACT_SWARM, 100 , 2560, 2303);
	Wait( 20 );
	QCmd(ACT_SWARM, 100 , 812, 1388);
	Wait( 20 );
	StartThread( Patrol_Start );
end;



function Patrol_Start_1()
	if ( GetNUnitsInScriptGroup(101) > 0) then
		StartThread( Patrol_1_GO);
	end;
end;

function Patrol_1_GO()
	Wait( 10 );
	GiveCommand(ACT_SWARM, 101, 6260, 1030);
	Wait( 25 );
	QCmd(ACT_SWARM, 101 , 8101, 2164);
	Wait( 25 );
	QCmd(ACT_SWARM, 101 , 9527, 3409);
	Wait( 25 );
	StartThread( Patrol_Start_1 );
end;

------------------------------------------------------Airfield

function RevealObjective1()
    Trace("Start Mission DEEP Run.");
    Wait(5);
	ObjectiveChanged(0, 1);
    Trace("Objective1 is reveal");
end;

function Objective1()
	if ((GetNUnitsInArea(0, "Airfield") > 0) and (GetNUnitsInArea(1, "Airfield") < 1)) then
        return 1;
    end;
end;

function CompleteObjective1()
	ObjectiveChanged(0, 2);
	SetIGlobalVar( "temp.Deep,objective1", 2 );
	Trace("Objective0 complete");
	Wait( 10 );
	StartThread( Attack_GT );
    StartThread( Attack_GI );
    StartThread( RevealObjective2 );
	Trigger( Objective2, CompleteObjective2 );
end;

-----------------------------------------------------Attack_AF

function Attack_GT()
    CmdMultiple( ACT_SWARM, 300, 9210,9557 );
    QCmdMultiple( ACT_SWARM, 300, 9435,4720 );
    QCmdMultiple( ACT_SWARM, 300, 4889,1110 );
	QCmdMultiple( ACT_SWARM, 300, 3771,4790 );
end;

function Attack_GI()
    CmdMultiple( ACT_SWARM, 301, 3633,1263 );
    QCmdMultiple( ACT_SWARM, 301, 9443,3643 );
    QCmdMultiple( ACT_SWARM, 301, 5792,5989 );
end;

-----------------------------------------------------BASE

function RevealObjective2()
	ObjectiveChanged(2, 1);
	Trace("Objective2 is reveal_Base");
end;

function Objective2()
	if ((GetNUnitsInArea(0, "Base") > 0) and (GetNUnitsInArea(1, "Base") < 1)) then
        return 1;
    end;
end;

function CompleteObjective2()
	ObjectiveChanged(2, 2);
	Trace("Objective2 complete_Base");
	Wait( 5 );
	StartThread( Rommel );
end;

----------------------------------------------------ROMMEL

function Rommel()
	local x = RandomInt(2);
	if x == 1 then
	StartThread( R1 );
	Trigger( Objective3, CompleteObjective3 );
	else
	StartThread( R2 );
	Trigger( Objective3_1, CompleteObjective3_1 );	
	end; 
end;
----------------------------------------R1
function R1()
	ObjectiveChanged(3, 1);
	Trace("Objective3 is reveal_Rommel_1");
end;

function Objective3()
	if ((GetNUnitsInArea(0, "Rommel_1") > 0) and (GetNUnitsInArea(1, "Rommel_1") < 1)) then
        return 1;
    end;
end;

function CompleteObjective3()
	ObjectiveChanged(2, 2);
	Trace("Objective2 complete_Rommel_1");
end;

-----------------------------------------R2

function R2()
	ObjectiveChanged(3, 1);
	Trace("Objective3 is reveal_Rommel_2");
end;

function Objective3_1()
	if ((GetNUnitsInArea(0, "Rommel_2") > 0) and (GetNUnitsInArea(1, "Rommel_2") < 1)) then
        return 1;
    end;
end;

function CompleteObjective3_1()
	ObjectiveChanged(2, 2);
	Trace("Objective3 complete_Rommel_2");
end;


--Main
StartThread( Patrol_Start_1 );
StartThread( Patrol_Start );
StartThread( RevealObjective1 );
Trigger( Objective1, CompleteObjective1 );


