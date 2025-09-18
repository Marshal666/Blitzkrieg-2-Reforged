-------- Start Scripts Small Mission 7
----------------------------------------------------------- Start
function RevealObjective0()
	 Wait(3);
	ObjectiveChanged(0, 1);
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

function Caput_2()
    while 1 do
        if (GetNUnitsInArea(2, "SITY", 0) > 2) then
		Wait(3);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;

function Winner() 
	while 1 do
		Wait( 2 );
			if ((GetNUnitsInArea(1, "SITY", 0) < 1) or (GetIGlobalVar("temp.All", 1) == 2)) then
			Wait( 1 );
			Win(0);
			break;
		end;
	end;
end;
------------------------------------------------------------------ Allies
function Allies_Attack()
	Wait( 1000 );
	StartThread( Allies_Attack2 );
end;

function Allies_Attack2()
	LandReinforcementFromMap( 3, 0, 0, 4001 ); 
	Wait( 2 );
	Cmd( 3, 4001, 50, 3788, 4010 );
	QCmd( 3, 4001, 50, 5171, 5972 );
	LandReinforcementFromMap( 3, 1, 0, 4002 ); 
	Wait( 2 );
	Cmd( 3, 4002, 50, 4773, 5077 );
	LandReinforcementFromMap( 3, 0, 0, 4003 ); 
	Wait( 6 );
	Cmd( 3, 4003, 50, 4238, 5833 );
	QCmd( 3, 4001, 50, 6223, 4043 );
	Wait( 10 );
	ObjectiveChanged(0, 2);
	Wait( 20 );
	SetIGlobalVar( "temp.All", 2 );
	StartThread( Allies2 );
end;

function Allies2() 
	while 1 do
		Wait( 2 );
			if ( GetNUnitsInScriptGroup( 4003 ) < 2 ) then
				Wait( 1 );
				StartThread( Allies_Attack2 );
			break;
		end;
	end;
end;
---------------------------------------------------------------------  T_Attacks
function Attack_Tanks() 
	while 1 do
		Wait( 2 );
			if (GetIGlobalVar("temp.All", 1) ~= 2) then
			Wait( 1 );
			StartThread( Rand_Tanks );
			break;
		end;
	end;
end;

function Rand_Tanks()
local x = RandomInt(3);
	if x == 0 then
	StartThread( T1 );
	end;
	if x == 1 then
	StartThread( T2 );
	end;
	if x == 2 then
	StartThread( T3 );
	end;
end;

function T1()
	Wait( 25 + RandomInt( 120 ) );
	LandReinforcementFromMap( 2, 0, 0, 301 ); 
	Wait( 2 );
	Cmd( 3, 301, 50, 4773, 5077 );
	Wait( 15 );
	StartThread( Attack_Tanks );
end;

function T2()
	Wait( 25 + RandomInt( 120 ) );
	LandReinforcementFromMap( 2, 0, 1, 302 ); 
	Wait( 2 );
	Cmd( 3, 302, 50, 4773, 5077 );
	Wait( 15 );
	StartThread( Attack_Tanks );
end;

function T3()
	Wait( 25 + RandomInt( 120 ) );
	LandReinforcementFromMap( 2, 0, 2, 303 ); 
	Wait( 2 );
	Cmd( 3, 303, 50, 4773, 5077 );
	Wait( 15 );
	StartThread( Attack_Tanks );
end;
------------------------------------------------------------- I_Attacks
function Attack_Infant() 
	while 1 do
		Wait( 2 );
			if (GetIGlobalVar("temp.All", 1) ~= 2) then
			Wait( 1 );
			StartThread( Rand_Infant );
			break;
		end;
	end;
end;

function Rand_Infant()
local x = RandomInt(2);
	if x == 0 then
	StartThread( I1 );
	end;
	if x == 1 then
	StartThread( I2 );
	end;
end;

function I1()
	Wait( 30 + RandomInt( 140 ) );
	LandReinforcementFromMap( 2, 1, 0, 311 ); 
	Wait( 2 );
	ChangeFormation( 311, 3 );
	Wait( 4 );
	Cmd( 3, 311, 50, 4773, 5077 );
	Wait( 10 );
	StartThread( Attack_Infant );
end;

function I2()
	Wait( 30 + RandomInt( 140 ) );
	LandReinforcementFromMap( 2, 1, 1, 312 ); 
	Wait( 2 );
	ChangeFormation( 312, 3 );
	Wait( 4 );
	Cmd( 3, 312, 50, 4773, 5077 );
	Wait( 10 );
	StartThread( Attack_Infant );
end;
---------------------------------------------------- KeyBuilding
function KeyBuilding_Flag()
local tmpold = { 0, 1 };
local tmp;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, 1 do
		if ( GetNUnitsInScriptGroup( i + 500, 0 ) == 1 ) then
			tmp = 0;
		elseif ( GetNUnitsInScriptGroup( i + 500, 1 ) == 1 ) then
			tmp = 1;
		end;
		if ( tmp ~= tmpold[i] ) then
			if ( tmp == 0 ) then
				SetScriptObjectHPs( 700 + i, 50 );
			else
				SetScriptObjectHPs( 700 + i, 100 );
			end;
			tmpold[i] = tmp;
		end;
	end;
	end;
end;
--------------------------------------------------- MAIN
StartThread( RevealObjective0 );
StartThread( Winner );
StartThread( Caput );
StartThread( Caput_2 );
StartThread( Attack_Tanks );
StartThread( Attack_Infant );
StartThread( Allies_Attack );
StartThread( KeyBuilding_Flag );
