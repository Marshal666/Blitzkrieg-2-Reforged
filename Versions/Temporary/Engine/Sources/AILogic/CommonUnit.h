#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "LinkObject.h"
#include "GroupUnit.h"
#include "QueueUnit.h"
#include "..\Common_RTS_AI\BasePathUnit.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ������� �� ������� � ����� �������� ����� ��������,
enum ECamouflageRemoveReason
{
	ECRR_SELF_SHOOT,
	ECRR_USER_COMMAND,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CBasicGun;
class CBuilding;
class CEntrenchment;
namespace NDb
{
	enum EUnitSpecialAbility;
	enum ESpecialAbilityParam;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SBehaviour
{
	enum EMoving
	{
		EMRoaming = 0,
		EMFollow = 1,
		EMHoldPos = 2
	};
	enum EFire
	{
		EFAtWill = 0,
		EFReturn = 1,
		EFNoFire = 2
	};


public:
	ZDATA
	EMoving moving;
	EFire fire;
	public: ZEND int operator&( IBinSaver &f ) { f.Add(2,&moving); f.Add(3,&fire); return 0; }
public:

	SBehaviour() : moving( EMRoaming ), fire( EFAtWill ) { }
	SBehaviour( const EMoving _moving, const EFire _fire ) : moving( _moving ), fire( _fire ) { }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IShootEstimator;
interface ICollisionsCollector;
//interface IScenarioUnit;
class CAIUnit;
class CCommonUnit : public CLinkObject, public CBasePathUnit, public CGroupUnit, public CQueueUnit
{
	SBehaviour beh;
	NTimer::STime lastBehTime;

	CPtr<CBasicGun> pLockingGun;
	CVec2 vBattlePos;
	SAIAngle wReserveDir;
	CPtr<CAIUnit> pTruck;

	bool bSelectable;

	float fDesirableSpeed;
	CPtr<CCommonUnit> pFollowedUnit;
	// ����������� ����������� �������� ��-�� ����, ��� �� ���� ���-�� �������
	float fMinFollowingSpeed;
	CVec2 vFollowShift;

	CObj<IShootEstimator> pShootEstimator;
	
	bool bCanBeFrozenByState;
	bool bCanBeFrozenByScan;
	NTimer::STime nextFreezeScan;
	float fPrice;
	CVec3 vOldPlacement;
	CQuat qStart;
	CQuat qFinish;
	int nCommandLeft;
protected:
	IShootEstimator* GetShootEstimator() { return pShootEstimator; }
	virtual void NullSegmTime() {};
	virtual void CheckForDestroyedObjects( const CVec2 &vCenter ) const;
	virtual void UpdatePlacement( const CVec3 &vOldPosition, const WORD wOldDirection, const bool bNeedUpdate );
	virtual void UpdateTile();
	void ProduceEventByAction( const NDb::EUnitSpecialAbility eAbility, const NDb::ESpecialAbilityParam action, class CAICommand * pCommand );

public:
	CCommonUnit() : wReserveDir( 0 ), vFollowShift( VNULL2 ) { }

	int operator&( IBinSaver &f );
	virtual int GetMovingType() const { return 0; }
	virtual bool IsSelectable() const { return bSelectable; }
	virtual void Init( const CVec3 &_vCenter, const WORD _wDirection, ICollisionsCollector *pCollisionsCollector );
	
	virtual int GetNGuns() const = 0;
	virtual CBasicGun* GetGun( const int n ) const = 0;

	//{ not very nice, but acceptable
	const int GetUniqueIDPath() const { return GetUniqueId(); }
	const int GetUniqueIdQU() const { return GetUniqueId(); }
	//}

	virtual CBasicGun* ChooseGunForStatObj( class CStaticObject *pObj, NTimer::STime *pTime ) = 0;
	virtual CBasicGun* ChooseGunForStatObjWOTime( class CStaticObject *pObj );

	bool CanShootToUnitWoMove( class CAIUnit *pTarget );

	virtual void SetSelectable( bool bSelectable, bool bSendToWorld );

	virtual const BYTE GetPlayer() const = 0;
	const BYTE GetParty() const;
	virtual void ChangePlayer( const BYTE cPlayer ) = 0;
	
	// ����� ������������ damage ����� ������� ����� pTarget
	virtual const float GetMaxDamage( class CCommonUnit *pTarget ) const;

	virtual const float GetSightRadius() const = 0;

	const SBehaviour::EMoving GetBehaviourMoving() const { return beh.moving; }
	const SBehaviour::EFire GetBehaviourFire() const { return beh.fire; }
	void SetBehaviourMoving( const SBehaviour::EMoving _moving );
	void SetBehaviourFire( const SBehaviour::EFire _fire ) { beh.fire = _fire; }

