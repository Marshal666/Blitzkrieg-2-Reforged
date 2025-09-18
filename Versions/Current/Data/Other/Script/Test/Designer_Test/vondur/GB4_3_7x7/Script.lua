

function tanks()
	Cmd(ACT_ENTRENCH, 88, 0, 0);
	Cmd(ACT_ENTRENCH, 77, 0, 0);
--	Cmd(ACT_SPYGLASS, 999, 50, 1679, 3929)
--	Cmd(ACT_SPYGLASS, 888, 50, 5179, 3415)
	return 1;
end

function Attack_1()
	
-- first wave	
	
	LandReinforcementFromMap( 1, "1087", 0, 1000 );
	Wait(1);
	ChangeFormation( 1000, 1 );
	Wait(1);
	LandReinforcementFromMap( 1, "1087", 1, 2000 );
	Wait(1);
	ChangeFormation( 2000, 1 );
	Wait( 3 );
	Cmd( ACT_SWARM, 1000, 50, 5865, 1502 );
	Wait( 5 );
	Cmd( ACT_SWARM, 2000, 50, 1709, 1948 );

-- second wave	

	Wait( 100 );	
	LandReinforcementFromMap( 1, "1087", 0, 1000 );
	Wait(1);
	LandReinforcementFromMap( 1, "1087", 1, 2000 );
	Wait( 10 );
	Cmd( ACT_SWARM, 1000, 50, 5865, 1502 );
	Wait( 5 );
	Cmd( ACT_SWARM, 2000, 50, 1709, 1948 );
	
-- third wave	

	Wait( 120 );	
	LandReinforcementFromMap( 1, "1087", 0, 1001 );
	Wait(1);
	--ChangeFormation( 1001, 1);
	Wait(1);
	LandReinforcementFromMap( 1, "1087", 1, 2001 );
	Wait( 3 );
	Cmd( ACT_SWARM, 1001, 50, 5865, 1502 );
	Wait( 15 );
	Cmd( ACT_SWARM, 2001, 50, 1709, 1948 );

	Wait(10);
	Trace("we re done with reinfs...");

end;


function bridges_destroyed()
	if ((IsSomeBodyAlive( 0, 20 ) <= 0) and (IsSomeBodyAlive( 0, 21 ) <= 0)) then
		Trace("bridges_destroyed");
		return 1;
	end; 
end;	

function failed_bridges_obj()
	FailObjective ( 0 );
	Wait( 3 );
	Loose( 0 );
	return 1;
end;


function bridges_captured()
local k=0;
	while k<=2 do
        if ((IsUnitNearScriptObject ( 1, 20, 500 )==1) or (IsUnitNearScriptObject ( 1, 21, 500 )==1)) then
            k=k+1;
        else
            k=0;
        end;
         Wait(3);
         Trace("counting...k=%g",k);
    end;
    Trace("bridges_captured");
    return 1;
end;


function fail()
	Loose( 0 );
end;


function WinCheck()
	Wait(5);
	while 1 do
		if (GetNUnitsInParty(1) <= 4)  then 
			CompleteObjective( 0 );
			Win(0);
			return 1;
		end;
		Wait(10);
	end;
end;


function LoseCheck()
	Wait(5);
        while 1 do
            if (( IsSomeUnitInParty(0) < 1) and (IsReinforcementAvailable(0) == 0)) then
				FailObjective ( 0 ); 
                Loose(0);
			return 1;
			end;
		Wait(5);
		end;
end;

function info()
	Trace("units in party 0..%g",GetNUnitsInParty(0))
	Trace("units in party 1..%g",GetNUnitsInParty(1))
end


-- main

GiveObjective( 0 )

StartThread( tanks );
StartThread( Attack_1 );
StartThread( LoseCheck );
StartThread( WinCheck );
Trigger( bridges_captured, failed_bridges_obj );
Trigger( bridges_destroyed, failed_bridges_obj );

