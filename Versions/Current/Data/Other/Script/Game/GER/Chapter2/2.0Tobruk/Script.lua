

---------------------------------------------------Start_mission_Tubruk_2.0
function RevealObjective0()
	Wait(2);
	GiveObjective( 0 );
	StartThread( Objective0 );
end;

function Objective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "Def1", 0) < 2) and (GetNUnitsInArea(1, "Def2", 0) < 2)) then
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.objective0", 2 );
			Wait( 2 );
			break;
		end;	
	end;
end;
--------------------------------------------------W_Fort
function RevealObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "W_fort", 0) > 0) or (GetIGlobalVar("temp.objective0", 1) == 2)) then
			Wait( 2 );
			GiveObjective( 1 );
			StartThread( Objective1 );
			break;
		end;	
	end;
end;

function Objective1()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(1, "W_fort", 0) < 1) then
			CompleteObjective( 1 );
			SetIGlobalVar( "temp.objective1", 2 );
			Wait( 2 );
			LandReinforcementFromMap( 0, 0, 4, 394 );
			break;
		end;	
	end;
end;
-------------------------------------------------GB_Tanks
function RevealObjective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "Tanks", 0) > 0) or (GetIGlobalVar("temp.objective1", 1) == 2)) then
			Wait( 2 );
			GiveObjective( 2 );
			StartThread( Objective2 );
			break;
		end;	
	end;
end;

function Objective2()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 222 ) < 2 ) then
			CompleteObjective( 2 );
			SetIGlobalVar( "temp.objective2", 2 );
			Wait( 2 );
			break;
		end;	
	end;
end;
--------------------------------------------------Village
function RevealObjective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "Village", 0) > 0) or (GetIGlobalVar("temp.objective2", 1) == 2)) then
			Wait( 2 );
			GiveObjective( 3 );
			StartThread( Objective3 );
			break;
		end;	
	end;
end;

function Objective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "Village", 0) < 2) and (GetNUnitsInArea(0, "Village", 0) > 0)) then
			CompleteObjective( 3 );
			SetIGlobalVar( "temp.objective3", 2 );
			Wait( 2 );
			break;
		end;	
	end;
end;
--------------------------------------------------Tubruk
function RevealObjective4()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "Tubruk", 0) > 0) or (GetIGlobalVar("temp.objective3", 1) == 2)) then
			Wait( 2 );
			GiveObjective( 4 );
			StartThread( Objective4 );
			break;
		end;	
	end;
end;

function Objective4()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "Tubruk", 0) < 2) and (GetNUnitsInArea(0, "Tubruk", 0) > 0)) then
			Wait( 2 );
			CompleteObjective( 4 );
			SetIGlobalVar( "temp.objective4", 2 );
			Wait( 2 );
			break;
		end;	
	end;
end;


--------------------------------------------------I_Attacks
function Attack_I() 
	while 1 do
		Wait( 2 );
			if ((GetIGlobalVar("temp.objective0", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) ~= 2)) then
			Wait( 1 );
			StartThread( Rand_Italo );
			break;
		end;
	end;
end;

function Rand_Italo()
local x = RandomInt(2);
	if x == 0 then
	StartThread( I1 );
	end;
	if x == 1 then
	StartThread( I2 );
	end;
end;

function I1()
	Wait( 10 );
	LandReinforcementFromMap( 2, 0, 0, 311 ); 
	Wait( 3 );
	ChangeFormation( 311, 3 );
	Wait( 3 );
	Cmd( 3, 311, 50, 1683, 2792 );
	QCmd( 3, 311, 50, 3603, 4817 );
	QCmd( 3, 311, 50, 7294, 11565 );
	Wait( 60 + RandomInt( 120 ) );
	StartThread( Attack_I );
end;

