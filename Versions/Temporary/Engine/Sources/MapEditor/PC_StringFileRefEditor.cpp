#include "stdafx.h"
#include "..\mapeditorlib\resourcedefines.h"
#include "..\mapeditorlib\commandhandlerdefines.h"
#include "ResourceDefines.h"

#include "..\System\FileUtils.h"
#include "PC_StringFileRefEditor.h"
#include "..\MapEditorLib\Interface_UserData.h"
#include "..\MapEditorLib\Interface_MOD.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CPCStringFileRefEditor::CPCStringFileRefEditor( const string &rszObjectTypeName ) : szObjectTypeName( rszObjectTypeName )
{
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CPCItemEditor
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CPCStringFileRefEditor::GetValue( CVariant *pValue )
{
	if ( pValue )
	{
		if ( const SPropertyDesc *pDesc = GetPropertyDesc() )
		{
			CPCStringBrowseEditor::GetValue( pValue );
			string szFilePath = pValue->GetStr();
			bool bResult = false;
			if ( !szFilePath.empty() )
			{
				SUserData::ENormalizePathType pathType = SUserData::NPT_UNKNOWN;
				if ( ( pDesc->nIntParam > SUserData::NPT_UNKNOWN ) && ( pDesc->nIntParam < SUserData::NPT_COUNT ) )
				{
					pathType = static_cast<SUserData::ENormalizePathType>( pDesc->nIntParam );
				}
				if ( ::IsValidFileName( szFilePath, false ) )
				{
					( *pValue ) = szFilePath;
					//
					// ������������� ������� ���� ����� ����������� ��� ����������� ������ ������� �������� �����
					const string szFullFilePath = Singleton<IMODContainer>()->GetDataFolder( pathType ) + szFilePath;
					string szObjectNamePrefix;
					CStringManager::SplitFileName( &szObjectNamePrefix, 0, 0, szFullFilePath );
					string szMask;
					szMask = pDesc->szStringParam;
					if ( szMask.empty() )
					{
						szMask = "All Files (*.*)|*.*||";
					}
					//							
					SUserData::CFilePathMap &rFilePathMap = Singleton<IUserDataContainer>()->Get()->filePathMap;
					rFilePathMap[szMask] = szObjectNamePrefix;
					bResult = true;
				}
			}
			else
			{
				bResult = true;
			}
			if ( !bResult )
			{
				SetDefaultValue();
				CPCStringBrowseEditor::GetValue( pValue );
			}
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CPCStringBrowseEditor
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//"All supported Files (*.bzm; *.xml)|*.bzm; *.xml"
//"XML files (*.xml)|*.xml"
//"BZM files (*.bzm)|*.bzm"
//"All Files (*.*)|*.*"
void CPCStringFileRefEditor::OnBrowse()
{
	if ( const SPropertyDesc *pDesc = GetPropertyDesc() )
	{
		CString strTitle;
		strTitle.LoadString( IDS_BROWSE_FOR_FILE_DIALOG_TITLE );
		string szTitle = StrFmt( strTitle, GetName() );
		//
		string szMask;
		szMask = pDesc->szStringParam;
		if ( szMask.empty() )
		{
			szMask = "All Files (*.*)|*.*||";
		}
		//
		SUserData::CFilePathMap &rFilePathMap = Singleton<IUserDataContainer>()->Get()->filePathMap;
		const string szInitialDir = rFilePathMap[szMask];
		//
		{
			NFile::CCurrDirHolder currDirHolder;
			CFileDialog fileDialog( true, "", "", OFN_FILEMUSTEXIST | OFN_PATHMUSTEXIST, szMask.c_str(), GetTargetWindow() );
			
			fileDialog.m_ofn.lpstrFile = new char[0xFFFF];
			fileDialog.m_ofn.lpstrFile[0] = 0;			
			fileDialog.m_ofn.nMaxFile = 0xFFFF - 1;
			fileDialog.m_ofn.lpstrInitialDir = szInitialDir.c_str();
			fileDialog.m_ofn.lpstrTitle = szTitle.c_str();
			
			if ( ( fileDialog.DoModal() == IDOK ) && ( ( GetStyle() & ES_READONLY ) == 0 ) )
			{
				POSITION position = fileDialog.GetStartPosition();
				while ( position )
				{
					SUserData::ENormalizePathType pathType = SUserData::NPT_UNKNOWN;
					if ( ( pDesc->nIntParam > SUserData::NPT_UNKNOWN ) && ( pDesc->nIntParam < SUserData::NPT_COUNT ) )
					{
						pathType = static_cast<SUserData::ENormalizePathType>( pDesc->nIntParam );
					}
					const string szFullFilePath = fileDialog.GetNextPathName( position );
					const string szDataFolder = Singleton<IMODContainer>()->GetDataFolder( pathType );
					if ( CStringManager::Compare( szFullFilePath, szDataFolder, true, true, true ) == 0 )
					{
						const string szFilePath = szFullFilePath.substr( szDataFolder.size() );
						SetWindowText( szFilePath.c_str() );
						// ������������� ������� ���� ����� ����������� ��� ����������� ������ ������� �������� �����
						string szObjectNamePrefix;
						CStringManager::SplitFileName( &szObjectNamePrefix, 0, 0, szFullFilePath );
						rFilePathMap[szMask] = szObjectNamePrefix;
					}
				}
			}
			delete[] fileDialog.m_ofn.lpstrFile;
			fileDialog.m_ofn.lpstrFile = 0;
		}
		//
		Singleton<ICommandHandlerContainer>()->HandleCommand( CHID_SCENE, ID_SCENE_REMOVE_INPUT, 0 );
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// basement storage  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
