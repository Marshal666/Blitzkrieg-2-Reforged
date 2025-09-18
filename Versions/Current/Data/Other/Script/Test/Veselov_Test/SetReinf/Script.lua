--Wait( 10 );
---Cmd( 3, 1, 900, 100 );

---DisplayTrace( "0 seconds passed", 0 );
---Wait(10);
---DisplayTrace( "10 seconds passed", 0 );

---SetReinforcement( 0, 151 );
--Wait(10);
--DisplayTrace( "20 seconds passed", 0 );
---DisableReinforcement( 0, 4 );
--DisableReinforcement( 0, 4 );

--Wait( 5 );

--LandReinforcement(2, 1009, 0, 2 );
--Wait( 1 )
--ChangePlayerForScriptGroup(2,0)

SCRunTime( "a0", "a1", 5 );
Wait( 5 );
SCRunTime( "a1","a2", 5 );
Wait( 5 );
SCRunTime( "a2", "a3", 5 );
Wait( 5 )
SCRunTime( "a3", "a4", 5 );
Wait( 5 );
DisplayTrace( "movie sequence finished", 0 );
SCReset();
Wait(5);
Wait(1);