function I2()
	Wait( 10 );
	LandReinforcementFromMap( 2, 1, 0, 312 );
	Wait( 3 );
	Cmd( 3, 312, 50, 1683, 2792 );
	QCmd( 3, 312, 50, 3603, 4817 );
	QCmd( 3, 312, 50, 7294, 11565 );
	Wait( 60 + RandomInt( 120 ) );
	StartThread( Attack_I );
end;
---------------------------------------------------Italo_avia
function Attack_Avia() 
	while 1 do
		Wait( 2 );
			if ((GetIGlobalVar("temp.objective0", 1) == 2) and (GetIGlobalVar("temp.objective1", 1) ~= 2)) then
			Wait( 1 );
			StartThread( Avia );
			break;
		end;
	end;
end;

function Avia()
	Wait( 10 );
	LandReinforcementFromMap( 2, 2, 0, 511 ); 
	Cmd( 0, 511, 1000, 3240, 4631 );
	Wait( 80 + RandomInt( 180 ) );
	StartThread( Attack_Avia );
end;
------------------------
function Start_Italo()
	Wait( 25 );
	LandReinforcementFromMap( 2, 1, 0, 6776 ); 
	Wait( 2 );
	Cmd( 3, 6776, 50, 1689, 3675 );
	QCmd( 3, 6776, 50, 4177, 5775 );
	QCmd( 3, 6776, 50, 7294, 11565 );
end;
-----------------------------------------------------W_FORT_DEFEND
function Fort_Def() 
	while 1 do
		Wait( 2 );
			if ((GetNUnitsInArea(1, "W_fort") < 6) and (GetNUnitsInArea(0, "W_fort") < 1) and (GetIGlobalVar("temp.objective1", 1) ~= 2)) then
			Wait( 1 );
			StartThread( GB_REINF_1 );
			break;
		end;
	end;
end;

function GB_REINF_1()
	Wait( 10 );
	LandReinforcementFromMap( 1, 0, 0, 2132 ); 
	Wait( 2 );
	Cmd( 3, 2132, 0, 4177, 5775 );
	Wait( 30 );
	StartThread( Fort_Def );
end;
----------------------------------------------------Winners
function Winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective1", 1) == 2) and (GetIGlobalVar("temp.objective4", 1) == 2)) then
			Wait( 3 );
			Win(0);
			break;
		end;	
	end;
end;

function Unlucky()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;
-----------------------------------------------------StartGB_attack
function StartGB()
	Wait( 20 );
	while 1 do
		Wait( 2 );
		if (GetNUnitsInArea(0, "A1", 0) < 3) then
			Wait( 2 );
			StartThread( GB_attack );
			Wait( 1 );
			break;
		end;	
	end;
end;

function GB_attack()
	Wait( 2 );
	LandReinforcementFromMap( 1, 1, 1, 5081 ); 
	Wait( 2 );
	ChangeFormation( 5081, 3 );
	Wait( 3 );
	Cmd( 3, 5081, 0, 10372, 864 );
	QCmd( 3, 5081, 0, 11398, 426 );
end;
------------------------------------------------------Mobile
function Mob_art()
	while 1 do
		Wait( 2 );
		if (GetNUnitsInArea(0, "Mobile", 0) > 0) then
			Wait( 1 );
			StartThread( Mobile_move );
			Wait( 1 );
			break;
		end;	
	end;
end;

function Mobile_move()
	Wait( 1 );
	Cmd( 0, 199, 0, 8745, 7629 );
	QCmd( 0, 199, 0, 7202, 5590 );
	QCmd( 8, 199, 0, 7401, 5280 );
	QCmd( 45, 199, 0, 7401, 5280 );
end;
----------------------------------------------------- MAIN

StartThread( RevealObjective0 );
StartThread( RevealObjective1 );
StartThread( RevealObjective2 );
StartThread( RevealObjective3 );
StartThread( RevealObjective4 );

StartThread( Winner );
StartThread( Unlucky );
StartThread( Attack_I );
StartThread( Attack_Avia );
StartThread( StartGB );
StartThread( Mob_art );


--StartThread( Fort_Def );

