#include "stdafx.h"

#include "AIMap.h"
#include "BasePathUnit.h"
#include "CommonPathFinder.h"
#include "StandartPath2.h"
#include "StaticPathInternal.h"
#include "Terrain.h"

#include "../Misc/Bresenham.h"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//������������ ���������� �����, �� ������� ����� ���������� ������ (� ������� PeekPoint)
static const int MAX_LOOK_FORWARD_POINTS = 7;
//������������ ����� ��������� ���� � ������
static const int MAX_PATH_TILES_COUNT = 64;
//� ������ ���� ����� ��������� ������ �� ������� ������
static const int SMALL_PATH_TILES_COUNT = MAX_PATH_TILES_COUNT/4;
//����������� ����� ����� �� ����������� ����
static const int STATIC_PATH_SHIFT = 10;
// p.s. ������������ ���������� ������, ������� ����� �������� - MAX_PATH_TILES_COUNT - ( 2 x MAX_LOOK_FORWARD_POINTS )
static vector<SVector> pathBuffer( MAX_PATH_TILES_COUNT );
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define INVALID_TILE SVector( -1, -1 )
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
inline const bool IsValidTile( const SVector &vTile )
{
	return vTile.x >= 0;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ���������� true, ���� vPoint ����� � vEndPoint1, ��� � vEndPoint2
inline const bool CompareDistance( const SVector &vEndPoint1, const SVector &vEndPoint2, const SVector &vPoint )
{
	return mDistance( vEndPoint1, vPoint ) < mDistance( vEndPoint2, vPoint );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CStandartPath2::CStandartPath2() : pPathFinder( 0 ), pAIMap( 0 ), nBoundTileRadius( -1 ), aiClass( EAC_NONE ), pStaticPath( 0 ),
  nCurStaticPathTile( -1 ), vStartPoint( VNULL2 ), vFinishPoint( VNULL2 ), vShift( VNULL2 ), nCurInsTile( 0 ), nCurPathTile( 0 ),
	nLastPathTile( -1 ), vShiftTile( 0, 0 ), vFinishTile( 0, 0 ), nUnitID( -1 )
{
	pathTiles.resize( MAX_PATH_TILES_COUNT, SVector( 0, 0 ) );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CStandartPath2::CStandartPath2( const CBasePathUnit *pUnit, IStaticPath *_pStaticPath, const CVec2 &_vStartPoint, const CVec2 &_vFinishPoint, CAIMap *_pAIMap )
: pPathFinder( pUnit->GetPathFinder() ), pAIMap( _pAIMap ), nBoundTileRadius( pUnit->GetBoundTileRadius() ), aiClass( pUnit->GetAIPassabilityClass() ),
	nCurInsTile( 0 ), vFinishTile( 0, 0 ), nUnitID( pUnit->GetUniqueID() )
{
	const int nUnitID = pUnit->GetUniqueID();
	pathTiles.resize( MAX_PATH_TILES_COUNT );
	InitByStaticPath( dynamic_cast<CCommonStaticPath *>( _pStaticPath ), _vStartPoint, _vFinishPoint, false );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CStandartPath2::InitByStaticPath( CCommonStaticPath *_pStaticPath, const CVec2 &_vStartPoint, const CVec2 &_vFinishPoint, const bool bResetShift )
{
	pStaticPath = _pStaticPath;
	vStartPoint = _vStartPoint;
	SetFinishPoint( _vFinishPoint );
	vShift = ( bResetShift || pStaticPath == 0 ) ? VNULL2 : vFinishPoint - pStaticPath->GetFinishPoint();
	vShiftTile.x = vShift.x/pAIMap->GetTileSize();
	vShiftTile.y = vShift.y/pAIMap->GetTileSize();
	nCurPathTile = 0;
	nLastPathTile = 1;
	nCurStaticPathTile = 0;
	pathTiles[1] = pathTiles[0] = GetTile( vStartPoint );

	if ( pStaticPath == 0 )
		SetFinishPoint( vStartPoint );
	else
		CalculatePath( true, INVALID_TILE );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const bool CStandartPath2::CanUnitGo( const SVector &vTile ) const
{
	STerrainModeSetter oldMode( ELM_STATIC, pAIMap->GetTerrain() );
	return pAIMap->GetTerrain()->CanUnitGo( nBoundTileRadius, vTile, aiClass ) != FREE_NONE;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const SVector CStandartPath2::GetTile( const CVec2 &vPoint ) const
{
	return pAIMap->GetTile( vPoint );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const CVec2 CStandartPath2::GetPoint( const SVector &vTile ) const
{
	return pAIMap->GetPointByTile( vTile );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ������ ���� � ������������� ������� (INVALID_TILE) ���� ����� �� �������, ��������� ����� ��������� �������� IsValidTile
const SVector CStandartPath2::GetTileWithShift( const SVector &vTile ) const
{
	const SVector vEndTile( vTile + vShiftTile );

	CBres bres;
	bres.InitPoint( vTile, vEndTile );

	bool bCanUnitGo = CanUnitGo( bres.GetDirection() );
	if ( !bCanUnitGo )
		return INVALID_TILE;

	SVector vResult = vTile;
	while ( bCanUnitGo && bres.GetDirection() != vEndTile )
	{
		vResult = bres.GetDirection();
		bres.MakePointStep();
		bCanUnitGo = CanUnitGo( bres.GetDirection() );
	}

	return vResult;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CStandartPath2::CopyPath( const int nLength )
{
	if ( nLength < 0 )
		return;
	pPathFinder->GetTiles( &(pathBuffer[0]), nLength );
	const int nCopyTiles = Min( nLength, MAX_PATH_TILES_COUNT - nLastPathTile );
	memcpy( &(pathTiles[0]) + nLastPathTile, &(pathBuffer[0]), sizeof(SVector) * Min( nLength, MAX_PATH_TILES_COUNT - nLastPathTile ) );
	if ( nLength > nCopyTiles )
		memcpy( &(pathTiles[0]), &(pathBuffer[0]) + nCopyTiles, sizeof(SVector) * ( nLength - nCopyTiles ) );
	nLastPathTile = (nLastPathTile+nLength)%MAX_PATH_TILES_COUNT;
	// ���� ����� ���� ����������
	pathTiles[nLastPathTile] = pathBuffer[nLength-1];
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const bool CStandartPath2::CalculatePath( const bool bShift, const SVector &vLastKnownGoodTile )
{
	// ������ �������, ���� �����������
	if ( pathTiles[nLastPathTile] == vFinishTile ) 
		return false;

	const int nPrevStaticPathTile = nCurStaticPathTile;
	// �������� ����� �� ������� ����������� ����
	if ( bShift )
		nCurStaticPathTile = Min( nCurStaticPathTile + STATIC_PATH_SHIFT, pStaticPath->GetLength()-2 );
	
	SVector vNextTile = GetTileWithShift( pStaticPath->GetTile( nCurStaticPathTile ) );
	bool bNextTileValid = true;
	if ( !IsValidTile( vNextTile ) )
	{
		int nShift = 1;
		while ( nShift < STATIC_PATH_SHIFT && !IsValidTile( vNextTile ) )
		{
			if ( nCurStaticPathTile + nShift < pStaticPath->GetLength()-1 )
				vNextTile = GetTileWithShift( pStaticPath->GetTile( nCurStaticPathTile + nShift ) );
			if ( IsValidTile( vNextTile ) )
				nCurStaticPathTile += nShift;
			else if ( nCurStaticPathTile - nShift > nPrevStaticPathTile )
			{
				vNextTile = GetTileWithShift( pStaticPath->GetTile( nCurStaticPathTile - nShift ) );
				if ( IsValidTile( vNextTile ) )
					nCurStaticPathTile -= nShift;
			}
			++nShift;
		}
		if ( !IsValidTile( vNextTile ) )
		{
			vNextTile = pStaticPath->GetTile( nCurStaticPathTile );
			bNextTileValid = false;
		}
	}

	//� ��� ������ ������� ��������� ����, �������� ���� - vNextTile, ����� �� �� - bNextTileValid, ��� ������ - nCurStaticPathTile
	if ( IsValidTile( vLastKnownGoodTile ) )
	{
		//DebugTrace( ">>>> CalculatePath: %d x %d - %d x %d (%s) (valid: %d x %d) for unit %d (%d & %d)", pathTiles[nLastPathTile].x, pathTiles[nLastPathTile].y, vNextTile.x, vNextTile.y, bNextTileValid ? "true" : "false", vLastKnownGoodTile.x, vLastKnownGoodTile.y, nUnitID, aiClass, nBoundTileRadius );
		pPathFinder->SetPathParameters( nBoundTileRadius, aiClass, GetPoint( pathTiles[nLastPathTile] ), GetPoint( vNextTile ), vLastKnownGoodTile, pAIMap );
	}
	else
	{
		//DebugTrace( ">>>> CalculatePath: %d x %d - %d x %d (%s) (valid: none) for unit %d (%d & %d)", pathTiles[nLastPathTile].x, pathTiles[nLastPathTile].y, vNextTile.x, vNextTile.y, bNextTileValid ? "true" : "false", nUnitID, aiClass, nBoundTileRadius );
		pPathFinder->SetPathParameters( nBoundTileRadius, aiClass, GetPoint( pathTiles[nLastPathTile] ), GetPoint( vNextTile ), pathTiles[nLastPathTile], pAIMap );
	}
	CPtr<IStaticPath> pFoundStaticPath = pPathFinder->CreatePath( false );
	pPathHistory2 = pPathHistory1;
	pPathHistory1 = pFoundStaticPath;

	// ���� ���� �� ������ - ������ �� ������, ��� �� ��������� ��� �����������, ��� ���� ����������
	// ������������ ���� ������ ��� - ��� ����� �� ��������
	if ( pFoundStaticPath == 0 )
		return false;

	if ( pFoundStaticPath->GetStartTile() == pFoundStaticPath->GetFinishTile() )
		return false;

	if ( pFoundStaticPath->GetFinishTile() != vNextTile )
		bNextTileValid = false;

	// ���� ���� ���� �� ������� ������� - �������� ���
	if ( pFoundStaticPath->GetLength() <= SMALL_PATH_TILES_COUNT )
	{
		CopyPath( pFoundStaticPath->GetLength() );
		// ��� ��� ��������� ��� - ������������ �������� �����
		if ( nCurStaticPathTile == pStaticPath->GetLength()-2 )
			SetFinishTile( pathTiles[nLastPathTile] );
	}
	else
	{
		// ��������� nCurStaticPathTile � ���� �� ����, ����� ��� ���� ����������� ������
		int nLength = Min( pFoundStaticPath->GetLength()-1, MAX_PATH_TILES_COUNT - 2*MAX_LOOK_FORWARD_POINTS );
		bool bCloseToFinish = false;
		do
		{
			bCloseToFinish = CompareDistance( vFinishTile, vNextTile, pFoundStaticPath->GetTile( nLength ) );
			if ( !bCloseToFinish )
				--nLength;
		} while( nLength > SMALL_PATH_TILES_COUNT && !bCloseToFinish );
    CopyPath( nLength );

		// �������� �����, ������� ����� � ������, ��� � ��������
		if ( bCloseToFinish )
		{
			int nBestStaticPathTile = nCurStaticPathTile;
			int nBestDistance = mDistance( pStaticPath->GetTile( nBestStaticPathTile ) + vShiftTile, pathTiles[nLastPathTile] );
			for ( int i = nCurStaticPathTile+1; i < pStaticPath->GetLength()-1; ++i )
			{
				const int nThisDistance = mDistance( pStaticPath->GetTile( i ) + vShiftTile, pathTiles[nLastPathTile] );
				if ( nThisDistance < nBestDistance )
				{
					nBestDistance = nThisDistance;
					nBestStaticPathTile = i;
				}
			}
			nCurStaticPathTile = nBestStaticPathTile;
		}
		// ��� ��� ��������� ��� - ������������ �������� �����
		if ( nCurStaticPathTile == pStaticPath->GetLength()-2 )
			SetFinishTile( pFoundStaticPath->GetFinishTile() );
	}
	return true;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const CVec2 CStandartPath2::PeekPoint( const int _nShift ) const
{
	if ( IsFinished() )
		return vFinishPoint;

	if ( nCurInsTile + _nShift < insTiles.size() )
		return GetPoint( insTiles[nCurInsTile+_nShift] );

	int nShift = nCurInsTile + _nShift - insTiles.size();
	NI_VERIFY( nShift <= MAX_LOOK_FORWARD_POINTS, "Cannot predict point. Shift too far", nShift = MAX_LOOK_FORWARD_POINTS );
  
	const int nLastPathTile2 = ( nCurPathTile < nLastPathTile ) ? nLastPathTile : nLastPathTile + MAX_PATH_TILES_COUNT; 
	if ( nCurPathTile + nShift > nLastPathTile2 )
		return vFinishPoint;

	const int nTile = ( nCurPathTile + nShift )%MAX_PATH_TILES_COUNT;
	return GetPoint( pathTiles[nTile] );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CStandartPath2::Shift( const int _nShift )
{
	if ( IsFinished() )
		return;
	if ( nCurInsTile + _nShift < insTiles.size() )
	{
		nCurInsTile += _nShift;
		return;
	}

	const int nShift = nCurInsTile + _nShift - insTiles.size();
	nCurInsTile = insTiles.size();

	nCurPathTile = ( nCurPathTile + nShift )%MAX_PATH_TILES_COUNT;
	const int nLastPathTile2 = ( nCurPathTile < nLastPathTile ) ? nLastPathTile : nLastPathTile + MAX_PATH_TILES_COUNT; 
	if ( nCurPathTile + MAX_LOOK_FORWARD_POINTS >= nLastPathTile2 )
	{
		CalculatePath( true, INVALID_TILE );
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CStandartPath2::InsertTiles( const list<SVector> &tiles )
{
	insTiles.clear();
	for ( list<SVector>::const_iterator it = tiles.begin(); it != tiles.end(); ++it )
		insTiles.push_back( *it );
	nCurInsTile = 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const bool CStandartPath2::CanGoBackward( const CBasePathUnit *pUnit ) const
{ 
	return pUnit->CanGoBackward() && pStaticPath->GetLength() * float( pAIMap->GetTileSize() ) <= pUnit->GetUnitProfile().GetHalfLength() * 5.0f;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CStandartPath2::RecoverPath( const CVec2 &vPoint, const bool bIsPointAtWater, const SVector &vLastKnownGoodTile )
{
	//DebugTrace( "(%d) CStandartPath2::RecoverPath( %2.3f x %2.3f, %s, %d x %d )", nUnitID, vPoint.x, vPoint.y, bIsPointAtWater ? "true" : "false", vLastKnownGoodTile.x, vLastKnownGoodTile.y );
	CPtr<IStaticPath> pNewStaticPath = 0;
	{
		STerrainModeSetter modeSetter( ELM_STATIC, pAIMap->GetTerrain() );
		pPathFinder->SetPathParameters( nBoundTileRadius, aiClass, vPoint, vFinishPoint, vLastKnownGoodTile, pAIMap );
		pNewStaticPath = pPathFinder->CreatePath( false );
	}
	if ( IsValid( pStaticPath ) && IsValid( pNewStaticPath ) && nCurStaticPathTile < pStaticPath->GetLength()-2 )
	{
		CPtr<IStaticPath> pBackStaticPath = 0;
		STerrainModeSetter modeSetter( ELM_STATIC, pAIMap->GetTerrain() );
		pPathFinder->SetPathParameters( nBoundTileRadius, aiClass, vPoint, GetPoint( pStaticPath->GetTile( nCurStaticPathTile ) ), vLastKnownGoodTile, pAIMap );
		pBackStaticPath = pPathFinder->CreatePath( false );
		if ( IsValid( pBackStaticPath ) && pBackStaticPath->GetLength() + pStaticPath->GetLength() - nCurStaticPathTile < pNewStaticPath->GetLength()+STATIC_PATH_SHIFT )
		{
			if ( pBackStaticPath->MergePath( pStaticPath, nCurStaticPathTile ) )
				pNewStaticPath = pBackStaticPath;
		}
	}
	InitByStaticPath( dynamic_cast_ptr<CCommonStaticPath*>( pNewStaticPath ), vPoint, pNewStaticPath->GetFinishPoint(), true );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CStandartPath2::RecalcPath( const CVec2 &vPoint, const bool bIsPointAtWater, const SVector &vLastKnownGoodTile )
{
	vStartPoint = vPoint;
	nCurPathTile = 0;
	nLastPathTile = 1;
	pathTiles[0] = pathTiles[1] = pAIMap->GetTile( vPoint );

	if ( !CalculatePath( false, vLastKnownGoodTile ) )
		nLastPathTile = 0;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CStandartPath2::MarkPath( const int nID, const NDebugInfo::EColor color ) const
{
	vector<SVector> tiles;

	if ( IsFinished() )
		return;

	if ( nCurInsTile < insTiles.size() )
	{
		for ( int i = nCurInsTile; i < insTiles.size(); ++i )
			tiles.push_back( insTiles[i] );
	}

	int i = nCurPathTile;
	while ( i != nLastPathTile )
	{
		tiles.push_back( pathTiles[i] );
		++i;
		if ( i == MAX_PATH_TILES_COUNT ) 
			i = 0;
	}
	DebugInfoManager()->CreateMarker( nID, tiles, color );
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
REGISTER_SAVELOAD_CLASS( 0x3121AC40, CStandartPath2 );
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
