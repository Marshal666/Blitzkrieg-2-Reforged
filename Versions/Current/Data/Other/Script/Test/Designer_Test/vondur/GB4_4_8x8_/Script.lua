

function hq_captured ()
	if GetNUnitsInScriptGroup(100, 1) > 0 then
		return 1;
	end;
end

function hq_captured_timer()
	local k=0
		while k<=2 do
			k = k + 1
			Wait(10)
			Trace("counting...",k)
		end;
	FailObjective ( 0 );
	Loose (0);
	return 1
end

function hq_failed()
	Loose ( 0 );
end;

function entering_town()
	Cmd(3, 10, 50, 4500, 2200)
	Wait(1)
	Cmd(3, 20, 50, 4500, 2200)
	Wait(1)
	Cmd(3, 30, 50, 4500, 2200)
	Wait(1)
	return 1;
end

function in_the_town()
	if GetNUnitsNearScriptObj(1, 200, 500) > 1 then 
		return 1;
	end;
end;

function attack_hq()
-- south group attacking church	
	Cmd(6, 10, 100)
	Wait(1)
-- west group attacking church		
	Cmd(6, 20, 100)
	Wait(1)
-- north group attacking church		
	Cmd(6, 30, 100)
	Wait(1)	
	return 1
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


-- main

StartThread( LoseCheck );
StartThread( WinCheck );
StartThread (entering_town)
Trigger (in_the_town, attack_hq)
Trigger(hq_captured, hq_captured_timer)
	