units = {};

units2 = {};

units = GetUnitListInAreaArray(0, "aaa");

Wait( 30 );

units2 = GetUnitListInAreaArray(0, "aaa");



function Swarm( sid, ... )

	if ( arg.n == 2 ) then

		Cmd( ACT_SWARM, sid, 0, arg[1], arg[2] );

	elseif ( arg.n > 2 ) then

		Cmd( ACT_SWARM, sid, arg[1], arg[2], arg[3] );

	end;

end;



function SwarmArea( sid, area )

	if ( arg.n == 2 ) then

		Cmd( ACT_SWARM, sid, 0, arg[1], arg[2] );

	elseif ( arg.n > 2 ) then

		Cmd( ACT_SWARM, sid, arg[1], arg[2], arg[3] );

	end;

end;



function CmdArea( action, sid, disp, area )



	Cmd( action, sid, disp, GetScriptAreaParams( area ) );

end;