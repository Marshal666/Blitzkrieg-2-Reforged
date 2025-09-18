

function Rand_Tanks()
local x = RandomInt(2);
	if x == 0 then
	StartThread( T1 );
	end;
	if x == 1 then
	StartThread( T2 );
	end;
end;

function T1()
	Wait( 2 );
	LandReinforcementFromMap( 0, "T1", 0, 308 ); 
end;

function T2()
	Wait( 2 );
	LandReinforcementFromMap( 0, "T2", 1, 309 ); 
end;

StartThread( Rand_Tanks );