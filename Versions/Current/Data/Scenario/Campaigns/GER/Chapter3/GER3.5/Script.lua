--------------------------------------------------------------
function RevealObjective0()
	GiveObjective( 0 );
end;
-------------------------------------------------------------

function AMMO()
    while 1 do
        if ( GetNUnitsInParty(0) > 0) then
		SetAmmo( GetObjectList( 500 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 501 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 502 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 503 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 504 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 505 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 506 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 507 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 508 ), 0, 0, 0 );
		SetAmmo( GetObjectList( 509 ), 0, 0, 0 );
		Wait(1);
		end;
	end;
end;

-------------------------------------------------------------
function START_RUS()
Wait( 80 );
	StartThread( Rus_Attack );
	StartThread( Rus_Attack_Land );
	StartThread( Rus_Attack_Land_2 );
end;
---------------------------------------------------------------
function Winners_1()
	Wait(800);
	SetIGlobalVar( "temp.All", 2 );
	StartThread( Winners_2 );
end;

function Winners_2()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.All", 1) == 2) and (GetNUnitsInArea(1, "station",0) < 1)) then
			CompleteObjective( 0 );
			Wait( 1 );
			Win(0);
			break;
		end;	
	end;
end;

-------------------------------------------------------DEF

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


function Defead_2()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(2, "TIGERS",0) < 8) then
			FailObjective( 0 );
			Wait( 1 );
			Win(1);
			break;
		end;	
	end;
end;

-------------------------------------------------------AIR_1

function Rus_Attack() 
	while 1 do
		Wait( 2 );
			if (GetIGlobalVar("temp.All", 1) ~= 2) then
				Wait( 1 );
				StartThread( Rand );
			break;
		end;
	end;
end;

--------------------------

function Rand()
local x = RandomInt(3);
	if x == 0 then
	StartThread( Air1 );
	end;
	if x == 1 then
	StartThread( Air2 );
	end;
	if x == 2 then
	StartThread( Air3 );
	end;
end;

--------------------------

function Air1()
	LandReinforcementFromMap( 1, "AG", 0, 301 ); 
	Cmd( 3, 301, 500, 4234, 4215 );
	Wait( 140 + RandomInt( 25 ) );
	StartThread( Rus_Attack );
end;

function Air2()
	LandReinforcementFromMap( 1, "AG", 1, 302 ); 
	Cmd( 3, 302, 500, 4234, 4215 );
	Wait( 140 + RandomInt( 25 ) );
	StartThread( Rus_Attack );
end;

function Air3()
	LandReinforcementFromMap( 1, "AG", 2, 303 ); 
	Cmd( 3, 303, 500, 4234, 4215 );
	Wait( 140 + RandomInt( 25 ) );
	StartThread( Rus_Attack );
end;

-----------------------------------------------------TANKS

function Rus_Attack_Land() 
	while 1 do
		Wait( 2 );
			if (GetIGlobalVar("temp.All", 1) ~= 2) then
				Wait( 1 );
				StartThread( Rand_2 );
			break;
		end;
	end;
end;

--------------------------

function Rand_2()
local x = RandomInt(4);
	if x == 0 then
	StartThread( L1 );
	end;
	if x == 1 then
	StartThread( L2 );
	end;
	if x == 2 then
	StartThread( L3 );
	end;
	if x == 3 then
	StartThread( L4 );
	end;
end;

--------------------------

function L1()
	LandReinforcementFromMap( 1, "TANKS", 6, 311 ); 
	Cmd( 3, 311, 0, 4234, 4215 );
	Wait( 90 + RandomInt( 10 ) );
	StartThread( Rus_Attack_Land );
end;

function L2()
	LandReinforcementFromMap( 1, "TANKS", 2, 312 ); 
	Cmd( 3, 312, 0, 4234, 4215 );
	Wait( 90 + RandomInt( 10 ) );
	StartThread( Rus_Attack_Land );
end;

function L3()
	LandReinforcementFromMap( 1, "TANKS", 3, 313 ); 
	Cmd( 3, 313, 0, 4234, 4215 );
	Wait( 90 + RandomInt( 10 ) );
	StartThread( Rus_Attack_Land );
end;

function L4()
	LandReinforcementFromMap( 1, "TANKS", 5, 314 ); 
	Cmd( 3, 314, 0, 4234, 4215 );
	Wait( 90 + RandomInt( 10 ) );
	StartThread( Rus_Attack_Land );
end;
----------------------------------------------------Rus3

function Rus_Attack_Land_2() 
	while 1 do
		Wait( 2 );
			if (GetIGlobalVar("temp.All", 1) ~= 2) then
				Wait( 1 );
				StartThread( Rand_3 );
			break;
		end;
	end;
end;

--------------------------

function Rand_3()
local x = RandomInt(2);
	if x == 0 then
	StartThread( I1 );
	end;
	if x == 1 then
	StartThread( I2 );
	end;
end;

--------------------------

function I1()
	LandReinforcementFromMap( 1, "RINF", 6, 411 );
	ChangeFormation( 411, 3 );
	Wait( 3 );
	Cmd( 3, 411, 0, 4234, 4215 );
	Wait( 160 + RandomInt( 20 ) );
	StartThread( Rus_Attack_Land_2 );
end;

function I2()
	LandReinforcementFromMap( 1, "RINF", 3, 412 );
	ChangeFormation( 412, 3 );
	Wait( 3 );
	Cmd( 3, 412, 0, 4234, 4215 );
	Wait( 160 + RandomInt( 20 ) );
	StartThread( Rus_Attack_Land_2 );
end;

-----------------------------------------------------

function D_L()
	while 1 do
		Wait( 3 );
		if (GetDifficultyLevel() == 1)  then
			Wait( 130 + RandomInt( 180 ) );
			LandReinforcementFromMap( 1, "FT", 1, 367 ); 
			Wait( 1 );
			Cmd( 0, 367, 0, 4234, 4215 );  
			break;
		end;	
	end;
end;

function D_L_2()
	while 1 do
		Wait( 3 );
		if ((GetDifficultyLevel() == 2)) then
			Wait( 300 + RandomInt( 30 ) );
			LandReinforcementFromMap( 1, "ART", 1, 399 ); 
			Wait( 2 );
			Cmd( ACT_SUPPRESS, 399, 100, 4434, 4252 );  
			break;
		end;	
	end;
end;

function Bon()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "BONUS",0) > 0) then
			Wait( 1 );
			GiveObjective( 2 );
			CompleteObjective( 2 );
			break;
		end;	
	end;
end;
-----------------------------------------------Main


StartThread( RevealObjective0 );

StartThread( START_RUS );
StartThread( AMMO );

StartThread( Winners_1 );
StartThread( Winners_2 );

StartThread( Defead );
StartThread( Defead_2 );

StartThread( D_L );
StartThread( D_L_2 );
StartThread( Bon );