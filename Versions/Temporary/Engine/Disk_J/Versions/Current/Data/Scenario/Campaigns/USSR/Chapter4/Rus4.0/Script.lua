
-----------------------------------Berlin
function RevealObjective0()
	GiveObjective( 0 );
	Wait( 1 );
	GiveObjective( 1 );
	StartThread( Objective0 );
	StartThread( Objective1 );
	DamageScriptObject (5001, 40000);
	DamageScriptObject (5002, 40000);
	DamageScriptObject (5003, 40000);
end;

function Objective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "START", 0) > 0) and (GetNUnitsInArea(0, "START", 0) < 1)) then
			FailObjective( 0 );
			Wait( 1 );
			Win( 1 );
			break;
		end;	
	end;
end;
--------------------------------------------1
function Objective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "STAFF", 0) < 1) and (GetNUnitsInArea(0, "STAFF", 0) > 0)) then
			CompleteObjective( 1 );
			SetIGlobalVar( "temp.objective1", 2 );
			Wait( 2 );
			GiveObjective( 2 );
			StartThread( Objective2 );
			break;
		end;	
	end;
end;
-------------------------------------------2
function Objective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "B1", 0) > 0) or (GetNUnitsInArea(0, "B2", 0) > 0) or (GetNUnitsInArea(0, "B3", 0) > 0)) then
			CompleteObjective( 2 );
			SetIGlobalVar( "temp.objective2", 2 );
			Wait( 2 );
			break;
		end;	
	end;
end;
-------------------------------------------3
function RevealObjective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "REICH", 0) > 1) or (GetIGlobalVar("temp.objective2", 1) == 2)) then
			GiveObjective( 3 );
			Wait( 2 );
			StartThread( Objective3 );
			break;
		end;	
	end;
end;

function Objective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "REICH", 0) > 0) and (GetNUnitsInArea(1, "REICH", 0) < 1)) then
			CompleteObjective( 3 );
			Wait( 2 );
			SetIGlobalVar( "temp.objective3", 2 );
			break;
		end;	
	end;
end;
-------------------------------------------4
function RevealObjective4()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "OFFICE", 0) > 1) or (GetIGlobalVar("temp.objective3", 1) == 2)) then
			GiveObjective( 4 );
			Wait( 2 );
			StartThread( Objective4 );
			break;
		end;	
	end;
end;

function Objective4()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "OFFICE", 0) > 0) and (GetNUnitsInArea(1, "OFFICE", 0) < 1)) then
			CompleteObjective( 4 );
			Wait( 2 );
			SetIGlobalVar( "temp.objective4", 2 );
			break;
		end;	
	end;
end;
-----------------------------------------------------Winners
function Winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective3", 1) == 2) and (GetIGlobalVar("temp.objective4", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) == 2)) then
			Wait( 1 );
			CompleteObjective( 0 );
			Wait( 1 );
			Win(0);
			break;
		end;	
	end;
end;

function Unlucky()
    while 1 do
        if (( IsSomePlayerUnit(0) < 1) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) or ( IsReinforcementAvailable( 0 ) == 0 )) ) then
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;

-----------------------------------------------------SS
function Metro_Rand() 
	while 1 do
		Wait( 5 );
			if (GetIGlobalVar("temp.objective1", 1) ~= 2) then
			Wait( 3 );
			StartThread( Rand );
			break;
		end;
	end;
end;

function Rand()
local x = RandomInt(4);
	if x == 0 then
	StartThread( A1 );
	end;
	if x == 1 then
	StartThread( A2 );
	end;
	if x == 2 then
	StartThread( A3 );
	end;
	if x == 3 then
	StartThread( A4 );
	end;
end;

function A1()
	LandReinforcementFromMap( 1, "FS", 1, 401 );         
	Wait( 1 );
	ChangeFormation( 401, 3 );
	Wait( 2 );
	Cmd(ACT_SWARM, 401, 0, GetScriptAreaParams( "MF" ) );
	Wait( 40 + RandomInt( 20 ) );
	StartThread( Metro_Rand );
end;

function A2()
	LandReinforcementFromMap( 1, "FS", 2, 402 );         
	Wait( 1 );
	ChangeFormation( 402, 3 );
	Wait( 2 );
	Cmd(ACT_SWARM, 402, 0, GetScriptAreaParams( "MF" ) );
	Wait( 40 + RandomInt( 20 ) );
	StartThread( Metro_Rand );
end;

function A3()
	LandReinforcementFromMap( 1, "FS", 3, 403 );         
	Wait( 1 );
	ChangeFormation( 403, 3 );
	Wait( 2 );
	Cmd(ACT_SWARM, 403, 0, GetScriptAreaParams( "MF" ) );
	Wait( 40 + RandomInt( 20 ) );
	StartThread( Metro_Rand );
end;

function A4()
	LandReinforcementFromMap( 1, "FS", 4, 404 );         
	Wait( 1 );
	ChangeFormation( 404, 3 );
	Wait( 2 );
	Cmd(ACT_SWARM, 404, 0, GetScriptAreaParams( "MF" ) );
	Wait( 40 + RandomInt( 20 ) );
	StartThread( Metro_Rand );
end;

----------------------------------------
function Bomb()
	while 1 do
		Wait( 3 );
		if (GetIGlobalVar("temp.objective1", 1) == 2) then
			LandReinforcementFromMap( 1, "BOMB", 0, 501 );
			Cmd(0, 501, 500, GetScriptAreaParams( "STAFF" ) );
			Wait( 2 );
			LandReinforcementFromMap( 1, "BOMB", 0, 502 );  
			Cmd(0, 502, 500, GetScriptAreaParams( "START" ) );
			break;
		end;	
	end;
end;
-------------------------------------------
function D_L()
	Wait(300);
	if (GetDifficultyLevel() == 0) then
	GiveReinforcementCalls ( 1, 8 );
	end;
	if (GetDifficultyLevel() == 1) then
	GiveReinforcementCalls ( 1, 12 );
	end;
	if (GetDifficultyLevel() == 2) then
	GiveReinforcementCalls ( 1, 25 );
	end;
end;

function D_L_2()
	Wait(1);
	if (GetDifficultyLevel() == 0) then
		RemoveScriptGroup(1001);
		RemoveScriptGroup(1002);
		RemoveScriptGroup(1003);
	end;
	if (GetDifficultyLevel() == 1) then
		RemoveScriptGroup(1002);
	end;
end;
-----------------------------
function Rem_tr()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 4321 ) < 1 ) then
			StartThread( Rem_tr2 );
			break;
		end;	
	end;
end;

function Rem_tr2()
	LandReinforcementFromMap( 0, "REM", 0, 4321 );         
	Wait( 30 );
	StartThread( Rem_tr );
end;
-----------------------------------------------------/// MAIN
StartThread( D_L_2 );
StartThread( D_L );
StartThread( Bomb );
StartThread( Winner );
StartThread( Unlucky );
StartThread( Metro_Rand );
StartThread( RevealObjective0 );
StartThread( RevealObjective3 );
StartThread( RevealObjective4 );

StartThread( Rem_tr );