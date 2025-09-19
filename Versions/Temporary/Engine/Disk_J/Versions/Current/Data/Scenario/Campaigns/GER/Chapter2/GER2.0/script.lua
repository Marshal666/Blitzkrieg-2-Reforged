--------------------------------------------------Tubruk2.0

function RevealObjective0()
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
			StartThread( GB_GRANTS );
			break;
		end;	
	end;
end;

function GB_GRANTS()
	Wait( 12 );
	LandReinforcementFromMap( 1, "GRANTS", 2, 222 );
	LandReinforcementFromMap( 1, "GRANTS", 3, 222 );
	SetIGlobalVar( "temp.GB_GRANT", 2 );
	Wait( 2 );
	StartThread( Objective2 );
	Cmd ( 0 , 222 , 0 , GetScriptAreaParams"GRANT1" );
	QCmd ( 3 , 222 , 0 , GetScriptAreaParams"GRANT2" );
	QCmd ( 3 , 222 , 0 , GetScriptAreaParams"GRANT3" );
	QCmd ( 3 , 222 , 0 , GetScriptAreaParams"GRANT4" );
	QCmd ( 3 , 222 , 0 , GetScriptAreaParams"GRANT1" );
	QCmd ( 45, 222, 0, 2972, 4324 );
end;

function Objective2()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 222 ) < 1 ) then
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
		if ((GetNUnitsInArea(1, "Village", 0) < 1) and (GetNUnitsInArea(0, "Village", 0) > 0)) then
			CompleteObjective( 3 );
			SetIGlobalVar( "temp.objective3", 2 );
			Wait( 2 );
			StartThread( Italo_2 );
			StartThread( Italo_3 );
			StartThread( Italo_4 );
			break;
		end;	
	end;
end;

function Italo_2()
	Wait( 15 );
	LandReinforcementFromMap( 2, "IT_INF", 3, 5099 );
	Wait( 3 );
	ChangeFormation( 311, 3 );
	Cmd( 3, 5099, 0, 5981, 9863 ); 
end;

function Italo_3()
	Wait( 40 );
	LandReinforcementFromMap( 2, "IT_TANKS", 3, 5098 );
	Wait( 2 );
	Cmd( 3, 5098, 0, 5981, 9863 ); 
end;

function Italo_4()
	Wait( 2 );
	LandReinforcementFromMap( 0, "ITALO_SPG", 3, 5097 );
	Wait( 1 );
	Cmd( 3, 5097, 0, 1098, 10930 ); 
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
		if ((GetNUnitsInArea(1, "Tubruk", 0) < 4) and (GetNUnitsInArea(0, "Tubruk", 0) > 0)) then
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
			if ((GetNUnitsInArea(1, "W_fort", 0) > 4) and (GetIGlobalVar("temp.objective0", 1) == 2)) then
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
	Wait( 5 );
	LandReinforcementFromMap( 2, "IT_INF", 0, 311 );
	LandReinforcementFromMap( 2, "IT_TANKS", 1, 312 );
	LandReinforcementFromMap( 2, "IT_INF", 2, 313 ); 
	Wait( 2 );
	ChangeFormation( 311, 3 );
	ChangeFormation( 313, 3 );
	Wait( 3 );
	Cmd ( 3 , 311 , 0 , GetScriptAreaParams"IT1" );
	Cmd ( 3 , 312 , 0 , GetScriptAreaParams"IT1_1" );
	Cmd ( 3 , 313 , 0 , GetScriptAreaParams"IT1_2" );
	QCmd ( 3 , 311 , 0 , GetScriptAreaParams"IT2" );
	QCmd ( 3 , 312 , 0 , GetScriptAreaParams"IT2" );
	QCmd ( 3 , 313 , 0 , GetScriptAreaParams"IT2" );
	QCmd ( 3 , 311 , 0 , GetScriptAreaParams"IT3" );
	QCmd ( 3 , 312 , 0 , GetScriptAreaParams"IT3" );
	QCmd ( 3 , 313 , 0 , GetScriptAreaParams"IT3" );
	Wait( 160 + RandomInt( 60 ) );
	StartThread( Attack_I );
end;

