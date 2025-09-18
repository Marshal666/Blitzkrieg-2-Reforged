missionend = 0;

function Objective0()
	if ( IsSomeBodyAlive( 501, 0 ) ~= 0 ) then
		CompleteObjective( 0 );
		return 1;
	end;
end;

function Objective1()
	if ( IsSomeBodyAlive( 502, 0 ) ~= 0 ) then
		CompleteObjective( 1 );
		return 1;
	end;
end;

function Objective2()
	if ( IsSomeBodyAlive( 503, 0 ) ~= 0 ) then
		CompleteObjective( 2 );
		return 1;
	end;
end;

function Objective3()
	if ( IsSomeBodyAlive( 504, 0 ) ~= 0 ) then
		CompleteObjective( 3 );
		return 1;
	end;
end;

function Objective4()
	if ( IsSomeBodyAlive( 505, 0 ) ~= 0 ) then
		CompleteObjective( 4 );
		return 1;
	end;
end;

function Objective5()
	if ( IsSomeBodyAlive( 506, 0 ) ~= 0 ) then
		CompleteObjective( 5 );
		return 1;
	end;
end;

----------------------------------
Objectives = { Objective0, Objective1, Objective2, Objective3, Objective4 };
Objectives_Count = 5;

StartAllObjectives( Objectives, Objectives_Count );

Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );


