
function AreaReinf()
	if ( IsSomeUnitInArea( 0, "area1", 0 ) == 1 ) then
		LandReinforcementFromMap( 0, "r1", 0, -1 );
		return 1;
	end;
	if ( IsSomeUnitInArea( 1, "area1", 0 ) == 1 ) then
		LandReinforcementFromMap( 1, "r1", 0, -1 );
		return 1;
	end;
end;

function GiveGun()
	if ( IsSomeUnitInArea( 0, "area2", 0 ) == 1 ) then
		ChangePlayerForScriptGroup( 1, 0 );
		return 1;
	end;
	if ( IsSomeUnitInArea( 1, "area2", 0 ) == 1 ) then
		ChangePlayerForScriptGroup( 1, 1 );
		return 1;
	end;
end;

--DamageScriptObject( 10, -21000 );

--StartCycled( AreaReinf );
--StartCycled( GiveGun );