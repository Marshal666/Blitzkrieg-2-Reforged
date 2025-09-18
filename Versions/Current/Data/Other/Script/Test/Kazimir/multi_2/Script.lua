function Begin_p_0()
	while 1 do
		Wait( 3 + Random (10));
		if ( GetNUnitsInArea(0,"1", 0) > 0) then
			Wait( 3 );
			LandReinforcement (0,1278,0,1);
			Cmd ( 3, 1 , 0, GetScriptAreaParams ("2")); 
			LandReinforcement (0,1272,0,2);
			Cmd ( 3, 2 , 0, GetScriptAreaParams ("2")); 
			LandReinforcement (0,1280,0,3);
			Cmd ( 3, 3 , 0, GetScriptAreaParams ("6")); 
			LandReinforcement (0,1280,0,4);
			Cmd ( 3, 4 , 0, GetScriptAreaParams ("6")); 
			Wait( 10 + Random (20));
		end;
	end;
end;

function Begin_2_p_0()
	while 1 do
		Wait( 3 + Random (30))
		if ( GetNUnitsInArea(0,"1", 0) > 0) then
			Wait( 3 );
			LandReinforcement (0,1278,0,5);
			Cmd ( 3, 5 , 0, GetScriptAreaParams ("6")); 
			LandReinforcement (0,1272,0,6);
			Cmd ( 3, 6 , 0, GetScriptAreaParams ("6")); 
			LandReinforcement (0,1280,0,7);
			Cmd ( 3, 7 , 0, GetScriptAreaParams ("2")); 
			LandReinforcement (0,1280,0,8);
			Cmd ( 3, 8 , 0, GetScriptAreaParams ("2")); 
			Wait( 10 + Random (20));
		end;
	end;
end;
	
function Stage_1_p_0()
	while 1 do
		Wait( 3 + Random (20))
		if ( GetNUnitsInArea(0,"1", 0) > 0) then
				if ( GetNUnitsInArea(0,"2", 0) > 0) then
					if ( GetNUnitsInArea(0,"6", 0) > 0) then
						Wait( 3 );
						LandReinforcement (0,1278,0,9);
						Cmd ( 3, 9 , 0, GetScriptAreaParams ("5")); 
						LandReinforcement (0,1272,0,10);
						Cmd ( 3, 10 , 0, GetScriptAreaParams ("3")); 
						LandReinforcement (0,1280,0,11);
						Cmd ( 3, 11 , 0, GetScriptAreaParams ("3")); 
						LandReinforcement (0,1280,0,12);
						Cmd ( 3, 12 , 0, GetScriptAreaParams ("5")); 
						Wait( 30);
					end;	
				end;
			end;
		end;
	end;
end;	
	
function Stage_2_p_0()
	while 1 do
		Wait( 3 + Random (30))
		if ( GetNUnitsInArea(0,"1", 0) > 0) then
			if ( GetNUnitsInArea(0,"2", 0) > 0) then
				if ( GetNUnitsInArea(0,"3", 0) > 0) then
					if ( GetNUnitsInArea(0,"5", 0) > 0) then
						if ( GetNUnitsInArea(0,"6", 0) > 0) then
							Wait( 3 );
							LandReinforcement (0,1278,0,13);
							Cmd ( 3, 13 , 0, GetScriptAreaParams ("4")); 
							LandReinforcement (0,1272,0,14);
							Cmd ( 3, 14 , 0, GetScriptAreaParams ("4")); 
							LandReinforcement (0,1280,0,15);
							Cmd ( 3, 15 , 0, GetScriptAreaParams ("4")); 
							LandReinforcement (0,1280,0,16);
							Cmd ( 3, 16 , 0, GetScriptAreaParams ("4")); 
							Wait( 30);
						end;
					end;
				end;	
			end;
		end;
	end;
end;

function End_p_0()
	while 1 do
		Wait( 3 + Random (30))
		if ( GetNUnitsInArea(0,"1", 0) = 0) then
			if ( GetNUnitsInArea(0,"2", 0) = 0) then
				if ( GetNUnitsInArea(0,"3", 0) = 0) then
					if ( GetNUnitsInArea(0,"4", 0) = 0) then
						if ( GetNUnitsInArea(0,"5", 0) = 0) then
							if ( GetNUnitsInArea(0,"6", 0) = 0) then
								
								
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;


StartThread( Begin_p_0 );
StartThread( Begin_2_p_0 );
