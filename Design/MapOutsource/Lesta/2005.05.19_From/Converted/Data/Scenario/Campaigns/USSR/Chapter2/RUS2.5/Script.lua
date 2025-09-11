function move0()
	Wait( 5 );
	StartThread( Reinf );
	LandReinforcementFromMap( 2, 'ship', 0, 114 );
	Wait( 1 );	
	Cmd( ACT_MOVE, 114, 512, GetScriptAreaParams( "a1" ) );
	Wait( 8 );
	LandReinforcementFromMap( 2, 'ship', 0, 115 );
	Wait( 1 );
	Cmd( ACT_MOVE, 115, 512, GetScriptAreaParams( "a1" ) );
	Wait( 8 );
	LandReinforcementFromMap( 2, 'ship', 0, 116 );
	Wait( 1 );
	Cmd( ACT_MOVE, 116, 512, GetScriptAreaParams( "a1" ) );
	Wait( 80 );
	StartThread( Reinf );
	Wait( 10 );
	StartThread( move1 );
	return 1;
end;


function move1()
	LandReinforcementFromMap( 2, 'ship', 0, 117 );
	Wait( 1 );	
	Cmd( ACT_MOVE, 117, 512, GetScriptAreaParams( "a1" ) );
	Wait( 8 );
	LandReinforcementFromMap( 2, 'ship', 0, 118 );
	Wait( 1 );
	Cmd( ACT_MOVE, 118, 512, GetScriptAreaParams( "a1" ) );
	Wait( 8 );
	LandReinforcementFromMap( 2, 'ship', 0, 119 );
	Wait( 1 );
	Cmd( ACT_MOVE, 119, 512, GetScriptAreaParams( "a1" ) );
	Wait( 80 );
	StartThread( Reinf );
	Wait( 10 )
	StartThread( move2 );
	return 1;
end;


function move2()
	LandReinforcementFromMap( 2, 'ship', 0, 120 );
	Wait( 1 );	
	Cmd( ACT_MOVE, 120, 512, GetScriptAreaParams( "a1" ) );
	Wait( 8 );
	LandReinforcementFromMap( 2, 'ship', 0, 121 );
	Wait( 1 );
	Cmd( ACT_MOVE, 121, 512, GetScriptAreaParams( "a1" ) );
	Wait( 8 );
	LandReinforcementFromMap( 2, 'ship', 0, 122 );
	Wait( 1 );
	Cmd( ACT_MOVE, 122, 512, GetScriptAreaParams( "a1" ) );
	Wait( 10 );
	StartThread( gameover );
	return 1;
end;
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function zd0()
		Wait( 1000 );
	while 1 do
	if ( GetNUnitsInArea( 0, "g1", 0 ) > 0 and
		GetNUnitsInArea( 1, "g1", 1 ) < 1) then
		 Wait( 1 );  		
		CompleteObjective( 0 );
		 Wait( 1 );  		
		SetIGlobalVar("temp.rus1_2.objective.0", 1);
	break;
    end;
    end;
end

---------------------------------------------------------------------------------
function ext()
		Wait( 3 );
	while 1 do
			Wait( 3 );
		if ( GetNScriptUnitsInArea ( 114, 'ext', 0 ) > 0) then
			RemoveScriptGroup ( 114 );
			SetIGlobalVar("temp.114.1", 1);
		end;  
		
		if ( GetNScriptUnitsInArea ( 115, 'ext', 0 ) > 0) then
		    RemoveScriptGroup ( 115 );
			SetIGlobalVar("temp.115.1", 1);
		end;  
		
		if ( GetNScriptUnitsInArea ( 116, 'ext', 0 ) > 0) then
		    RemoveScriptGroup ( 116 );
			SetIGlobalVar("temp.116.1", 1);
		end;  
		
		if ( GetNScriptUnitsInArea ( 117, 'ext', 0 ) > 0) then
		    RemoveScriptGroup ( 117 );
			SetIGlobalVar("temp.117.1", 1);
		end;  
		
		if ( GetNScriptUnitsInArea ( 118, 'ext', 0 ) > 0) then
			RemoveScriptGroup ( 118 );
			SetIGlobalVar("temp.118.1", 1);
		end;  
		
		if ( GetNScriptUnitsInArea ( 119, 'ext', 0 ) > 0) then
			RemoveScriptGroup ( 119 );
			SetIGlobalVar("temp.119.1", 1);
		end;  

		if ( GetNScriptUnitsInArea ( 120, 'ext', 0 ) > 0) then
			RemoveScriptGroup ( 120 );
			SetIGlobalVar("temp.120.1", 1);
		end;  

		if ( GetNScriptUnitsInArea ( 121, 'ext', 0 ) > 0) then
			RemoveScriptGroup ( 121 );
			SetIGlobalVar("temp.121.1", 1);
		end;  

		if ( GetNScriptUnitsInArea ( 122, 'ext', 0 ) > 0) then
			RemoveScriptGroup ( 122 );
			SetIGlobalVar("temp.122.1", 1);

		end;  
    end;            
