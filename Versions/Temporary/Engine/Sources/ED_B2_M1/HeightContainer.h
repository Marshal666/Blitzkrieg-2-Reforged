#if !defined(__MAPINFO_HEIGHT_CONTAINER__)
#define __MAPINFO_HEIGHT_CONTAINER__
#pragma once

#include "..\MapeditorLib\Tools_FreeIDCollector.h"
#include "VSOManager.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CHeightContainer
{
	static int STACK_SIZE;
	static int TRACE_IMAGE_TILE_SIZE;
	//
	CTPoint<int> planeSize;														// ������ ���������� ���������
	int nStackCount;																	// ���������� ������
	float fTileSize;																	// ������ �����
	vector<CArray2D<DWORD> > blackPlaneStackList;			// ����� ���������� ���������� ( �� sizeof(DWORD) �� ���� ) (������)
	vector<CArray2D<DWORD> > redPlaneStackList;				// ����� ���������� ���������� ( �� sizeof(DWORD) �� ���� ) (�������)
	vector<DWORD> markedBitslList;										// ����� ����� ����������� ����� (������� �� ������ ���������)
	vector<DWORD> filledBitsList;											// ����� ����� ����������� ������������� ( ���� ��������� ����� == 0, �� ����� ��������� ���������� ���������� ) (����� ��� ����� ����� ����������)
	CFreeIDCollector freePlaneIndexCollector;					// ������ ��������� ����������
	hash_map<int, int> polygonID2PlaneIndexMap;				// PolygonID -> PlaneIndex (0...nCount)
	//
	bool bTraceToImage;																// ��� �������� �����
	//
	void AddStack();																											// �������� ����� ����� ����������
	void EraseStack();																										// ������� �������������� ����� ����������
	int AddPlane( int nPolygonID );																				// �������� ��������� � ������ ����������
	void ErasePlane( int nPolygonID );																		// ������� ��������� �� ������ ��������
	//
	void ClearPlane( int nPlaneIndex );																		// �������� ���������
	void FillPlane( int nPlaneIndex,
									const vector<CVec2> &rBlackPolygon,
									const vector<CVec2> &rRedPolygon );										// ��������� ���������
	//
	void GetBits( vector<DWORD> *pBitsList, const int x, const int y );
	void AddBitsToString( string *pszMessage, const DWORD dwBits ) const;
	//
	void MarkTraceImageTile( CArray2D<DWORD> *pImage, int x, int y, DWORD dwColor );
	void MarkTraceImageGrid( CArray2D<DWORD> *pImage, DWORD dwColor );

public:
	CHeightContainer( const float _fTileSize );
	//
	void Clear();
	void SetSize( const int x, const int y, bool _bTraceToImage );
	inline bool IsValid() { return ( fTileSize > 0.0f ) && ( nStackCount > 0 ) && ( planeSize.x > 0 ) && ( planeSize.y > 0 ); }
	//
	void Mark( const int x, const int y );																// ��������� �����
	bool Compare( const int x, const int y );															// true - identical, false - not identical
	//
	void InsertPolygon( const vector<CVec2> &rBlackPolygon,
											const vector<CVec2> &rRedPolygon,
											int nPolygonID );																	// �������� ��� �������� �������
	void ErasePolygon( int nPolygonID );																	// ������� �������
	bool GetBlackRedBallance( const CTRect<int> &rRect );
	//
	void InsertVSO( const NDb::SVSOInstance &rVSO );
	//
	void Trace();
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__MAPINFO_HEIGHT_CONTAINER__)
