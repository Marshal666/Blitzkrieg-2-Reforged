function RevealObjective0()
	Wait(1);
	GiveObjective( 0 );
	StartThread( Objective0 );
end;


function Objective0() 
	while 1 do
		Wait( 2 );
			if (GetNUnitsInArea(1, "ART_2",0) < 1) then
			Wait( 1 );
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.Objective0", 2 );
			StartThread( RevealObjective1 );
			break;
		end;
	end;
end;

------------------------------------

function RevealObjective1()
	Wait(1);
	GiveObjective( 1 );
	StartThread( Objective1 );
end;

function Objective1() 
	while 1 do
		Wait( 2 );
			if ((GetNUnitsInArea(1, "BASE",0) < 1) and (GetNUnitsInArea(0, "BASE",0) > 0 )) then
			Wait( 1 );
			CompleteObjective( 1 );
			SetIGlobalVar( "temp.Objective1", 2 );
			StartThread( RevealObjective2 );
			Wait( 2 );
			LandReinforcementFromMap( 0, "Start_t", 0, 1985 );  ---------scriptreinfplayer
			StartThread( Defead );
			DamageScriptObject ( 500, 1000 )    ----------////test!!!!
			Cmd (3, 2119, 0, 5398, 6644 );
			Cmd (3, 2120, 0, 5054, 6649 );
			break;
		end;
	end;
end;

-----------------------------------

function RevealObjective2()
	Wait(1);
	GiveObjective( 2 );
	StartThread( Objective2 );
end;

function Objective2() 
	while 1 do
		Wait( 2 );
			if (GetNUnitsInArea(1, "RUS_LOCATION",0) < 1) then
			Wait( 1 );
			CompleteObjective( 2 );
			SetIGlobalVar( "temp.Objective2", 2 );
			Wait( 1 );
			StartThread( RevealObjective3 );
			break;
		end;
	end;
end;
---------------------------------------------------------------------//////
function RevealObjective3()
	Wait(1);
	GiveObjective( 3 );
	StartThread( Objective3 );
	Wait(60);
	StartThread( All_ATTACK_1 );
	Wait(60);
	StartThread( All_ATTACK_3 );
end;

function Objective3() 
	while 1 do
		Wait( 2 );
			if (GetNUnitsInArea(1, "DEFENCE",0) < 1) then
			Wait( 1 );
			CompleteObjective( 3 );
			SetIGlobalVar( "temp.Objective3", 2 );
			Wait( 1 );
			Win( 0 );
			break;
		end;
	end;
end;
------------------------------Defeats

function Sniper_dead() 
	while 1 do
		Wait( 2 );
			if ( GetNUnitsInScriptGroup( 111, 0 ) < 1 ) and ((GetIGlobalVar("temp.Objective0", 1) ~= 2) or (GetIGlobalVar("temp.Objective1", 1) ~= 2)) then
			Wait( 1 );
			Win( 1 );
			break;
		end;
	end;
end;

function Defead()
    while 1 do
        if (( IsSomePlayerUnit(0) < 1) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) or ( IsReinforcementAvailable( 0 ) == 0 )) ) then
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;

---------------------------------------------

function All_art() 
	while 1 do
		Wait( 2 );
			if (GetNScriptUnitsInArea(111, "ART") > 0) then
			Wait( 1 );
			Cmd (32, 211, 0, 6642, 700 );
			Cmd (32, 212, 0, 6830, 731 );
			Cmd (32, 213, 0, 7068, 743 );
			Wait( 5 );
			Cmd ( ACT_ROTATE, 211, 0, 6400, 7100 );
			Cmd ( ACT_ROTATE, 212, 0, 6400, 7100 );
			Cmd ( ACT_ROTATE, 213, 0, 6400, 7100 );
			break;
		end;
	end;
end;

-----------------------------------------------

function Oficers() 
	while 1 do
		Wait( 2 );
			if (GetNScriptUnitsInArea(500, "ART_2") < 1) then
			Wait( 1 );
			Cmd (4, 47, 55 );
			Cmd (4, 46, 55 );
			StartThread( Oficers_2 );
			break;
		end;
	end;
end;

function Oficers_2() 
	Wait( 4 );
	Cmd( 0, 55, 800, GetScriptAreaParams( "RUS_LOCATION" ) );
end;

function Oficers_3() 
	while 1 do
		Wait( 2 );
			if ( GetNUnitsInScriptGroup( 88 ) < 1 ) then
			Wait( 1 );
			Cmd( 3, 89, 100, GetScriptAreaParams( "P2" ) );
			break;
		end;
	end;
end;

-----------------------------------------------

function Patrol() 
	while 1 do
		Wait( 2 );
			if ( GetNUnitsInScriptGroup( 93 ) > 0 ) then
			Wait( 2 );
			StartThread( P_go );
			break;
		end;
	end;
end;

function P_go () 
	Cmd( 3, 93, 100, GetScriptAreaParams( "P1" ) );
	QCmd( 3, 93, 100, GetScriptAreaParams( "P2" ) );
	QCmd( 3, 93, 100, GetScriptAreaParams( "P3" ) );
	Wait( 50 );
	StartThread( Patrol );
end;

-----------------------------------------------

function All_SUP_1() 
	while 1 do
		Wait( 2 );
			if (GetIGlobalVar("temp.Objective1", 1) == 2) then
			Wait( 3 );
			Cmd( ACT_SUPPRESS, 211, 100, 2325, 2779 );
			Cmd( ACT_SUPPRESS, 212, 100, 2325, 2779 );
			Cmd( ACT_SUPPRESS, 213, 100, 2325, 2779 );
			Wait( 50 );
			StartThread( All_SUP_2 );
			break;
		end;
	end;
