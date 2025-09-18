----------------------------------------Objectives
function RevealObjective()
	Wait(2);
	GiveObjective( 0 );
	Wait(2);
	GiveObjective( 1 );
	Wait(2);
	StartThread( CompleteObjective0 );
	StartThread( CompleteObjective1 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "Factory", 0) < 1)then
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.objective0", 2 );
			break;
		end;	
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "City", 0) < 1)then
			CompleteObjective( 1 );
			SetIGlobalVar( "temp.objective1", 2 );
			break;
		end;	
	end;
end;



---------------------------------------------------------WIN_LOSE
function Winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective0", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) == 2)) then
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

-----------------------------------------------------
function Alert()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "Factory", 0) < 2)then
			StartThread( German_Track ); 
			StartThread( German_Track1 ); 
			Wait( 150 ); 
			StartThread( German_Run );
			break;
		end;	
	end;
end;


function German_Track()
	Wait( 2 );
	Cmd( 0, 31, 0, 2472, 857 );
	QCmd( 5, 31, 0, 2661, 4614 );
end;

function German_Track1()
	Wait( 2 );
	Cmd( 0, 41, 0, 7170, 4459 );
	QCmd( 5, 41, 0, 6496, 5895 );
	QCmd( 5, 41, 0, 3656, 6700 );
end;

function German_Run()
Wait( 2 );
	Cmd( 3, 32, 0, 2246, 6013 );
	Cmd( 3, 42, 0, 2246, 6013 );	
end;




-----------------------------------------------------
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

---------------------------------------Patrol
function Start_Patrol()
	while 1 do
		Wait(5);
		if ( GetNUnitsInScriptGroup( 11 ) > 0 ) then
			Wait(3);
			StartThread( Run1 );
			break
		end;
	end;
end;


------------------------

function Run1 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 11, "P1" ) > 0 ) then
		Wait( 3 + RandomInt( 6 ) );
		Cmd(3, 11, 0, GetScriptAreaParams("P2"));
			StartThread( Run2 );
			break
		end;		
	end;
end;

function Run2 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 11, "P2" ) > 0 ) then
		Wait( 3 + RandomInt( 15 ) );
		Cmd(3, 11, 0, GetScriptAreaParams("P3"));
			StartThread( Run3 );
			break
		end;		
	end;
end;

function Run3 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 11, "P3" ) > 0 ) then
		Wait( 3 + RandomInt( 10 ) );
		Cmd(3, 11, 0, GetScriptAreaParams("P4"));
			StartThread( Run4 );
			break
		end;		
	end;
end;

function Run4 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 11, "P4" ) > 0 ) then
		Wait( 3 + RandomInt( 15 ) );
		Cmd(3, 11, 0, GetScriptAreaParams("P1"));
			StartThread( Start_Patrol );
			break
		end;		
	end;
end;
------------------------------------------------2
function Start_Patrol1()
	while 1 do
		Wait(5);
		if ( GetNUnitsInScriptGroup( 12 ) > 0 ) then
			Wait(3);
			StartThread( Run11 );
			break
		end;
	end;
end;


------------------------

function Run11 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 12, "Z1" ) > 0 ) then
		Wait( 3 + RandomInt( 6 ) );
		Cmd(3, 12, 0, GetScriptAreaParams("Z2"));
			StartThread( Run22 );
			break
		end;		
	end;
end;

function Run22 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 12, "Z2" ) > 0 ) then
		Wait( 3 + RandomInt( 15 ) );
		Cmd(3, 12, 0, GetScriptAreaParams("Z3"));
			StartThread( Run33 );
			break
		end;		
	end;
end;

function Run33 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 12, "Z3" ) > 0 ) then
		Wait( 3 + RandomInt( 10 ) );
		Cmd(3, 12, 0, GetScriptAreaParams("Z4"));
			StartThread( Run44 );
			break
		end;		
	end;
end;

function Run44 ()
	while 1 do
	Wait(3);
	if ( GetNScriptUnitsInArea ( 12, "Z4" ) > 0 ) then
		Wait( 3 + RandomInt( 15 ) );
		Cmd(3, 12, 0, GetScriptAreaParams("Z1"));
			StartThread( Start_Patrol1 );
			break
		end;		
	end;
end;

--------------------------------------------------- MAIN

StartThread( RevealObjective );
StartThread( Winner );
StartThread( Caput );
StartThread( Alert );
StartThread( KeyBuilding_Flag );
StartThread( Start_Patrol );
StartThread( Start_Patrol1 );

