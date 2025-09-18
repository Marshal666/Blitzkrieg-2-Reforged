-- us1.2

function assault66()
	Wait(60)
	if (GetNUnitsInScriptGroup(404) >= 1) then
		LandReinforcementFromMap(1, "0", 0, 66)
		Wait(5)
		Cmd(ACT_SWARM, 66, 10, 1054, 1260);
		Wait(1)
		assaultalive_check66();
	else
		Trace("howitzers are destroyed so no assault here");
		return 1;
	end;
end

function assault77()
	Wait(60)
	if (GetNUnitsInScriptGroup(101) == 1) then
		LandReinforcementFromMap(1, "0", 1, 77)
		Wait(5)
--		Cmd(ACT_SWARM, 77, 10, 2013, 4641);
 		Cmd(ACT_ENTER, 77, 101); 
		Wait(1)
		assaultalive_check77()
	else
		Trace("building is destroyed so no assault here");
		return 1;
	end;
end

function assault88()
	Wait(60)
	if (GetNUnitsInScriptGroup(102) == 1) then
		LandReinforcementFromMap(1, "0", 2, 88)
		Wait(5)
--		Cmd(ACT_SWARM, 88, 10, 6730, 3844);
 		Cmd(ACT_ENTER, 88, 102); --used for proper
		Wait(1)
		assaultalive_check88()
	else
		Trace("building is destroyed so no assault here");
		return 1;
	end;
end

function assault99()
	Wait(60)
	if (GetNUnitsInScriptGroup(103) == 1) then
		LandReinforcementFromMap(1, "0", 3, 99)
		Wait(5)
--		Cmd(ACT_SWARM, 99, 10, 6302, 1566);
 		Cmd(ACT_ENTER, 99, 103); --used for proper
		Wait(1)
		assaultalive_check99()
	else
		Trace("building is destroyed so no assault here");
		return 1;
	end;
end


function assaultalive_check66()
	Wait(1)
	while 1 do
		if GetNUnitsInScriptGroup(66) < 1 then assault66();
		Trace("calling help66");
		Wait (5);
		return 1;
		end
	Wait(1);
	end;
end

function assaultalive_check77()
	Wait(1)
	while 1 do
		if GetNUnitsInScriptGroup(77) < 1 then assault77()
		Trace("calling help77");
		Wait (5);
		return 1;
		end
	Wait(1);
	end;
end

function assaultalive_check88()
	Wait(1)
	while 1 do
		if GetNUnitsInScriptGroup(88) < 1 then assault88()
		Trace("calling help88");
		Wait (5);
		return 1;
		end
	Wait(1);
	end;
end

function assaultalive_check99()
	Wait(1)
	while 1 do
		if GetNUnitsInScriptGroup(99) < 1 then assault99()
		Trace("calling help99");
		Wait (5);
		return 1;
		end
	Wait(1);
	end;
end

function capturecheck ()
local k=0
Wait(2)
	while k<=3 do
--		if (GetNScriptUnitsInArea(77,"base1",0) >= 1) or (GetNScriptUnitsInArea(88,"base2",0) >= 1) or (GetNScriptUnitsInArea(99,"base3",0) >= 1) or (GetNScriptUnitsInArea(66,"howitzer",0) >= 1) then
		if (IsUnitNearScriptObject(1,101,20) >= 1) or (IsUnitNearScriptObject(1,102,20) >= 1) or (IsUnitNearScriptObject(1,103,20) >= 1) then
		k=k+1;
		else
		k=0
		Wait(20);
		end;
	end;
	FailObjective(0);
	Loose (0);
	return 1;
end

function capturecheck2 ()
local k=0
Wait(2)
	while k<=3 do
		if (GetNScriptUnitsInArea(66,"howitzer",0) >= 1) then
		k=k+1;
		else
		k=0
		Wait(20);
		end;
	end;
	FailObjective(1);
	Loose (0);
	return 1;
end

function destroy()
	a = 0
	while 1 do
--		if (GetNUnitsInScriptGroup(101) == 0) and (GetNUnitsInScriptGroup(404) == 0) then 
		if (GetNUnitsInScriptGroup(101) == 0) and (GetNUnitsInScriptGroup(102) == 0) and (GetNUnitsInScriptGroup(103) == 0) then 	
			CompleteObjective(0);
			Wait(1);
			a = 1
			return 1;
		end;
	Wait(1);
	end;
	return 1;
end

function destroy2()
	b = 0
	while 1 do
		if (GetNUnitsInScriptGroup(404) == 0) then 	
			CompleteObjective(1);
			Wait(1);
			b = 1
			return 1;
		end;
	Wait(1);
	end;
	return 1;
end

function wincheck()
	while 1 do
		if a == 1 and b == 1 then
			Win(0);
			Wait(1);
		end
	Wait(1);
	end
end

GiveObjective( 0 )
GiveObjective( 1 )
StartThread( capturecheck )
StartThread( capturecheck2 )
StartThread( destroy )
StartThread( destroy2 )
StartThread( assaultalive_check66 )
StartThread( assaultalive_check77 )
StartThread( assaultalive_check88 )
StartThread( assaultalive_check99 )
StartThread( wincheck )
