#if !defined(__BRIDGERPGSTATS_EXPORTER__)
#define __BRIDGERPGSTATS_EXPORTER__

#pragma once

#include "StaticObjectRPGStatsExporter.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CBridgeRPGStatsExporter : public CStaticObjectRPGStatsExporter
{
	OBJECT_NOCOPY_METHODS( CBridgeRPGStatsExporter );

	enum LOCK_TYPE
	{
		LOCK_TILE					= 0,
		UNLOCK_TILE				= 1,
		SHIP_LOCK_TILE		= 2,
		SHIP_UNLOCK_TILE	= 3,
	};

	enum EAIGeometry
	{
		AIG_MAI			= 0,
		AIG_CENTER	= 1,
		AIG_BORDER	= 2,
		AIG_COUNT		= 3,
	};
	//
	typedef hash_map<string, string> CTempNamesMap;
	CTempNamesMap tempNamesMap;

	void GetTempAIGeometryName( string *pszAIGeometryPrefix, const string &rszVisObjectName, const CDBID &rDBID, EAIGeometry eAIGeometry );
	void GetVisObjectNameList( list<string> *pVisOblectNameList, interface IManipulator *pManipulator );
	//
	void EnlargeArray( CArray2D<BYTE> *pDestination, const CVec2 &rvDestination, const CVec2 &rvSource );
	void EnlargeArray( CArray2D<BYTE> *pDestination, const CTPoint<int>  &rSourceSize );
	// ��������� ������ �� ������� X
	void EnlargeXSide( CArray2D<BYTE> *pDestination, CVec2 *pOrigin, int nAITileCount );
	// ��������� ������ �� ������� Y
	void EnlargeYSide( CArray2D<BYTE> *pDestination, CVec2 *pOrigin, bool bMakeStep, int nAITileCount );
	//
	void SetArrayInfo( CArray2D<BYTE> *pDestination, const CArray2D<BYTE> &rSource, LOCK_TYPE lockType );
	//
	void ExportAdditionalInfo( IManipulator *pManipulator, const string &rszObjectName, const CDBID &rDBID );
protected:
	bool NeedCreatePassability() { return false; }
	//
	CBridgeRPGStatsExporter() {}
public:
	//CStaticObjectRPGStatsExporter
	void FinishExport( const string &rszObjectTypeName, bool bForce );
	EXPORT_RESULT ExportObject( IManipulator* pManipulator,
															const string &rszObjectTypeName,
															const string &rszObjectName,
															bool bForce,
															EXPORT_TYPE exportType );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__BRIDGERPGSTATS_EXPORTER__)
