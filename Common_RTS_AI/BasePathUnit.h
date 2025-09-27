#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "..\Common_RTS_AI\Terrain.h"

#include "Path.h"
#include "StaticPath.h"
#include "Collision.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CAIMap;
class CStaticMapHeights;
class CCollisionsCollector;
class CCommonPathFinder;
interface IPointChecking;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! ��������� ��� ������������ ��������
enum EAdjustSpeedParam
{
	ADJUST_SLOW,	//! ��������� �������� � ��������� ���������� ���
	ADJUST_FAST,	//! ��������� �������� � ��������� ���������� ���
	ADJUST_SET,		//! ������ ��������
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! "���������" �������� �����
enum EMovementPlane
{
	PLANE_TERRAIN,
	PLANE_WATER,
	PLANE_AIR,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! �������� � ��� ����� ����������� ����
enum ECollidingType
{
	ECT_ALL,
	ECT_INTERNAL,
	ECT_NONE,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CBasePathUnit;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! callback ��� ������������ �� ������
struct SIterateUnitsCallback
{
	virtual bool Iterate( CBasePathUnit *unit ) const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! ����������� �����, �������������� "������������" �����. ��� ��� ����� ��������� � AI, ������ ������������� ��
//! CBasePathUnit. ����� ������������� ����������� ����������� ���������� � ����� ��� ������� ������ ����.
class CBasePathUnit
{
	CBasePathUnit *pLastPushUnit;
	CBasePathUnit *pLastPusherUnit;
	CPtr<CCommonPathFinder> pPathFinder;

	ZDATA
		ZONSERIALIZE
		ZSKIP

		SAIAngle wDirection;					//! ����������� ���� ����
		SAIAngle wFrontDirection;			//! ����������� ������

		SAIAngle wLastDirection;			//! ���������� �����������
		bool bGoForward;					//! ���� �������

		bool bTurning;						//! ������������
		bool bTurnCalled;					//! �� ���� �������� ��������������

		CVec3 vCenter;						//! ��������� ����� (� ������ ������)
		SVector vTile;						//! ��������� ����� �� ��������� ����� � AI ������
		SVector vLastKnownGoodTile;

		float fSpeed;							//! �������� �����
		float fDesiredSpeed;			//! �������� �������� ��������

		bool bLocking;						//! ���� ������� ����� ��� �����
		bool bOnLockedTiles;			//! ���� �� ��������� ������
		bool bIdle;								//! ��� ���� �� �������� ����� �����
		bool bFixUnlocking;				

		int nCollisionsCount;

		CPtr<ISmoothPath> pSmoothPath;
		CPtr<ISmoothPath> pDefaultPath;

		CPtr<IMemento>		pPathMemento;

		CPtr<ICollision>  pCurrentCollision;
		CPtr<ICollision>  pInterruptedCollision;
		bool bNoCollision;

		NTimer::STime stayTime;
		NTimer::STime collStayTime;
		NTimer::STime nextSecondPathSegmTime;
		NTimer::STime checkOnLockedTime;

		bool bMaxSlowed, bMinSlowed, bNotified;

		bool bTurningToDirContinuesly;
		SAIAngle wDirToContinueslyTurn;

		EMovementPlane eMovementPlane;
		CPtr<CAIMap> pAIMap;
		CPtr<CStaticMapHeights> pHeights;
		CPtr<ICollisionsCollector> pCollisionsCollector;

