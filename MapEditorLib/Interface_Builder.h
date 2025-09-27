#if !defined(__INTERFACE__BUILDER__)
#define __INTERFACE__BUILDER__
#pragma once

#include "Interface_FolderCallback.h"
#include "StringManager.h"
//
interface IManipulator;
interface IView;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define DEFAULT_BUILDER_LABEL __DEFAULT__BUILDER__
#define DEFAULT_BUILDER_LABEL_TXT "__DEFAULT__BUILDER__"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// BDF = build data flag
#define BDF_EXPORT_CHECK_BOX	0x00000001
#define BDF_EDIT_CHECK_BOX		0x00000002
//
#define BDF_CHECK_FILE_NAME		0x00000010
#define BDF_CHECK_PROPERTIES	0x00000020
#define BDF_ALL								0xFFFFFFFF
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SBuildDataParams
{
	UINT nFlags;										// ��������� �������������
	string szObjectTypeName;				// ��� �������
	// ��� ����������� ��������� �������:
	// string szFileName = szObjectNamePrefix + szObjectName + szObjectNamePostfix;
	// CStringManager::ExtendFileExtention( &szFileName, szObjectNameExtention );
	// ���� �����������, ��� ����������� ������� - �� ������� � szObjectNamePostfix � ������ ��������� ����
	string szObjectNamePrefix;			// ��������������� �����
	string szObjectName;						// ������ ��������������
	string szObjectNamePostfix;			// ��������������� �����
	string szObjectNameExtention;		// ���������� (���������� ���������)
	//
	bool bNeedExport;								// ���������� �� �������������� ������ ����� ��������
	bool bNeedEdit;									// ���������� �� ��������� ������ ����� �������� ��� ��������
	SBuildDataParams() : nFlags( BDF_ALL ), bNeedExport( false ), bNeedEdit( false ) {}
	void GetObjectName( string *pszObjectName )
	{
		if ( pszObjectName )
		{
			( *pszObjectName ) = szObjectNamePrefix + szObjectName + szObjectNamePostfix;
			CStringManager::ExtendFileExtention( pszObjectName, szObjectNameExtention );
			CStringManager::RemoveDoubleSlashes( pszObjectName );
		}
	}
	inline bool DoesNameEmpty() { return szObjectName.empty(); }
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CRAP{ HASH_SET
typedef hash_map<string, DWORD> CTableSet;
typedef hash_map<int, CTableSet> CTableSetMap;
// CRAP} HASH_SET

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IBuildDataCallback
{
	// ��������� ������ �� ������������ ����������, ���� ������ �� ����� ������� ������� �������� ������
	// pszDescription - ����� ���� �������
	virtual bool IsValidBuildData( IManipulator *pBuildDataManipulator, string *pszDescription, IView *pBuildDataView ) = 0;
	// ��������� ��� ������� �� ������������
	virtual bool IsUniqueObjectName( const string &szObjectType, const string &szObjectName ) = 0;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// � cpp ����� �������� ������: REGISTER_EDITOR_IN_...( typeName, className )

// ��� �������� ������������
// Constructor()
// Build();

// ��� ���������� ������������
// Destructor()

// ��� ������������ ������������� ( �� ��������� � �� ��������� )
// Build();
interface IBuilder : public CObjectBase
{
	// ������� � ������������ ������� ( ����� ���� ��������� ����� ����� �������� )
	// true - ������� ����� ���� ������� ( ���������� ���������� �������� ������ )
	// false - ������ Cancel ( �������� ������������ ��� ������������� )
	virtual bool InsertObject( string *pszObjectTypeName,											// ���������� ��� �������� Builder'�� ��� ��������� ����� ��������
														 string *pszUniqueObjectName,										// ��� ��������� ������������� ( ������ )
														 bool bFromMainMenu,
														 bool *pbCanChangeObjectName,										// ����� �� ����� �������� ������� ������ ��� ���
														 bool *pbNeedExport,														// ����� �� ���������� ����� ����� ��������
														 bool *pbNeedEdit ) = 0;
	// ����������� ������
	virtual bool CopyObject( const string &rszObjectTypeName,									// ���������� ��� �������� Builder'�� ��� ��������� ����� ��������
													 const string &rszDestination,										// ��� ���� ����������
													 const string &rszSource ) = 0;										// ��� ������ ����������
	// ������������� ������
	virtual bool RenameObject( const string &rszObjectTypeName,								// ���������� ��� �������� Builder'�� ��� ��������� ����� ��������
														 const string &rszDestination,									// ��� ���� ����������
														 const string &rszSource ) = 0;									// ��� ������ ����������
	// ������� ������
	virtual bool RemoveObject( const string &rszObjectTypeName,								// ���������� ��� �������� Builder'�� ��� ��������� ����� ��������
														 const string &rszObjectName ) = 0;							// ��� ��������� ������������� ( ������ )
	//
	virtual void GetDefaultFolder( const string &rszObjectTypeName, string *pszDefaultFolder ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IBuilderContainer : public CObjectBase
{
	enum { tidTypeID = 0x1408A3C3 };
	//
	// ��������� �� ������������� ������������
	virtual bool CanBuildObject( const string &rszObjectTypeName ) = 0;
	virtual bool CanDefaultBuildObject( const string &rszObjectTypeName ) = 0;
	// ������ �������� � �������� �������������
	virtual void Create( const string &rszObjectTypeName ) = 0;
	virtual void Destroy( const string &rszObjectTypeName ) = 0;
	//
	virtual bool InsertObject( string *pszObjectTypeName,											// ���������� ��� �������� Builder'�� ��� ��������� ����� ��������
														 string *pszUniqueObjectName,										// ��� ��������� ������������� ( ������ )
														 bool bFromMainMenu,
														 bool *pbCanChangeObjectName,										// ����� �� ����� �������� ������� ������ ��� ���
														 bool *pbNeedExport,														// ����� �� ���������� ����� ����� ��������
														 bool *pbNeedEdit ) = 0;												// ����� �� ��������� �������� ����� �������� ��� ����� �������� �������
	virtual bool CopyObject( const string &rszObjectTypeName,									// ���������� ��� �������� Builder'�� ��� ��������� ����� ��������
													 const string &rszDestination,										// ��� ���� ����������
													 const string &rszSource ) = 0;										// ��� ������ ����������
	virtual bool RenameObject( const string &rszObjectTypeName,								// ���������� ��� �������� Builder'�� ��� ��������� ����� ��������
														 const string &rszDestination,									// ��� ���� ����������
														 const string &rszSource ) = 0;									// ��� ������ ����������
	virtual bool RemoveObject( const string &rszObjectTypeName,								// ���������� ��� �������� Builder'�� ��� ��������� ����� ��������
														 const string &rszObjectName ) = 0;							// ��� ��������� ������������� ( ������ )
	virtual void GetDefaultFolder( const string &rszObjectTypeName, string *pszDefaultFolder ) = 0;
	// ��������� BuildData
	virtual bool FillBuildData(	string *pszBuildDataTypeName,
															string *pszBuildDataName,
															SBuildDataParams *pBuildDataParams,					
															IBuildDataCallback *pBuildDataCallback ) = 0;
	virtual bool FillNewObjectName( SBuildDataParams *pBuildDataParams ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__BUILDER__)

