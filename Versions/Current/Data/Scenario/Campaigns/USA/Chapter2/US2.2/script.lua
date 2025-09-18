--------------------------------------Artillery fire1 

function Start ()
    
    while 1 do
     Wait (3)
     Cmd( ACT_SUPPRESS, 160, 400, 4170, 2271 );
     Cmd( ACT_SUPPRESS, 161, 400, 4170, 2271 );
     Cmd( ACT_SUPPRESS, 162, 400, 4170, 2271 );
     Cmd( ACT_SUPPRESS, 163, 400, 4170, 2271 );
     Cmd( ACT_SUPPRESS, 164, 400, 4170, 2271 );
     Cmd( ACT_SUPPRESS, 165, 400, 4170, 2271 );
     Wait (20)
     Cmd (ACT_STOP, 160);
     Cmd (ACT_STOP, 161);
     Cmd (ACT_STOP, 162);
     Cmd (ACT_STOP, 163);
     Cmd (ACT_STOP, 164);
     Cmd (ACT_STOP, 165);
     break;
    end;
end;

 
function ArtAction160() 
	local x = 3490; 
	local y = 4310; 
	Wait( 25 ); 
		while y > 2600 do  
			Cmd( ACT_SUPPRESS, 160, 500, x, y ); 
			Wait( 35 ); 
			y = y - 100; 
				if (GetNUnitsInScriptGroup ( 160, 0 )==1) then 
				QCmd (ACT_STOP, 160); 
				return 1 
				end; 
		end; 
	Trace("Kannon1Complete"); 
	Cmd( ACT_STOP, 160 ); 
end; 
 
-----------------------------------------------Artillery fire2 
 
function ArtAction161() 
	local x = 3900; 
	local y = 4150; 
		Wait( 25 ); 
	while y > 2800 do  
		Cmd( ACT_SUPPRESS, 161, 500, x, y ); 
		Wait( 20 ); 
		y = y - 100; 
			if (GetNUnitsInScriptGroup ( 161, 0 )==1) then 
			QCmd (ACT_STOP, 161); 
			return 1 
			end; 
	end; 
	Trace("Kannon2Complete"); 
	Cmd( ACT_STOP, 161 ); 
end; 
 
-----------------------------------------------Artillery fire3 
 
function ArtAction162() 
	local x = 4040; 
	local y = 4226; 
		Wait( 25 ); 
	while y > 2800 do  
		Cmd( ACT_SUPPRESS, 162, 5, x, y ); 
		Wait( 25 ); 
		y = y - 100; 
			if (GetNUnitsInScriptGroup ( 162, 0 )==1) then 
			QCmd (ACT_STOP, 162); 
			return 1 
			end; 
	end; 
	Trace("Kannon3Complete"); 
	Cmd( ACT_STOP, 162 ); 
end; 
 
-----------------------------------------------Artillery fire4 
 
function ArtAction163() 
	local x = 4550; 
	local y = 3888; 
		Wait( 25 ); 
	while x > 2500 do  
		Cmd( ACT_SUPPRESS, 163, 5, x, y ); 
		Wait( 35 ); 
		y = y - 100; 
			if (GetNUnitsInScriptGroup ( 163, 0 )==1) then 
			QCmd (ACT_STOP, 163); 
			return 1 
			end; 
	end; 
	Trace("Kannon4Complete"); 
	Cmd( ACT_STOP, 163 ); 
end; 
-----------------------------------------------Patrol1 
function Patrol1() 
	Wait( 5 ); 
	while 1 do 
			QCmd(ACT_SWARM, 200, 0, 3736, 2544); 
			Wait( 2 ); 
			QCmd(ACT_SWARM, 200, 0, 4020, 4000); 
			Wait( 2 ); 
			QCmd(ACT_SWARM, 200, 0, 3525, 2285); 
			Wait( 2 ); 
			QCmd(ACT_SWARM, 200, 0, 4020, 1500); 
			Wait( 5 ); 
		if ( GetNUnitsInScriptGroup( 200 ) <= 0 ) then 
			Trace("Patrol1_Defeated") 
			Wait(2) 
			return 1; 
		end; 
	end; 
end; 
 
