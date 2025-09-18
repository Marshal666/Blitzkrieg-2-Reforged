function P0_1()
	while 1 do
		Wait( 3 );
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
				Wait( 30);
			end;
			
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
			
			if ( GetNUnitsInArea(0,"1", 0) = 0) then
				if ( GetNUnitsInArea(0,"2", 0) = 0) then
					if ( GetNUnitsInArea(0,"3", 0) = 0) then
						if ( GetNUnitsInArea(0,"4", 0) = 0) then
							if ( GetNUnitsInArea(0,"5", 0) = 0) then
								if ( GetNUnitsInArea(0,"6", 0) = 0) then
									break;
								end;
							end;
						end;
					end;
				end;
			end;
			
		end;
	end;
end;

function P1_1()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInArea(1,"4", 0) > 0) then
			Wait( 3 );
			LandReinforcement (1,1278,0,1);
			Cmd ( 3, 1 , 0, GetScriptAreaParams ("3")); 
			LandReinforcement (1,1272,0,2);
			Cmd ( 3, 2 , 0, GetScriptAreaParams ("3")); 
			LandReinforcement (1,1280,0,3);
			Cmd ( 3, 3 , 0, GetScriptAreaParams ("5")); 
			LandReinforcement (1,1280,0,4);
			Cmd ( 3, 4 , 0, GetScriptAreaParams ("5")); 
			Wait( 30);
			
			if ( GetNUnitsInArea(1,"4", 0) > 0) then
				Wait( 3 );
				LandReinforcement (1,1278,0,5);
				Cmd ( 3, 5 , 0, GetScriptAreaParams ("5")); 
				LandReinforcement (1,1272,0,6);
				Cmd ( 3, 6 , 0, GetScriptAreaParams ("5")); 
				LandReinforcement (1,1280,0,7);
				Cmd ( 3, 7 , 0, GetScriptAreaParams ("3")); 
				LandReinforcement (1,1280,0,8);
				Cmd ( 3, 8 , 0, GetScriptAreaParams ("3")); 
				Wait( 30);
			end;
			
			if ( GetNUnitsInArea(1,"4", 0) > 0) then
				if ( GetNUnitsInArea(1,"3", 0) > 0) then
					if ( GetNUnitsInArea(1,"5", 0) > 0) then
						Wait( 3 );
						LandReinforcement (1,1278,0,9);
						Cmd ( 3, 9 , 0, GetScriptAreaParams ("2")); 
						LandReinforcement (1,1272,0,10);
						Cmd ( 3, 10 , 0, GetScriptAreaParams ("6")); 
						LandReinforcement (1,1280,0,11);
						Cmd ( 3, 11 , 0, GetScriptAreaParams ("2")); 
						LandReinforcement (1,1280,0,12);
						Cmd ( 3, 12 , 0, GetScriptAreaParams ("6")); 
						Wait( 30);
					end;	
				end;
			end;
			
			if ( GetNUnitsInArea(1,"4", 0) > 0) then
				if ( GetNUnitsInArea(1,"3", 0) > 0) then
					if ( GetNUnitsInArea(1,"5", 0) > 0) then
						if ( GetNUnitsInArea(1,"2", 0) > 0) then
							if ( GetNUnitsInArea(1,"6", 0) > 0) then
								Wait( 3 );
								LandReinforcement (1,1278,0,13);
								Cmd ( 3, 13 , 0, GetScriptAreaParams ("1")); 
								LandReinforcement (1,1272,0,14);
								Cmd ( 3, 14 , 0, GetScriptAreaParams ("1")); 
								LandReinforcement (1,1280,0,15);
								Cmd ( 3, 15 , 0, GetScriptAreaParams ("1")); 
								LandReinforcement (1,1280,0,16);
								Cmd ( 3, 16 , 0, GetScriptAreaParams ("1")); 
								Wait( 30);
							end;
						end;
					end;	
				end;
			end;
			
		end;
	end;
end;


StartThread( P0_1 );
StartThread( P1_1);