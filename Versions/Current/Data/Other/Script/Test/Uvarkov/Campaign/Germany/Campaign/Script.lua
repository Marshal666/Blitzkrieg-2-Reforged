function DLizardTest()
	GiveMedal( GetUserPlayer(), 1 );
	GiveMedal( GetUserPlayer(), 1 );
	GiveMedal( GetUserPlayer(), 2 );
	GiveMedal( GetUserPlayer(), 1 );

	SetPlayerRank( GetUserPlayer(), 2 );
	SetPlayerXP( GetUserPlayer(), GetPlayerXP( 0 ) + 10 );
	SetPlayerXP( GetUserPlayer(), GetPlayerXP( 0 ) + 20 );
end;

DLizardTest();