-----------------------------------------------Patrol2 
function Patrol2() 
	Wait( 5 ); 
	while 1 do 
			QCmd(ACT_SWARM, 201, 0, 1675, 5024); 
			Wait( 2 ); 
			QCmd(ACT_SWARM, 201, 0, 2666, 5294); 
			Wait( 2 ); 
			QCmd(ACT_SWARM, 201, 0, 3100, 3818); 
			Wait( 3 ); 
			QCmd(ACT_SWARM, 201, 0, 1460, 4475); 
			Wait( 3 ); 
			QCmd(ACT_SWARM, 201, 0, 1120, 3888); 
			Wait( 3 ); 
		if ( GetNUnitsInScriptGroup( 201 ) <= 0 ) then 
			Trace("Patrol2_Defeated") 
			Wait(2) 
			return 1; 
		end; 
	end; 
end; 
 
-----------------------------------------------Bomber Strike 
function Bomb_Strike() 
	while 1 do 
		if ( GetNUnitsInScriptGroup( 102 ) <= 0 ) and ( GetNUnitsInScriptGroup( 104 ) <= 0 ) then 
			Wait (3) 
			LandReinforcementFromMap (1, "bomber", 0, 1001 ); 
			Wait (15); 
			Trace("Bombimg_srike"); 
		end; 
	Wait (180); 
	end; 
end; 
-----------------------------------------------Air Strike 
function Air_Strike() 
	while 1 do 
		if ( GetNUnitsInScriptGroup( 102 ) <= 0 ) and ( GetNUnitsInScriptGroup( 104 ) <= 0 ) then 
			Wait (3); 
			LandReinforcementFromMap (1, "fighter", 1, 1000 ); 
			Wait (3); 
			QCmd (ACT_SWARM, 1000, 999, 4110, 3685 ); 
			Trace("Air_srike"); 
		end; 
	Wait (180); 
	end; 
end; 
-----------------------------------------------Enemies Attack 
 
function Attack_GO() 
	while 1 do 
		if (GetNUnitsInArea (0, "LZ", 0) > 0 ) then 
		Wait ( 2 ); 
		QCmd(ACT_SWARM, 104, 500, 4020, 2800); 
		Wait ( 5 ); 
		end; 
	Wait ( 2 ); 
	end; 
end; 
 
function Attack_1_GO() 
	while 1 do 
		if (GetNUnitsInArea (0, "LZ", 0) > 0 ) then 
		Wait ( 2 ); 
		QCmd(ACT_SWARM, 102, 500, 3985, 2790); 
		Wait ( 5 ); 
		end; 
	Wait ( 2 ); 
	end; 
end; 
 
function Attack_2_GO() 
	Wait( 25 ); 
	while 1 do	 
		QCmd(ACT_SWARM, 110, 500, 4360, 5980); 
		Wait (15); 
	end; 
end; 
 
function Attack_3_GO() 
	Wait( 5 ); 
	while 1 do 
		QCmd(ACT_SWARM, 111, 200, 4360, 5980); 
	Wait (5); 
	end 
end; 
 
function Attack_4_GO() 
	while 1 do 
		QCmd(ACT_SWARM, 112, 200, 500, 7240); 
	Wait (5); 
	end 
end; 
 
function Attack_5_GO() 
	while 1 do 
		QCmd(ACT_SWARM, 113, 200, 7602, 6792); 
	Wait (5); 
	end 
end; 
------------------------------------------------------Attack_Wawe2 
function Wawe2() 
	while 1 do 
        if ( GetNUnitsInScriptGroup( 102 ) <= 0 ) and ( GetNUnitsInScriptGroup( 104 ) <= 0 ) then 
            Wait ( 5 ); 
            LandReinforcementFromMap (1, "Tanks", 0, 110); 
            Wait ( 2 ); 
            LandReinforcementFromMap (1, "Infant", 2, 111); 
            Wait ( 2 ); 
			StartThread( Attack_2_GO ); 
			Wait ( 2 ); 
			StartThread( Attack_3_GO ); 
			Wait (2); 
			Trace("Second_Wawe"); 
			return 1; 
		end	 
		Wait( 30 ); 
	end; 
