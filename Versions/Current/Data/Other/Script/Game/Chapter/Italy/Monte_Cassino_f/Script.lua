
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
------------------------------------------- DEFENSE START LOCATION
function RevealObjective0()
	Wait(5);
	ObjectiveChanged(0, 1);
	StartThread( Statr_Attack );
end;

function Statr_Attack()
local x = RandomInt(2);
	if x == 0 then
	StartThread( Attack1 );
	StartThread( FallObjective0 );
	StartThread( CompleteObjective0 );
	end;
	if x == 1 then
	StartThread( Attack2 );
	StartThread( FallObjective0 );
	StartThread( CompleteObjective0 );
	end;
end;

function Attack1()
	Wait(20);
	Cmd( 0, 201, 0, 9555, 13382 );
	QCmd(3, 201 , 0, 12390, 13230);
end;

function Attack2()
	Wait(20);
	Cmd( 0, 201, 0, 12959, 10951 );
	QCmd(3, 201 , 0, 12294, 13647);
end;


function FallObjective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "SL", 0) < 1) and (GetNUnitsInArea(1, "SL", 0) > 0)) then
			ObjectiveChanged(0, 3);
			Wait( 3 );
			Loose(0);
			break;
		end;	
	end;
end;

function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 201 ) <= 0 ) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0", 2 );
			StartThread( Objective1 );
			break;
		end;	
	end;
end;
--------------------------------------------- CAPTURE SITY 1 - Station
function Objective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S1", 0) > 0) or (GetIGlobalVar("temp.objective0", 1) == 2)) then
			Wait( 3 );
			ObjectiveChanged(1, 1);
			StartThread( CompleteObjective1 );
			break;
		end;	
	end;
end;

function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S1", 0) > 0) and (GetNUnitsInArea(1, "S1", 0) < 1)) then
			ObjectiveChanged(1, 2);
			SetIGlobalVar( "temp.objective1", 2 );
			StartThread( ReturnObjective1 );
			Wait( 1 );
			break;
		end;	
	end;
end;

function ReturnObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S1", 0) < 1) and (GetNUnitsInArea(1, "S1", 0) > 0)) then
			SetIGlobalVar( "temp.objective1", 1 );
			Wait( 1 );
			ObjectiveChanged(1, 1);
			StartThread( CompleteObjective1 );
			Wait( 1 );
			break;
		end;	
	end;
end;
--------------------------------------------- CAPTURE SITY 2 - Storehouse
function Objective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S2", 0) > 0) or (GetIGlobalVar("temp.objective1", 1) == 2)) then
			Wait( 3 );
			ObjectiveChanged(2, 1);
			StartThread( CompleteObjective2 );
			break;
		end;	
	end;
end;

function CompleteObjective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S2", 0) > 0) and (GetNUnitsInArea(1, "S2", 0) < 1)) then
			ObjectiveChanged(2, 2);
			SetIGlobalVar( "temp.objective2", 2 );
			Wait( 1 );
			break;
		end;	
	end;
end;
---------------------------------------------- CAPTURE SITY 3 - Barracs
function Objective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S3", 0) > 0) or (GetIGlobalVar("temp.objective2", 1) == 2)) then
			Wait( 3 );
			ObjectiveChanged(3, 1);
			StartThread( CompleteObjective3 );
			break;
		end;	
	end;
end;

function CompleteObjective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S3", 0) > 0) and (GetNUnitsInArea(1, "S3", 0) < 1)) then
			ObjectiveChanged(3, 2);
			SetIGlobalVar( "temp.objective3", 2 );
			Wait( 1 );
			StartThread( ReturnObjective3 );
			Wait( 1 );
			break;
		end;	
	end;
end;
------------------------------
function ReturnObjective3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S3", 0) < 1) and (GetNUnitsInArea(1, "S3", 0) > 0)) then
			SetIGlobalVar( "temp.objective3", 1 );
			Wait( 1 );
			StartThread( Objective3 );
			Wait( 1 );
			break;
		end;	
	end;
end;

--------------------------------------------- CAPTURE FINAL SITY 4 
function Objective4()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S4", 0) > 0) or (GetIGlobalVar("temp.objective3", 1) == 2)) then
			Wait( 3 );
			ObjectiveChanged(4, 1);
			StartThread( CompleteObjective4 );
			break;
		end;	
	end;
end;

function CompleteObjective4()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S4", 0) > 0) and (GetNUnitsInArea(1, "S4", 0) < 1)) then
			ObjectiveChanged(4, 2);
			SetIGlobalVar( "temp.objective4", 2 );
			Wait( 1 );
			break;
		end;	
	end;
end;
---------------------------------------------  WIN_LOOSE
function Winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective3", 1) == 2) and (GetIGlobalVar("temp.objective4", 1) == 2)) then
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

---------------------------------------- SPECIAL_AIR_ATTACK1
function Special_Air()
	Wait(2);
	StartThread( Air_Attack );
end;

function Air_Attack()
local x = RandomInt(2);
	if x == 0 then
	StartThread( Air1 );
	end;
	if x == 1 then
	StartThread( Air2 );
	end;
end;

function Air1()
	Wait( 200 + RandomInt( 3000 ));
	LandReinforcementFromMap( 2, "1", 1, 3012 ); 
	Wait( 1 );
	Cmd( 5, 3012, 0, 11403, 13121 );	
end;

function Air2()
	Wait( 200 + RandomInt( 3000 ));
	LandReinforcementFromMap( 2, "1", 1, 3012 ); 
	Wait( 2 );
	Cmd( 0, 3012, 0, 8273, 3499 );
	QCmd( 5, 3012, 0, 12170,12121);
