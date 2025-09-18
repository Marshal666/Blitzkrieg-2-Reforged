DredgeEnemy=1;

function DredgeFlag()
local k=0;
	while 1 do
		if DredgeEnemy == 0 then
			while k<3 do
			 if  ( GetNUnitsInArea ( 1, "Dredge", 0) > 0 ) and ( GetNUnitsInArea ( 0, "Dredge", 0 )<=0 ) then
				k=k+1;
			 else
				k=0;
			 end;
			 Wait(3);
			end;
			DredgeEnemy = 1;
			Trace("DredgeEnemy = true");
		else
			while k<3 do
			 if ( GetNUnitsInArea ( 0, "Dredge", 0)>0 ) and ( GetNUnitsInArea ( 1, "Dredge", 0 )<=0 ) then
				k=k+1;
			 else
				k=0;
			 end;
			 Wait(3);
			end;
			DredgeEnemy = 0;
		end;
		k=0;
		Wait(2);
	end;
end;

function Objective1()
	while 1 do
		if DredgeEnemy == 0 then
			CompleteObjective( 1 );
			Trace("CompleteObjective( 1 )");
			Win(0);
		end;	
			Wait( 3 );
			
		if DredgeEnemy and ( GetIGlobalVar( "temp.objective.1", 0 ) == 2 ) then
			Wait( 3 );
			GiveObjective( 1 );
		end;
			
		if ( GetNUnitsInScriptGroup( 111 ) == 0 ) then -- dredge is destroyed
			FailObjective( 1 );
			return 1;
		end;
			Wait(5);
	end;	
end;

function Objective0()
	while 1 do
		if ( GetNUnitsInArea( 0, "War" ) >= 3 ) then
			CompleteObjective( 0 );
			Wait( 2 );
			if ( GetIGlobalVar( "temp.objective.1", 0 ) == 0 ) then
				GiveObjective( 1 );
			end
			return 1;
		end;
		Wait( 2 );
	end;
end;

--function WinCheck()
--	while ( missionend == 0 ) do
--		Wait( 2 );
--		if ( GetIGlobalVar( "temp.objective.1", 0 ) == 2 ) then
--			Wait( 3 );
--			Win( 0 ); -- player wins
--			missionend = 1;
--		end;
--	end;
--end;


function CheckAll()
Trace("DredgeEnemy=%g", DredgeEnemy);
Trace("OursInDredge=%g", GetNUnitsInArea ( 0, "Dredge", 0));  
Trace("EnemyInDredge=%g", GetNUnitsInArea ( 1, "Dredge", 0 ));
end;

--Objectives = { Objective0, Objective1 };
--Objectives_Count = 2;

--StartAllObjectives(Objectives, Objectives_Count);
StartThread(Objective0);
GiveObjective(0);
StartThread(DredgeFlag);
StartThread(Objective1);