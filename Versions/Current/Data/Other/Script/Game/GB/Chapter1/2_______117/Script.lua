missionend = 0;
escaped_units = 0;

function Patrol1()
local pt = 1;
	while ( IsSomeBodyAlive( 1, 100 ) > 0 ) do
		if ( pt > 5 ) then
			pt = 1;
		end;
		Cmd( ACT_SWARM, 100, 192, GetScriptAreaParams( "P" .. pt ) );
		WaitForGroupAtArea( 100, "P" .. pt );
		Wait( Random( 5 ) );
		pt = pt + 1;
	end;
end;

function Objective0()
	if ( IsSomeBodyAlive( 1, 1 ) == 0 ) and ( escaped_units <= 2 ) then
		CompleteObjective( 0 );
		missionend = 1;
		Wait( 3 );
		Win( 0 );
		return 1;
    end;
end;

function LooseCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( ( IsSomeUnitInParty( 0 ) <= 0 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) ) 
		or ( escaped_units > 2 ) then
			missionend = 1;
			Wait( 3 );
			Win( 1 );
			return
		end;
	end;
end;

function CheckAttack()
	if ( GetNUnitsInScriptGroup( 1, 1 ) < 6 ) or ( GetNUnitsInScriptGroup( 5 ) < 2 ) then
		return 1;
	end;
end;

function Attack()
local units = {};
local trucks = {};
local passanger;
local stats;
local j = -1;
	StartThread( EscortHelp );
	units = GetObjectListArray( 1 );
	trucks = GetUnitsByParam( units, PT_CLASS, CLASS_APC );
	for i = 1, trucks.n do
		passanger = GetPassangers( trucks[i], 1 );
		if ( passanger ~= nil ) then
			stats = GetUnitRPGStatsArray( passanger );
			if ( stats.Class == CLASS_MAIN_SQUAD ) then
				j = i;
				break;
			end;
		end;
	end;
	if ( j < 0 ) then 
		return 0;
	end;
	UnitCmd( ACT_STOP, trucks[j] );
	Sleep( 10 );
	UnitCmd( ACT_UNLOAD, trucks[j], 0, ObjectGetCoord( trucks[j] ) );
	Wait( 1 );
	UnitCmd( ACT_MOVE, trucks[j], 0, GetScriptAreaParams( "A10" ) );
	ChangeFormation( 1, 3 );
	Wait( 1 );
	UnitCmd( ACT_SWARM, passanger, 0, GetScriptAreaParams( "A10" ) );
end;

function EscortHelp()
	Wait( Random( 10 ) );
	Cmd( ACT_SWARM, 2, 256, GetScriptObjCoordMedium( 1 ) );
	Cmd( ACT_LEAVE, 3, 0, GetScriptAreaParams( "P5" ) );
	Wait( 2 );
	Cmd( ACT_SWARM, 3, 256, GetScriptObjCoordMedium( 1 ) );
end;

function EscortCheck()
	if ( ( IsSomeUnitInArea( 0, "Zone1" ) + IsSomeUnitInArea( 0, "Zone2" ) ) > 0 ) then
		return 1;
	end;
end;

function Escort()
local truckunits = {};
local tankunits = {};
local units = {};
local afvunits = {};
local len1;
local k = 0;
local link = {};
	units = GetObjectListArray( 1 );
	guns = GetObjectListArray( 5 );
	tankunits = GetUnitsByParam( units, PT_CLASS, CLASS_LIGHT_TANK );
	afvunits = GetUnitsByParam( units, PT_CLASS, CLASS_AFV );
	Trace( "afvunits = %g", afvunits.n );
	tankunits = ConcatArray( tankunits, afvunits );
	Trace( "tankunits = %g", tankunits.n );
	truckunits = GetUnitsByParam( units, PT_CLASS, CLASS_APC );
	
	-- CRAP
	for i = 1, truckunits.n do
		if ( GetUnitsByParam( GetPassangersArray( truckunits[i], 1 ), PT_CLASS, CLASS_SPECIAL_SQUAD ).n > 0 ) then
			x, y = ObjectGetCoord( truckunits[ i ] );
			len1 = 1000;
			for j = 1, guns.n do
				x1, y1 = ObjectGetCoord( guns[ j ] );
				len2 = len( x1 - x, y1 - y );
				if ( len2 < len1 ) then
					k = j;
					len1 = len2;
				end;
			end;
			link[ truckunits[ i ] ] = guns[ k ];
		end;
	end;
	-- END OF CRAP
	
	CmdArray( ACT_SWARM, tankunits, GetScriptAreaParams( "A1" ) );
	CmdArray( ACT_MOVE, truckunits, GetScriptAreaParams( "A1" ) );
	for i = 2, 10 do
		QCmdArray( ACT_SWARM, tankunits, GetScriptAreaParams( "A" .. i ) );
		QCmdArray( ACT_MOVE, truckunits, GetScriptAreaParams( "A" .. i ) );
	end;
	--QCmdArray( ACT_DISAPPEAR, tankunits );
	--QCmdArray( ACT_DISAPPEAR, truckunits );
	--Trigger( CheckAttack, Attack );
	Trigger( CheckAttack, EscortHelp );
	while ( IsSomeBodyAlive( 1, 1 ) > 0 ) do
		Wait( 2 );
		for cnt = 1, units.n do
		if ( IsAlive( units[cnt] ) > 0 ) then
		if ( IsUnitInArea( 1, "A10", units[cnt] ) == 1 ) then
			UnitRemove( units[cnt] );
			if link[ units[cnt] ] then
				UnitRemove( link[ units[cnt] ] );
			end;
			escaped_units = escaped_units + 1;
		end;
		end;
		end;
	end;
end;

Objectives = { Objective0 };
Objectives_Count = 1;

StartAllObjectives( Objectives, Objectives_Count );
Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( Patrol1 );
Trigger( EscortCheck, Escort );
