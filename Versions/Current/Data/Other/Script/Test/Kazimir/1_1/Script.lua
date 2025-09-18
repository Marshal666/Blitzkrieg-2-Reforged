function Check()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInArea(0,"1_1", 0) > 0) then
			Wait( 3 );
			LandReinforcementFromMap (1,"Plane",0,1);
			Cmd (ACT_MOVE, 1 , 0, GetScriptAreaParams ("AA")); 
			LandReinforcementFromMap (1,"Plane",1,2);
			Cmd (ACT_MOVE, 2 , 0, GetScriptAreaParams ("AA")); 
			Wait( 30);
			
		end;
	end;
end;

StartThread( Check );