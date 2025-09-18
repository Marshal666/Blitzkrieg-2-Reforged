----------------------------------------Objectives
function RevealObjective()
	Wait(1);
	GiveObjective( 0 );
	Wait(1);
	GiveObjective( 1 );
	Wait(1);
	GiveObjective( 2 );
	StartThread( CompleteObjective0 );
	StartThread( CompleteObjective1 );
	StartThread( CompleteObjective2 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 211 ) <= 0 ) then
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.objective0", 2 );
			break;
		end;	
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 212 ) <= 0 ) then
			CompleteObjective( 1 );
			SetIGlobalVar( "temp.objective1", 2 );
			break;
		end;	
	end;
end;

function CompleteObjective2()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 213 ) <= 0 ) then
			CompleteObjective( 2 );
			SetIGlobalVar( "temp.objective2", 2 );
			break;
		end;	
	end;
end;
---------------------------------------------------------WIN_LOSE
function Winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective0", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) == 2) and (GetIGlobalVar("temp.objective2", 1) == 2)) then
			Wait( 3 );
			Win(0);
			break;
		end;	
	end;
end;

function Caput()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
		Wait(3);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;
-----------------------------------------------------GerART

function G_ART()
	while 1 do
		Wait( 10 );
		if (( GetNUnitsInScriptGroup( 801 ) < 1) or ( GetNUnitsInArea ( 0, "ART" ) > 0 ))then
			Wait( 60 + RandomInt( 180 ) );
			StartThread( Avia_spy3 );
			LandReinforcementFromMap( 1, "0", 0, 4777 );
			Wait( 5 );
			StartThread( G_ART2 );   
			break;
		end;	
	end;
end;

function G_ART2()
	while 1 do
		Wait( 10 );
		if ( GetNUnitsInScriptGroup( 4777 ) < 1) then
			Wait( 60 + RandomInt( 180 ) );
			StartThread( Avia_spy3 );
			LandReinforcementFromMap( 1, "0", 1, 4778 );  
			break;
		end;	
	end;
end;
---------------------------------------------------------GER_ATTACK
function Inf_Attacks() 
	Wait( 2 );
	StartThread( Rand_At );
end;
-------------------------
function Rand_At()
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
-------------------------
function A1()
	Wait( 60 + RandomInt( 60 ) );
	LandReinforcementFromMap( 1, "1", 2, 730 ); --tanks
	Wait( 2 );
	Cmd( 3, 730, 100, 4046, 667 );
	QCmd( 3, 730, 100, 6383, 861 );
	Wait( 2 );
	StartThread( Inf_Attacks );
end;

function A2()
	Wait( 60 + RandomInt( 60 ) );
	LandReinforcementFromMap( 1, "1", 3, 731 ); --tanks
	Wait( 2 );
	Cmd( 3, 731, 100, 6383, 861 );
	QCmd( 3, 731, 100, 4046, 667 );
	Wait( 2 );
	StartThread( Inf_Attacks );
end;

function A3()
	Wait( 60 + RandomInt( 60 ) );
	LandReinforcementFromMap( 1, "2", 2, 732 ); --inf
	Wait( 3 );
	ChangeFormation( 732, 3 );
	Wait( 3 );
	Cmd( 3, 732, 100, 4046, 667 );
	QCmd( 3, 732, 100, 6383, 861 );
	Wait( 2 );
	StartThread( Inf_Attacks );
end;

function A4()
	Wait( 60 + RandomInt( 60 ) );
	LandReinforcementFromMap( 1, "2", 2, 733 ); --inf
	Wait( 2 );
	ChangeFormation( 733, 3 );
	Wait( 3 );
	Cmd( 3, 733, 100, 6383, 861 );
	QCmd( 3, 733, 100, 4046, 667 );
	Wait( 2 );
	StartThread( Inf_Attacks );
end;

-----------------------------------Avia_spy_GB_1

function Avia_1()
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective0", 1) ~= 2) and ( GetNUnitsInScriptGroup( 843 ) < 1)) then
			Wait( 2 );
			LandReinforcementFromMap( 3, "0", 0, 843 );
			Cmd( 0, 843, 0, 4733, 4983 ); 
			Wait( 80 + RandomInt( 60 ) );
			StartThread( Avia_1_1 );   
			break;
		end;	
	end;
end;

function Avia_1_1()
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective0", 1) ~= 2) and ( GetNUnitsInScriptGroup( 843 ) < 1)) then
			Wait( 2 );
			LandReinforcementFromMap( 3, "0", 0, 843 );
			Cmd( 0, 843, 0, 4733, 4983 );
			Wait( 80 + RandomInt( 60 ) );
			StartThread( Avia_1 );   
			break;
		end;	
	end;
end;
-----------------------------------Avia_spy_GB_2
function Avia_2()
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective0", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) ~= 2) and ( GetNUnitsInScriptGroup( 843 ) < 1)) then
			Wait( 2 );
			LandReinforcementFromMap( 3, "0", 0, 843 );
			Cmd( 0, 843, 0, 752, 7016 ); 
			Wait( 80 + RandomInt( 60 ) );
			StartThread( Avia_2_1 );   
			break;
		end;	
	end;
end;

function Avia_2_1()
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective0", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) ~= 2) and ( GetNUnitsInScriptGroup( 843 ) < 1)) then
			Wait( 2 );
			LandReinforcementFromMap( 3, "0", 0, 843 );
			Cmd( 0, 843, 0, 752, 7016 );
			Wait( 80 + RandomInt( 60 ) );
			StartThread( Avia_2 );   
			break;
		end;	
	end;
end;
-----------------------------------Avia_spy_GB_3
function Avia_3()
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective0", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) == 2) and ( GetNUnitsInScriptGroup( 843 ) < 1)) then
			Wait( 2 );
			LandReinforcementFromMap( 3, "0", 0, 843 );
			Cmd( 0, 843, 0, 7428, 6892 ); 
			Wait( 80 + RandomInt( 60 ) );
			StartThread( Avia_spy_3_1 );   
			break;
		end;	
	end;
end;

function Avia_3_1()
	while 1 do
		Wait( 3 );
			if ((GetIGlobalVar("temp.objective0", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) == 2) and ( GetNUnitsInScriptGroup( 843 ) < 1)) then
			Wait( 2 );
			LandReinforcementFromMap( 3, "0", 0, 843 );
			Cmd( 0, 843, 0, 7428, 6892 );
			Wait( 80 + RandomInt( 60 ) );
			StartThread( Avia_3 );   
			break;
		end;	
	end;
end;
------------------------------------Avia_spy_german
function Avia_spy3()
	Wait( 60 + RandomInt( 280 ) ); 
	LandReinforcementFromMap( 1, "3", 0, 845 );
	Wait( 2 ); 
	Cmd( 0, 845, 100, 4726, 1238 ); 
end;
---------------------------------------------------MAIN

StartThread( RevealObjective );
StartThread( Winner );
StartThread( Caput );
StartThread( G_ART );
StartThread( Inf_Attacks );

StartThread( Avia_1 );
StartThread( Avia_2 );
StartThread( Avia_3 );



