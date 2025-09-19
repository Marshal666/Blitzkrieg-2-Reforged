-- Naming convention:   
-- g_<variable> - global variable
-- l_<variable> - local variable

g_ShootingFlag = 0;
g_TankID = 1;

function Play()

	local l_Delay = 0;	-- Just local var

	local l_Roll0 = 100;	-- Probability of tank running at startup
	local l_Roll2 = 30;	-- Probability of starting the second tank after the first one
	local l_Roll3 = 30;	-- Probability of starting the third tank after the second one
	
	-- Startup camera&render tweaks
	SetFGlobalVar( "camera_near_plane", 3);
	SCStartMovie( 0 );
	ViewZone( "All", 1 );

	-- Moving Tanks out of view to avoid 355K tris on startup.. ;)
	ObjectPlayAnimation( 1, 1 );
	ObjectPlayAnimation( 2, 1 );
	ObjectPlayAnimation( 3, 1 );
	ObjectPlayAnimation( 4, 1 );

	-- Starting Opel on fire & Zundapp "on smoke". Some delay needed just in case.. 
	Wait( 0.1 );
	ObjectPlayAttachedEffect( 0, 0 );
	ObjectPlayAttachedEffect( 0, 1 );

	if D100() < l_Roll0 then

		StartThread( PlayTank );
	end;

	while 1 do

		l_Delay = 30 + Random( 30 );
		Wait( l_Delay );
		StartThread( PlayTank );
		
		if D100() < l_Roll2 then 

			l_Delay = 2 + Random( 5 );
			Wait( l_Delay );
			StartThread( PlayTank );

			if D100() < l_Roll3 then 

				l_Delay = 2 + Random( 5 );
				Wait( l_Delay );
				StartThread( PlayTank );
			end;
		end;
	end;
end;

function PlayTank()

	local l_TankID = g_TankID;

	g_TankID = g_TankID + 1;
	if g_TankID > 4 then

		g_TankID = 1;
	end; 

	ObjectPlayAnimation( l_TankID, 0 );
	ObjectPlayAttachedEffect( l_TankID, 0 );

	StartThread( TankShooting );
	StartThread( PlayTankShot, l_TankID );

	Wait( 18 );
	ObjectStopAttachedEffect( l_TankID, 0 );

end;

function PlayTankShot( ID )
	
	local l_TankID = ID;

	local l_Delay = 0;	-- Just local var
	local l_Roll = 0;	-- Just local var

	local l_RollFarShot = 25;   	-- Probability of a single shot
	local l_RollNearShot = 25;   	-- Probability of a single shot
	local l_RollMegaShot = 1;	-- Probability of a chain-shot
	
	l_Roll = D100();

	if D100() <= l_RollMegaShot then -- Start MEGASHOT


		while g_ShootingFlag == 0 do

			Wait( 1 );
		end;

		while g_ShootingFlag == 1 do

			l_Delay = 0.1 + Random( 10 ) / 10;
			Wait( l_Delay );
			ObjectPlayAttachedEffect( l_TankID, 2 );
		end;

	else

		if D100() < l_RollFarShot then
		
			l_Delay = 3; --1 + Random( 12 );
			Wait( l_Delay );
			ObjectPlayAttachedEffect( l_TankID, 2 );
		end;

		if D100() < l_RollNearShot then
		
			l_Delay = 10; --1 + Random( 12 );
			Wait( l_Delay );
			ObjectPlayAttachedEffect( l_TankID, 2 );
		end;
	end;
end;

function TankShooting()

	g_ShootingFlag = 0;
	Wait(2);
	g_ShootingFlag = 1;
	Wait(12);
	g_ShootingFlag = 0;
end;

function PlayHeat( HeatID )

	local l_Delay = 0;

	Wait(10);

	while 1 do

		l_Delay = 20 + Random( 40 );
		Wait( l_Delay );						
		ObjectPlayAttachedEffect( 0, HeatID );
	end;
end;

function PlayHeats()

	StartThread( PlayHeat, 2);
	StartThread( PlayHeat, 3);
	StartThread( PlayHeat, 4);
end;

function ChangeWeather()

	local l_Delay = 0;
	
	while 1 do
	
		SwitchWeather( 1 );
		l_Delay = 60 + Random( 60 );
		Wait( l_Delay )
		
		SwitchWeather( 0 );
		l_Delay = 10 + Random( 10 );
		Wait( l_Delay )
	end;
end;

function D100()
	
	local l_D100 = 1 + Random( 99 );
	return l_D100;
end;

StartThread( Play );
StartThread( PlayHeats );
StartThread( ChangeWeather );