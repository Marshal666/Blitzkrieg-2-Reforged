------------------------------------------------Starts

function RevealObjective0()
	Wait(1);
	GiveObjective( 0 );
	StartThread( Objective0 );
	StartThread( Boom_1 );
	Wait(15);
	StartThread( Start_attack );
end;


function Objective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "GSM", 0) > 0) and (GetNUnitsInArea(1, "GSM", 0) < 1)) then
			Wait( 2 );
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.Objective0", 2 );
			Wait( 2 );
			StartThread( RevealObjective1 );
			StartThread( GSM_gef );
			Wait( 120 );
			StartThread( RevealObjective2 );
			break;
		end;	
	end;
end;

-------------------------------------------------

function RevealObjective1()
	Wait(1);
	GiveObjective( 1 );
	StartThread( Boom_2 );
end;

-------------------------------------------------

function RevealObjective2()
	Wait(1);
	GiveObjective( 2 );
	Wait(10);
	LandReinforcementFromMap( 1, "RUS_1", 1, 211 ); 
	LandReinforcementFromMap( 1, "RUS_2", 1, 212 );
	Wait(1);
	DamageScriptObject ( 212, 150 )
	StartThread( Objective2 );
	StartThread( Rus_final );
	StartThread( Rus_go_1 );
	Wait(3);
	StartThread( Rus_go_2 );
end;

function Objective2() 
	while 1 do
		Wait( 3 );
			if ( GetNUnitsInScriptGroup( 212 ) < 1 ) then
			Wait( 2 );
			CompleteObjective( 2 );
			Wait( 2 );
			CompleteObjective( 1 );
			Wait( 1 );
			Win( 0 );
			break;
		end;
	end;
end;

---------------------------------------------

function Rus_go_1()
	Cmd( 3, 211, 0, GetScriptAreaParams( "Z1" ) );
	QCmd( 3, 211, 0, GetScriptAreaParams( "Z3" ) );
	QCmd( 3, 211, 0, GetScriptAreaParams( "Z4" ) );
	QCmd( 3, 211, 0, GetScriptAreaParams( "Z6" ) );
end;

function Rus_go_2()
	Cmd( 0, 212, 0, GetScriptAreaParams( "Z1" ) );
	QCmd( 0, 212, 0, GetScriptAreaParams( "Z2" ) );
	QCmd( 0, 212, 0, GetScriptAreaParams( "Z3" ) );
	QCmd( 0, 212, 0, GetScriptAreaParams( "Z4" ) );
	QCmd( 0, 212, 0, GetScriptAreaParams( "Z5" ) );
	QCmd( 0, 212, 0, GetScriptAreaParams( "Z6" ) );

end;

function Rus_final() 
	while 1 do
		Wait( 3 );
			if (GetNScriptUnitsInArea(212, "Exit") > 0) then
			Wait( 1 );
			StartThread( T_Exit );
			break;
		end;
	end;
end;

function T_Exit()
	RemoveScriptGroup( 212 );
	FailObjective( 2 );
	Wait( 2 );
	Win( 1 );
end;


----------------------------------------------

function Boom_1() 
	while 1 do
		Wait( 3 );
			if (( GetNUnitsInScriptGroup ( 111 ) < 200 ) and (GetIGlobalVar("temp.Objective0", 1) ~= 2)) then
			Wait( 2 );
			FailObjective( 0 );
			Wait( 2 );
			Win( 1 );
			break;
		end;
	end;
end;

function Boom_2() 
	while 1 do
		Wait( 3 );
			if ( GetNUnitsInScriptGroup ( 111 ) < 200 ) then
			Wait( 2 );
			FailObjective( 1 );
			Wait( 2 );
			Win( 1 );
			break;
		end;
	end;
end;
----------------------------------------
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


function GSM_gef()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "GSM", 0) < 1) and (GetNUnitsInArea(1, "GSM", 0) > 0)) then
			Wait( 1 );
			FailObjective( 1 );
			Wait( 1 );
			Win(1);
			break;
		end;	
	end;
end;
--------------------------------

function Attack_fuel() 
	while 1 do
		Wait( 3 );
			if (GetIGlobalVar("temp.Objective0", 1) == 2) then
			Wait( 2 );
			LandReinforcementFromMap( 1, "R_SPG", 2, 310 );
			Wait( 3 );
			Cmd( 3, 310, 100, GetScriptAreaParams( "RU1" ) );
			QCmd( 3, 310, 100, GetScriptAreaParams( "RU2" ) );
			QCmd( 3, 310, 100, GetScriptAreaParams( "RU3" ) );
			QCmd( 3, 310, 100, GetScriptAreaParams( "RU4" ) );
			break;
		end;
	end;
end;

function Start_attack()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "Start_lok", 0) > 3 ) then
			Wait( 2 );
			Cmd( 3, 16, 0, 1035, 1481 );
		else
			Cmd( 3, 15, 0, 1035, 1481 );
			break;
		end;	
	end;
end;

-----------------------------------AT

function Armortr_1() 
	while 1 do
		Wait( 3 );
			if ((GetNScriptUnitsInArea(400, "AT1") > 0) and ( GetNUnitsInScriptGroup ( 400 ) > 2 )) then
			Wait( 10 );
			Cmd( 0, 400, 0, GetScriptAreaParams( "AT2" ) );
			StartThread( Armortr_2 );
			break;
		end;
	end;
end;

function Armortr_2() 
	while 1 do
		Wait( 3 );
			if ((GetNScriptUnitsInArea(400, "AT2") > 0) and ( GetNUnitsInScriptGroup ( 400 ) > 2 )) then
			Wait( 10 );
			Cmd( 0, 400, 0, GetScriptAreaParams( "AT1" ) );
			StartThread( Armortr_1 );
			break;
		end;
	end;
end;

----------------------------------

function Rus_avia() 
	while 1 do
		Wait( 3 );
			if (GetNUnitsInArea(0, "Aviation",0) > 0) then
			Wait( 1 );
			LandReinforcementFromMap( 1, "AVIA", 0, 433 );
			Cmd( 3, 433, 0, GetScriptAreaParams( "RU3" ) );
			break;
		end;
	end;
end;
---------------------------------------------DF
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
--------------------------------------------MAIN--

StartThread( RevealObjective0 );
StartThread( Defead );
StartThread( Attack_fuel );
StartThread( Armortr_1 );
StartThread( Rus_avia );
StartThread( D_L );