		CPtr<ISmoothPath> pInterruptedPath;
		ZSKIP
		bool bPlacementUpdated;
		bool bStoppedSent;
		ZSKIP
		CVec3 vOldPlacement;
		WORD wOldDirection;
	public:
	ZEND int operator&( IBinSaver &f ) { OnSerialize( f ); f.Add(3,&wDirection); f.Add(4,&wFrontDirection); f.Add(5,&wLastDirection); f.Add(6,&bGoForward); f.Add(7,&bTurning); f.Add(8,&bTurnCalled); f.Add(9,&vCenter); f.Add(10,&vTile); f.Add(11,&vLastKnownGoodTile); f.Add(12,&fSpeed); f.Add(13,&fDesiredSpeed); f.Add(14,&bLocking); f.Add(15,&bOnLockedTiles); f.Add(16,&bIdle); f.Add(17,&bFixUnlocking); f.Add(18,&nCollisionsCount); f.Add(19,&pSmoothPath); f.Add(20,&pDefaultPath); f.Add(21,&pPathMemento); f.Add(22,&pCurrentCollision); f.Add(23,&pInterruptedCollision); f.Add(24,&bNoCollision); f.Add(25,&stayTime); f.Add(26,&collStayTime); f.Add(27,&nextSecondPathSegmTime); f.Add(28,&checkOnLockedTime); f.Add(29,&bMaxSlowed); f.Add(30,&bMinSlowed); f.Add(31,&bNotified); f.Add(32,&bTurningToDirContinuesly); f.Add(33,&wDirToContinueslyTurn); f.Add(34,&eMovementPlane); f.Add(35,&pAIMap); f.Add(36,&pHeights); f.Add(37,&pCollisionsCollector); f.Add(38,&pInterruptedPath); f.Add(40,&bPlacementUpdated); f.Add(41,&bStoppedSent); f.Add(43,&vOldPlacement); f.Add(44,&wOldDirection); return 0; }
	private:
	
	void OnSerialize( IBinSaver &f );
	const bool MakeTurnToDirection( const WORD wDirection );

	const bool IterateUnitsProc( const CBasePathUnit *unit ) const;
	const SRect GetUnitModifiedRect( const float fCompress ) const;
	void CalculateIdle();
	void SetNextSecondPathSegmTime( const NTimer::STime time ) { nextSecondPathSegmTime = time; }

protected:
	//! �������� ������� �����, ��� ������ ������ ���-�� �� AI
	//virtual void UpdatePlacement( const CVec3 &vOldPosition )	{ NI_ASSERT( false, "Illegal call of CBasePathUnit::UpdatePlacement" ); }
	virtual void UpdatePlacement( const CVec3 &vOldPosition, const WORD wOldDirection, const bool bNeedUpdate )	= 0;
	virtual void UpdateTile() = 0;
	//! ������� ���� ��� ������������� ����� (��� �������� ��������� ���� ����)
	virtual ISmoothPath *CreateSmoothPath();
	//! ���������, �� ������� �� ����-������
	virtual void CheckForDestroyedObjects( const CVec2 &vCenter ) const = 0;
	virtual void NullSegmTime() = 0;
	virtual void AdjustSpeed();

	// called when path finished
	virtual void OnIdle() {}
	// called when unit stopped (no placement update)
	virtual void OnStopped() {}
public:
	CBasePathUnit();
	void Init( const CVec3 &vCenter, const WORD wDirection, CAIMap *pAIMap, ICollisionsCollector *pCollisionsCollector, CCommonPathFinder *pPathFinder );

	//! ���������� � ������� ����� � ������������ (3D)
	const CVec3 & GetCenter() const {	return vCenter; }
	//! ���������� � ������� ����� �� ��������� (2D)
	// hack to increase FPS :)
	const CVec2 & GetCenterPlain() const { return *( reinterpret_cast<const CVec2 *>( &vCenter ) ); }

	CCommonPathFinder* GetPathFinder() const { return pPathFinder; }
	
	//! ���������� � ������� ����� � AI ������
	const SVector GetCenterTile() const { return vTile; }
	//! ��������� ����, �� ������� ���� �� ���� �� �������
	const SVector GetLastKnownGoodTile() const { return vLastKnownGoodTile; }

	//! ���������, ��� ���� �� ����� �������� �� ������� ����� � ����� �������
	const bool IsValidCenter( const CVec3 &vCenter );
	//! �������� ����� �����, bNeedUpdate - ���������� ������������� ������ UpdatePlacement
	virtual void SetCenter( const CVec3 &vCenter, const bool bNeedUpdate = true );
  
