#ifndef __STATISTICS_H__
#define __STATISTICS_H__
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma ONCE
namespace NDb
{
	enum EReinforcementType;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CStatistics
{
	public: int operator&( IBinSaver &saver ); private:;

	bool bEnablePlayerExp;										// can we add player exp? (false in tutorial mode - initialized in the Init())

public:
	CStatistics() : bEnablePlayerExp( false ) {  }

	void Init();

	const int GetXPLevel( const int nPlayer, const NDb::EReinforcementType eType );
	const int GetAbilityLevel( const int nPlayer, const NDb::EReinforcementType eType );		// Different from XP level, because of leaders

	float GetValue( const int nValue, const int nPlayer ) const;
	int GetUnitLevel( const NDb::EReinforcementType eType, const int nPlayer ) const;
	// player captured oter player's unit
	void UnitCaptured( const int nPlayer );
	// ����� nPlayer ��������� ����� ������ nKilledUnitsPlayer, fTotalAIPrice - �� price
	void UnitKilled( const int nPlayer, const int nKilledUnitsPlayer, const float fTotalAIPrice, const EReinforcementType eKillerType, const EReinforcementType eDeadType, const bool bInfantry );
	// unit ����
	void UnitDead( class CCommonUnit *pUnit );
	// ����� nPlayer ��������� house
	void ObjectDestroyed( const int nPlayer );
	// ����� nPlayer ������ �������
	void AviationCalled( const int nPlayer );
	// ����� nPlayer ����������� reinforcement
	void ReinforcementUsed( const int nPlayer );
	// ����� nPlayer ����������� �������
	void ResourceUsed( const int nPlayer, const float fResources );
	//player's experience
	void IncreasePlayerExperience( const int nPlayer, const NDb::EReinforcementType eType, const float fPrice ) ;

	void SetFlagPoints( const int nParty, const float fPoints );
	void SetCapturedFlags( const int nParty, const int nFlags );

};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // __STATISTICS_H__
