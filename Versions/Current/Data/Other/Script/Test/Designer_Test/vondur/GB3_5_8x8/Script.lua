
--3.5

SetIGlobalVar("temp.trucks_won",0)

function tanks()
	Cmd(ACT_ENTRENCH, 88, 0, 0);
	return 1;
end

function snipers()
	Cmd(ACT_AMBUSH, 77, 0, 0);
	return 1;
end

function attack_column()
	Cmd(3, 10, 50, 2580, 4455)
	Wait(20)
	Cmd(3, 50, 50, 2580, 4455)
	Wait(1)
	return 1;
end

--LandReinforcementFromMap( nPlayer, nReinfIndex, nPosition, nScriptID

function attack_column2()
	Wait(120);
	Trace("swarming evil squad");
--	LandReinforcement( 1, 1069, 0, 1000);
        LandReinforcementFromMap( 1, "0", 0, 1000 );
	Cmd(ACT_SWARM, 1000, 50, 2580, 4455);
	
	Wait(120);

	Trace("swarming evil squad number 2");
--	LandReinforcement( 1, 1069, 1, 2000);
        LandReinforcementFromMap( 1, "0", 1, 2000 );
	Cmd(ACT_SWARM, 2000, 50, 5189, 1478);

	Wait(1)
	return 1;
end

function airshow()
        while 1 do
                Wait(80)
        	Trace("planes...");
--        	LandReinforcement(2, 259, 0, 555)
                LandReinforcementFromMap( 2, "0", 0, 555 );
        	Cmd(ACT_SWARM, 555, 50, 4202, 4141)
        	Wait(15)
--        	LandReinforcement(1, 686, 2, 333)
                LandReinforcementFromMap( 1, "2", 2, 333 );
        	Cmd(ACT_SWARM, 333, 50, 4202, 4141)
        end
        Wait(1)
end

function chase()
        while 1 do
                Wait(120)
                Trace("starting chase...")
                LandReinforcementFromMap( 1, "3", 3, 666 );  
                Wait(1);      
                Cmd(ACT_SWARM, 666, 50, 2372, 3643);
                Wait(30)
                Cmd(ACT_SWARM, 666, 50, 4109, 1998);
                Wait(1)
        end
end

function tank_patrol()
        while 1 do
                Wait (30)
                Trace("start patroling...")
                Cmd(ACT_SWARM, 1000, 99, 3221, 4949);
                Wait (30)
                Cmd(ACT_SWARM, 1000, 99, 276, 5750);
                Wait (30)
        end
end

function entering_village()
        local w = 0
	while 1 do
		if GetNScriptUnitsInArea(222, "village") >=2 then
			Wait (5);
			Trace("we are saved!!!");
			CompleteObjective( 0 );
			Win(0);
                        SetIGlobalVar("temp.trucks_won",1)
			return 1;	
		end;
		Wait(3);
	end
end



function failing_trucks()
	while 1 do
		if GetNUnitsInScriptGroup(222, 0) < 3 then 
                        if (GetIGlobalVar("temp.trucks_won",1) ~= 1) then
			FailObjective( 0 );
			Loose (0);
                        else
                        Trace ("bleh...");
                        Wait(1);
                        end
			Trace( "trucks...%g",GetNUnitsInScriptGroup(222, 0));
			return 1;
		end
		Wait(3);
	end
end

function WinCheck()
	while 1 do
		if ((GetNUnitsInParty(1) < 1) and (IsReinforcementAvailable(0) == 0)) then 
			Win(0);
			return 1;
		end;
		Wait(5);
	end;
end;


function LoseCheck()
        while 1 do
            if (( GetNUnitsInParty(0) < 1) and (IsReinforcementAvailable(0) == 0)) then
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
StartThread( LoseCheck );
StartThread( WinCheck );
StartThread( attack_column );
StartThread( attack_column2);
StartThread( entering_village );
StartThread( failing_trucks );
StartThread( airshow );
StartThread( chase );
StartThread( tank_patrol );