	const NTimer::STime& GetLastBehTime() const { return lastBehTime; }
	NTimer::STime& GetLastBehTime() { return lastBehTime; }

	virtual const bool IsVisible( const BYTE party ) const = 0;

	virtual const bool NeedDeinstall() const { return false; }
	// ����� �� ������ �������� ( ��������, ���� �� ��������������, �� �� ����� )
	virtual const bool CanShoot() const { return true; }
	virtual const bool CanShootToPlanes() const = 0;
	virtual const bool CanShootInMovement() { return false; }
	
	virtual void Fired( const float fGunRadius, const int nGun ) = 0;
	
	virtual CBasicGun* GetFirstArtilleryGun() const { return 0; }
	
	virtual const NTimer::STime GetTimeToCamouflage() const = 0;
	virtual void SetCamoulfage()=0;
	virtual void RemoveCamouflage( ECamouflageRemoveReason eReason )=0;

	
	// ��� updat-��� ������� range/����������
	virtual void UpdateArea( const EActionNotify eAction ) = 0;
	virtual const DWORD GetNormale( const CVec2 &vCenter ) const;
	virtual void GetPlacement( struct SAINotifyPlacement *pPlacement, const NTimer::STime timeDiff );
	// �������� unit ( ���� ��� ��� ��������, �� ������ lock �������� )
	virtual void Lock( const CBasicGun *pGun );
	// unlock unit ( ���� ������� ������ gun-��, �� ������ �� �������� )
	virtual void Unlock( const CBasicGun *pGun );
	// ������� �� �����-���� gun-��, �� ������ pGun
	virtual bool IsLocked( const CBasicGun *pGun ) const;
	
	virtual class CTurret* GetTurret( const int nTurret ) const = 0;
	virtual const int GetNTurrets() const = 0;
	virtual bool IsMech() const = 0;
	
	void SetBattlePos( const CVec2 &vPos, const WORD _wReserveDir = 0 ) { vBattlePos = vPos; wReserveDir = _wReserveDir; }
	bool DoesReservePosExist() const { return vBattlePos.x != -1.0f; }
	const CVec2& GetBattlePos() const { NI_ASSERT( DoesReservePosExist(), "Reserve pos doesn't exist" ); return vBattlePos; }
	const WORD GetReserveDir() const { NI_ASSERT( DoesReservePosExist(), "Reserve pos doesn't exist" ); return wReserveDir; }
	void SetTruck( class CAIUnit *pUnit );
	class CAIUnit* GetTruck() const;
	
	// ������� ���� � �����
	virtual void Disappear() = 0;
	// �������
	virtual void Die( const bool fromExplosion, const float fDamage ) = 0;

	// true ���������� ������ ��������
	virtual bool IsFormation() const { return false; }
	virtual const bool IsInfantry() const { return false; }

	virtual void SendAcknowledgement( EUnitAckType ack, bool bForce = false ) = 0;
	// ack ��� ������� pCommand
	virtual void SendAcknowledgement( CAICommand *pCommand, EUnitAckType ack, bool bForce = false ) = 0;

	//virtual const float GetMaxSpeedHere( const CVec2 &point, bool bAdjust = true ) const;
	virtual void SetDesirableSpeed( const float fDesirableSpeed );
	virtual void UnsetDesirableSpeed();
	virtual float GetDesirableSpeed() const;
	virtual void AdjustWithDesirableSpeed( float *pfMaxSpeed ) const;

	// follow state - �� �� ���-�� �������
	void SetFollowState( class CCommonUnit *pFollowedUnit );
	void UnsetFollowState();
	bool IsInFollowState();
	// ������� ����, �� ������� �������
	class CCommonUnit* GetFollowedUnit() const;
	const CVec2& GetFollowShift() const { return vFollowShift; }

	// ���� pFollowingUnit ������� �� ����
	void FollowingByYou( class CCommonUnit *pFollowingUnit );

	virtual void Segment();
	virtual void FreezeSegment();
	
	// ��������� �� (�-�, ����� ��� ������� ������������)
	virtual bool IsOperable() const { return true; }
	
	virtual const int GetMinArmor() const = 0;
	virtual const int GetMaxArmor() const = 0;
	virtual const int GetMinPossibleArmor( const int nSide ) const = 0;
	virtual const int GetMaxPossibleArmor( const int nSide ) const = 0;
	virtual const int GetArmor( const int nSide ) const = 0;
	virtual const int GetRandomArmor( const int nSide ) const = 0;
	
	virtual float GetMaxFireRange() const = 0;
	
