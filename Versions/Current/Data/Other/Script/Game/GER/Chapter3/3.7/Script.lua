
reinf = {"t-34","BT", "t-70", "infantry", "spg", "infT-34"};
reinf.n = 6;

area = { "church", "lenin", "vokzal", "halupa" };
area.n = 4;
area_state = { 1, 1, 1, 0 };
area_state.n = 4;
i=0;
j=0;
z=0;


function ReinfChurch()
	while 1 do
	Wait(3);
		if (area_state[1] == 1) then
			Wait(60 + Random(90));
			Trace("Church Reinforcements available");
			reinfName = reinf[Random(6)];
			Trace(reinfName);
			LandReinforcementFromMap(1,reinfName,0,(100 + i));
			Cmd(ACT_SWARM, 100+i, 600, 767, 1505);
			i = i+1;
		end;
	end;
end;

function ReinfLenin()
	while 1 do
	Wait(3);
		if (area_state[2] == 1) then
			Wait(60 + Random(90));
			Trace("Lenin Reinforcements available");
			reinfName = reinf[Random(6)];
			Trace(reinfName);
			LandReinforcementFromMap(1,reinfName,1,(300 + j));
			Cmd(ACT_SWARM, 300+j, 600, 767, 1505);
			j = j+1;
		end;
	end;
end;

function ReinfVokzal()
	while 1 do
	Wait(3);
		if (area_state[3] == 1) then
			Wait(60 + Random(90));
			Trace("Vokzal Reinforcements available");
			reinfName = reinf[Random(6)];
			Trace(reinfName);
			Wait ( 1 );
			GiveObjective ( 1 );
			LandReinforcementFromMap(1,reinfName,2,(500 + z));
			Cmd(ACT_SWARM, 500+z, 600, 767, 1505);
			z = z+1;
		end;
	end;
end;

function AreaManager()
	for i = 1, area_state.n do
		StartThread( AreaState, i );
	end;
end;

function AreaState( n )
local k=0;
	while 1 do
		if area_state[n] == 1 then
			while k < 3 do
			 if IsSomeUnitInArea ( 0, area[n], 0 ) == 1 and IsSomeUnitInArea ( 1, area[n], 0 ) == 0 then
				k = k + 1;
			 else
				k = 0;
			 end;
			 Wait(5);
			end;
			area_state[n] = 0; 
			Trace("area_state[%g]=%g - our", n, area_state[n] );
		else
			while k < 3 do
			 if IsSomeUnitInArea ( 1, area[n], 0 ) == 1 and IsSomeUnitInArea ( 0, area[n], 0 ) == 0 then
				k = k + 1;
			 else
				k = 0;
			 end;
			 Wait(5);
			end;
			area_state[n] = 1; -- 1 = area failed
			Trace("area_state[%g]=%g - enemy", n, area_state[n] );
		end;
		k = 0;
		Wait( 2 );
	end;
end;
-----------------------------------------------------WinCheck
function win()
	while 1 do
        if (area_state[1] == 0 and area_state[2] == 0 and area_state[3] == 0 and area_state[4] == 0) then
            Wait(3);
			Trace("ura");
			CompleteObjective ( 1 );
			Win( 0 );
			return 1;
		end	
		Wait( 2 );
	end;
end;
-----------------------------------------------------LooseCheck

function beda()
	while 1 do
        if ( (GetNUnitsInParty ( 0 ) < 1 and GetReinforcementCallsLeft(0) < 1) or area_state[4] == 1) then
            Wait(3);
			Trace("Beda");
			Win( 1 );
			return 1;
		end	
		Wait( 2 );
	end;
end;

----------------------------------------------------------Main
GiveObjective ( 0 );
StartThread(win);
StartThread(beda);
StartThread(AreaManager);
StartThread(ReinfChurch);
StartThread(ReinfLenin);
StartThread(ReinfVokzal);
