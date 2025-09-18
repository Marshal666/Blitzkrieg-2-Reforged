SetIGlobalVar("temp.nogeneral_sript",1)

function Start_Road()
	while 1 do
		Wait(3);
		if (( GetNUnitsInScriptGroup(99) < 1) and (GetIGlobalVar("temp.Sea,objective", 1) ~= 2))then
		Wait(3);
		StartThread(Rand_Road);
		end;
	end;
end;


function Rand_Road()
	local x = RandomInt(2);
	if x == 1 then
	Wait(2);
	LandReinforcementFromMap (1, 0, 0, 99 );
	DisplayTrace ( "The Enemy transport appeared!" ); 
	Wait(2);
	Cmd( 0, 99, 0, 6213, 8182 );
	QCmd( 0, 99, 0, 3374, 4657 );
	QCmd( 0, 99, 0, 457, 8203 );
	else
	Wait(2);
	LandReinforcementFromMap (1, 0, 1, 99 );
	DisplayTrace ( "The Enemy transport appeared!" );  
	Wait(2);
	Cmd( 0, 99, 0, 6128, 5190 );
	QCmd( 0, 99, 0, 3582, 8209 );
	QCmd( 0, 99, 0, 455, 4267 );
	end; 
end;
------------------------------------------------------------
function Loose()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "Exit", 0) > 0) and (GetIGlobalVar("temp.Sea,objective", 1) ~= 2))then
			RemoveScriptGroup( 99 );
			ObjectiveChanged(0, 3);
			Wait( 2 );
			Win(1);
			break;
		end;	
	end;
end;
------------------------------------------------------------
function Winner()
	Wait( 350 + RandomInt( 100 ) );
	SetIGlobalVar( "temp.Sea,objective", 2 );
end;
------------------------------------------------------------

function RevealObjective0()
    Wait(2);
	ObjectiveChanged(0, 1);
end;

function Objective0()
	if ((GetIGlobalVar("temp.Sea,objective", 1) == 2) and ( GetNUnitsInScriptGroup( 99, 1 ) == 0 ))then
    return 1;
    end;
end;

function CompleteObjective0()
	ObjectiveChanged(0, 2);
	Wait(2);
	Win(0);
	SetIGlobalVar( "temp.Sea,objective", 2 );
	Wait(3);
end;
-----------------------------------------------------
function Ger_allert()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "Warzone", 0) > 0) then
			LandReinforcementFromMap (1, 1, 2, 120 );
			Wait(2);
			Cmd( ACT_SWARM, 120, 50, 5870, 5009 );
			LandReinforcementFromMap (1, 2, 0, 130 ); 
			Wait(2);
			Cmd( ACT_SWARM, 130, 100, 5870, 5009 ); 
			Wait( 2 );
			break;
		end;	
	end;
end;

---------------------------------------MAIN
StartThread( Winner );
StartThread( Ger_allert );
StartThread( Start_Road );
StartThread( Loose );

StartThread( RevealObjective0 );
Trigger( Objective0, CompleteObjective0 );