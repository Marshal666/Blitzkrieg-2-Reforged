--Rus3.4
---------------------------------///Winners
function Loose()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) or ( IsReinforcementAvailable( 0 ) == 0 )) ) then
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;
----------------------
function Loose1()
    while 1 do
		if (GetNUnitsInArea(1, "zona1", 0) > 0 and GetNUnitsInArea(0, "zona1", 0) < 1 and GetNUnitsInArea(2, "zona1", 0) < 1) then
			FailObjective (0);
			Wait(1);
			Win(1);
			return 1;
		end;
	Wait(5);
	end;
end;
---------------------
function Loose2()
    while 1 do
		if (GetNUnitsInArea(1, "zona2", 0) > 0 and GetNUnitsInArea(0, "zona2", 0) < 1 and GetNUnitsInArea(2, "zona2", 0) < 1) then
			FailObjective (1);
			Wait(1);
			Win(1);
			return 1;
		end;
	Wait(5);
	end;
end;
-------------------
function Glory()
	SetCatchArtFlag( 301, CATCH_ALL );
	SetCatchArtFlag( 401, CATCH_ALL );
	Wait(740);
	SetIGlobalVar( "temp.vinner", 2 );
	StartThread( Glory2 );
end;

function Glory2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "zona1", 0) < 1) and (GetNUnitsInArea(1, "zona2", 0) < 1)) then
			CompleteObjective( 0 );
			Win(0);
			break;
		end;	
	end;
end;
---------------------------------///

function Swarm_G()
	Wait( 80 );
	LandReinforcementFromMap( 1, "SPY", 4, 619 );  
	Cmd( 0, 619, 0, 3999, 2540 );
	StartThread( Secret_ch );
	StartThread( Rand_At2 );
end;
--------------------------
function Secret_ch()
	while 1 do
		Wait( 2 );
		if ((GetIGlobalVar("temp.secret", 1) ~= 2) or (GetIGlobalVar("temp.vinner", 1) ~= 2)) then
			StartThread( Rand_At1 );
			break;
		end;	
	end;
end;

function Rand_At1()
local x = RandomInt(3);
	if x == 0 then
	StartThread( A1 );
	end;
	if x == 1 then
	StartThread( A2 );
	end;
	if x == 2 then
	StartThread( A3 );
	end;
end;

function A1()
	LandReinforcementFromMap( 1, "G_Inf", 0, 601 );   
	LandReinforcementFromMap( 1, "G_Tanks1", 1, 602 ); 
	Wait( 2 );
	ChangeFormation( 601, 3 );
	Wait( 2 );
	Cmd( 3, 601, 0, GetScriptAreaParams( "A1" ) );
	Cmd( 3, 602, 0, GetScriptAreaParams( "A2" ) );
	Wait( 75 );
	StartThread( Secret_ch );
end;

function A2()
	LandReinforcementFromMap( 1, "G_Tanks1", 0, 701 );  
	LandReinforcementFromMap( 1, "G_Inf", 1, 702 );     
	Wait( 2 );
	ChangeFormation( 702, 3 );
	Wait( 2 );
	Cmd( 3, 701, 0, GetScriptAreaParams( "A1" ) );
	Cmd( 3, 702, 0, GetScriptAreaParams( "A2" ) );
	Wait( 75 );
	StartThread( Secret_ch );
end;

function A3()
	LandReinforcementFromMap( 1, "G_Tanks2", 0, 801 );   
	LandReinforcementFromMap( 1, "G_Inf", 1, 802 );     
	Wait( 2 );
	ChangeFormation( 802, 3 );
	Wait( 2 );
	Cmd( 3, 801, 0, GetScriptAreaParams( "A1" ) );
	Cmd( 3, 802, 0, GetScriptAreaParams( "A2" ) );
	Wait( 75 );
	StartThread( Secret_ch );
end;
------------------------------------------------------
function Att_x()
	while 1 do
		Wait( 2 );
		if (GetIGlobalVar("temp.vinner", 1) ~= 2) then
			StartThread( Rand_At2 );
			break;
		end;	
	end;
end;

function Rand_At2()
local x = RandomInt(3);
	if x == 0 then
	StartThread( B1 );
	end;
	if x == 1 then
	StartThread( B2 );
	end;
	if x == 2 then
	StartThread( B3 );
	end;
end;

function B1()
	LandReinforcementFromMap( 1, "G_Inf", 2, 603 );   
	LandReinforcementFromMap( 1, "G_Tanks1", 3, 604 );      
	Wait( 2 );
	ChangeFormation( 603, 3 );
	Wait( 2 );
	Cmd( 3, 603, 0, GetScriptAreaParams( "A3" ) );
	Cmd( 3, 604, 0, GetScriptAreaParams( "A4" ) );
	Wait( 75 );
	StartThread( Att_x );
end;

