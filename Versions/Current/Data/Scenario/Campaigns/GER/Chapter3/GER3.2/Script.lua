-- Konvoy
-------------------------------------------------1

function RevealObjective0()
	GiveObjective( 0 );
	SetAmmo( GetObjectList( 5555 ), 0, 0, 0 );
	SetAmmo( GetObjectList( 5566 ), 0, 0, 0 );
	StartThread( Objective0 );
end;

function Objective0()
	while 1 do
		Wait( 3 );
		if ((GetNScriptUnitsInArea(521, "EXIT") > 0) and (GetNScriptUnitsInArea(522, "EXIT") > 0)) then
			Wait( 2 );
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.EXIT", 2 );
			StartThread( ObjectiveManager );
			break;
		end;	
	end;
end;

-------------------

function ObjectiveManager() 
	while 1 do	 
		Wait( 2 );
		if (GetIGlobalVar("temp.R1_R2", 1) == 2) then
			Wait( 2 );
			Win( 0 );
			break;
		elseif  (GetIGlobalVar("temp.R1_R2", 1) ~= 2) then
			Wait( 2 );
			GiveObjective( 1 );
			ChangePlayerForScriptGroup( 5555, 0 ); 
			ChangePlayerForScriptGroup( 5566, 0 ); 
			Wait( 30 );
			StartThread( Rus_attack );
			break;
		end;
	end;
end;

function Rus_attack()
	LandReinforcementFromMap( 1, "RUS_TANKS", 3, 311 ); 
	Wait( 2 );
	Cmd( 3, 311, 0, GetScriptAreaParams( "Z1" ) );
	QCmd( 3, 311, 0, GetScriptAreaParams( "Z2" ) );
	StartThread( Objective1 );
end;

function Objective1()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 311 ) < 1 ) then
			Wait( 2 );
			CompleteObjective( 0 );
			Wait( 2 );
			Win( 0 );
			break;
		end;	
	end;
end;

--------------------------------------------------
function R_ZONA1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "R1", 0) < 1) or (GetNUnitsInArea(0, "R1", 0) > 0)) then
			Wait( 2 );
			SetIGlobalVar( "temp.R1", 2 );
			break;
		end;	
	end;
end;

function R_ZONA2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "R2", 0) < 1) or (GetNUnitsInArea(0, "R2", 0) > 0)) then
			Wait( 2 );
			SetIGlobalVar( "temp.R2", 2 );
			break;
		end;	
	end;
end;

function ZONES()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.R1", 1) == 2) and (GetIGlobalVar("temp.R2", 1) == 2)) then
			Wait( 2 );
			SetIGlobalVar( "temp.R1_R2", 2 );
			break;
		end;	
	end;
end;
----------------------------------------RUS_INFANTRY
-----------------------------------1
function R_Zona1()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.R1", 1) ~= 2) and ( GetNUnitsInScriptGroup( 521 ) > 0 ) and ( GetNUnitsInScriptGroup( 401 ) < 1 ))then
			Wait( 2 );
			StartThread( Rus_inf1 );
			break;
		end;	
	end;
end;

function Rus_inf1()
	LandReinforcementFromMap( 1, "RUS_INF", 1, 401 );  
	Wait( 2 );
	ChangeFormation( 401, 3 );
	Cmd( 3, 401, 0, GetScriptAreaParams( "A1" ) );
	QCmd( 3, 401, 0, GetScriptAreaParams( "A2" ) );
	QCmd( 3, 401, 0, GetScriptAreaParams( "A3" ) );
	QCmd( 3, 401, 0, GetScriptAreaParams( "A4" ) );
	QCmd( 3, 401, 0, GetScriptAreaParams( "A5" ) );
	Wait( 70 + Random( 20 ) );
	StartThread( R_Zona1 );
end;
-------------------------------------2
function R_Zona2()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.R2", 1) ~= 2) and ( GetNUnitsInScriptGroup( 402 ) < 1 ))then
			Wait( 2 );
			StartThread( Rus_inf2 );
			break;
		end;	
	end;
