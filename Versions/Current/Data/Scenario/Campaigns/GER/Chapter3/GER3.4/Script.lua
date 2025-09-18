------------------------------------Start
function RevealObjective0()
	Wait(1);
	GiveObjective( 0 );
end;
------------------------------------Winners
function Defead()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
		Wait(3);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;

function Defead_2()
    while 1 do
        if ((GetNUnitsInArea(0, "Village", 0) < 1) and (GetNUnitsInArea(1, "Village", 0) > 0)) then
		Wait(2);
		Win(1);
		return 1;
		end;
	Wait(3);
	end;
end;
----------------------------------------------Repair
function T1()
	while 1 do
		Wait( 3 );
		if (GetScriptObjectHPs(401) >= 80) then
			ChangePlayerForScriptGroup( 401, 0 );  
			break;
		end;	
	end;
end;

function T2()
	while 1 do
		Wait( 3 );
		if (GetScriptObjectHPs(402) >= 80) then
			ChangePlayerForScriptGroup( 402, 0 );
			ChangePlayerForScriptGroup( 502, 1 );  
			break;
		end;	
	end;
end;

function T3()
	while 1 do
		Wait( 3 );
		if (GetScriptObjectHPs(403) >= 35) then
			ChangePlayerForScriptGroup( 403, 0 );  
			break;
		end;	
	end;
end;

function T4()
	while 1 do
		Wait( 3 );
		if (GetScriptObjectHPs(404) >= 50) then
			ChangePlayerForScriptGroup( 404, 0 );  
			break;
		end;	
	end;
end;
----------------------------------Rus_Attacks
function Rus_Attack() 
	while 1 do
		Wait( 2 );
			if (GetIGlobalVar("temp.All", 1) ~= 2) then
			Wait( 1 );
			StartThread( Rands );
			break;
		end;
	end;
end;

function Rands()
local x = RandomInt(3);
	if x == 0 then
	StartThread( Ainf );
	end;
	if x == 1 then
	StartThread( Atanks );
	end;
	if x == 2 then
	StartThread( Ainf_dva );
	end;
end;

function Ainf()
	LandReinforcementFromMap( 1, "R_INF", 0, 201 ); 
	Wait( 2 );
	ChangeFormation( 201, 3 );
	Wait( 4 );
	Cmd( 3, 201, 300, 6122, 877 );
	Wait( 50 + RandomInt( 30 ) );
	StartThread( Rus_Attack );
end;

function Atanks()
	LandReinforcementFromMap( 1, "R_TANKS", 0, 202 ); 
	Wait( 2 );
	Cmd( 3, 202, 300, 6122, 877 );
	Wait( 50 + RandomInt( 30 ) );
	StartThread( Rus_Attack );
end;

function Ainf_dva()
	LandReinforcementFromMap( 1, "R_INF", 1, 203 ); 
	Wait( 2 );
	ChangeFormation( 203, 3 );
	Wait( 3 );
	Cmd( 3, 203, 100, 1154, 1808 );
	QCmd( 3, 203, 100, 5904, 596 );
	Wait( 50 + RandomInt( 30 ) );
	StartThread( Rus_Attack );
end;
-----------------------------------Rus_Spy
function Avia_spy()
	Wait( 60 + RandomInt( 160 ) );
	LandReinforcementFromMap( 1, "RUSSPY", 2, 208 ); 
	Wait( 1 );
	Cmd( 0, 208, 500, 3225, 2501 );
end;

function Avia_spy_dva()
	Wait( 220 + RandomInt( 180 ) );
	LandReinforcementFromMap( 1, "RUSSPY", 2, 218 ); 
	Wait( 1 );
	Cmd( 0, 218, 200, 5118, 2007 );
end;
-----------------------------------Rus_Art
function R_ART()
	Wait( 120 + RandomInt( 300 ) );
	LandReinforcementFromMap( 1, "RUSART", 2, 212 );
end;
-----------------------------------GER_Attack
function G_Boom_1()
	Wait( 940 );
	LandReinforcementFromMap( 2, "G_BOMBS", 0, 982 ); 
	Wait(1);
	Cmd( 3, 982, 100, 6065, 6327 ); 
end;

function G_Boom_2()
	Wait( 945 );
	LandReinforcementFromMap( 2, "G_BOMBS", 0, 983 ); 
	Wait(1);
	Cmd( 3, 983, 100, 6065, 6327 ); 
end;

function G_Boom_3()
	Wait( 950 );
	LandReinforcementFromMap( 2, "G_GAP", 0, 984 ); 
	Wait(1);
	Cmd( 3, 984, 0, 6065, 6327 ); 
	SetIGlobalVar( "temp.All", 2 );
end;

-----------------------------Winner

function Winner()
	Wait(1020);
	CompleteObjective( 0 );
	Wait(1);
	Win(0);
end;
---------------------------------------------
function D_L()
	Wait(2);
	if (GetDifficultyLevel() == 1) then
	GiveReinforcementCalls ( 1, 2 );
	end;
	if (GetDifficultyLevel() == 2) then
	GiveReinforcementCalls ( 1, 2 );
	StartThread( HARDLEVEL );
	end;
end;

function HARDLEVEL()
	Wait( 500 + RandomInt( 100 ) );
	LandReinforcementFromMap( 1, "RUS_BA20", 0, 843 );
	Wait(1);
	Cmd( 3, 843, 0, 6122, 877 );
end;
----------------------------------------------MAIN

StartThread( RevealObjective0 );
StartThread( Defead );
StartThread( Defead_2 );

StartThread( T1 );
StartThread( T2 );
StartThread( T3 );
StartThread( T4 );

StartThread( Rus_Attack );
StartThread( Winner );

StartThread( Avia_spy );
StartThread( Avia_spy_dva );

StartThread( R_ART );
StartThread( G_Boom_1 );
StartThread( G_Boom_2 );
StartThread( G_Boom_3 );

StartThread( D_L );







