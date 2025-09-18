missionend = 0;
ag = 1;
x_rally, y_rally = GetScriptAreaParams( "p5" );
endwave = 0;

function Objective0()
	if ( IsSomeUnitInArea( 0, "p8", 0 ) > 0 ) and ( IsSomeBodyAlive( 1, 10 ) == 0 ) then
		CompleteObjective( 0 );
		return 1;
	end;
	--if ( endwave == 1 ) and ( IsSomeBodyAlive( 1, 10009 ) == 0 ) then
	--	FailObjective( 0 );
	--	return 1;
	--end;
end;

function Attack( reinf, sid )
local units = {};
local x, y, r = GetScriptAreaParams( "attack" );
local width = 1000;
local width_2 = width / 2;
local act, sup;

	if ( reinf == "tanks5" ) then
		pt = 1;
	else
		pt = RandomInt( 2 );
	end;
	
	LandReinforcementFromMap( 1, reinf, pt, sid );
	
	--if ( sid == 10005 ) then
	--	act = ACT_SWARM;
	--else
		act = ACT_MOVE;
	--end;
	
	Cmd( act, sid, 0, GetScriptAreaParams( "p1" ) );
	for i = 2, 5 do
		QCmd( act, sid, 0, GetScriptAreaParams( "p" .. i ) );
	end;
	
	Wait( 1 );
	units = GetObjectListArray( sid );
	
	if ( sid > 10001 ) then --and ( sid ~= 10005 ) then
		sup = units[ Random( units.n ) ];
		UnitCmd( ACT_MOVE, sup, 100, GetScriptAreaParams( "p1" ) );
		UnitQCmd( ACT_MOVE, sup, 100, GetScriptAreaParams( "p2" ) );
		if ( RandomInt( 2 ) == 1 ) then
			UnitQCmd( ACT_MOVE, sup, 100, GetScriptAreaParams( "p3" ) );
		end;
		UnitQCmd( ACT_STAND, sup );
	end;

	Wait( 55 + Random( 5 ) );
	Trace( "after wait" );
	
	units = GetObjectListArray( sid );
	if ( units.n == 0 ) then
		return 0;
	end;
	
	units = DeleteElement( units, sup );
	
	for i = 1, units.n do
		UnitCmd( ACT_MOVE, units[i], 32, x_rally - width_2 + i * width / units.n, y_rally );
	end;
	Wait( 2 );
	WaitWhileStateArray( units, STATE_MOVE );
	Cmd( ACT_ROTATE, sid, 0, GetScriptAreaParams( "p6" ) );
	Wait( 1 );
	WaitWhileStateArray( units, STATE_MOVE );
	Wait( 1 );
	--AttackGroupCreate( ag );
	--AttackGroupAddUnit( ag, sid );
	--AttackGroupStartAttack( ag, x, y, r );
	--AttackGroupDelete( ag );
	--ag = ag + 1;
	Cmd( ACT_SWARM, sid, 0, GetScriptAreaParams( "p6" ) );
	for i = 7, 8 do
		QCmd( ACT_SWARM, sid, 0, GetScriptAreaParams( "p" .. i ) );
	end;
	--if ( IsAlive( sup ) == 1 ) then
	--	UnitCmd( ACT_STAND, sup );
	--end;
end;

function Attacks_Manager()
local sid = 10000;
local reinf = { "tanks2", "tanks3" };

	Wait( 5 + Random( 5 ) );
	StartThread( Attack, "tanks1", sid );
	sid = 10001;
	
	Wait( 70 + Random( 10 ) );
	StartThread( Attack, "tanks2", sid );
	sid = 10002;
	
	Wait( 60 + Random( 10 ) );
	StartThread( Attack, "tanks3", sid );
	sid = 10003;
	
	Wait( 40 + Random( 10 ) );
	StartThread( Attack, "tanks4", sid );
	sid = 10004;
	
	Wait( 20 + Random( 10 ) );
	StartThread( Attack, reinf[ Random( 2 ) ], sid );
	sid = 10005;
	
	StartThread( Bombers );

	Wait( 30 + Random( 10 ) );
	StartThread( Attack, "tanks4", sid );
	sid = 10006;
	
	Wait( 10 + Random( 10 ) );
	StartThread( Attack, reinf[ Random( 2 ) ], sid );
	sid = 10007;
	
	Wait( 15 + Random( 10 ) );
	StartThread( Attack, "tanks4", sid );
	sid = 10008;	

	Wait( 10 + Random( 10 ) );
	StartThread( Attack, reinf[ Random( 2 ) ], sid );
	sid = 10009;

	Wait( 5 + Random( 10 ) );
	StartThread( Attack, "tanks5", sid );
	Wait( 5 );
	endwave = 1;
end;

function Bombers()
local sid = 5000;
	LandReinforcementFromMap( 1, "bombers", 0, sid );
	Cmd( ACT_MOVE, sid, 300, GetScriptAreaParams( "p7" ) );
end;                                                  

----------------------------------
Objectives = { Objective0 };
Objectives_Count = 1;

StartAllObjectives( Objectives, Objectives_Count );

Cmd( ACT_ATTACKOBJECT, 111, 911 );
Wait( 2 );
DamageScriptObject( 111, 30 );
Sleep( 5 );
ChangePlayerForScriptGroup( 111, 3 );
Sleep( 5 );
DamageScriptObject( 111, 30 );
Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );
--StartThread( Attacks_Manager );