	//! ���������, ��� ���� �� ����� �������� �� ������� ����� � ����� �����������
	const bool IsValidDirection( const WORD wDirection );
	//! ���������, ��� ���� �� ����� �������� �� ������� ����� � ����� ����������� (����������� �������� ��������)
	const bool IsValidDirection( const CVec2 &vDirection ) { return IsValidDirection( GetDirectionByVector( vDirection ) ); }
	//! �������� ����������� �������� �����, 
	const WORD GetDirection() const { return wDirection; }
	const float GetDir() const { return float(wFrontDirection) / 65536.0f * FP_2PI; }

	//! ���� ������� ����� �����
	const WORD GetFrontDirection() const { return wFrontDirection; }
	//! �������� ���������� �������� ����� � �������
	const CVec2 GetDirectionVector() const { return GetVectorByDirection( GetDirection() ); }
	//! ��������, ���� ���������� ����� ���� (�������� �� ��������� ����� ��������� ���������� �� ����������� ��������)
	const CVec2 GetMoveDirection() const;
	//! ���� ������� ����� ����� � �������
	const CVec2 GetFrontDirectionVector() const { return GetVectorByDirection( GetFrontDirection() ); }
	//! ���������� ����������� �������� �����
	virtual void SetDirection( const WORD wDirection, const bool bNeedUpdate = true );
	//! ���������� ����������� �������� ����� ��������
	void SetDirectionVec( const CVec2 &vDirection ) { SetDirection( GetDirectionByVector( vDirection ) ); }
	//! ����������� � ��������� �����������
	virtual const bool TurnToDirection( const WORD wDirection, const bool bCanBackward, const bool bCanForward );
	//! ����������� �� ��������� �����
	virtual const bool TurnToTarget( const CVec2 &vTarget );

	//! ����� �� ������� ����������� � ��������� �����������
	virtual const bool CanTurnToFrontDir( const WORD wDirection ) const;
	//! ����� �� ����������� � ��������� �����������
	virtual const bool CanTurnTo( const WORD wDirection, const bool bCanRebuildPath = true );
	//! ����� �� ������������ �� 180 ��������
	bool CanMake180DegreesTurn( SRect rect ) const;

	//! ���������, ����� �� ������������ � ����������� vDir, fRectCoeff - ����������� "����������" �������� �����
	virtual const bool CheckTurn( const float fRectCoeff, const CVec2 &vDir, const bool bWithUnits, const bool bCanGoBackward ) const;
	//! ���������� ��������
	void SetSpeed( const float _fSpeed ) { fSpeed = _fSpeed; }
	//! ���������� ��������, ��� ������ ��������� eAdjust ����� ���������� ��� ������ ������ ��������
	void SetSpeed( const EAdjustSpeedParam eAdjust, const float fValue );
	//! �������� ������� ��������
	const float GetSpeed() const { return fSpeed; }
	//! ������ �������� ��������
	void SetDesiredSpeed( const float _fSpeed ) {	fDesiredSpeed = _fSpeed; }
	//! �������� ��������
	const float GetDesiredSpeed() const { return fDesiredSpeed; }
	//! ���������� �������� �������� ������ ������������
	void ResetDesiredSpeed() { fDesiredSpeed = GetMaxPossibleSpeed(); }
	//! ������������ �������� �������� � ��������� �����. bAdjust - ��������� �������� � ������ ��������
	const float GetMaxSpeedHere( const CVec2 &vPosition, const bool bAdjust ) const;
	//! ������������ �������� �������� � �����, ��� ���������� ����� �����. ��������� ������������� � ������ �������� ��������
	const float GetMaxSpeedHere() const { return GetMaxSpeedHere( GetCenterPlain(), true ); }
	//! ���� ������ �� ���������� �����
	virtual const bool IsIdle() const { return bIdle; }
	//! ���� ������ �� ����
	virtual const bool IsMoving() const { return /* GetSmoothPath()->IsUnitMoving() || */ GetSpeed() != 0.0f; }
	//! ���� ��������������
	virtual const bool IsTurning() const { return bTurning; }
	//! ���� ���� �������
	virtual const bool IsGoForward() const { return bGoForward; }
	//! ���������� ����������� �������� ����� (������� ��� �����)
	void SetGoForward( const bool bGoForward );
	//! ������������� ��������� ���� ��������� �������
	void ForceGoForward() { bGoForward = true; }  

