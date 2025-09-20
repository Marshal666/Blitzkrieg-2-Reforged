#ifndef __BUILDING_H__
#define __BUILDING_H__
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma ONCE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "StaticObject.h"
#include "..\Misc\Heap.h"
#include "StormableObject.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CSoldier;
class CCommonUnit;
class CTurret;
class CUnitGuns;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*******************************************************************
//*														CBuilding															*
//*******************************************************************
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CBuilding : public CGivenPassabilityStObject, public ILoadableObject, public CStormableObject
{

	struct SHealthySort{ bool operator()( const CPtr<CSoldier> &a, const CPtr<CSoldier> &b ); };
	struct SIllSort{ bool operator()( const CPtr<CSoldier> &a, const CPtr<CSoldier> &b ); };

	struct SSwapAction
	{
		void operator()( CPtr<CSoldier> pSoldier1, CPtr<CSoldier> pSoldier2, const int nSoldier1Index, const int nSoldier2Index );
	};
	struct SSideInfo
	{
		// ���������� fireSlots �� �������
		int nFireSlots;
		// ���������� observation points �� �������
		int nObservationPoints;
		// ���������� ������ � observation points �������
		int nSoldiersInObservationPoints;

		SSideInfo() : nFireSlots( 0 ), nObservationPoints( 0 ), nSoldiersInObservationPoints( 0 ) { }
	};

	ZDATA_(CGivenPassabilityStObject)
	ZPARENT(CStormableObject)
	SAIAngle wDir;
	
	bool bKeyBuilding;
	//

	// ������ ���������, ����� ��� � ������. ������� ��������
	NTimer::STime startOfRest;
	// �������
	bool bAlarm;


	CHeap< CPtr<CSoldier>, SHealthySort, SSwapAction > medical;
	CHeap< CPtr<CSoldier>, SIllSort, SSwapAction > fire;
	CHeap< CPtr<CSoldier>, SIllSort, SSwapAction > rest;
	int nOveralPlaces;

	int nIterator;

	CPtr<CCommonUnit> pLockingUnit;

	NTimer::STime nextSegmTime;
	
	vector< CObj<CTurret> > turrets;
	vector< CPtr<CUnitGuns> > guns;

	NTimer::STime lastDistibution;

	// ��� ������ �� ������ 3 �������������� fireplace
	CArray2D<int> observationPlaces;

	vector<SSideInfo> sides;
	// �� fire place - <����� ����� << 2> | <�������>
	vector<int> firePlace2Observation;
	// �� fireplace - ������ � ��
	vector< CPtr<CSoldier> > firePlace2Soldier;
	int nLastFreeFireSoldierChoice;

	// player ���������� �� ����������, ����������� � ������
	int nLastPlayer;

	int nScriptID;
	
	// ������ �� ����� ������� �� ������, ����� � ���� ��������� ���� ��������
	bool bShouldEscape;
	// units escaped
	bool bEscaped;
	NTimer::STime timeOfDeath;
	
	vector<NTimer::STime> lastLeave;
protected:
	int nLinkID;
	CDBPtr<SBuildingRPGStats> pStats;
private:
	bool bNewtralInfantryInside;

public: 
	ZEND int operator&( IBinSaver &f ) { f.Add(1,(CGivenPassabilityStObject*)this); f.Add(2,(CStormableObject*)this); f.Add(3,&wDir); f.Add(4,&bKeyBuilding); f.Add(5,&startOfRest); f.Add(6,&bAlarm); f.Add(7,&medical); f.Add(8,&fire); f.Add(9,&rest); f.Add(10,&nOveralPlaces); f.Add(11,&nIterator); f.Add(12,&pLockingUnit); f.Add(13,&nextSegmTime); f.Add(14,&turrets); f.Add(15,&guns); f.Add(16,&lastDistibution); f.Add(17,&observationPlaces); f.Add(18,&sides); f.Add(19,&firePlace2Observation); f.Add(20,&firePlace2Soldier); f.Add(21,&nLastFreeFireSoldierChoice); f.Add(22,&nLastPlayer); f.Add(23,&nScriptID); f.Add(24,&bShouldEscape); f.Add(25,&bEscaped); f.Add(26,&timeOfDeath); f.Add(27,&lastLeave); f.Add(28,&nLinkID); f.Add(29,&pStats); f.Add( 30, &bNewtralInfantryInside ); return 0; }

	//
	bool IsIllInFire();
	bool IsIllInRest();

	void SwapFireMed();
	void SwapRestMed();

	const BYTE GetFreeFireSlot();

	// �������� ����������� ����� � ����
	void PopFromFire();

	// ���� ��������� ����, �������� ���� ���������
	void SeatSoldierToMedicalSlot();
	// ���� ��������� ����, �������� ���� �����������
	void SeatSoldierToFireSlot();

	// ���������������� �������� (��������/������� �� medical places )
	void DistributeAll();
	// ���������������� �� ���������� �������� ( ��������/������� �� medical places )
	void DistributeNonFires();

	void SetFiringUnitProperties( class CSoldier *pUnit, const int nSlot, const int nIndex );
	void DistributeFiringSoldiers();

	void InitObservationPlaces();

	//
	void DelSoldierFromFirePlace( CSoldier *pSoldier );
	void DelSoldierFromMedicalPlace( CSoldier *pSoldier );
	void DelSoldierFromRestPlace( CSoldier *pSoldier );

	void PushSoldierToFirePlace( CSoldier *pUnit, const int nFirePlace );

	// �������� pUnit � ������ ���������� fireplace
	void PushToFire( class CSoldier *pUnit );
	void PushToMedical( class CSoldier *pUnit );
	void PushToRest( class CSoldier *pUnit );

	// ��������� ������ � ����� ����������
	void SetSoldiersToObservationPoints();
	// ����������� ����������� ������� pSoldier ��������� � ����� ����������; true - ����������, false - ���
	bool TryToPushRestSoldierToObservation( CSoldier *pSoldier );
	// ����������� ������� � ���������� ������ ��������� � ����� ����������; true - ����������, false - ���
	bool TryToPushFireSoldierToObservation( CSoldier *pSoldier );

	// ��������� �� pSoldier � ����� ����������
	bool IsSoldierInObservationPoint( CSoldier *pSoldier ) const;
	// ��������� pSoldier � observation point �� ������� nSide
	void PushSoldierToObservationPoint( CSoldier *pSoldier, const int nSide );

	// ������� ������� ����� ���������� ������� nSide
	void GetSidesObservationPoints( const int nSide, int *pnLeftPoint, int *pnRightPoint ) const;
	// ������� ����������� ����� ���������� ������� nSide
	const int GetMiddleObservationPoint( const int nSide ) const;
	// ������� ������� �� ������ �� ������� nSize
	CSoldier* GetSoldierOnSide( const int nSide );
	// true, ���� pSoldierInPoint � observation point ����� ������� �� pSoldier
	bool IsBetterChangeObservationSoldier( CSoldier *pSoldier, CSoldier *pSoldierInPoint );
	// ������� �������, ����� �������� ������� � ����� ����������,
	// ���� � ������ �� ����� ��� ����� ������, ��������� -1
	const int ChooseSideToSetSoldier( class CSoldier *pSoldier ) const;
	void CentreSoldiersInObservationPoints();
	// �������� ������ �� ���������� �����
	void ExchangeSoldiersToTurrets();

	// ���������� HP, ����� ���� ������� �� ������ ( �������, ���� �� ������ ������ )
	const float GetEscapeHitPoints() const;
	// ������� �������� ������� �� ����, pFormations - ������ ��� ��������� ��������
	void DriveOut( CSoldier *pSoldier, hash_set<int> *pFormations );
	void KillAllInsiders();
protected:

	virtual void AddSoldier( class CSoldier *pUnit );
	virtual void DelSoldier( class CSoldier *pUnit, const bool bFillEmptyFireplace );
	void SoldierDamaged( class CSoldier *pUnit );

	CBuilding() : pLockingUnit( 0 ), nextSegmTime ( 0 ), nScriptID( -1 ), bKeyBuilding( false ), bNewtralInfantryInside( false ) { }
	CBuilding( const SBuildingRPGStats *pStats, const CVec3 &center, const WORD wDir, const float fHP, const int nFrameIndex, int _nLinkID );
public:
	const int GetNFreePlaces() const;
	const int GetNOverallPlaces() const { return nOveralPlaces; }

	virtual const SHPObjectRPGStats* GetStats() const { return pStats; }
	virtual void SetHitPoints( const float fNewHP );
	virtual void TakeDamage( const float fDamage, const bool bFromExplosion, const int nPlayerOfShoot, CAIUnit *pShotUnit );
	virtual void Die( const float fDamage );

	const int GetNEntrancePoints() const { return pStats->entrances.size(); }
	const CVec2 GetEntrancePoint( const int nEntrance ) const;
	void GetEntranceData( CVec2 *pvPoint, WORD *pwDir, int nIndex ) const;
	// ����� �����, ��������� ����� ���� � ����� point
	bool ChooseEntrance( class CCommonUnit *pUnit, const CVec2 &vPoint, int *pnEntrance ) const;

	void GoOutFromEntrance( const int nEntrance, class CSoldier *pUnit );
	bool IsGoodPointForRunIn( const SVector &point, const int nEntrance, const float fMinDist = 0 ) const;

	virtual void Segment();
	virtual const NTimer::STime GetNextSegmentTime() const { return nextSegmTime; }
	
	virtual EStaticObjType GetObjectType() const { return ESOT_BUILDING; }

	virtual void GetRPGStats( struct SAINotifyRPGStats *pStats );

	// ������������ �� fire slots
	virtual void StartIterate() { nIterator = 0; }
	virtual void Iterate() { if ( nIterator < fire.Size() ) ++nIterator; }
	virtual bool IsIterateFinished() { return nIterator == fire.Size(); }
	virtual class CAIUnit* GetIteratedUnit();

	virtual bool IsContainer() const { return true; }
	virtual const int GetNDefenders() const;
	virtual class CSoldier* GetUnit( const int n ) const;
	virtual const BYTE GetPlayer() const;
	
	void Lock( class CCommonUnit *pUnit );
	bool IsLocked( const int nPlayer ) const;
	void Unlock( class CCommonUnit *pUnit );

	void Alarm();
	
	const int GetNGunsInFireSlot( const int nSlot );
	CBasicGun* GetGunInFireSlot( const int nSlot, const int nGun );
	CTurret* GetTurretInFireSlot( const int nSlot );
	float GetMaxFireRangeInSlot( const int nSlot ) const;
	
	bool IsSoldierVisible( const int nParty, const CVec2 &center, bool bCamouflated, const float fCamouflage ) const;
	
	virtual bool IsSelectable() const;
	virtual const bool IsVisibleForDiplomacyUpdate();
	
	virtual bool CanUnitGoThrough( const EAIClasses &eClass ) const;
	
	// ����� �� ������ ���� � ����� �������
	virtual bool CanRotateSoldier( class CSoldier *pSoldier ) const;
	// ��������� ������� � place ������ �������� ���
	virtual void ExchangeUnitToFireplace( class CSoldier *pSoldier, int nFirePlace );
	// ���������� fireplaces
	const int GetNFirePlaces() const;
	// ������, ������� � fireplace, ���� fireplace ����, �� ���������� 0
	class CSoldier* GetSoldierInFireplace( const int nFireplace) const;
	
	virtual void SetScriptID( const int _nScriptID ) { nScriptID = _nScriptID; }

	const NTimer::STime& GetLastLeaveTime( const int nPlayer ) const { return lastLeave[nPlayer]; }
	void SetLastLeaveTime( const int nPlayer );
	virtual const WORD GetDir() const { return wDir; }
	virtual const float GetMinHP() const;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ������� ������
class CBuildingSimple : public CBuilding
{
	OBJECT_BASIC_METHODS( CBuildingSimple );
	ZDATA_(CBuilding)
	int nPlayer;
	NTimer::STime timeToChangeOwner;
	CPtr<CExistingObject> pKeyBuildingFlag;
	CPtr<CExistingObject> pNeutralKeyBuildingFlag;
	int nSideToCapture;
	NTimer::STime timeToChangeOwnerTotal;
	ZEND int operator&( IBinSaver &f ) { f.Add(1,(CBuilding*)this); f.Add(2,&nPlayer); f.Add(3,&timeToChangeOwner); f.Add(4,&pKeyBuildingFlag); f.Add(5,&pNeutralKeyBuildingFlag); f.Add(6,&nSideToCapture); f.Add(7,&timeToChangeOwnerTotal); return 0; }
	
	void RaisePlayerFlag( int nNewPlayer );
protected:
	virtual void AddSoldier( CSoldier *pUnit );
public:
	CBuildingSimple() { }
	CBuildingSimple( const SBuildingRPGStats *pStats, const CVec3 &center, const WORD wDir, const float fHP, const int nFrameIndex, int nPlayerIndex, int nLinkID );
	
	virtual void Segment();
	virtual const BYTE GetPlayer() const;
	void ChangePlayer( const int nPlayer );
	virtual void TakeDamage( const float fDamage, const bool bFromExplosion, const int nPlayerOfShoot, CAIUnit *pShotUnit );
	virtual void Die( const float fDamage );
	virtual bool ShouldSuspendAction( const EActionNotify &eAction ) const;
	void SetPartyFlag( CExistingObject * _pKeyBuildingFlag );
	virtual void SetHitPoints( const float fNewHP );
	void CheckHitPoints();
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // __BUILDING_H__
