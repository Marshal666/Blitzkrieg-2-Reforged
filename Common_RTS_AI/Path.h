#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "../Common_RTS_AI/AIClasses.h"
#include "../DebugTools/DebugInfoManager.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CBasePathUnit;
class CAIMap;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! ��� �� ���������� �� �����...
interface IMemento : public CAIObjectBase
{
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! ���� �����
interface IPath : public CAIObjectBase
{
	virtual bool IsFinished() const = 0;

	virtual const CVec2 PeekPoint( const int nShift ) const = 0;
	virtual void Shift( const int nShift ) = 0;

	virtual const CVec2& GetFinishPoint() const = 0;
	virtual const CVec2& GetStartPoint() const = 0;

	//! ������������ ���� �� ����� ����� ( vPoint )
	virtual void RecoverPath( const CVec2 &vPoint, const bool bIsPointAtWater, const SVector &vLastKnownGoodTile ) = 0;
	//! ����������� ���� �� ����� ����� ( vPoint )
	virtual void RecalcPath( const CVec2 &vPoint, const bool bIsPointAtWater, const SVector &vLastKnownGoodTile ) = 0;
	//! �������� ����� � ������ ����
	virtual void InsertTiles( const list<SVector> &tiles ) = 0;
	//! ����� �� �������� ���� ���� �����
	virtual const bool CanGoBackward( const CBasePathUnit *pUnit ) const = 0;
	virtual const bool ShouldCheckTurn() const = 0;
	//! ����� �� ��� ����� ���� ��������� ������� ��������
	virtual const bool CanBuildComplexTurn() const = 0;

	virtual void MarkPath( const int nID, const NDebugInfo::EColor color ) const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! ���������� ���� �����, ������ ����� ����� ���� � ���������� �������� �����
interface ISmoothPath : public CAIObjectBase
{
	// ���������� - ����� ���� �� ���� ��� ���
	virtual bool Init( CBasePathUnit *pUnit, IPath *pPath, bool bSmoothTurn, bool bCheckTurn, CAIMap *pAIMap ) = 0;
	virtual bool Init( IMemento *pMemento, CBasePathUnit *pUnit, CAIMap *pAIMap ) = 0;

	virtual bool IsFinished() const = 0;

	virtual void Stop() = 0;

	virtual void Segment( const NTimer::STime timeDiff ) = 0;

	virtual const bool CanGoBackward() const = 0;
	virtual const bool CanGoForward() const = 0;

	virtual const CVec2 PeekPathPoint( const int nShift ) const = 0;
	virtual IMemento* CreateMemento() const = 0;

	virtual const float GetSpeed() const { return -1.0f; }

	virtual bool InitByFormationPath( class CFormation *pFormation, CBasePathUnit *pUnit ) { return true; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
