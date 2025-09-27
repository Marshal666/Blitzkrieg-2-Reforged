#if !defined(__FOLDER_CONTROLLER__)
#define __FOLDER_CONTROLLER__
#pragma once

#include "DefaultController.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TYPE_INSERT:		( ������������ ������ ��� Update )
// szDestination	- ��� ������������ �������
//
// TYPE_REMOVE:		( ������������ ������ ��� Update )
// szDestination	- ��� ���������� �������
//
// TYPE_COPY:			( ������������ ������ ��� Update )
// szDestination	- ���� ����������
// szSource				- ������ ����������
//
// TYPE_RENAME:		( ������������ ������ ��� Update )
// szDestination	- ���� ����������
// szSource				- ������ ����������
// newValue				- true / false, true - ����� HTREEITEM, false - ������ �������������� �������� ������� � ���� � � ������
//
// TYPE_COLOR		( ������������ ������ ��� Update )
// szDestination	- ��� �������
// newValue				- ����� (�������������) ��������
//
// TYPE_EXPAND		( ������������ ������ ��� Update )
// szName					- ��� �������
// newValue				- 1 Expand, 0 Collapse
//
// TYPE_CHECK		( ������������ ������ ��� Update )
// szName					- ��� �������
//
// TYPE_EXPORT		( ������������ ������ ��� Update )
// szName					- ��� �������
// newValue				- 1 Force Export, 0 Export
class CFolderController : public CDefaultController
{
	OBJECT_NOCOPY_METHODS( CFolderController );

public:	
	struct SUndoData
	{
		enum EType
		{
			TYPE_INSERT				= 0,
			TYPE_REMOVE				= 1,
			TYPE_COPY					= 2,
			TYPE_RENAME				= 3,
			TYPE_COLOR				= 4,
			TYPE_EXPAND				= 6,
		};
		//
		string szDestination;
		string szSource;
		CVariant newValue;
		//
		EType eType;
	};
	//
	typedef list<SUndoData> CUndoDataList;
	
	// ������ ������ ������������ ����������
	CUndoDataList undoDataList;

protected:
	// CUndoObject
	virtual bool UndoWithoutUpdateViews();
	virtual bool RedoWithoutUpdateViews();

public:
	// IUndoObject
	virtual bool IsEmpty() const { return undoDataList.empty(); }
	virtual bool IsAbsolute() const { return true; }
	// Helpers
	bool AddInsertOperation( const string &rszObjectName );
	bool AddRemoveOperation( const string &rszObjectName );
	bool AddCopyOperation( const string &rszDestination, const string &rszSource );
	bool AddRenameOperation( const string &rszDestination, const string &rszSource, bool bNewHTREEITEM );
	bool AddColorOperation( const string &rszObjectName, int nNewColor );
	bool AddExpandOperation( const string &rszObjectName, bool bExpand );
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__FOLDER_CONTROLLER__)

