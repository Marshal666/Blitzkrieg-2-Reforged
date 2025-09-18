--------------------------------------------------------SeaPatrol
function SeaPatrol()
	Wait( 5 );
	while 1 do
		Wait (2);
		QCmd(ACT_SWARM, 150, 15, 2438, 3587);
		Wait( 15 );
		QCmd(ACT_SWARM, 150, 15, 4584, 5294);
		Wait( 15 );
		QCmd(ACT_SWARM, 150, 15, 2438, 3587);
		Wait( 15 );
	end;
end;