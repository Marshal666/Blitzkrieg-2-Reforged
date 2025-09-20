#include "StdAfx.h"
#include "../misc/2darray.h"
#include "../misc/strproc.h"
#include "../zlib/zconf.h"
#include "../3dmotor/dbscene.h"
#include "../vendor/Granny/include/granny.h"

#include "../libdb/ResourceManager.h"
#include "../MapEditorLib/ExporterFactory.h"
#include "../MapEditorLib/ManipulatorManager.h"
#include "../MapEditorLib/Interface_MOD.h"

#include "ExporterMethods.h"
#include "FenceRPGStatsExporter.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
REGISTER_EXPORTER_IN_DLL( FenceRPGStats, CFenceRPGStatsExporter )

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EXPORT_RESULT CFenceRPGStatsExporter::ExportObject( IManipulator* pManipulator,
																										const string &rszObjectTypeName,
																										const string &rszObjectName,
																										bool bForce,
																										EXPORT_TYPE exportType )
{
	CStaticObjectRPGStatsExporter::ExportObject( pManipulator, rszObjectTypeName, rszObjectName, bForce, exportType );
	//
	if ( exportType == ET_BEFORE_REF )
		return ER_SUCCESS;
	//
	IResourceManager *pResourceManager = Singleton<IResourceManager>();
	CArray2D<BYTE> passabilityArray( 1, 3 );
	passabilityArray[0][0] = 1;
	passabilityArray[1][0] = 1;
	passabilityArray[2][0] = 1;
	CVec3 vPassabilityOrigin( AI_TILE_SIZE / 2.0f, AI_TILE_SIZE / 2.0f, 0 );
	ExportVisobjs( pManipulator, "CenterSegments", passabilityArray, vPassabilityOrigin );

	ExportVisobjs( pManipulator, "DamagedSegments", passabilityArray, vPassabilityOrigin );

	passabilityArray[0][0] = 0;
	passabilityArray[1][0] = 0;
	passabilityArray[2][0] = 0;
	ExportVisobjs( pManipulator, "DestroyedSegments", passabilityArray, vPassabilityOrigin );

	CreatePassProfiles( pManipulator, "CenterSegments" );
	CreatePassProfiles( pManipulator, "DamagedSegments" );
	CreatePassProfiles( pManipulator, "DestroyedSegments" );

	return ER_SUCCESS;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CFenceRPGStatsExporter::GetGeom0FileName( IManipulator *pManipulator, const string &rszSegmentsSetName, string *pszGeomFileName )
{
	// �������� ����������� �� VisObject-�
	int nNumVisobjs = 0;
	if ( !CManipulatorManager::GetValue( &nNumVisobjs, pManipulator, rszSegmentsSetName + ".VisObjes" ) )
		return false;

	if ( nNumVisobjs <= 0 )
		return false;

	// ������������� ������ ������ ������ (���� �� ���������)
	// �.�. passability � ��� ���� ������ ���� ����������
	string szObjName = rszSegmentsSetName + ".VisObjes.[0]";

	IResourceManager *pResourceManager = Singleton<IResourceManager>();
	if ( !pResourceManager )
		return false;

	CPtr<IManipulator> pVisObjectManipulator = CManipulatorManager::CreateManipulatorFromReference( szObjName, pManipulator, 0, 0, 0 );
	if ( !pVisObjectManipulator )
		return false;

	// �������� ����������� ������ ������ �� ��������� ( ������ )
	CPtr<IManipulator> pModelManipulator = CreateModelManipulatorFromVisObj( pVisObjectManipulator, 0 );
	if ( pModelManipulator == 0 )
		return false;

	string szGeometryName;
	CManipulatorManager::GetParamsFromReference( "Geometry", pModelManipulator, 0, &szGeometryName, 0 );
	//
	SUserData *pUserData = Singleton<IUserDataContainer>()->Get();
	const string szGeometriesFolder =	Singleton<IMODContainer>()->GetDataFolder( SUserData::NPT_EXPORT_DESTINATION ) + "bin\\Geometries\\";

	CDBPtr<NDb::SGeometry> pGeometry = NDb::Get<NDb::SGeometry>( CDBID( szGeometryName ) );
	*pszGeomFileName = NBinResources::GetExistentBinaryFileName( szGeometriesFolder, pGeometry->GetRecordID(), pGeometry->uid ); // uid
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CFenceRPGStatsExporter::CreatePassProfiles( IManipulator *pManipulator, const string &rszSegmentsSetName )
{
	string szGrannyFileName;
	if ( GetGeom0FileName( pManipulator, rszSegmentsSetName, &szGrannyFileName ) )
	{
		NDb::SPassProfile passProfile;
		if ( CreateObjectPassabilityProfile( szGrannyFileName, 1.0f, &passProfile ) )
			SavePassProfile( passProfile, rszSegmentsSetName, "PassProfile", pManipulator ); 
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CFenceRPGStatsExporter::ExportVisobjs( IManipulator *pManipulator, 
																					  const string &rszSegmentsSetName, 
																						const CArray2D<BYTE> &rPassabilityArray, 
																						const CVec3 &rvPassabilityOrigin )
{
	// ���������� ������ �������� - AI ������������ �������

	// ������� ������ ������
	bool bResult = CManipulatorManager::Remove2DArray( pManipulator, rszSegmentsSetName + ".passability" );
	
	if ( bResult )
	{
		bResult = bResult && CManipulatorManager::Set2DArray( rPassabilityArray, pManipulator, rszSegmentsSetName + ".passability" );
		bResult = bResult && pManipulator->SetValue( rszSegmentsSetName + ".Origin.x", rvPassabilityOrigin.x );
		bResult = bResult && pManipulator->SetValue( rszSegmentsSetName + ".Origin.y", rvPassabilityOrigin.y );
	}

	return bResult;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