end;
------------------------------------------ Panthers
function Panthers()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "AZ1",0) > 0) and ( GetNUnitsInScriptGroup( 401 ) > 0))then
			StartThread( PAt1 );  
			break;
		end;	
	end;
end;

function PAt1()
	Wait( 2 );
	Cmd( 3, 401, 0, 12277, 4866 );
	Wait( 60 + RandomInt( 120 ));
	StartThread( Panthers2 );
end;

function Panthers2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "AZ1",0) < 1) and ( GetNUnitsInScriptGroup( 401 ) > 0))then
			StartThread( PAt2 );  
			break;
		end;	
	end;
end;

function PAt2()
	Wait( 2 );
	Cmd( 3, 401, 0, 11135, 1927 );
	QCmd( 8, 401, 0, 11134, 2626 );
	Wait( 60 + RandomInt( 120 ));
	StartThread( Panthers );
end;
----------------------------------------------------------

function Bridge()
	while 1 do
		Wait( 3 );
		if (( GetNUnitsInScriptGroup( 801 ) == 0 ) and ( GetNUnitsInScriptGroup( 802 ) == 0 ) and ( GetNUnitsInScriptGroup( 803 ) == 0 ))then
			Wait(3);
			Win(1); 
			break;
		end;	
	end;
end;

-------------------------------------------------US
function Bomb()
	while 1 do
		Wait( 2 );
		if (GetNUnitsInArea(0, "US1_Z", 0) > 0)  then
			Trace("US....Bomb!");
			LandReinforcementFromMap (3, "0", 0, 1011 );
			Cmd (0, 1011, 0, 11559, 5614 );
			Wait( 3 );
			LandReinforcementFromMap (3, "1", 0, 1012 );
			Cmd (0, 1012, 0, 11559, 5614 );
			Wait( 8 );
			LandReinforcementFromMap (3, "1", 0, 1013 );
			Cmd (0, 1013, 0, 13507, 5684 );
			Wait( 8 );
			LandReinforcementFromMap (3, "1", 0, 1014 );
			Cmd (0, 1014, 0, 12402, 4851 );
			break;
		end;	
	end;
end;
-------------------------------------------------GER_BRIDGE
function BridgeBomb()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "B1", 0) > 0)  then
			LandReinforcementFromMap (1, "0", 1, 7001 );
			Cmd (0, 7001, 1, 8073, 13359 );
			Wait( 6 );
			LandReinforcementFromMap (1, "0", 1, 7002 );
			Cmd (0, 7002, 1, 9386, 6343 );
			break;
		end;	
	end;
end;
------------------------------------------------GER_AAttack
function GER_AVIA1()
	Wait( 300 + RandomInt( 600 ));
	LandReinforcementFromMap (1, "2", 1, 8001 );
	Cmd (0, 8001, 1, 11864, 10636 );
	Wait( 20 );
	LandReinforcementFromMap (3, "0", 0, 1015 );
	Cmd (0, 1015, 0, 11864, 10636 );
end;
-----------------------------------------------GER_S3_attack
function GER_S3()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "S3", 0) > 0) and (GetNUnitsInArea(1, "S3", 0) < 1)) then
			LandReinforcementFromMap (1, "3", 0, 8005 );
			Cmd (3, 8005, 0, 7202, 5810 );
			Wait( 10 );
			LandReinforcementFromMap (1, "3", 0, 8006 );
			Cmd (3, 8006, 0, 12361, 4792 );
			break;
		end;	
	end;
end;
-----------------------------------------------US_TANKS_GER_TANKS
function US_TANKS_GER_TANKS()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "S2", 0) > 0) then
			LandReinforcementFromMap (3, "3", 2, 9001 );
			Cmd (3, 9001, 0, 2717, 2737 );
			QCmd (3, 9001, 0, 1436, 12959 );
			LandReinforcementFromMap (3, "3", 3, 9002 );
			Cmd (3, 9002, 0, 2717, 2734 );
			QCmd (3, 9002, 0, 1436, 12959 );
			LandReinforcementFromMap (3, "3", 4, 9003 );
			Cmd (3, 9003, 0, 2717, 2734 );
			QCmd (3, 9003, 0, 1436, 12959 );
			Wait( 5 );
			LandReinforcementFromMap (2, "0", 0, 9005 );
			Cmd (3, 9005, 0, 5840, 1490 );
			break;
		end;	
	end;
end;
-------------------------------------------------Add_GAttack
function GER_Add_Attack()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "S1", 0) < 1) or (GetNUnitsInArea(0, "zona1", 0) > 0)) then
			LandReinforcementFromMap (2, "2", 0, 8151 );
			QCmd (3, 8151, 0, 8336, 1704 );
			QCmd (3, 8151, 0, 13223, 4804 );
			Cmd (3, 8151, 0, 12248, 12352 );
			break;
		end;	
	end;
end;
-------------------------------------------------Final_avia_shou
function Fin_avia()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "S4", 0) > 0) then
			Wait( 2 );
			LandReinforcementFromMap (1, "2", 0, 879 );
			Cmd (3, 879, 0, 2269, 12078 );
			LandReinforcementFromMap (3, "0", 3, 878 );
			Cmd (3, 878, 0, 2269, 12078 );
			break;
		end;	
	end;
end;
---------------------------------  MAIN

StartThread( Unlucky );
StartThread( Winner );
StartThread( KeyBuilding_Flag );
StartThread( RevealObjective0 );

StartThread( Objective2 );
StartThread( Objective3 );
StartThread( Objective4 );

StartThread( Special_Air );
StartThread( Panthers );
----StartThread( Bridge );
StartThread( Bomb );
StartThread( BridgeBomb );
StartThread( GER_AVIA1 );
StartThread( GER_S3 );
StartThread( US_TANKS_GER_TANKS );
StartThread( GER_Add_Attack );
StartThread( Fin_avia );




