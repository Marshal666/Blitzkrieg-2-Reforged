function RevealObjective0()
	GiveObjective( 0 );
	StartThread( Objective0 );
	GiveObjective( 1 );
	StartThread( Objective1 );
end;

function Objective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "STAFF", 0) < 1) and (GetNUnitsInArea(0, "STAFF", 0) > 0)) then
			CompleteObjective( 0 );
			CompleteObjective( 1 );
			Wait( 3 );   -------------------WIN!
			Win( 0 );
			break;
		end;	
	end;
end;

function Objective1()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "ALLS", 0) > 0) and ((GetNUnitsInArea(0, "ALLS", 0) < 1) or (GetNUnitsInArea(2, "ALLS", 0)) < 1) then
			FailObjective( 1 );
			Wait( 3 );
			Win( 1 );
			break;
		end;	
	end;
end;
----------------------------------------------1
function Attack_1() 
	while 1 do
		Wait( 5 );
			if ((GetIGlobalVar("temp.german", 1) ~= 2) and (GetIGlobalVar("temp.zona1", 1) ~= 2)) then
			Wait( 3 );
			StartThread( Rand_1 );
			break;
		end;
	end;
end;

function Rand_1()
local x = RandomInt(2);
	if x == 0 then
	StartThread( A1 );
	end;
	if x == 1 then
	StartThread( A2 );
	end;
end;

function A1()
	LandReinforcementFromMap( 1, "2_TANKS", 0, 901 );   
	Wait( 1 );
	ChangeFormation( 901, 3 );
	Wait( 2 );
	Cmd(ACT_SWARM, 901, 0, GetScriptAreaParams( "x1" ) );
	QCmd(ACT_SWARM, 901, 0, GetScriptAreaParams( "x2" ) );
	QCmd(ACT_SWARM, 901, 0, GetScriptAreaParams( "x3" ) );
	Wait( 180 + RandomInt( 30 ) );
	StartThread( Attack_1 );
end;

function A2()
	LandReinforcementFromMap( 1, "1_TANKS", 0, 902 );         
	Wait( 1 );
	Cmd(ACT_SWARM, 902, 0, GetScriptAreaParams( "x1" ) );
	QCmd(ACT_SWARM, 902, 0, GetScriptAreaParams( "x2" ) );
	QCmd(ACT_SWARM, 902, 0, GetScriptAreaParams( "x3" ) );
	Wait( 180 + RandomInt( 30 ) );
	StartThread( Attack_1 );
end;

---------------------------------------------2
function Attack_2() 
	while 1 do
		Wait( 5 );
			if ((GetIGlobalVar("temp.german", 1) ~= 2) and (GetIGlobalVar("temp.zona2", 1) ~= 2)) then
			Wait( 3 );
			StartThread( Rand_2 );
			break;
		end;
	end;
end;

function Rand_2()
local x = RandomInt(2);
	if x == 0 then
	StartThread( B1 );
	end;
	if x == 1 then
	StartThread( B2 );
	end;
end;

function B1()
	LandReinforcementFromMap( 1, "2_TANKS", 1, 801 );         
	Wait( 1 );
	ChangeFormation( 901, 3 );
	Wait( 2 );
	Cmd(ACT_SWARM, 801, 0, GetScriptAreaParams( "y1" ) );
	QCmd(ACT_SWARM, 801, 0, GetScriptAreaParams( "y2" ) );
	QCmd(ACT_SWARM, 801, 0, GetScriptAreaParams( "y3" ) );
	Wait( 40 + RandomInt( 10 ) );
	StartThread( Attack_2 );
end;

function B2()
	LandReinforcementFromMap( 1, "1_TANKS", 1, 802 );         
	Wait( 1 );
	Cmd(ACT_SWARM, 802, 0, GetScriptAreaParams( "y1" ) );
	QCmd(ACT_SWARM, 802, 0, GetScriptAreaParams( "y2" ) );
	QCmd(ACT_SWARM, 802, 0, GetScriptAreaParams( "y3" ) );
	Wait( 40 + RandomInt( 10 ) );
	StartThread( Attack_2 );
