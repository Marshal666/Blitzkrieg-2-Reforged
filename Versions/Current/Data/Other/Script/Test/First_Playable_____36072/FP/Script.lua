--function Test(O, ... )
--	for i = 1, arg.n do
--		O[i] = arg[i];
--	end;
--	return arg.n;
--end;
--
--
--
--Cmd( 3, 100, 500, 3096 );
--Obj1 = {};
--local num = Test( Obj1, GetUnitListInArea( 0, "Area1" ) );
--Trace( "num=%g", num );
--
--for i = 1, num do
--	UnitCmd( 0, Obj1[i], 600, 4300 );
--	Trace( "%g, %g", ObjectGetCoord( Obj1[i] ) );
--	Trace( IsUnitInArea( Obj1[i], "Area1" ) );
--	DamageObject( Obj1[i], 5 );
--	
--end;
--ChangePlayer( Obj1[1], 1 );
--UnitRemove( Obj1[2] );
--UnitRemove( Obj1[3] );


--local veselovTest = GetIGlobalVar( "veselov_test", 0 );
--if ( veselovTest == 1 ) then
--	StartSequence();
--	CameraMove( 1, 10000 );
--	Sleep( 200 );
--	EndSequence();
--end;

--function Asd()
--	StartSequence();
--	CameraMove(0, 10000);
--	AddChatMessage(3546,-1);
--	CameraMove(1, 10000);
--	EndSequence();
--end;
--------------------------------------------------------------------------------------------------------------------------------------------------------------

player_reinf = 4;
start_pos = { };
start_pos[1], start_pos[2] = ObjectGetCoord( player_tanks[ Random( player_tanks.n ) ] ); -- получить позицию одного из трёх танков

----------------------------------------------------------------------------------

r_p = "Reinf_Player";

player_tanks_id = 500;
player_tanks = {};
player_tanks = GetObjectListArray( player_tanks_id );

----------------------------------------------------------------------------------

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
-----------------------------------------------------------------------------------------------------------

StartThread( Player_Reinforcements );

-----------------------------------------------------------------------------------------------------------
--Sleep(20*3);
--Asd();
--StartSequence();
--CameraMove(1, 10000);
--Sleep(20*10);
--EndSequence();
--AddChatMessage(3546,-1);
--Sleep(20*10);
--StartSequence();
--CameraMove(2, 10000);
--Sleep(20*10);
--EndSequence();