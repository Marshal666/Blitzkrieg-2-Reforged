#include "stdafx.h"

#include "..\misc\bresenham.h"
#include "CLockWithUnlockPossibilities.h"
#include "AIUnit.h"
#include "UnitsIterators2.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*******************************************************************
//*										  CLockWithUnlockPossibilities								*
//*******************************************************************
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CLockWithUnlockPossibilities::TryLockAlongTheWay( const bool bLock, const BYTE _bAIClass )
{
	// ��������/��������� ����� 
	if ( bLock )
	{
		NI_ASSERT( pathTiles.size() == 0, "wrong call" );
		NI_ASSERT( formerTilesType.size() == 0, "wrong call" );
		// ����� ���������� ������, ������� ����� ���� �� ����� ����.
		int nUnits = 0;
		for ( CUnitsIter<0,3> iter( 0, ANY_PARTY, bigRect.center, Max( bigRect.width, Max(bigRect.lengthAhead,bigRect.lengthBack) ) );
					!iter.IsFinished(); iter.Iterate() )
		{
			if ( bigRect.IsIntersected( (*iter)->GetUnitRect() ) ) 
			{
				if ( ++nUnits > 1 )
					return false;
			}
		}

		// ��������� ����
		// ��������� ��������� ������������ �� ���� ���� � �������� ����������� ����� �������
		GetAIMap()->GetTilesCoveredByRect( bigRect, &pathTiles );
		
		formerTilesType.resize( pathTiles.size(),0 );
		int i = 0;
		bool bPossible = true;
		bAIClass = _bAIClass;
		for ( list<SVector>::iterator it = pathTiles.begin(); it != pathTiles.end(); ++it )
		{
			BYTE b = GetTerrain()->GetTileLockInfo( (*it) );
			formerTilesType[i] = b;
			bPossible &= !(formerTilesType[i] & bAIClass); // ����� �� ���� �������� �� ������� ����
			++i;
		}
		if (!bPossible)
		{
			pathTiles.clear();
			formerTilesType.clear();
			return false;
		}
		else
		{
			// ��������� ������
			Unlock();

			// ��� ��-������ ��������
			list<SObjTileInfo> tilesInfo;
			for ( list<SVector>::iterator it = pathTiles.begin(); it != pathTiles.end(); ++it )
				tilesInfo.push_back( SObjTileInfo( *it, EAC_ANY ) );

			GetTerrain()->AddStaticObjectTiles( tilesInfo );
		}
	}
	else
	{
		if ( pathTiles.size() != 0 ) // ���-�� ������
		{
			//��������� 
			list<SObjTileInfo> tilesInfo;
			for ( list<SVector>::iterator it = pathTiles.begin(); it != pathTiles.end(); ++it )
				tilesInfo.push_back( SObjTileInfo( *it, EAC_ANY ) );

			GetTerrain()->RemoveStaticObjectTiles( tilesInfo );

			//�������� ��� ���� �� ������ ��������
			Lock();

			pathTiles.clear();
			formerTilesType.clear();
		}
	}
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CLockWithUnlockPossibilities::Lock()
{
	int i=0;
	BYTE aiClass=0;
	bool aiAnyExists = false;

	list<SObjTileInfo> tilesInfo;
	for ( list<SVector>::iterator it = pathTiles.begin(); it != pathTiles.end(); ++it )
	{
//		GetTerrain()->LockTile( (*it), formerTilesType[i] );
		tilesInfo.push_back( SObjTileInfo(*it, formerTilesType[i]) );

		aiClass |= formerTilesType[i];
		aiAnyExists |= (formerTilesType[i]==EAC_ANY);
		++i;
	}

	GetTerrain()->AddStaticObjectTiles( tilesInfo );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CLockWithUnlockPossibilities::Unlock()
{
	int i=0;
	BYTE aiClass=0;
	bool aiAnyExists = false;

	list<SObjTileInfo> tilesInfo;
	for ( list<SVector>::iterator it = pathTiles.begin(); it != pathTiles.end(); ++it )
	{
//		GetTerrain()->UnlockTile( (*it), formerTilesType[i] );
		tilesInfo.push_back( SObjTileInfo(*it, formerTilesType[i]) );

		aiClass |= formerTilesType[i];
		aiAnyExists |= (formerTilesType[i]==EAC_ANY);
		++i;
	}

	GetTerrain()->AddStaticObjectTiles( tilesInfo );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