function I2()
	Wait( 5 );
	LandReinforcementFromMap( 2, "IT_TANKS", 0, 314 );
	LandReinforcementFromMap( 2, "IT_INF", 1, 315 );
	LandReinforcementFromMap( 2, "IT_TANKS", 2, 316 ); 
	Wait( 2 );
	ChangeFormation( 315, 3 );
	Wait( 3 );
	Cmd ( 3 , 314 , 0 , GetScriptAreaParams"IT1" );
	Cmd ( 3 , 315 , 0 , GetScriptAreaParams"IT1_1" );
	Cmd ( 3 , 316 , 0 , GetScriptAreaParams"IT1_2" );
	QCmd ( 3 , 314 , 0 , GetScriptAreaParams"IT2" );
	QCmd ( 3 , 315 , 0 , GetScriptAreaParams"IT2" );
	QCmd ( 3 , 316 , 0 , GetScriptAreaParams"IT2" );
	QCmd ( 3 , 314 , 0 , GetScriptAreaParams"IT3" );
	QCmd ( 3 , 315 , 0 , GetScriptAreaParams"IT3" );
	QCmd ( 3 , 316 , 0 , GetScriptAreaParams"IT3" );
	Wait( 160 + RandomInt( 60 ) );
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
	LandReinforcementFromMap( 2, "IT_AVIA", 0, 511 ); 
	Cmd( 0, 511, 1000, 3240, 4631 );
	Wait( 140 + RandomInt( 100 ) );
	StartThread( Attack_Avia );
end;
------------------------
function Start_Italo()
	Wait( 25 );
	LandReinforcementFromMap( 2, "IT_INF", 0, 6776 ); 
	Wait( 2 );
	Cmd( 3, 6776, 50, 1689, 3675 );
	QCmd( 3, 6776, 50, 4177, 5775 );
	QCmd( 3, 6776, 50, 7294, 11565 );
end;
-----------------------------------------------------W_FORT_DEFEND
function Fort_Def() 
	while 1 do
		Wait( 2 );
			if ((GetNUnitsInArea(1, "W_fort") < 10) and (GetNUnitsInArea(0, "W_fort") < 1) and (GetIGlobalVar("temp.objective1", 1) ~= 2)) then
			Wait( 1 );
			StartThread( GB_REINF_1 );
			break;
		end;
	end;
end;

function GB_REINF_1()
	Wait( 3 );
	LandReinforcementFromMap( 1, "GB_TANKS", 1, 2132 ); 
	Wait( 2 );
	Cmd ( 3 , 2132 , 0 , GetScriptAreaParams"GB1" );
	QCmd ( 3 , 2132 , 0 , GetScriptAreaParams"GB2" );
	Wait( 5 );
	StartThread( Fort_2 );
end;

function Fort_2() 
	while 1 do
		Wait( 2 );
			if (( GetNUnitsInScriptGroup( 2132 ) < 2 ) and (GetIGlobalVar("temp.objective1", 1) ~= 2 )) then
			Wait( 1 );
			StartThread( GB_REINF_1 );
			break;
		end;
	end;
end;

----------------------------------------------------Winners
function Winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective1", 1) == 2) and (GetIGlobalVar("temp.objective4", 1) == 2) and (GetIGlobalVar("temp.objective3", 1) == 2)) then
			Wait( 3 );
			Win(0);
			break;
		end;	
	end;
end;

function Unlucky()
    while 1 do
        if (( IsSomePlayerUnit(0) < 1) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) or ( IsReinforcementAvailable( 0 ) == 0 )) ) then
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;
------------------------------------------------------Mobile
function Mob_art()
	while 1 do
		Wait( 2 );
		if (GetNUnitsInArea(0, "Mobile", 0) > 0) then
			Wait( 1 );
			StartThread( Mobile_move_1 );
			StartThread( Mobile_move_2 );
			Wait( 1 );
			break;
		end;	
	end;
end;

function Mobile_move_1()
	Wait( 1 );
	Cmd( 0, 199, 0, 7202, 5590 );
	QCmd( 8, 199, 0, 7401, 5280 );
	QCmd( 45, 199, 0, 7401, 5280 );
end;

function Mobile_move_2()
	Wait( 1 );
	Cmd( 0, 198, 0, 7336, 5664 );
	QCmd( 8, 198, 0, 7501, 4667 );
	QCmd( 45, 198, 0, 7501, 4667 );
