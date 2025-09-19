missionend = 0;
given0 = 0;
given1 = 0;
given2 = 0;

function ForceGiveObjective( obj )
	ObjectiveChanged( obj, 1 );
	SetIGlobalVar( __objective_global_name .. obj, 1 );
end;

function Objective0()
	if ( given0 == 1 ) and ( IsSomeBodyAlive( 0, 501 ) ~= 0 ) then
		CompleteObjective( 0 );
		given0 = 0;
	end;
	if ( given0 == 0 ) and ( IsSomeBodyAlive( 1, 501 ) ~= 0 ) then
		ForceGiveObjective( 0 );
		given0 = 1;
	end;
end;

function Objective1()
	if ( given1 == 1 ) and ( IsSomeBodyAlive( 0, 502 ) ~= 0 ) then
		CompleteObjective( 1 );
		given1 = 0;
	end;
	if ( given1 == 0 ) and ( IsSomeBodyAlive( 1, 502 ) ~= 0 ) then
		ForceGiveObjective( 1 );
		given1 = 1;
	end;
end;

function Objective2()
	if ( given2 == 1 ) and ( IsSomeBodyAlive( 0, 503 ) ~= 0 ) then
		CompleteObjective( 2 );
		given2 = 0;
	end;
	if ( given2 == 0 ) and ( IsSomeBodyAlive( 1, 503 ) ~= 0 ) then
		ForceGiveObjective( 2 );
		given2 = 1;
	end;
end;

function SecretObj()
	if ( IsSomeBodyAlive( 1, 801 ) == 0 ) then
		CompleteObjective( 3 );
		return 1;
	end;
end;

--
objectives = { Objective0, Objective1, Objective2 };
StartAllObjectives( objectives, 3 );

--StartThread( Reinf_Manager );
StartCycled( SecretObj );
StartThread( LooseCheck, 3 );
StartThread( WinCheck, 3 );