int nRelaxTime;
int nFireRate;

float GetRandomDamage() const { return GetPositiveRandom( fDamagePower, nDamageRandom ); }
int GetRandomPiercing() const { return GetPositiveRandom( nPiercing, nPiercingRandom ); }
int GetMaxPossiblePiercing() const { return nPiercing + nPiercingRandom; }
int GetMinPossiblePiercing() const { return Max( 0, nPiercing - nPiercingRandom ); }
const bool HasCraters() const { return pCraters != 0; }
//const string& GetRandomCrater() const { return craters[rand() % craters.size()]; }
// ������������� �� ������������ ������ � AI
bool ToAIUnits( bool bInEditor )
{
	if ( !bInEditor )
	{
		// ����� <=> AI �����
		fArea *= 32.0f;
		fArea2 *= 32.0f;
		// �����/������� <=> AI �����/���
		fSpeed *= 32.0f / 1000.0f;
		// [0..100] <=> [0..1]
		fBrokeTrackProbability *= 0.01f;
	}
	// ����/������ <=> ticks ����� �������� ���� � �������
	nFireRate = int( 60000.0f / fFireRate );
	// ������� <=> ticks
	nRelaxTime = int( fRelaxTime * 1000.0f );
	return true;
}
