--
function LooseCheck( _objectives_count_ )
	Objectives_Count = Objectives_Count or _objectives_count_;
	missionend = missionend or 0;
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( ( IsSomePlayerUnit( 0 ) == 0 ) and ( ( GetReinforcementCallsLeft( 0 ) == 0 )
			or ( IsReinforcementAvailable( 0 ) == 0 ) ) ) then
			missionend = 1;
			Wait( 3 );
			Win( 1 );
			return
		end;
		if Objectives_Count ~= nil then
		for u = 0, Objectives_Count - 1 do
			if ( GetIGlobalVar( "temp.objective." .. u, 0 ) == 3 ) then
				missionend = 1;
				Wait( 3 );
				Win( 1 ); -- player looses
				return
			end;
		end;
		end;
	end;
end;

function WinCheck( _objectives_count_ )
local obj;
	Objectives_Count = Objectives_Count or _objectives_count_;
	missionend = missionend or 0;
	while ( missionend == 0 ) do
		obj = 1;
		Wait( 2 );
		for u = 0, Objectives_Count - 1 do
			if ( GetIGlobalVar( "temp.objective." .. u, 0 ) ~= 2 ) then
				obj = 0;
				break;
			end;
		end;
		if ( obj == 1 ) then
			missionend = 1;
			Wait( 3 );
			Win( 0 ); -- player wins
			return
		end
	end;
end;
--
Trace( "Win / Loose checks loaded" );