end;
--------------------------------------------------------------------GB_INF_RETREAT
function Retreat_1()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInScriptGroup( 281 ) < 6 ) then
			Wait( 2 );
			Cmd( 0, 281, 0, 9967, 3149 );
			ChangeFormation( 281, 1 );
			QCmd( 0, 281, 0, 9306, 6626 );
			Wait( 1 );
			break;
		end;	
	end;
end;

function GB_infantry()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective3", 1) ~= 2) and (GetIGlobalVar("temp.objective0", 1) == 2) and ( GetNUnitsInScriptGroup( 5088 ) < 1 )) then
			Wait( 2 );
			GiveObjective( 1 );
			StartThread( GB_inf_attack );
			break;
		end;	
	end;
end;

function GB_inf_attack()
	Wait( 2 );
	LandReinforcementFromMap( 1, "GB_INF", 0, 5088 ); 
	Wait( 2 );
	ChangeFormation( 5088, 3 );
	Wait( 5 );
	Cmd( 3, 5088, 500, 3671, 4994 );
	QCmd( 3, 5088, 0, 5485, 1253 );
	QCmd( 3, 5088, 0, 9952, 4056 );
	QCmd( 3, 5088, 0, 10930, 442 );
	Wait( 180 );
	StartThread( GB_infantry );
end;
------------------------------------------------------It_tanks_grant

function Grant_at()
	while 1 do
		Wait( 2 );
		if ((GetIGlobalVar("temp.objective1", 1) == 2) and (GetIGlobalVar("temp.GB_GRANT", 1) == 2)) then
			Wait( 1 );
			LandReinforcementFromMap( 2, "IT_TANKS", 0, 710 );
			LandReinforcementFromMap( 2, "IT_TANKS", 1, 711 );
			LandReinforcementFromMap( 2, "IT_TANKS", 2, 712 );
			Wait( 1 );
				Cmd ( 3 , 710 , 0 , GetScriptAreaParams"IT1" );
				Cmd ( 3 , 711 , 0 , GetScriptAreaParams"IT1_1" );
				Cmd ( 3 , 712 , 0 , GetScriptAreaParams"IT1_2" );
				QCmd ( 3 , 710 , 0 , GetScriptAreaParams"IT2" );
				QCmd ( 3 , 711 , 0 , GetScriptAreaParams"IT2" );
				QCmd ( 3 , 712 , 0 , GetScriptAreaParams"IT2" );
				QCmd ( 3 , 710 , 0 , GetScriptAreaParams"IT2_2" );
				QCmd ( 3 , 711 , 0 , GetScriptAreaParams"IT2_2" );
				QCmd ( 3 , 712 , 0 , GetScriptAreaParams"IT2_2" );
				QCmd ( 3 , 710 , 0 , GetScriptAreaParams"ITF" );
				QCmd ( 3 , 711 , 0 , GetScriptAreaParams"ITF" );
				QCmd ( 3 , 712 , 0 , GetScriptAreaParams"ITF" );
				QCmd ( 3 , 710 , 0 , GetScriptAreaParams"TUB" );
				QCmd ( 3 , 711 , 0 , GetScriptAreaParams"TUB" );
				QCmd ( 3 , 712 , 0 , GetScriptAreaParams"TUB" );
			break;
		end;	
	end;
end;
-------------------------------------------------D_LEVEL
function D_L()
	Wait(2);
	if (GetDifficultyLevel() == 0) then
	RemoveScriptGroup(1001);
	RemoveScriptGroup(1002);
	end;
	if (GetDifficultyLevel() == 1) then
	RemoveScriptGroup(1002);
	GiveReinforcementCalls ( 1, 8 );
	end;
	if (GetDifficultyLevel() == 2) then
	GiveReinforcementCalls ( 1, 15 );
	end;
end;
--------------------------
function Bonus()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "BON",0) > 0) then
			Wait( 1 );
			GiveObjective( 5 );
			CompleteObjective( 5 );
			break;
		end;	
	end;
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

StartThread( Mob_art );
StartThread( Retreat_1 );
StartThread( GB_infantry );
StartThread( Grant_at );

StartThread( Fort_Def );
StartThread( D_L );
StartThread( Bonus );