	virtual void UnRegisterAsBored( const enum EUnitAckType eBoredType ) = 0;
	virtual void RegisterAsBored( const enum EUnitAckType eBoredType ) = 0;

	virtual EUnitAckType GetGunsRejectReason() const = 0;

	// ��� ��������������
	void SetShootEstimator( interface IShootEstimator *pShootEstimator );
	// �������� ��� ���������� � shoot estimator � ������������������� ��� ������ pCurEnemy
	// ��������� ��� ������ �������� �� pCurEnemy, bDamageUpdated - ��� �� update �� damage pCurEnemy ����
	void ResetShootEstimator( class CAIUnit *pCurEnemy, const bool bDamageUpdated, const DWORD dwForbidden = 0 );
	void AddUnitToShootEstimator( class CAIUnit *pUnit );
	CAIUnit* GetBestShootEstimatedUnit() const;
	CBasicGun* GetBestShootEstimatedGun() const;
	const int GetNumOfBestShootEstimatedGun() const;

	virtual const float GetKillSpeed( class CAIUnit *pEnemy ) const { return 0; }
	// �������� ����� ��� �������� ������������
	virtual void ResetTargetScan() = 0;
	// ��������������, ���� ����; ���� ����� ����, �� ���������
	virtual BYTE AnalyzeTargetScan(	CAIUnit *pCurTarget, const bool bDamageUpdated, const bool bScanForObstacles, CObjectBase *pCheckBuilding = 0 ) = 0;
	// �������������� �� ����� ����
	virtual void LookForTarget( CAIUnit *pCurTarget, const bool bDamageUpdated, CAIUnit **pBestTarget, CBasicGun **pGun ) = 0;
	// ����� �����������
	virtual interface IObstacle * LookForObstacle() { return 0; };
	
	// ����� �� �������� ��������� ������ � �����, ������� �������� (�-�, ��� ������� �� �����)
	virtual bool CanMoveForGuard() const = 0;

	virtual bool CanCommandBeExecutedByStats( int nCmd ) const = 0;
	virtual void NotifyAbilityRun( class CAICommand * pCommand ) = 0;

	virtual const NTimer::STime GetNextPathSegmTime() const { return 0; }
	
	virtual float GetPriceMax() const = 0;
	virtual const NTimer::STime GetBehUpdateDuration() const = 0;
	
	virtual void AnimationSegment() { }
	
	virtual const float GetTargetScanRadius() { return 0.0f; }

	bool CanBeFrozen() const;
	bool IsFrozenByState() const;
	virtual void FreezeByState( const bool bFreeze );
	
	virtual bool CanHookUnit( class CAIUnit *pUnitToHook ) const { return false; }
	virtual bool IsTowing() const { return false; }
	
	void SetPrice( float fNewPrice ) { fPrice = fNewPrice; }
	float GetPrice() { return fPrice; }
	
	virtual bool CanMoveAfterUserCommand() const = 0;

	virtual const CVec2 GetUnitPointInFormation() const { return VNULL2; }
	virtual const CVec2 &GetAABBHalfSize() const = 0;

	virtual const int GetUnitPriority() const { return 0; }

	//����� PathFinder
	virtual bool IsInFormation() const { return false; }
	virtual class CFormation* GetFormation() const { return 0; }
	virtual const float GetSpeedForFollowing();
	virtual const bool CanGoToPoint( const CVec2 &point ) const;
	virtual const bool CanRotate() const = 0;
	virtual const EAIClasses GetAIPassabilityClass() const { return EAC_ANY; }
	virtual const bool IsDangerousDirExist() const { return false; }
	virtual const WORD GetDangerousDir() const { return 0; }
	virtual const int GetUniqueID() const { return CLinkObject::GetUniqueId(); }
	virtual void UnitTrampled( const CBasePathUnit *pUnit ) {}
	virtual const bool CanUnitTrampled( const CBasePathUnit *pUnit ) const = 0;
	virtual const bool IterateUnits( const CVec2 &vCenter, const float fRadius, const bool bOnlyMech, const SIterateUnitsCallback &callback ) const;
	virtual const bool IsTrain() const = 0;

	//������ PathFinder
	IStaticPath* GetPathToBuilding( CBuilding *pBuilding, int *pnEntrance );
	IStaticPath* GetPathToEntrenchment( CEntrenchment *pEntrenchment );
	virtual const int GetFormationSlot() { return 0; }
  
	virtual void WarFogChanged() = 0;

	virtual const float GetZ() const { return 0.0f; }
	const bool TryExecuteCommand( class CAICommand *pCommand, const bool bPlaceInQueue, bool bOnlyThisUnitCommand );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
