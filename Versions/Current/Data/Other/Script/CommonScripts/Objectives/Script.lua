function CompleteObjective( objnum )
	ObjectiveChanged( objnum, 2 );
	SetIGlobalVar( "temp.objective." .. objnum, 2 );
end;

function FailObjective( objnum )
	ObjectiveChanged( objnum, 3 );
	SetIGlobalVar( "temp.objective." .. objnum, 3 );
end;

function GiveObjective( objnum )
	if ( GetIGlobalVar( "temp.objective." .. objnum, 0 ) == 0 ) then
		ObjectiveChanged( objnum, 1 );
		SetIGlobalVar( "temp.objective." .. objnum, 1 );
	end;
end;

function ObjectiveFunctionPrototype( checkfunc )
	while ( 1 ) do
		Wait( 2 );
		if ( checkfunc() ~= nil ) then break end;
	end;
end;

function StartAllObjectives( objective_checks, number_of_checks )
	for i = 1, number_of_checks do
		StartThread( ObjectiveFunctionPrototype, objective_checks[ i ] );
	end;
end;
--
Trace( "Objectives functions loaded" );