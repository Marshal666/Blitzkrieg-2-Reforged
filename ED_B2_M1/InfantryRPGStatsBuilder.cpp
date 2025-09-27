#include "StdAfx.h"

#include "InfantryRPGStatsBuilder.h"
#include "..\MapEditorLib\BuilderFactory.h"
//
#include "../libdb/ResourceManager.h"
//
#include "..\MapEditorLib\Interface_UserData.h"
#include "..\MapEditorLib\DefaultView.h"
#include "..\MapEditorLib\ObjectController.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
REGISTER_BUILDER_IN_DLL( InfantryRPGStats, CInfantryRPGStatsBuilder )

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const string CInfantryRPGStatsBuilder::BUILD_DATA_TYPE_NAME = "InfantryRPGStatsBuilder";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInfantryRPGStatsBuilder::IsValidBuildData( IManipulator *pBuildDataManipulator, string *pszDescription, IView *pBuildDataView )
{
	NI_ASSERT( pBuildDataManipulator != 0, "CInfantryRPGStatsBuilder::IsValidBuildData() pBuildDataManipulator == 0" );
	NI_ASSERT( pszDescription != 0, "CInfantryRPGStatsBuilder::IsValidBuildData() pszDescription == 0" );
	pszDescription->clear();	
	// ��������� ������
	string szVisualObject;
	if ( !CManipulatorManager::GetValue( &szVisualObject, pBuildDataManipulator, "VisualObject" ) || szVisualObject.empty() )
	{
		( *pszDescription ) = "<VisualObject> must be filled.";
		return false;
	}
	string szDBType;
	if ( !CManipulatorManager::GetValue( &szDBType, pBuildDataManipulator, "Type" ) || szDBType.empty() )
	{
		( *pszDescription ) = "<Type> must be filled.";
		return false;
	}
	string szSource;
	CManipulatorManager::GetValue( &szSource, pBuildDataManipulator, "Source" );
	if ( szPreviousDBType != szDBType )
	{
		szPreviousDBType = szDBType;
		const SUserData::CObjectDBTypeMap &rInfantryDBTypeMap = Singleton<IUserDataContainer>()->Get()->infantryDBTypeMap;
		SUserData::CObjectDBTypeMap::const_iterator posInfantryDBType = rInfantryDBTypeMap.find( szPreviousDBType );
		if ( ( posInfantryDBType != rInfantryDBTypeMap.end() ) && ( !posInfantryDBType->second.empty() ) )
		{
			if ( pBuildDataView )
			{
				CPtr<CObjectBaseController> pObjectController = dynamic_cast<CDefaultView*>(pBuildDataView)->CDefaultView::CreateController<CObjectController>( static_cast<CObjectController*>( 0 ) );
				if ( pObjectController->AddChangeOperation( "Source", posInfantryDBType->second, pBuildDataManipulator ) )
				{
					pObjectController->Redo( false, true, 0 );
					Singleton<IControllerContainer>()->Add( pObjectController );
				}
			}
		}
	}
	if ( !CManipulatorManager::GetValue( &szSource, pBuildDataManipulator, "Source" ) || szSource.empty() )
	{
		( *pszDescription ) = "<Source> must be filled.";
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInfantryRPGStatsBuilder::InternalInsertObject( string *pszObjectTypeName,
																										 string *pszUniqueObjectName,
																										 bool bFromMainMenu,
																										 bool *pbCanChangeObjectName,
																										 bool *pbNeedExport,
																										 bool *pbNeedEdit,
																										 IManipulator *pBuildDataManipulator )
{
	NI_ASSERT( pszObjectTypeName != 0, "CInfantryRPGStatsBuilder::InternalInsertObject() pszObjectTypeName == 0" );
	NI_ASSERT( pszUniqueObjectName != 0, "CInfantryRPGStatsBuilder::InternalInsertObject() pszUniqueObjectName == 0" );
	NI_ASSERT( pBuildDataManipulator != 0, "CInfantryRPGStatsBuilder::InternalInsertObject() pBuildDataManipulator == 0" );
	IResourceManager *pResourceManager = Singleton<IResourceManager>();
	IFolderCallback *pFolderCallback = Singleton<IFolderCallback>();
	//
	string szDescription;
	if ( !IsValidBuildData( pBuildDataManipulator, &szDescription, 0 ) )
	{
		return false;
	}
	// ��������� ������
	string szVisualObject;
	string szDBType;
	string szSource;
	CManipulatorManager::GetValue( &szVisualObject, pBuildDataManipulator, "VisualObject" );
	CManipulatorManager::GetValue( &szDBType, pBuildDataManipulator, "Type" );
	CManipulatorManager::GetValue( &szSource, pBuildDataManipulator, "Source" );
	//
	bool bResult = pFolderCallback->InsertObject( *pszObjectTypeName, *pszUniqueObjectName );
	if ( bResult )
	{
		CPtr<IManipulator> pInfantryRPGStatsManipulator = pResourceManager->CreateObjectManipulator( *pszObjectTypeName, *pszUniqueObjectName );
		NI_ASSERT( pInfantryRPGStatsManipulator != 0, "CInfantryRPGStatsBuilder::InternalInsertObject() pInfantryRPGStatsManipulator == 0" );
		if ( !szSource.empty() )
		{
			CPtr<IManipulator> pSourceInfantryRPGStatsManipulator = pResourceManager->CreateObjectManipulator( *pszObjectTypeName, szSource );
			if ( pSourceInfantryRPGStatsManipulator )
			{
				CManipulatorManager::CloneDBManipulator( pInfantryRPGStatsManipulator, pSourceInfantryRPGStatsManipulator, true );
			}
		}
		// ����������� �������� ���������
		bResult = bResult && pInfantryRPGStatsManipulator->SetValue( "GameType", string( "SGVOGT_UNIT" ) );
		bResult = bResult && pInfantryRPGStatsManipulator->SetValue( "DBtype", szDBType );
		bResult = bResult && pInfantryRPGStatsManipulator->SetValue( "visualObject", szVisualObject );
	}
	return bResult;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// basement storage  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
