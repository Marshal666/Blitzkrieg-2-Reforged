#ifndef __GUNS_H__
#define __GUNS_H__
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma ONCE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "LinkObject.h"
#include "..\Stats_B2_M1\RPGStats.h"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	struct SWeaponRPGStats;
	struct SBaseGunRPGStats;
}
class CAIUnit;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*******************************************************************
//*								  ������ �����																		*
//*******************************************************************
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SCommonGunInfo : public CAIObjectBase
{
	OBJECT_BASIC_METHODS( SCommonGunInfo );
public:
	ZDATA
	bool bFiring;
	int nAmmo;
	NTimer::STime lastShoot;
	int nGun;
	int nPlatform;
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&bFiring); f.Add(3,&nAmmo); f.Add(4,&lastShoot); f.Add(5,&nGun); f.Add(6,&nPlatform); return 0; }
public:

	SCommonGunInfo() { }
	SCommonGunInfo( bool _bFiring, const int _nAmmo, const int _nPlatform, const int _nGun ) : bFiring( _bFiring ), nAmmo( _nAmmo ), nPlatform( _nPlatform ), lastShoot( 0 ), nGun( _nGun ) { }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IGunsFactory
{
	enum EGunTypes { MOMENT_CML_GUN, MOMENT_BURST_GUN, VIS_CML_BALLIST_GUN, VIS_BURST_BALLIST_GUN, PLANE_GUN, MORALE_GUN, TORPEDO_GUN, ROCKET_GUN, FLAME_GUN };

	virtual class CBasicGun* CreateGun( const EGunTypes eType, const int nShell, SCommonGunInfo *pCommonGunInfo ) const = 0;
	virtual int GetNCommonGun() const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CBasicGunCRAPSaver : public CLinkObject
{
	ZDATA_(CLinkObject)
public: 
protected:
	CDBPtr<SWeaponRPGStats> pWeapon;
public:
	ZEND int operator&( IBinSaver &f ) { f.Add(1,(CLinkObject*)this); f.Add(2,&pWeapon); return 0; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CBasicGun : public CBasicGunCRAPSaver
{

	enum EShootState { EST_TURNING, EST_AIMING, WAIT_FOR_ACTION_POINT, EST_SHOOTING, EST_REST };
	typedef list< CPtr<CBasicGun> > CParallelGuns;

	ZDATA_(CBasicGunCRAPSaver)
protected:
	ZSKIP//	CDBPtr<SWeaponRPGStats> pWeapon;
private:
	EShootState shootState;

	bool bWaitForReload; //specific for artillery

	// ����� �� ����������� �������
	bool bCanShoot;
	// ������� ��� �������� � �������
	int nShotsLast;


	IGunsFactory::EGunTypes eType;
	EUnitAckType eRejectReason;

	CVec3 vLastShotPoint;

	float fRandom4Aim, fRandom4Relax;
	//
protected:	
	BYTE nShellType;
	CPtr<CAIUnit> pOwner;
	int nOwnerParty;
	CPtr<SCommonGunInfo> pCommonGunInfo;

	// ����, �� �������� �������� ( � ������ �������� �� ����� )
	CPtr<CAIUnit> pEnemy;
	// ���� ��������
	CVec2 target;
	// ����� ������ ������������ ��� ������ ������, � ����������� �� ���������
	NTimer::STime lastCheck;
	CVec2 lastEnemyPos;
	bool bAngleLocked;

	// ����� �� �������������
	bool bAim;
	bool bGrenade;
	// ������ �����, � ������� ���������� ��������
	float z;

	CParallelGuns parallelGuns;
	bool bParallelGun;
	NTimer::STime lastCheckTurnTime;
	bool bIgnoreObstacles;
private:
	CPtr<CAIUnit> pCanShootCachedEnemy;
	bool bCanShootToUnitWOMove;
public:
	ZEND int operator&( IBinSaver &f ) { f.Add(1,(CBasicGunCRAPSaver*)this); f.Add(3,&shootState); f.Add(4,&bWaitForReload); f.Add(5,&bCanShoot); f.Add(6,&nShotsLast); f.Add(7,&eType); f.Add(8,&eRejectReason); f.Add(9,&vLastShotPoint); f.Add(10,&fRandom4Aim); f.Add(11,&fRandom4Relax); f.Add(12,&nShellType); f.Add(13,&pOwner); f.Add(14,&nOwnerParty); f.Add(15,&pCommonGunInfo); f.Add(16,&pEnemy); f.Add(17,&target); f.Add(18,&lastCheck); f.Add(19,&lastEnemyPos); f.Add(20,&bAngleLocked); f.Add(21,&bAim); f.Add(22,&bGrenade); f.Add(23,&z); f.Add(24,&parallelGuns); f.Add(25,&bParallelGun); f.Add(26,&lastCheckTurnTime); f.Add(27,&bIgnoreObstacles); f.Add(28,&pCanShootCachedEnemy); f.Add(29,&bCanShootToUnitWOMove); return 0; }

private:

	void Aiming();
	void WaitForActionPoint();
	void Shooting();
	const CVec2 GetShootingPoint() const;
	WORD GetVisAngleOfAim() const;

	// ��� ��������� �������� � ������� �������
	void OnWaitForActionPointState();
	void OnTurningState();
	void OnAimState();

	bool CanShotBecauseOfObstacles( const CVec2 &point, const float fZ );
	void ToRestStateWOParallel();
protected:


	const NTimer::STime GetActionPoint() const;
	//
	virtual bool TurnGunToEnemy( const CVec2 &vEnemyCenter, const float zDiff ) = 0;
	// ����� �� ����� ������ ���������� �� point ( �� ������ �� turret �� base ), ����������� - ���� addAngle, cDeltaAngle - ��������� �� deltaAngle
	virtual bool IsGoodAngle( const CVec2 &point, const WORD addAngle, const float z, const BYTE cDeltaAngle ) const = 0;
	virtual void ToRestState();
	virtual void Rest() = 0;
	virtual bool AnalyzeTurning() = 0;
	// ����� �� ���������� �� ���� �� ������ �� turret �� base � �� ��������
	// cDeltaAngle - ��������� �� deltaAngle
	bool CanShootWOGunTurn( const BYTE cDeltaAngle, const float fZ );
	// ����� �� �������� �� �����, ���� pUnit ��������� ������ ������. �������
	bool AnalyzeLimitedAngle( class CCommonUnit *pUnit, const CVec2 &point ) const;
	void Turning();
	bool CanShootToTargetWOMove();

	void InitRandoms();
public:
	CBasicGun() : pOwner( 0 ), bParallelGun( false ), vLastShotPoint( VNULL3	), lastCheckTurnTime( 0 ), bCanShootToUnitWOMove( false ) { }
	CBasicGun( class CAIUnit *pOwner, const BYTE nShellType, SCommonGunInfo *pCommonGunInfo, const IGunsFactory::EGunTypes eType );

	virtual int GetShellType() const { return nShellType; } 

	virtual const float GetAimTime( bool bRandomize = true ) const;
	virtual const float GetRelaxTime( bool bRandomize = true ) const;
	virtual class CAIUnit* GetOwner() const { return pOwner; }	
	virtual void SetOwner( CAIUnit *pOwner );
	bool IsGrenade() const { return bGrenade; }

	virtual void GetMechShotInfo( SAINotifyMechShot *pMechShotInfo, const NTimer::STime &time ) const;
	virtual void GetInfantryShotInfo( SAINotifyInfantryShot *pInfantryShotInfo, const NTimer::STime &time ) const;

	virtual bool InFireRange( class CAIUnit *pTarget ) const;
	virtual bool InFireRange( const CVec3 &vPoint ) const;
	virtual float GetFireRange( float z ) const;
	// ���������� fRandgeMax from rpgstats � ������ ���� ������������� - �������������
	virtual float GetFireRangeMax() const;
	virtual bool InGoToSideRange( const class CAIUnit *pTarget ) const;
	virtual bool TooCloseToFire( const class CAIUnit *pTarget ) const;
	virtual bool TooCloseToFire( const CVec3 &vPoint ) const;

	virtual void StartPointBurst( const CVec3 &target, bool bReAim );
	virtual void StartPointBurst( const CVec2 &target, bool bReAim );
	virtual void StartEnemyBurst( class CAIUnit *pEnemy, bool bReAim );
	void Segment();

	bool IsWaitForReload() const { return bWaitForReload; }
	virtual void ClearWaitForReload() { bWaitForReload = false; }

	// � ������ ������ � ��������� ������� � ��������
	virtual bool IsFiring() const ;
	bool IsBursting() const { return shootState == WAIT_FOR_ACTION_POINT || shootState == EST_SHOOTING; }

	virtual const SBaseGunRPGStats& GetGun() const;
	virtual const SWeaponRPGStats* GetWeapon() const;
	virtual const SWeaponRPGStats::SShell& GetShell() const;

	virtual bool IsRelaxing() const;
	// ����� �� ���������� �� pEnemy, �� ������ �� base �� turret, cDeltaAngle - ��������� �� deltaAngle
	virtual bool CanShootWOGunTurn( class CAIUnit *pEnemy, const BYTE cDeltaAngle );
	virtual const NTimer::STime GetRestTimeOfRelax() const;

	// ��������, ����� ��������� ���������
	virtual bool CanShootToUnitWOMove( class CAIUnit *pEnemy );
	virtual bool CanShootToObjectWOMove( class CStaticObject *pObj );
	virtual bool CanShootToPointWOMove( const CVec2 &point, const float fZ, const WORD wHorAddAngle = 0, const WORD wVertAddAngle = 0, CAIUnit *pEnemy = 0 );

	// ����� �� ������������ �� ������	
	virtual bool CanShootByHeight( class CAIUnit *pTarget ) const;	
	virtual bool CanShootByHeight( const float fZ ) const;

	// ����� �� ���������� � ������ �� ������� �������
	virtual bool CanShootToUnit( class CAIUnit *pEnemy );
	virtual bool CanShootToObject( class CStaticObject *pObj );
	virtual bool CanShootToPoint( const CVec2 &point, const float fZ, const WORD wHorAddAngle = 0, const WORD wVertAddAngle = 0 );

	// ����� �����������, �� ����������� base ( turret ������� ����� )
	virtual bool IsInShootCone( const CVec2 &point, const WORD wAddAngle = 0 ) const;

	virtual const float GetDispersion() const;
	virtual const float GetDispRatio( BYTE nShellType, const float fDist ) const; 
	virtual const int GetFireRate() const;
	void LockInCurAngle() { bAngleLocked = true; }
	void UnlockCurAngle() { bAngleLocked = false; }

	// ��� ��������
	virtual void StartPlaneBurst( class CAIUnit *pEnemy, bool bReAim );

	// ����� ������� ����� � ������ �������, ������� ������� pTarget
	virtual bool CanBreakArmor( class CAIUnit *pTarget ) const;
	// ����� ������� ����� � �����-������ �������
	virtual bool CanBreach( const class CCommonUnit *pTarget ) const;
	// ����� ������� ����� �� ������� nSide
	virtual bool CanBreach( const class CCommonUnit *pTarget, const int nSide ) const;
	virtual bool CanBreach( const SHPObjectRPGStats *pStats, const int nSide ) const;

	// ����� ������ ��� ��������, ������ ��� �������� �� ���� (��������, ������������), �� �� ����� ��������
	void DontShoot() { bCanShoot = false; }
	// �������� DontShoot()
	void CanShoot() { bCanShoot = true; }
	bool IsShootAllowed(){ return bCanShoot; }

	// �������� �� ����� gun ( � ������ �������� - �.�. ����������� ��� guns, ����������� � ��� � ����� ������ )
	bool IsCommonGunFiring() const { return pCommonGunInfo->bFiring; }
	// ����� �� pGun ( � ������ �������� )
	virtual bool IsCommonEqual( const CBasicGun *pGun ) const;

	// "����� ������" ( gun-�, ������������ ������ ���������, �� ����������� � ����� ������ )
	int GetCommonGunNumber() const { return pCommonGunInfo->nGun; }
	int GetPlatform() const { return pCommonGunInfo->nPlatform; }

	int GetNAmmo() const { return pCommonGunInfo->nAmmo; }
	void SetNAmmo( int nAmmo ) { pCommonGunInfo->nAmmo = nAmmo; }

	virtual interface IBallisticTraj* CreateTraj( const CVec3 &vTarget ) const;
	virtual void Fire( const CVec2 &target, const float z, const bool bShowBombEffect );
	virtual WORD GetTrajectoryZAngle( const CVec3 &vToAim ) const;

	// �������, ������ ��������� ��������
	virtual const EUnitAckType& GetRejectReason() const { return eRejectReason; }
	virtual void SetRejectReason( const EUnitAckType &eReason );

	virtual const bool IsVisible( const BYTE party ) const { return true; }
	virtual void GetTilesForVisibility( CTilesSet *pTiles ) const { pTiles->clear(); }
	virtual bool ShouldSuspendAction( const EActionNotify &eAction ) const { return false; }

	void AddParallelGun( CBasicGun *pGun ) { parallelGuns.push_back( pGun ); }
	void SetToParallelGun() { bParallelGun = true; }

	// ������� ��������
	virtual const int GetPiercing() const;
	// �������
	virtual const int GetPiercingRandom() const;
	// ��������� �������� piercing
	virtual const int GetRandomPiercing() const;
	virtual const int GetMaxPossiblePiercing() const;
	virtual const int GetMinPossiblePiercing() const;

	// ������� �������� damage
	virtual const float GetDamage() const;
	// �������
	virtual const float GetDamageRandom() const;
	// ��������� �������� damage
	virtual const float GetRandomDamage() const;

	virtual bool IsBallisticTrajectory() const;
	bool IsIgnoreObstacles() const { return bIgnoreObstacles; }

	virtual bool IsOnTurret() const = 0;

	virtual void StopFire() = 0;

	virtual WORD GetHorTurnConstraint() const = 0;
	virtual WORD GetVerTurnConstraint() const = 0;
	virtual class CTurret* GetTurret() const = 0;

	// �����������, �� �������� � ������ ������ ������� ������
	virtual const WORD GetGlobalDir() const = 0;
	// for AA guns.
	virtual const NTimer::STime GetTimeToShootToPoint( const CVec3 &vPoint ) const { return 0; }
	virtual const NTimer::STime GetTimeToShoot( const CVec3 &vPoint ) const { return 0; }
	virtual void TraceAim( class CAIUnit *pUnit ) = 0;
	// ���� �� ������, �� ��������� � ������������� ���� wAngle
	virtual void TurnToRelativeDir( const WORD wAngle ) = 0;
	// ���������/��������� ��������� ��� ����� ����������� �� ������� ������ �� �����������
	virtual void SetCircularAttack( const bool bCanAttack ) = 0;
	virtual class CBuilding *GetMountBuilding() const { return 0; }
	virtual void StopTracing() = 0;
	virtual const float GetRotateSpeed() const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
float GetDispByRadius( const class CBasicGun *pGun, const CVec2 &attackerPos, const CVec2 &explCoord );
float GetDispByRadius( const class CBasicGun *pGun, const float fDist );
float GetDispByRadius( const float fDispRadius, const float fRangeMax, const float fDist );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const float GetFireRangeMax( const SWeaponRPGStats *pStats, CAIUnit *pOwner );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // __GUNS_H__
