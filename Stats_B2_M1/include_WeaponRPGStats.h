WORD wDeltaAngle;
int nAimingTime;

virtual void ToAIUnits( bool bInEditor )
{ 
	SCommonRPGStats::ToAIUnits( bInEditor );
	// ������� <=> ticks
	nAimingTime = int( fAimingTime * 1000.0f );
	// ����� <=> AI �����
	if ( !bInEditor )
	{
		fDispersion *= 32.0f;
		fRangeMax *= 32.0f;
		fRangeMin *= 32.0f;
		fRevealRadius *= 32.0f;
	}
	// ������� <=> �������65535
	wDeltaAngle = ( DWORD( float( fDeltaAngle / 2 ) * (65536.0f / 360.0f) ) ) % 65536;
	// shell types
	for ( int i = 0; i < shells.size(); ++i )
		shells[i].ToAIUnits( bInEditor ); 
}