end; 
 
------------------------------------------------------Counter_Attack_Wawe3 
function Wawe3() 
	while 1 do 
        if ( GetNUnitsInArea ( 0, "WZ", 0 ) > 0 ) then 
            Wait ( 2 ); 
            LandReinforcementFromMap (1, "Tanks", 0, 112); 
            Wait ( 1 ); 
			StartThread( Attack_4_GO ); 
			Trace("Third_Wawe"); 
			return 1; 
		end	 
		Wait( 20 ); 
	end; 
end; 
 
------------------------------------------------------Counter_Attack_Wawe3-1 
function Wawe31() 
	while 1 do 
        if ( GetNUnitsInArea ( 0, "WZ2", 0 ) > 0 ) then 
            Wait ( 2 ); 
            LandReinforcementFromMap (1, "Infant", 0, 113); 
            Wait ( 1 ); 
			StartThread( Attack_5_GO ); 
			Trace("Third_Wawe"); 
			return 1; 
		end	 
		Wait( 2 ); 
	end; 
end; 
------------------------------------------------------Defeat 
function LooseCheck() 
	local missionend = 0 
	while ( missionend == 0 ) do 
		Wait( 3 ); 
		if ( GetNUnitsInParty( 0 ) <= 1 ) and ( GetReinforcementCallsLeft( 0 ) <= 0 ) then 
			missionend = 1; 
			Wait( 6 ); 
			Trace( "mission failed" ); 
			Win( 1 ); 
			return 1; 
		end; 
	end; 
end; 
-----------------------------------------------------Guadal 
 
function CompleteObjective0() 
    while 1 do 
        Wait (5) 
        if ( GetNUnitsInScriptGroup( 160, 1 ) == 0  ) and ( GetNUnitsInScriptGroup( 161, 1 ) == 0  )  and 
		( GetNUnitsInScriptGroup( 162, 1 ) == 0  ) and ( GetNUnitsInScriptGroup( 163, 1 ) == 0  ) then 
            Wait ( 3 ); 
			CompleteObjective( 0 ); 
			Wait ( 5 ); 
			return 1; 
		end	 
	end; 
end; 
------------------------------------------------------Guadal1 
function Guadal1() 
	while 1 do 
        if ( GetNUnitsInArea ( 0, "LZ", 0 ) >= 0 ) then 
			Wait (5); 
			GiveObjective (1); 
            Wait ( 15 ); 
            StartThread ( CBEliminated ) 
			return 1; 
		end	 
		Wait( 2 ); 
	end; 
end; 
-------------------------------------------------------CBEliminated 
function CBEliminated() 
	while 1 do 
	    Wait (3)
        if ( GetNUnitsInScriptGroup( 165, 1) < 1 ) then 
            Wait ( 2 ); 
			CompleteObjective( 1 ); 
			Wait ( 2 ); 
			return 1; 
		end	 
	end; 
end; 
------------------------------------------------------Guadal2 
function Guadal2() 
	while 1 do 
        if ( GetIGlobalVar ( "temp.objective.0", 0 ) == 2 ) and ( GetIGlobalVar ( "temp.objective.1", 0 ) == 2 ) then 
            Wait(5); 
			Trace("Win!"); 
			Win( 0 ); 
			return 1; 
		end	 
		Wait( 6 ); 
	end; 
end; 
------------------------------------------------------Main 
GiveObjective( 0 ); 
GiveObjective( 1 ); 
--StartThread(Patrol1); 
--StartThread(Patrol2); 
StartThread( ArtAction160 ); 
StartThread( ArtAction161 ); 
StartThread( ArtAction162 ); 
StartThread( ArtAction163 ); 
--StartThread( Guadal1 ); 
StartThread( Guadal2 ); 
StartThread ( CBEliminated ) 
StartThread( Attack_GO ); 
StartThread( Attack_1_GO ); 
--StartThread( Bomb_Strike ); 
--StartThread( Air_Strike ); 
StartThread( Wawe2 ); 
StartThread( Wawe3 ); 
StartThread( Wawe31 ); 
StartThread( CompleteObjective0 ); 
StartThread( LooseCheck );
StartThread (Start);