	//! �������� "���������" �������� ����� (����/�����)
	virtual const EMovementPlane GetMovementPlane() const { return eMovementPlane; }
	//! �������� �������� ��������� "���������" �������� ����� � �������� AI ����� (����/�����)
	virtual const EMovementPlane GetProbablePlane( const SVector &vPos ) const;

	//! ���������� ����
	virtual void Stop();
	//! ���������� ������� �����
	virtual void StopTurning() { bTurning = false; }

	//! �������� ����� ��� ������
	void LockTiles();
	//! �������� ����� ��� ������ (� ��� ����� � ��� �������)
	void ForceLockTiles();
	//! ��������� ����� ��� ������
	void UnlockTiles();
	void StaticLockTiles() const;
	//! ��������� �� ���� ����� ��� �����
	const bool IsLockingTiles() const { return bLocking; }
	//! ��������� ����������� ������ (�� �������� ��� ForceLockTiles)
	void FixUnlocking() { bFixUnlocking = true; }
	//! ��������� ����������� ������ (�� �������� ��� ForceLockTiles)
	void UnfixUnlocking() { bFixUnlocking = false; }
	//! ����� �� ���� ������ �����
	virtual const bool CanLockTiles() const { return !bLocking; }
	//! ���������, ����� �� ��������� ������� (profile) ������ �� ���������� ������
	const bool IsOnLockedTiles( const SUnitProfile &profile ) const;
	//! ������������ ����������� ������, ���������� ����� load'�
	void RestoreLock();
	 
	//! ������ ������� ����������� �����: ���������� ��������
	virtual void FirstSegment( const NTimer::STime timeDiff );
	//! ������ ������� ����������� �����: �������� ����� ����
	virtual void SecondSegment( const NTimer::STime timeDiff );
	//! ���������� �������, ����� ������� ����� ������� ������ ������� ��� �����
	virtual const NTimer::STime GetNextSecondPathSegmTime() const { return nextSecondPathSegmTime; }
	void CallUpdatePlacement();

	//! ������� ����, ���������� ��� �������� �����
	virtual ISmoothPath *GetDefaultPath() const { return pDefaultPath; }
	//! ������� ����, �� �������� �������� ���� � ������ ������
	virtual ISmoothPath *GetSmoothPath() const { return pSmoothPath; }
	//! �������� � ������� ��������� ���� 
	virtual ICollision *GetCollision() const { return pCurrentCollision; }
	//! ������ �������� ��� �����
	virtual void SetCollision( ICollision *pCollision, IPath *pPath );
	virtual void SetCollisionOld( ICollisionOld *pCollision, IPath *pPath ) {}

	const int GetStayTime() const { return stayTime; }
	void UpdateCollisionStayTime( const NTimer::STime time ) { collStayTime = Max( collStayTime, Min( stayTime, time ) ); }

	void SetLastPushUnit( CBasePathUnit *pUnit ) { pLastPushUnit = pUnit; }
	CBasePathUnit *GetLastPushUnit() const { return pLastPushUnit; }
	CBasePathUnit *GetLastPusherUnit() const { return pLastPusherUnit; }

	void IncCollisionsCount() { ++nCollisionsCount; }
	void ResetCollisionsCount() { nCollisionsCount = 0; }
	const int GetCollisionsCount() { return nCollisionsCount; }

	virtual void SetSmoothPath( ISmoothPath *_pSmoothPath )
	{
		pSmoothPath = _pSmoothPath;
	}
	virtual void RestoreSmoothPath();

	const bool IsPathFinished() const { return GetSmoothPath()->IsFinished(); }  
	//! ��� ������� ������ ���� �������������� � ������� - ��������
	virtual const int GetUniqueID() const = 0;

