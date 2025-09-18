player_reinf = 6;
enemy_infantry_reinf = 7;
enemy_tank_reinf = 8;

r_i = "Reinf_Infantry";
p1 = "Point1";
r_t = "Reinf_Tank";
pt1 = "PointT1";
pt2 = "PointT2";
r_p = "Reinf_Player";

String1 = 3548;
String2 = 3549;
String3 = 3550;

player_tanks_id = 1000;
enemy_town_units_id = 1;

SANames = { pt1, pt2 };
player_tanks = {};
player_tanks = GetObjectListArray( player_tanks_id );

start_pos = { };
start_pos[1], start_pos[2] = ObjectGetCoord( player_tanks[ Random( player_tanks.n ) ] ); -- получить позицию одного из трёх танков
Trace( "1 %g, %g", GetScriptAreaParams( p1 ) );

function InfantryAttack()
local Infantry = {};
	while ( 1 ) do
	if ( ( GetNUnitsInArea( 0, r_i ) == 0 ) and ( GetNUnitsInCircle( 1, start_pos[1], start_pos[2], 300 ) == 0 ) ) then
		LandReinforcement( 1, enemy_infantry_reinf, 0 ); -- create units at player 1 reinf point 0
		Wait( 1 );
		Infantry = GetUnitListInAreaArray( 1, r_i );
		for i = 1, Infantry.n do
			UnitCmd( ACT_SWARM, Infantry[i],  GetScriptAreaParams( p1 ) );
			UnitQCmd( ACT_SWARM, Infantry[i],  start_pos[1], start_pos[2] );
		end;
		Wait( RandomInt( 60 ) + 149 );
	end;
	Wait( 1 );
	end;
end;

function TankAttack()
local Tanks = {};
	while 1 do
	if ( ( GetNUnitsInArea( 0, r_t ) == 0 ) and ( GetNUnitsInCircle( 1, start_pos[1], start_pos[2], 300 ) == 0 ) ) then
		LandReinforcement( 1, enemy_tank_reinf, 1); -- create units at player 1 reinf point 1
		Wait( 1 );
		Tanks = GetUnitListInAreaArray( 1, r_t );
		for i = 1, Tanks.n do
			UnitCmd( ACT_SWARM, Tanks[i],  GetScriptAreaParams( SANames[ Random( 2 ) ] ) );
			UnitQCmd( ACT_SWARM, Tanks[i],  start_pos[1], start_pos[2] );
		end;
		Wait( RandomInt( 60 ) + 209 );
	end;
	Wait( 1 );
	end;
end;

function CheckWin()
	if ( GetNUnitsInScriptGroup( enemy_town_units_id ) == 0 ) then 
		return 1;
	end;
	return 0;
end;

function Player_Reinforcements()
local Tanks = {};
	while 1 do
		if ( GetNUnitsInParty(0) <= 1 ) then 
			LandReinforcement( 0, player_reinf, 0); -- create units at player 0 reinf point 0
			Wait( 1 );
			Tanks = GetUnitListInAreaArray( 0, r_p );
			for i = 1, Tanks.n do
				UnitCmd( ACT_SWARM, Tanks[i],  start_pos[1], start_pos[2] );
			end;
			Wait( 1 );
			CameraMove( 0, 0 );
		end;
		Wait( 1 );
	end;
end;

function Victory()
	Wait( 3 );
	Win( 0 );
end;

StartSequence();
Wait( 2 );
CameraMove( 1, 6000 );
Wait( 1 );
StartThread( InfantryAttack );
Wait( 10 );
CameraMove( 0, 6000 );
Wait( 7 );
EndSequence();

StartThread( Player_Reinforcements );

-- здесь давать текст задания 1
AddChatMessage( String1, -1 );

Wait( 50 );

StartSequence();
Wait( 2 );
CameraMove( 2, 0 );
Sleep( 2 );
CameraMove( 3, 5000 );
Wait( 2 );
StartThread( TankAttack );
Wait( 8 );
CameraMove( 0, 5000 );
Wait( 6 );
EndSequence();

-- здесь давать текст задания 2
AddChatMessage( String2, -1 );

Wait( 40 );

StartSequence();
Wait( 2 );
CameraMove( 4, 0 );
Sleep( 2 );
CameraMove( 5, 8000 );
Wait( 12 );
CameraMove( 0, 0 );
Wait( 1 );
EndSequence();

-- здесь давать текст задания 3
AddChatMessage( String3, -1 );

Trigger( CheckWin, Victory );

