sid = 19000;
max_hps = {};
for i = 1111, 1113 do
	max_hps[i] = GetScriptObjectHPs( i );
end;

function Objective0()
	Wait( 3 );
	if ((IsSomeUnitInArea(0, "ART", 0) == 1) and (IsSomeUnitInArea(1, "ART", 0) == 0)) then
		CompleteObjective( 0 );
		DamageScriptObject( 3001, 0 );
		Wait( 3 );
		GiveObjective( 1 );
		ViewZone( "obj2", 1 );
		Wait( 1 );
		DamageScriptObject( 3002, 10 );
		ViewZone( "obj2", 0 );
		return 1;
	end;
end;

function Objective1()
	Wait( 3 );
	if ( (IsSomeUnitInArea(0, "B2", 0) + IsSomeUnitInArea(2, "B2", 0)) > 0 )
		and ( IsSomeUnitInArea(1, "B2", 0) < 1 ) then
		CompleteObjective( 1 );
		DamageScriptObject( 3002, 0 );
		Wait( 3 );
		GiveObjective( 2 );
		GiveObjective( 3 );
		ViewZone( "obj3", 1 );
		ViewZone( "obj4", 1 );
		Wait( 1 );
		DamageScriptObject( 3003, 10 );
		DamageScriptObject( 3004, 10 );
		ViewZone( "obj3", 0 );
		ViewZone( "obj4", 0 );
		return 1;
	end;	
end;

function Objective2()
	Wait( 3 );
	if ((IsSomeUnitInArea(0, "AIRF", 0) > 0) and (IsSomeUnitInArea(1, "AIRF", 0) < 1)) then
		CompleteObjective( 2 );
		DamageScriptObject( 3003, 0 );
		return 1;
	end;	
end;

function Objective3()
	Wait( 3 );
	if (((IsSomeUnitInArea(0, "PORT", 0) + IsSomeUnitInArea(2, "PORT", 0)) > 0) 
		and (IsSomeUnitInArea(1, "PORT", 0) < 1)) then
		CompleteObjective( 3 );
		DamageScriptObject( 3004, 0 );
		return 1;
	end;
end;

function Winners()
	while 1 do
		Wait( 3 );
		if (( GetObjectiveState( 2 ) == 2) and (GetObjectiveState( 3 ) == 2)) then
			Wait( 2 );
			Win( 0 );
			break;
		end;	
	end;
end;

