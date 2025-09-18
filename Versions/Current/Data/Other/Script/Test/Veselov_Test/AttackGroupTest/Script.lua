--AttackGroupCreate( 1 );
--AttackGroupAddUnit( 1, 1, -1 );
--AttackGroupStartAttack( 1, 4000,4000, 2000 );
function Bomb()
	LandReinforcementFromMap( 1, "Bomb", 0, 111 );
	GiveCommand( 16, 111, 0, 1000,1000 );
	LandReinforcementFromMap( 0, "Fighter1", 0, 112 );
end;