function B2()
	LandReinforcementFromMap( 1, "G_Tanks1", 2, 703 );   
	LandReinforcementFromMap( 1, "G_Inf", 3, 704 );     
	Wait( 2 );
	ChangeFormation( 704, 3 );
	Wait( 2 );
	Cmd( 3, 703, 0, GetScriptAreaParams( "A3" ) );
	Cmd( 3, 704, 0, GetScriptAreaParams( "A4" ) );
	Wait( 75 );
	StartThread( Att_x );
end;

function B3()
	LandReinforcementFromMap( 1, "G_Inf", 2, 803 );   
	LandReinforcementFromMap( 1, "G_Tanks2", 3, 804 );     
	Wait( 2 );
	ChangeFormation( 803, 3 );
	Wait( 2 );
	Cmd( 3, 803, 0, GetScriptAreaParams( "A3" ) );
	Cmd( 3, 804, 0, GetScriptAreaParams( "A4" ) );
	Wait( 75 );
	StartThread( Att_x );
end;
-------------------------------------------------------Secrets
function Bonus1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "secret1", 0) < 1) and (GetNUnitsInArea(0, "secret1", 0) > 0)) then
			GiveObjective( 2 );
			CompleteObjective( 2 );
			SetIGlobalVar( "temp.secret", 2 );
			LandReinforcementFromMap( 0, "ATR", 2, 12 );
			break;
		end;	
	end;
end;
------------------------------------------------------DL

function D_L()
	Wait(120);
	if (GetDifficultyLevel() == 1) then
	GiveReinforcementCalls ( 1, 5 );
	end;
	if (GetDifficultyLevel() == 2) then
	GiveReinforcementCalls ( 1, 10 );
	LandReinforcementFromMap( 1, "G_Avia1", 3, 813 );
	Wait( 1 );
	Cmd( 3, 813, 0, GetScriptAreaParams( "A2" ) ); 
	end;
end;

function D_L_2()
	Wait(120);
	if ((GetDifficultyLevel() == 0) or (GetDifficultyLevel() == 1)) then
	LandReinforcementFromMap( 2, "Katerina", 0, 1110 );
	LandReinforcementFromMap( 2, "Katerina", 1, 1120 );
	Wait( 1 );
	Cmd( 0, 1110, 0, 1619, 2228 );
	Cmd( 0, 1120, 0, 6768, 2182 );
	QCmd( 8, 1110, 0, 1552, 2741 );
	QCmd( 8, 1120, 0, 6830, 3011 );
	end;
end;
----------------------------------------------------Rus_add
function Rus1()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(2, "Control1", 0) < 1) then
			LandReinforcementFromMap( 2, "T1", 0, 791 );
			Cmd( 3, 791, 0, 693, 3140 );
			QCmd( 8, 791, 0, 1913, 6797 );
			QCmd( 45, 791, 0, 1913, 1913 );
			Wait( 4 );
			LandReinforcementFromMap( 2, "T1", 0, 792 );
			Cmd( 3, 792, 0, 1318, 3162 );
			Wait( 4 );
			LandReinforcementFromMap( 2, "T1", 0, 793 );
			Cmd( 3, 793, 0, 1807, 3075 );
			QCmd( 8, 793, 0, 1913, 6797 );
			QCmd( 45, 793, 0, 1913, 6797 );
			Wait( 4 );
			LandReinforcementFromMap( 2, "T1", 0, 794 );
			Cmd( 3, 794, 0, 2573, 3278 );
			break;
		end;	
	end;
end;

function Rus2()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(2, "Control2", 0) < 1) then
			LandReinforcementFromMap( 2, "T1", 1, 891 );
			Cmd( 3, 891, 0, 5832, 3426 );
			Wait( 4 );
			LandReinforcementFromMap( 2, "T1", 1, 892 );
			Cmd( 3, 892, 0, 6299, 3425 );
			QCmd( 8, 892, 0, 7260, 6264 );
			QCmd( 45, 892, 0, 7260, 6264 );
			Wait( 4 );
			LandReinforcementFromMap( 2, "T1", 1, 893 );
			Cmd( 3, 893, 0, 6840, 3457 );
			QCmd( 8, 893, 0, 7260, 6264 );
			QCmd( 45, 893, 0, 7260, 6264 );
			Wait( 4 );
			LandReinforcementFromMap( 2, "T1", 1, 894 );
			Cmd( 3, 894, 0, 7365, 3440 );
			break;
		end;	
	end;
end;
------------------------------------////////////////MAIN

Wait(1);
GiveObjective( 0 );
Wait( 2 )
GiveObjective( 1 );

--------------------------------///

StartThread( Loose );
StartThread( Loose1 );
StartThread( Loose2 );

StartThread( Glory );
StartThread( Swarm_G );

StartThread( Bonus1 );
StartThread( D_L );
StartThread( D_L_2 );

StartThread( Rus1 );
StartThread( Rus2 );