function Defead()
    while 1 do
    	Wait( 3 );
        if (( IsSomePlayerUnit(0) == 0) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			return 1;
		end;
	end;
end;

function BridgeHealing()
	while 1 do
		Sleep( 10 );
		for i = 1111, 1113 do
			if ( GetScriptObjectHPs( i ) < (max_hps[i] - 1) ) then
				DamageScriptObject( i, GetScriptObjectHPs( i ) - max_hps[i] );
			end;
		end;
	end;
end;

function DescentManager()
local reinfs;
local cnt = 0;
	Wait( 10 + RandomInt( 5 ) );
	while ( GetObjectiveState( 1 ) ~= 2 ) do
		if ( GetNUnitsInPlayerUF( 2 ) <= 10 ) then
			for i = 0, 2 do
				Wait( Random( 3 ) );
				if ( Random( 10 ) == 1 ) then
					reinfs = "tanks";
				else
					reinfs = "inf";
				end;
				StartThread( Descent1, reinfs, i );
			end;
			cnt = cnt + 2;
		end;
		Wait( 30 + RandomInt( 10 ) + cnt );
	end;
	
	for i = 20000, sid + 1000 do
		if ( IsSomeBodyAlive( 2, i ) == 1 ) then
			Wait( 2 + RandomInt( 3 ) );
			Cmd( ACT_SWARM, i, 300, "rally" );
			QCmd( ACT_SWARM, i, 500, "PORT" );
		end;
	end;
	
	Wait( 120 + Random( 10 ) );
	
	while ( GetObjectiveState( 3 ) ~= 2 ) do
		if ( GetNUnitsInPlayerUF( 2 ) <= 10 ) then
			if ( Random( 10 ) <= 3 ) then
				reinfs = "tanks";
			else
				reinfs = "inf";
			end;
			StartThread( Descent2, reinfs, RandomInt( 3 ) );
		end;
		Wait( 80 + RandomInt( 10 ) );
	end;
end;

function Descent1( reinf, pt )
	sid = sid + 1
	LandReinforcementFromMap( 2, "ship", pt, sid );
	Cmd( ACT_MOVE, sid, 0, "des"..pt );
	QCmd( ACT_MOVE, sid, 0, "ship"..pt );
	QCmd( ACT_DISAPPEAR, sid );
	WaitForGroupAtArea( sid, "des"..pt );
	local sid1 = sid + 1000;
	LandReinforcementFromMap( 2, reinf, pt + 3, sid1 );
	CmdMultipleDisp( ACT_SWARM, sid1, 500, "at"..(pt+1).."_1" );
	for i = 2, 3 do
		QCmdMultipleDisp( ACT_SWARM, sid1, 500, "at"..(pt+1).."_"..i );
	end;
end;

function Descent2( reinf, pt )
	sid = sid + 1
	LandReinforcementFromMap( 2, "ship", pt, sid );
	Cmd( ACT_MOVE, sid, 0, "des"..pt );
	QCmd( ACT_MOVE, sid, 0, "ship"..pt );
	QCmd( ACT_DISAPPEAR, sid );
	WaitForGroupAtArea( sid, "des"..pt );
	local sid1 = sid + 1000;
	LandReinforcementFromMap( 2, reinf, pt + 3, sid1 );
	CmdMultipleDisp( ACT_SWARM, sid1, 500, "rally" );
	QCmdMultipleDisp( ACT_SWARM, sid1, 500, "PORT" );
end;

function Reinf1_check()
	if ( IsSomeBodyAlive( 1, 601 ) == 0 ) then
		return 1;
	end;
end;

function Reinf1()
	LandReinforcementFromMap( 1, "inf", 0, 1200 );
	CmdMultipleDisp( ACT_SWARM, 1200, 600, "ART" );
	Wait( 1 );
	ChangeFormation( 1200, 3 );
	Wait( 90 );
	LandReinforcementFromMap( 0, "tanks", 3, 900 );
	Wait( 1 );
	local x, y = GetScriptObjCoordMedium( 900 );
	y = y + 2000;
	Cmd( ACT_SWARM, 900, 300, x, y );
	Wait( 3 );
	LandReinforcementFromMap( 0, "inf", 3, 800 );
	Cmd( ACT_SWARM, 800, 300, x, y );
	Wait( 4 );
	LandReinforcementFromMap( 0, "inf", 3, 850 );
	Cmd( ACT_SWARM, 850, 200, x - 1000, y );
end;

function Aircombat()
planes = 70000;
planes1 = 71000;
	while (GetObjectiveState( 2 ) ~= 2) do
		planes = planes + 1;
		planes1 = planes1 + 1;
		Wait( 60 + Random( 30 ) );
		LandReinforcementFromMap( 1, "gaps", 0, planes );
		pt = Random(2);
		if ( pt == 1 ) then
			Cmd( ACT_SWARM, planes, 500, "des1" );
		else
			Cmd( ACT_SWARM, planes, 500, "ART" );
		end;
		Wait( 10 + Random( 10 ) );
		LandReinforcementFromMap( 2, "fighters", RandomInt( 3 ), planes1 );
		if ( pt == 1 ) then
			Cmd( ACT_SWARM, planes1, 500, "des1" );
		else
			Cmd( ACT_SWARM, planes1, 500, "ART" );
		end;
	end;
end;

function AIReinfCalls()
__difficulty = GetDifficultyLevel();
	while 1 do
		if ( GetObjectiveState( 0 ) == 2 ) then
			Wait( 90 - __difficulty * 25 );
		else
			Wait( 150 - __difficulty * 30 );
		end;
		GiveReinforcementCalls( 1, 1 );
	end;
end;

-------------------------------------------------MAIN

Objectives = { Objective0, Objective1, Objective2, Objective3 };
GiveObjective( 0 );
StartAllObjectives( Objectives, 4 );
StartThread( Winners );
StartThread( Defead );
StartThread( BridgeHealing );
StartThread( DescentManager );
StartThread( Aircombat );
Trigger( Reinf1_check, Reinf1 );
StartThread( AIReinfCalls );