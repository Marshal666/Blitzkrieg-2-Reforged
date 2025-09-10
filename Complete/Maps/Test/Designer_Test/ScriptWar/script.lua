function flag()
local who_first;
local k;

while 1 do
	k=0;
	who_first = 2;
	
	while who_first == 2 do
		if ( GetNUnitsInArea ( 0, "FlagArea", 0)>0 ) then
			who_first = 0;
		elseif ( GetNUnitsInArea ( 1, "FlagArea", 0)>0 ) then
			who_first = 1;
		end;
		
		Wait(1);	
	end;

	if who_first == 0 then
		while k<3 or who_first ~=2 do
		 if ( GetNUnitsInArea ( 0, "FlagArea", 0)>0 ) and ( GetNUnitsInArea ( 1, "FlagArea", 0 )<=0 ) then
			k=k+1;
			Trace("FlagAreaNeutral");
		 else
			k=0;
			who_first = 2;
		 end;
		 Wait(10);
		end;
		if who_first ~= 2 then
			Trace("Player 0 won!!!");
			Win(0);
			return 1;
		end;
	end;
	if who_first == 1 then
		while k<3 or who_first ~=2 do
		 if ( GetNUnitsInArea ( 1, "FlagArea", 0)>0 ) and ( GetNUnitsInArea ( 0, "FlagArea", 0 )<=0 ) then
			k=k+1;
		Trace("FlagAreaNeutral");
		 else
			k=0;
			who_first = 2;
		 end;
		 Wait(10);
		end;
		if who_first ~= 2 then
			Trace("Player 1 won!!!");
			Win(1);
			return 1;
		end;
	end;
Wait(1);
end;
end;

StartThread( flag );