end;

----------------------------------------------------
function ALL_1()
	while 1 do
		Wait( 5 );
		if ( GetNUnitsInScriptGroup( 441 ) < 1 ) then
			Wait( 35 );
			StartThread( ALL_1_1 );
			break;
		end;	
	end;
end;

function ALL_1_1()
	LandReinforcementFromMap( 2, "ALL", 0, 441 ); 
	Cmd( 3, 441, 0, GetScriptAreaParams( "11" ) );
	QCmd( 8, 441, 0, GetScriptAreaParams( "33" ) );
	StartThread( ALL_1 );
end;
-------------------------

function ALL_2()
	while 1 do
		Wait( 5 );
		if ( GetNUnitsInScriptGroup( 442 ) < 1 ) then
			Wait( 45 );
			StartThread( ALL_2_2 );
			break;
		end;	
	end;
end;

function ALL_2_2()
	LandReinforcementFromMap( 2, "ALL", 0, 442 ); 
	Cmd( 3, 442, 0, GetScriptAreaParams( "22" ) );
	QCmd( 8, 442, 0, GetScriptAreaParams( "33" ) );
	StartThread( ALL_2 );
end;
---------------------------------------------

function Unlucky()
    while 1 do
        if (( IsSomePlayerUnit(0) < 1) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) or ( IsReinforcementAvailable( 0 ) == 0 )) ) then
			FailObjective( 0 );
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;
------------------------------------
function Zona1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "Z1", 0) < 1) and (GetNUnitsInArea(0, "Z1", 0) > 0)) then
			SetIGlobalVar( "temp.zona1", 2 );
			break;
		end;	
	end;
end;

function Zona2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "Z2", 0) < 1) and (GetNUnitsInArea(0, "Z2", 0) > 0)) then
			SetIGlobalVar( "temp.zona2", 2 );
			break;
		end;	
	end;
end;

function Bonus()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.zona1", 1) == 2) and (GetIGlobalVar("temp.zona2", 1) == 2))then
			Wait( 1 );
			GiveObjective( 2 );
			CompleteObjective( 2 );
			Cmd( 0, 481, 0, 3567, 329 );
			Cmd( 0, 484, 0, 4601, 325 );
			Cmd( 0, 483, 0, 3567, 329 );
			Cmd( 0, 486, 0, 4601, 325 );
			StartThread( E1 );
			StartThread( E2 );
			StartThread( E3 );
			StartThread( E4 );
			break;
		end;	
	end;
end;

function E1()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(481, "E1") > 0) then
			RemoveScriptGroup (481);
			break;
		end;	
	end;
end;

function E2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(484, "E2") > 0) then
			RemoveScriptGroup (484);
			break;
		end;	
	end;
end;

function E3()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(483, "E1") > 0) then
			RemoveScriptGroup (483);
			break;
		end;	
	end;
end;

function E4()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(486, "E2") > 0) then
			RemoveScriptGroup (486);
			break;
		end;	
	end;
end;
------------------------------------DL
function D_L()
	Wait(200);
	if (GetDifficultyLevel() == 1) then
	GiveReinforcementCalls ( 1, 2 );
	end;
	if (GetDifficultyLevel() == 2) then
	GiveReinforcementCalls ( 1, 5 );
	end;
end;

function D_L_2()
	Wait(1);
	if (GetDifficultyLevel() == 0) then
		RemoveScriptGroup(1001);
		RemoveScriptGroup(1002);
	end;
	if (GetDifficultyLevel() == 1) then
		RemoveScriptGroup(1002);
	end;
end;
-----------------------------------
function Time_out()
Wait( 600 );
SetIGlobalVar( "temp.german", 2 );
Trace ("Timeout")
end;

------------------------------------
StartThread( RevealObjective0 );
StartThread( Unlucky );
StartThread( Attack_1 );
StartThread( Attack_2 );
StartThread( ALL_1 );
StartThread( ALL_2 );

StartThread( Zona1 );
StartThread( Zona2 );
StartThread( Bonus );

StartThread( D_L );
StartThread( D_L_2 );

StartThread( Time_out );