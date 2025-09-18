function RevealObjective()
    DisplayTrace("StartMission");
    Wait(5);
	ObjectiveChanged(0, 1);
end;

------------------//GB//---------------------
function EntGB()
	Wait(5)
	--GetNUnitsInScriptGroup(13000, 1)
	Wait(5)
	Cmd(ACT_ENTRENCH, 13000, 1)
end;

function RestGB()
	Wait(5)
	--GetNUnitsInScriptGroup(12000, 1)
	Wait(5)
	Cmd(ACT_REST, 12000, 1)
end;




---------------//Ger//-----------------
function Ent()
	Wait(5)
	--GetNUnitsInScriptGroup(1000, 1)
	Wait(5)
	Cmd(ACT_ENTRENCH, 1000, 1)
end;

function Rest()
	Wait(5)
	--GetNUnitsInScriptGroup(3000, 1)
	Wait(5)
	Cmd(ACT_REST, 3000, 1)
end;

function Hide()
	Wait(5)
	--GetNUnitsInScriptGroup(2000, 1)
	Wait(5)
	Cmd(ACT_AMBUSH, 2000, 1)
end;

function Attack()
	while 1 do
		if(GetNUnitsInArea(0, "APoint") >=1) then
			Wait(5)
			GetNUnitsInScriptGroup(7000)
			Wait(3)
			Cmd(ACT_SWARM, 7000, 2645, 502)
		break
		end;
		Wait(1)
	end;
end;



--------------//German_Recon//----------------

function GerPatrol() 
	while 1 do	
		if (GetNUnitsInArea(0, "Point", 0) >= 1) then
			Wait ( 5 )
			GetNUnitsInScriptGroup( 5000 )
			Wait ( 5 )
			Cmd(ACT_SWARM, 5000, 1812, 2274)
		break
		end;
		Wait(1)
	end;	
end;


function GerPatrol1() 
	while 1 do	
		if (GetNUnitsInArea(0, "Point_1", 0) >= 1) then
			Wait ( 5 )
			GetNUnitsInScriptGroup( 6000 )
			Wait ( 5 )
			Cmd(ACT_SWARM, 6000, 5728, 1724)
		break
		end;
		Wait(1)
	end;	
end;

-------------//Loose//-----------------

function Looser()
	while 1 do
		if ((GetNUnitsInScriptGroup(10000, 0) < 2) and (GetNUnitsInScriptGroup(11000, 0) < 2)) then
		Wait ( 5 )
		Win ( 1 )
		break
		end;
		Wait(1)
	end;	
end;

function Winner()
	while 1 do
		if((GetNUnitsInArea(0, "APoint") >=2) and (GetNUnitsInArea(1, "APoint") <= 0) and (tmpold == { 0, 0 })) then
		Wait ( 5 )
		DisplayTrace("Weeeeee... !")
		Win ( 0 )
		break
		end;
		Wait(1)
	end;
end;
------------------------------------------
function KeyBuilding_Flag()
local tmpold = { 2, 2 };
local tmp;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, 1 do
		if ( GetNUnitsInScriptGroup( i + 500, 0 ) == 1 ) then
			tmp = 0;
		elseif ( ( GetNUnitsInScriptGroup( i + 500, 1 ) + GetNUnitsInScriptGroup( i + 500, 2 ) ) == 1 ) then
			tmp = 1;
		end;
		if ( tmp ~= tmpold[i] ) then
			if ( tmp == 0 ) then
				DamageScriptObject( 700 + i, 50 );
			else
				DamageScriptObject( 700 + i, -50 );
			end;
			tmpold[i] = tmp;
		end;
	end;
	end;
end;

StartThread( Attack )
StartThread( KeyBuilding_Flag )
StartThread( RevealObjective )
StartThread( EntGB )
StartThread( RestGB )
StartThread( Ent )
StartThread( Rest )
StartThread( Hide )
StartThread( GerPatrol )
StartThread( GerPatrol1 )
StartThread( Winner )
StartThread( Looser )