	//! ��������� ����� �����, �� ������������� (�.�. ������ �����) ���������������� ���������
	virtual const float GetMaxPossibleSpeed() const = 0;
	virtual const EAIClasses GetAIPassabilityClass() const = 0;
	virtual const float GetTurnRadius() const = 0;
	virtual const float GetTurnSpeed() const = 0;
	virtual const SUnitProfile &GetUnitProfile() const = 0;
	virtual const SRect & GetUnitRect() const = 0;
	virtual const CVec2 &GetAABBHalfSize() const = 0;
	virtual const CVec2 GetCenterShift() const = 0;
	virtual const bool CanGoBackward() const = 0;
	virtual const bool CanTurnRound() const = 0;
	virtual const bool IsRound() const = 0;
	virtual const int GetBoundTileRadius() const = 0;
	virtual const float GetSmoothTurnThreshold() const = 0;
	virtual const float GetPassability() const = 0;
	virtual const bool CanGoToPoint( const CVec2 &point ) const = 0;
	virtual const bool CanTurnInstant() const { return false; }
	virtual const bool CanChangeSpeedInstand() const { return false; }
	virtual const bool ShouldScatter() const { return false; }
	virtual const bool IsInfantry() const { return false; }
	virtual const bool IsAviation() const { return false; }
	

	//! ����� �� ���� ���������
	virtual const bool CanMove() const { return true; }
	//! ����� �� ���� ��������� ���� ����� ����
	virtual const bool CanMoveCritical() const { return true; }
	//! ����� �� ���� ��������������
	virtual const bool CanRotate() const { return true; }


	//! ���� �������� ������ ������ (pTramplerUnit - ����, ������� ������� this)
	virtual void UnitTrampled( const CBasePathUnit *pTramplerUnit ) = 0;
	
	//! ���� ����� ���� �������� ������ ������ (pTramplerUnit - ��� ��� ���������� ������ this)
	//! ���-�� ����� this - ������ � ���� ��� pTramplerUnit
	virtual const bool CanUnitTrampled( const CBasePathUnit *pTramplerUnit ) const = 0;

	virtual const bool IsDangerousDirExist() const = 0;
	virtual const WORD GetDangerousDir() const = 0;

	//! � ��� ����� ����������� ����
	virtual const ECollidingType GetCollidingType( CBasePathUnit *pUnit ) const { return ECT_ALL; }

	//! �������� �������� �� ������ CUnitsIter< 0, 0 >, ��� ������� ����� ����� ������� ������� iterFunc,
	//! ������������ ������������ �� ��� ��� ���� ���� ����� � ���� iterFunc ���������� true. ������������
	//! �������� ����� ���������� �������� iterFunc, ��� ���� (this) ������� �� ������� ����� ��������
	virtual const bool IterateUnits( const CVec2 &vCenter, const float fRadius,	const bool bOnlyMech, const SIterateUnitsCallback &callback ) const = 0;

	virtual void TurnToDirectionContinuesly( const WORD _wDirection );

	//! ������� ���� ����� ����, ���������� true, ���� ���� ������
	virtual const bool SendAlongPath( IPath *pPath );
	//! ������� ���� ����� ����, ���������� true, ���� ���� ������
	virtual const bool SendAlongPath( IStaticPath *pStaticPath, const CVec2 &vShift, const bool bSmoothTurn );
	//! ������� ���� ����� ����, ���������� true, ���� ���� ������
	virtual void SendAlongSmoothPath( ISmoothPath *pPath );

	virtual IStaticPath *CreateBigStaticPath( const CVec2 &vStartPoint, const CVec2 &vFinishPoint, IPointChecking *pChecking );
	virtual const NTimer::STime GetCollStayTime() { return collStayTime; }
	virtual void ResetCollStayTime() { collStayTime = 0; }

	virtual void NotifyAboutClosestThreat( const CBasePathUnit *pUnit, const float fDistance );
	virtual const bool IsStaticUnit() const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! CBasePathUnit �� �������� �������� CObjectBase, ������� ��� ��� ������������ ������ ������������ operator&, ����������
//! ������������ SerializeBasePathUnit( ... )
void SerializeBasePathUnit( IBinSaver &saver, const int nChunkID, CBasePathUnit **pUnit );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
