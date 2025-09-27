#if !defined(__INTERFACE__CONTROLLER__)
#define __INTERFACE__CONTROLLER__
#pragma once

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef hash_map<CDBID, int> CObjectNameSet;	// ����� �������
typedef list<CDBID> CObjectNameList;					// ����� ������������������
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SObjectSet
{
	string szObjectTypeName;
	CObjectNameSet objectNameSet;

	inline void Clear()
	{
		szObjectTypeName.clear();
		objectNameSet.clear();
	}
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 
struct SSelectionSet
{
	string szObjectTypeName;
	CObjectNameList objectNameList;

	inline void Clear()
	{
		szObjectTypeName.clear();
		objectNameList.clear();
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// �������� Undo ���� ����� ��� ���� ��������
// ������ ����� ��������� �������� ��������
interface IView;
interface IController : public CObjectBase
{
	// ��������� Undo ( ����� ���������� View )
	virtual bool Undo( bool bUpdateManipulator, bool bUpdateViews, IView *pViewToExlude ) = 0;
	// ��������� Redo ( ����� ���������� View )
	virtual bool Redo( bool bUpdateManipulator, bool bUpdateViews, IView *pViewToExlude ) = 0;
	// ������ ��� �� ������ ���������� (���� �� ������ �� �� ������������ � Container)
	virtual bool IsEmpty() const = 0;
	// ���������� ����� �������� ������ �� ����� ������� ������ UNDO � Containter
	virtual bool IsAbsolute() const = 0;
	// �������� ������� ��������
	virtual void GetDescription( CString *pstrDescription ) const = 0;
	// ���� Undo Operation ���������, �� �� ����� ������� �� ����� ID
	virtual void GetTemporaryLabel( string *pszTemporaryLabel ) const = 0;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ����������� ���������� Undo
// ���������� �� � ������ � ����� �� �������������
typedef list<CString> CDescriptionList;
interface IControllerContainer : public CObjectBase
{
	enum { tidTypeID = 0x1408A3C2 };
	//
	// �������� ��������
	virtual void Add( IController *pOperation ) = 0;
	// �������� �����
	virtual void Clear() = 0;
	// ���� �� ��� �������� Undo ������
	virtual bool CanUndo() const = 0;
	// ���� �� ��� �������� Redo ������
	virtual bool CanRedo() const = 0;
	// Undo na nCount ��������	
	virtual bool Undo( int nCount ) = 0;
	// Redo na nCount ��������
	virtual bool Redo( int nCount ) = 0;
	//�������� ������ ��������
	virtual int GetDescriptionList( CDescriptionList *pDescriptionList, bool bUndoList ) const = 0;
	// ������� ��������� Undo Operations
	virtual int RemoveTemporaryControllers( const string &rszTemporaryLabel ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__CONTROLLER__)

