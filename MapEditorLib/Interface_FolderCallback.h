#if !defined(__INTERFACE__CC_FOLDER_CALLBACK__)
#define __INTERFACE__CC_FOLDER_CALLBACK__
#pragma once

#include "Interface_Controller.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ������������������ �������� �������� ������ ���� ������ ����� ��� �������� �������� ������� ����� �������� ����� ������ �������
// ��� �������, ��� ������ �� ������� ��������� ���������� ��������� �����
interface IFolderCallback : public CObjectBase
{
	enum { tidTypeID = 0x140A7000 };

	// lock and unlock objects for Remove (not for rename)
	virtual void LockObjects( const SObjectSet &rObjectSet ) = 0;
	virtual void UnockObjects( const SObjectSet &rObjectSet ) = 0;
	// define locked object
	virtual bool IsObjectLocked( const string &rszTypeName, const CDBID &rDBID ) const = 0;
	// �������� �����
	virtual void ClearUndoData() = 0;
	// ������� ��������� ������� ������� 
	virtual void UndoChanges() = 0;
	// ���������� �� ���
	virtual bool IsUniqueName( const string &rszTypeName, const string &rszName ) = 0;
	// ������� ��� ����������
	virtual bool UniqueName( const string &szTypeName, string *pszName ) = 0;
	// ������� ������ � ���� ( � � ������ )
	virtual bool InsertObject( const string &rszObjectTypeName, const string &rszObjectName ) = 0;
	// ����������� ������
	virtual bool CopyObject( const string &rszObjectTypeName, const string &rszDestination, const string &rszSource ) = 0;
	// ������������� ������
	virtual bool RenameObject( const string &rszObjectTypeName, const string &rszDestination, const string &rszSource ) = 0;
	// ������� ������ �� ���� ( � �� ������ )
	virtual bool RemoveObject( const string &rszObjectTypeName, const string &rszObjectName, bool bRecursive ) = 0;
	// ���������� �������� �������
	virtual bool SetColor( const string &rszObjectTypeName, const string &rszObjectName, const int nNewColor ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__CC_FOLDER_CALLBACK__)

