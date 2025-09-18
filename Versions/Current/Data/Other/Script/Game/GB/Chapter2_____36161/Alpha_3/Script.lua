DISPERSION = 200;

function RevealObjective0()
    --DisplayTrace("StartMission");
    Wait(3);
	ObjectiveChanged(0, 1);
	ObjectiveChanged(1, 1);
end;

function Obj1()
	while 1 do
	if ( GetNUnitsInArea( 1, "GBOutpost", 0 ) > 0 ) and ( ( GetNUnitsInArea( 0, "GBOutpost", 0 ) + 
		GetNUnitsInArea( 2, "GBOutpost", 0 ) ) == 0 ) then
		ObjectiveChanged( 0, 3 );
		Loose();
		return 1;
	end;
	Wait( 2 );
	end;
end;

function Obj2()
	while 1 do
	if ( GetNUnitsInArea( 1, "GBOutpost2", 0 ) > 0 ) and ( ( GetNUnitsInArea( 0, "GBOutpost2", 0 ) + 
		GetNUnitsInArea( 2, "GBOutpost2", 0 ) ) == 0 ) then
		ObjectiveChanged( 1, 3 );
		Loose();
		return 1;
	end;
	Wait( 2 );
	end;
end;

function LooseCheck()
	if ( GetNUnitsInPlayerUF( 0 ) == 0 ) and ( ( IsReinforcementAvailable( 0 ) == 0 ) or 
		( GetReinforcementCallsLeft( 0 ) == 0 ) ) then
		return 1;
	end;
end;

function Loose()
	Wait( 3 );
	Win( 1 );
end;

function WinCheck()
	if ( GetNUnitsInScriptGroup( 5005 ) <= 0 ) then
		return 1;
	end;
end;

function Win1()
	ObjectiveChanged( 0, 2 );
	ObjectiveChanged( 1, 2 );
	Wait( 3 );
	--SetIGlobalVar( "nogeneral_script" , 0 );
	Win( 0 );
end;

-------------------//Waves//--------------

function Attacks()
local Reinfs = { 0, 1, 2 };
local ReinfScriptId;
	Wait( 15 );
	for ReinfScriptId = 5001, 5005 do
		Wait( RandomInt( 20 ) + 80 );
		Point = RandomInt( 2 );
		LandReinforcementFromMap( 1, Reinfs[ Random( 3 ) ], Point, ReinfScriptId );
		Wait( 1 );
		if ( Point == 0 ) then
			Cmd( ACT_SWARM, ReinfScriptId, DISPERSION, GetScriptAreaParams( "P11" ) );
			QCmd( ACT_SWARM, ReinfScriptId, DISPERSION, GetScriptAreaParams( "P12" ) );
			QCmdMultipleDisp( ACT_SWARM, ReinfScriptId, 600, GetScriptAreaParams( "GBOutpost" ) );
		else
			Cmd( ACT_SWARM, ReinfScriptId, DISPERSION, GetScriptAreaParams( "P21" ) );
			QCmd( ACT_SWARM, ReinfScriptId, DISPERSION, GetScriptAreaParams( "P22" ) );
			if ( RandomInt( 2 ) == 0 ) then
				QCmd( ACT_SWARM, ReinfScriptId, DISPERSION, GetScriptAreaParams( "P23" ) );
				QCmdMultipleDisp( ACT_SWARM, ReinfScriptId, 600, GetScriptAreaParams( "GBOutpost" ) );
			else
				QCmdMultipleDisp( ACT_SWARM, ReinfScriptId, 600, GetScriptAreaParams( "GBOutpost2" ) );
			end;
		end;
	end;
	Trigger( WinCheck, Win1 );
end;

-----
function KeyBuilding_Flag()
local tmpold = { 0, 0 };
local tmp;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, 2 do
		if ( ( GetNUnitsInScriptGroup( i + 500, 0 ) + 
			GetNUnitsInScriptGroup( i + 500, 2 ) ) == 1 ) then
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
-----

function CheckPresence()
	while ( GetNUnitsInArea( 0, "GBOutpost", 0 ) == 0 ) do
		Wait( 2 );
	end;
	ChangePlayerForScriptGroup( 7000, 0 );
end;

---------------------//ST//---------------------------
--SetIGlobalVar( "nogeneral_script" , 1 );
StartThread( RevealObjective0 );
StartThread( Obj1 );
StartThread( Obj2 );
Trigger( LooseCheck, Loose );
StartThread( Attacks );

StartThread( CheckPresence );
StartThread( KeyBuilding_Flag );
