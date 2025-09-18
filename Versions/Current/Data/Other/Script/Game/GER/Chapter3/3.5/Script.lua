---------------------------------------------------------------
function RevealObjective0()
GiveObjective( 0 );
end;

function Winner()
	Wait(400); 
	StartThread( Cargo_tr );
	StartThread( GER_FT );
	StartThread( Object_2start );
end;
--------------------------------------
function Object_2start()
	while 1 do
		Wait( 2 );
		if (GetNScriptUnitsInArea (601, "cargo" ) > 0 )then
			Wait( 1 );
			SetIGlobalVar( "temp.All", 2 );
			CompleteObjective( 0 );
			StartThread( RevealObjective1 );
			break;
		end;	
	end;
end;

---------------------------------
function Cargo_tr()
	LandReinforcementFromMap( 2, "CARGO", 0, 601 );
	Wait( 1 ); 
	Cmd( 0, 601, 0, 3681, 4616 );
end;

function GER_FT()
	LandReinforcementFromMap( 2, "FT", 0, 701 );
	Wait( 1 ); 
	Cmd( 3, 601, 0, 3681, 4616 );
end;
----------------------------------
function RevealObjective1()
	Wait(2);
	GiveObjective( 1 );
	ChangePlayerForScriptGroup( 155, 0 );
	StartThread( Rus_T1 );
	StartThread( Rus_T2 );
	StartThread( Defead );
	StartThread( Winners );
end;
------------------------------------------------------Caput
function Caput1()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.All", 1) ~= 2) and ( GetNUnitsInScriptGroup( 155 ) < 14 ))then
			Wait(1);
			Win(1);  
			break;
		end;	
	end;
end;

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

function Winners()
	while 1 do
		Wait( 3 );
		if (( GetNUnitsInScriptGroup( 401 ) < 1 ) and ( GetNUnitsInScriptGroup( 402 ) < 1 )) then
			Wait(1);
			CompleteObjective( 1 );
			Wait(2);
			Win(0);  
			break;
		end;	
	end;
end;

-------------------------------------------------------
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
	Wait( 40 + RandomInt( 50 ) );
	StartThread( Rus_Attack );
end;

function Air2()
	LandReinforcementFromMap( 1, "AG", 1, 302 ); 
	Cmd( 3, 302, 500, 4234, 4215 );
	Wait( 40 + RandomInt( 50 ) );
	StartThread( Rus_Attack );
end;

function Air3()
	LandReinforcementFromMap( 1, "AG", 2, 303 ); 
	Cmd( 3, 303, 500, 4234, 4215 );
	Wait( 40 + RandomInt( 50 ) );
	StartThread( Rus_Attack );
end;
-------------------------------BOMB
function Air_Bomb()
	Wait( 160 + RandomInt( 200 ) );
	LandReinforcementFromMap( 1, "BOMB", 0, 304 ); 
	Wait( 1 );
	Cmd( 0, 304, 1000, 4234, 4215 );
	StartThread( Rus_Attack );
end;

-------------------------------------------Rus_tank

function Rus_T1()
	LandReinforcementFromMap( 1, "TANKS", 2, 401 );
	Wait( 10 ); 
	Cmd( 3, 401, 200, 4004, 1180 );
	QCmd( 3, 401, 200, 4234, 4215 );
end;

function Rus_T2()
	LandReinforcementFromMap( 1, "TANKS", 1, 402 );
	Wait( 15 ); 
	Cmd( 3, 402, 200, 4234, 4215 );
end;


---------------------------------------Main

StartThread( RevealObjective0 );
StartThread( Rus_Attack );
StartThread( Air_Bomb );
StartThread( Winner );
StartThread( Caput1 );