end;

function All_SUP_2() 
	Cmd( ACT_SUPPRESS, 211, 100, 4160, 2576 );
	Cmd( ACT_SUPPRESS, 212, 100, 4160, 2576 );
	Cmd( ACT_SUPPRESS, 213, 100, 4160, 2576 );
	Wait( 50 );
	StartThread( All_STOP );
end;

function All_STOP() 
	Cmd( ACT_ROTATE, 211, 100, 2738, 6602 );
	Cmd( ACT_ROTATE, 212, 100, 2738, 6602 );
	Cmd( ACT_ROTATE, 213, 100, 2738, 6602 );
end;

------------------------------------------------

function All_ATTACK_1() 
	LandReinforcementFromMap( 2, "INF1", 0, 801 );
	LandReinforcementFromMap( 2, "INF1", 1, 802 );
	LandReinforcementFromMap( 2, "INF1", 2, 803 );
	ChangeFormation( 801, 3 );
	ChangeFormation( 802, 3 );
	ChangeFormation( 803, 3 );
	Wait( 5 );
	Cmd( 3, 801, 0, GetScriptAreaParams( "A1" ) );
	Cmd( 3, 802, 0, GetScriptAreaParams( "A2" ) );
	Cmd( 3, 803, 0, GetScriptAreaParams( "A3" ) );
	QCmd( 3, 801, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 802, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 803, 0, GetScriptAreaParams( "A4" ) );
	StartThread( All_ATTACK_2 );
end;

function All_ATTACK_2() 
	Wait( 10 );
	LandReinforcementFromMap( 2, "T1", 0, 804 );
	LandReinforcementFromMap( 2, "T1", 1, 805 );
	LandReinforcementFromMap( 2, "T1", 2, 806 );
	Wait( 5 );
	LandReinforcementFromMap( 1, "RUS_IL", 0, 9061 );
	Cmd( 3, 9061, 0, GetScriptAreaParams( "A2" ) );
	Cmd( 3, 804, 0, GetScriptAreaParams( "A1" ) );
	Cmd( 3, 805, 0, GetScriptAreaParams( "A2" ) );
	Cmd( 3, 806, 0, GetScriptAreaParams( "A3" ) );
	QCmd( 3, 804, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 805, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 806, 0, GetScriptAreaParams( "A4" ) );
	Wait( 10 );
end;

----------------------------------------

function Air_Attack() 
	while 1 do
		Wait( 2 );
			if (GetNUnitsInArea(0, "RUS_LOCATION",0) > 1) then
			Wait( 1 );
			LandReinforcementFromMap( 1, "RUS_IL", 0, 9062 );
			Cmd( 3, 9061, 0, GetScriptAreaParams( "RUS_LOCATION" ) );
			break;
		end;
	end;
end;
--------------------------------------------
function D_L()
	Wait(2);
	if (GetDifficultyLevel() == 0) then
		RemoveScriptGroup(1001);
		RemoveScriptGroup(1002);
	end;
	if (GetDifficultyLevel() == 1) then
		RemoveScriptGroup(1002);
	end;
end;
-------------------------------------------

function All_ATTACK_3() 
	LandReinforcementFromMap( 2, "INF1", 0, 901 );
	LandReinforcementFromMap( 2, "INF1", 1, 902 );
	LandReinforcementFromMap( 2, "INF1", 2, 903 );
	ChangeFormation( 901, 3 );
	ChangeFormation( 902, 3 );
	ChangeFormation( 903, 3 );
	Wait( 5 );
	Cmd( 3, 901, 0, GetScriptAreaParams( "A1" ) );
	Cmd( 3, 902, 0, GetScriptAreaParams( "A2" ) );
	Cmd( 3, 903, 0, GetScriptAreaParams( "A3" ) );
	QCmd( 3, 901, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 902, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 903, 0, GetScriptAreaParams( "A4" ) );
	StartThread( All_ATTACK_4 );
end;

function All_ATTACK_4() 
	Wait( 10 );
	LandReinforcementFromMap( 2, "T1", 0, 904 );
	LandReinforcementFromMap( 2, "T1", 1, 905 );
	LandReinforcementFromMap( 2, "T1", 2, 906 );
	Wait( 5 );
	Cmd( 3, 904, 0, GetScriptAreaParams( "A1" ) );
	Cmd( 3, 905, 0, GetScriptAreaParams( "A2" ) );
	Cmd( 3, 906, 0, GetScriptAreaParams( "A3" ) );
	QCmd( 3, 904, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 905, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 906, 0, GetScriptAreaParams( "A4" ) );
end;
--------------------------------
function JP()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "JEEP",0) > 0) then
			ChangePlayerForScriptGroup( 6512, 0 );
			break;
		end;	
	end;
end;
----------------------------
function Zasran() 
	while 1 do
		Wait( 2 );
			if ( GetNUnitsInScriptGroup( 88 ) < 1 ) then
			Wait( 1 );
			Cmd( 5, 28, 0, 6584, 4426 );
			break;
		end;
	end;
end;

-------------------------------------------Main

StartThread( All_art );
StartThread( RevealObjective0 );
StartThread( Sniper_dead );
StartThread( All_SUP_1 );
StartThread( Oficers );
StartThread( Oficers_3 );
StartThread( Patrol );
StartThread( Air_Attack );
StartThread( D_L );
StartThread( JP );
StartThread( Zasran );