end;
---------------------------------------------------------------------------------
function victory()
	while 1 do
		Wait( 3 );
	if ( GetIGlobalVar("temp.114.1", 0) +
 		GetIGlobalVar("temp.115.1", 0) +
 		GetIGlobalVar("temp.116.1", 0) +
 		GetIGlobalVar("temp.117.1", 0) +
 		GetIGlobalVar("temp.118.1", 0) +
 		GetIGlobalVar("temp.119.1", 0) +
 		GetIGlobalVar("temp.120.1", 0) +
 		GetIGlobalVar("temp.121.1", 0) +
		GetIGlobalVar("temp.122.1", 0) > 4) then
		Wait( 1 );
		CompleteObjective( 0 );
		Wait( 3 );
		Win(0);
		break;
	end;
	end;
end;

function gameover()
		Wait( 120 );
	while 1 do
		Wait( 3 );
	if ( GetIGlobalVar("temp.114.1", 0) +
 		GetIGlobalVar("temp.115.1", 0) +
 		GetIGlobalVar("temp.116.1", 0) +
 		GetIGlobalVar("temp.117.1", 0) +
 		GetIGlobalVar("temp.118.1", 0) +
 		GetIGlobalVar("temp.119.1", 0) +
 		GetIGlobalVar("temp.120.1", 0) +
 		GetIGlobalVar("temp.121.1", 0) +
		GetIGlobalVar("temp.122.1", 0) < 5) then
		Wait( 1 );
		Win(1);
		break;
	end;
	end;
end;
---------------------------------------------------------------------------------
function Unlucky()
	while 1 do
		Wait( 3 );
        if (GetNUnitsInParty(0) < 1 and 
		GetReinforcementCallsLeft( 0 ) == 0) then
		    Wait( 1 );
			Win(1);
			break;
		end;
	end;
end;
---------------------------------------------------------------------------------
function user()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup ( 114 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 114 )
		end;
		
		if ( GetNUnitsInScriptGroup ( 115 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 115 )
		end;
		
		if ( GetNUnitsInScriptGroup ( 116 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 116 )
		end;
		
		if ( GetNUnitsInScriptGroup ( 117 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 117 )
		end;
		
		if ( GetNUnitsInScriptGroup ( 118 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 118 )
		end;
		
		if ( GetNUnitsInScriptGroup ( 119 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 119 )
		end;
		
		if ( GetNUnitsInScriptGroup ( 120 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 120 )
		end;
		
		if ( GetNUnitsInScriptGroup ( 121 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 121 )
		end;
		
		if ( GetNUnitsInScriptGroup ( 122 ) > 0) then
		xe1, ye1 = GetScriptObjCoord ( 122 )
		end;
		
		ye2 = ye1 - 500
		
		Cmd ( ACT_SWARM, 125 , 512, xe1, ye2 )
		Cmd ( ACT_SWARM, 126 , 512, xe1, ye2 )
		Cmd ( ACT_SWARM, 127 , 512, xe1, ye2 )
		Cmd ( ACT_SWARM, 128 , 512, xe1, ye2 )
		Cmd ( ACT_SWARM, 129 , 512, xe1, ye2 )
	end;
end;

function Reinf()
			Wait( 3 );
		LandReinforcementFromMap( 1, 'junkers_ju87g', 1, 126 );	
		LandReinforcementFromMap( 1, 'schnellboot', 0, 125 );
		LandReinforcementFromMap( 1, 'schnellboot', 2, 129 );
			Wait( 60 );
		LandReinforcementFromMap( 1, 'messer_bf_109_g', 1, 127 );			
			Wait( 60 );
		LandReinforcementFromMap( 1, 'he_111_heinkel', 1, 128 );
		LandReinforcementFromMap( 1, 'schnellboot', 2, 129 );
		LandReinforcementFromMap( 1, 'schnellboot', 0, 125 );
			Wait( 10 );
		LandReinforcementFromMap( 1, 'junkers_ju87g', 2, 126 );
			Wait( 30 );
		LandReinforcementFromMap( 1, 'messer_bf_109_g', 2, 127 );
		LandReinforcementFromMap( 1, 'schnellboot', 2, 129 );			
		return 1;
end;
-----------------------------------------------------------------------------
Objectives = { victory};
Objectives_Count = 1;

StartAllObjectives( Objectives, Objectives_Count );
Wait( 1 );
GiveObjective( 0 );
---------------------------------------------------------------------------------
StartThread( user );
StartThread( move0 );
StartThread( ext );
StartThread( victory );
StartThread( Unlucky );