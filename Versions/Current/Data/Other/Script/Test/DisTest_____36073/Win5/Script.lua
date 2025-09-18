function RandomLight()
local state = 0;
	while 1 do
		state = 1 - state;
		SwitchSquadLightFX( 999, state );
		Sleep( 5 + Random( 20 ) );
	end;
end;

function Light1()
	while 1 do
		for i = 600, 608 do
			SwitchSquadLightFX( i, 1 );
			Sleep( 3 );
			SwitchSquadLightFX( i, 0 );
		end;
	end;
end;

function Gun()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInScriptGroup( 678, 0 ) == 1 ) then
			DamageScriptObject( 678, 0 );
			break;
		end;
	end;
end;

StartThread( Light1 );
StartThread( RandomLight );
StartThread( Gun );