end;

function Rus_inf2()
	LandReinforcementFromMap( 1, "RUS_INF", 2, 402 );  
	Wait( 2 );
	ChangeFormation( 402, 3 );
	Cmd( 3, 402, 0, GetScriptAreaParams( "B1" ) );
	QCmd( 3, 402, 0, GetScriptAreaParams( "B2" ) );
	QCmd( 3, 402, 0, GetScriptAreaParams( "B3" ) );
	Wait( 50 + Random( 20 ) );
	StartThread( R_Zona2 );
end;
----------------------------------------
function R_Amb1()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(521, "X1") > 0)then
			Wait( 5 + Random( 20 ) );
			LandReinforcementFromMap( 1, "RUS_INF", 0, 870 );
			Cmd( 3, 870, 0, GetScriptAreaParams( "BR1" ) );  
			break;
		end;	
	end;
end;

function R_Amb2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(521, "X2") > 0)then
			Wait( 2 );
			LandReinforcementFromMap( 1, "RUS_INF", 3, 871 );
			Cmd( 3, 871, 0, GetScriptAreaParams( "BR2" ) );  
			break;
		end;	
	end;
end;

function R_Amb3()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(521, "X3") > 0)then
			Wait( 5 + Random( 10 ) );
			LandReinforcementFromMap( 1, "RUS_INF", 3, 871 );
			Cmd( 3, 871, 0, GetScriptAreaParams( "X3" ) );  
			break;
		end;	
	end;
end;

----------------------------------------
function Bon()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "BONUS",0) > 0) then
			Wait( 2 );
			Cmd(ACT_LEAVE, 189, 0, 4418, 2990 );
			Cmd(ACT_LEAVE, 188, 0, 4418, 2990 );
			Wait( 3 );
			ChangePlayerForScriptGroup( 189, 0 );
			ChangePlayerForScriptGroup( 188, 0 );
			GiveObjective( 2 );
			CompleteObjective( 2 );
			break;
		end;	
	end;
end;
---------------------------------
function Z_Enter()
	while 1 do
		Wait( 3 );
		if ((GetNScriptUnitsInArea(521, "ZONA_Z") > 0) or (GetNScriptUnitsInArea(522, "ZONA_Z") > 0)) then
			Wait( 3 );
			LandReinforcementFromMap( 1, "T60", 5, 1777 );
			Cmd( 3, 1777, 0, GetScriptAreaParams( "ZONA_Z" ) );  
			break;
		end;	
	end;
end;

-------------------------------DEF!

function Def_1()
	while 1 do
		Wait( 3 );
		if (( GetNUnitsInScriptGroup( 521 ) < 1 ) or ( GetNUnitsInScriptGroup( 522 ) < 1 )) then
			Wait( 1 );
			Win( 1 );
			break;
		end;	
	end;
end;

function Def_2()
    while 1 do
        if (( IsSomePlayerUnit(0) < 1) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) or ( IsReinforcementAvailable( 0 ) == 0 )) ) then
			Wait(3);
			Win(1);
        return 1;
	end;
	Wait(5);
	end;
end;
--------------------------------------DF
function D_L()
	Wait(2);
	if (GetDifficultyLevel() == 0) then
		RemoveScriptGroup(1001);
		RemoveScriptGroup(1002);
	end;
	if (GetDifficultyLevel() == 1) then
		RemoveScriptGroup(1002);
	end;
end;
-------------------------------------------------
StartThread( RevealObjective0 );
StartThread( R_ZONA1 );
StartThread( R_ZONA2 );
StartThread( ZONES );
StartThread( Def_1 );
StartThread( Def_2 );
StartThread( R_Zona1 );
StartThread( R_Zona2 );
StartThread( R_Amb1 );
StartThread( R_Amb2 );
StartThread( R_Amb3 );
StartThread( Bon );
StartThread( D_L );
StartThread( Z_Enter );