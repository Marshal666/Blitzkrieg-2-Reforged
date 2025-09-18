--4.4

function tanks()
	Cmd(ACT_ENTRENCH, 88, 0, 0);
	return 1;
end


function Attack_1()
	
-- first wave	
	
	LandReinforcementFromMap( 1, "1088", 0, 1000 );
	Wait(1);
	LandReinforcementFromMap( 1, "1088", 1, 2000 );
	Wait( 3 );
	LandReinforcementFromMap( 1, "1088", 2, 3000 );
	Wait( 3 );	
	Cmd( ACT_SWARM, 1000, 50, 4500, 2200 );
	Wait( 5 );
	Cmd( ACT_SWARM, 2000, 50, 4500, 2200 );
	Wait( 5 );
	Cmd( ACT_SWARM, 3000, 50, 4500, 2200 );
	Wait( 150 );
end
	
-- third wave	
function Attack_3()

--	Wait( 130 );
	LandReinforcementFromMap( 1, "1088", 0, 1000 );
	Wait(1);
	LandReinforcementFromMap( 1, "1088", 1, 2000 );
	Wait( 3 );
	LandReinforcementFromMap( 1, "1088", 2, 3000 );
	Wait( 3 );	
	Cmd( ACT_SWARM, 1000, 50, 4500, 2200 );
	Wait( 5 );
	Cmd( ACT_SWARM, 2000, 50, 4500, 2200 );
	Wait( 5 );
	Cmd( ACT_SWARM, 3000, 50, 4500, 2200 );	

	Wait(50);
	Trace("end of reinfs");
	
	Wait(10);
	Trace("entering church");
	Cmd( ACT_ENTER, 1000, 501 );
	Cmd( ACT_ENTER, 2000, 501 );
	Cmd( ACT_ENTER, 3000, 501 );

end	


function war()
	Trace("attack 1")
	Attack_1()
	Wait(1)
	Trace("attack 2")
	Attack_1()
	Wait(1)
	Trace("attack 3")
	Attack_3()
	Wait(1)
	Trace("wincheck")
	WinCheck()
end


function hq_captured ()
	if GetNUnitsInScriptGroup(501, 1) > 0 then
		return 1;
	end;	
end

function hq_captured_timer()
local k=0
	while k<=2 do
		if (GetNUnitsInScriptGroup(501, 1) > 0) then
            k=k+1;
		else
			k=0
			Wait(10);
			Trace("counting...k=%g",k);
		end;
	end;
	FailObjective ( 0 );
	Loose (0);
	return 1;
end

function WinCheck()
	Wait(5)
	while 1 do
		if ((IsSomeUnitInParty(1) < 1) and (IsReinforcementAvailable(1) == 0)) then 
		CompleteObjective( 0 );
		Win(0);
		return 1;		
		end;
	Wait(5);
	end;
end;


function LoseCheck()
	Wait(5)
        while 1 do
            if (( IsSomeUnitInParty(0) < 1) and (GetObjectHPs(501) < 1)) then
            FailObjective( 0 );    
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

function KeyBuilding_Flag()
local tmpold = { 0, 1 };
local tmp;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, 1 do
		if ( GetNUnitsInScriptGroup( i + 500, 0 ) == 1 ) then
			tmp = 0;
		elseif ( GetNUnitsInScriptGroup( i + 500, 1 ) == 1 ) then
			tmp = 1;
		end;
		if ( tmp ~= tmpold[i] ) then
			if ( tmp == 0 ) then
				SetScriptObjectHPs( 700 + i, 50 );
			else
				SetScriptObjectHPs( 700 + i, 100 );
			end;
			tmpold[i] = tmp;
		end;
	end;
	end;
end;

-- main

GiveObjective ( 0 )

StartThread( tanks );
--StartThread( Attack_1 );
StartThread( LoseCheck );
--StartThread( WinCheck );
StartThread( war );
Trigger(hq_captured, hq_captured_timer)
StartThread( KeyBuilding_Flag );
	