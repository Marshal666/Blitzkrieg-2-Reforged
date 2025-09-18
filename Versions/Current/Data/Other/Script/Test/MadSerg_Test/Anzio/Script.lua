function TobeDefeated()
	if (GetNUnitsInScriptGroup (1000, 0) <= 0) then
		Loose();
		Suicide();
	end;
end;

function ToWin()
	if (( GetIGlobalVar("Ardennes44.objective.2", 0) * GetIGlobalVar("Ardennes44.objective.3", 0) *
	  GetIGlobalVar("Ardennes44.objective.4", 0) * GetIGlobalVar("Ardennes44.objective.5", 0)) == 1) then
		Win(0);
		Suicide();
	end;
end;

function RevealObjective0()
	ObjectiveChanged(0, 0);
	Suicide();
end;

function RevealObjective1()
	ObjectiveChanged(1, 0);
	Suicide();
end;

function RevealObjective2()
	ObjectiveChanged(2, 0);
	Suicide();
end;

function RevealObjective3()
	ObjectiveChanged(3, 0);
	Suicide();
end;

function RevealObjective4()
	ObjectiveChanged(4, 0);
	Suicide();
end;

function RevealObjective5()
	ObjectiveChanged(5, 0);
	Suicide();
end;


function Objective0()
	if ( GetNUnitsInScriptGroup(1, 1) < 4) then
		SetIGlobalVar("Ardennes44.objective.0", 1);
		ObjectiveChanged(0, 1);

		RunScript( "RevealObjective1", 5000);
		RunScript( "Reinforce1", 10000);
		Suicide();
	end;
end;

-- repell enemy counterattack at north
function Objective1()
	if ( GetIGlobalVar("temp.Ardennes44.objective.101", 0) == 1) then
	if ( GetNUnitsInScriptGroup(10, 1) <= 0) then
		SetIGlobalVar("Ardennes44.objective.1", 1);
		ObjectiveChanged(1, 1);

		RunScript( "RevealObjective2", 5000);
		Suicide();
	end;
	end;
end;

-- destroy enemy long range artillery
function Objective2()
	if ( GetNUnitsInScriptGroup(5, 1) <= 0) then
		SetIGlobalVar("Ardennes44.objective.2", 1);
		ObjectiveChanged(2, 1);
		Suicide();
	end;
end;

-- destroy #2 group
function Objective3()
	if ( GetNUnitsInScriptGroup(2, 1) < 3) then
		SetIGlobalVar("Ardennes44.objective.3", 1);
		ObjectiveChanged(3, 1);

		RunScript( "Reinforce2", 10000);
		Suicide();
	end;
end;

-- destroy #3 group
function Objective4()
	if ( GetNUnitsInScriptGroup(3, 1) < 3) then
		SetIGlobalVar("Ardennes44.objective.4", 1);
		ObjectiveChanged(4, 1);
		RunScript( "Reinforce3", 10000);
		Suicide();
	end;
end;

-- capture general warehouses in southwest town
function Objective5()
	if ( GetNUnitsInScriptGroup(4, 1) <= 0) then
		SetIGlobalVar("Ardennes44.objective.5", 1);
		ObjectiveChanged(5, 1);
		Suicide();
	end;
end;


StartThread( StartMission )   
Trigger( Objective0, CompleteObjective0 )     
Trigger( Objective1, CompleteObjective1 )    
Trigger( Objective2, CompleteObjective2 )    
Trigger( Objective3, CompleteObjective3 ) 
Trigger( Objective4, CompleteObjective4 )
Trigger( Objective5, CompleteObjective5 )  
Trigger( Objective6, CompleteObjective6 )
Trigger( SObjective0, CompleteSObjective0 )
Trigger( SObjective1, CompleteSObjective1 )
StartThread( ToWin )          
StartThread( TobeDefeated )   


	
	
	
