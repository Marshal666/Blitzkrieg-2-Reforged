a = 0;
b = 0;

function obj1()
	if ( a == 1 ) then
		Trace( "a" );
		return 1;
	end;
end;

function obj2()
	if ( b == 1 ) then
		Trace( "b" );
		return 1;
	end;
end;

function aa()
	a = 1;
end;

function bb()
	b = 1;
end;

objectives = { obj1, obj2 };

StartAllObjectives( objectives, 2 );