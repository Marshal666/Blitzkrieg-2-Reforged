#if !defined(__INTERFACE__EDITOR__)
#define __INTERFACE__EDITOR__
#pragma once

#include "Interface_View.h"
#include "Interface_InputState.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// � cpp ����� �������� ������: REGISTER_EDITOR_IN_...( typeName, className )

// ��� �������� ���������
// Constructor()
// Create()
// GetView->SetViewManipulator();
// GetInputState->Enter();

// ��� ���������� ���������
// GetInputState->Leave();
// GetView->RemoveViewManipulator();
// Destroy()
// Destructor()
interface IEditor : public CObjectBase
{
	// ���������� � View
	virtual void GetTemporaryLabel( string *pszTemporaryLabel ) = 0;
	// �������� ��� child frame
	virtual void GetChildFrameType( string *pszChildFrameTypeName ) = 0;
	// �������� ��������������� - ��������.
	virtual IView* GetView() = 0;
	// �������� ��������������� - IInputState
	virtual IInputState* GetInputState() = 0;
	// ������� �������������� �������� ( ���������� ��� �������� MainFrame �� ���������� ��������� �������)
	virtual void CreateControls() = 0;
	// ������� �������������� �������� ( ���������� ��� �������� MainFrame ����� ���������� �������)
	virtual void PostCreateControls() = 0;
	// ������� �������������� �������� ( ���������� ��� �������� MainFrame �� ����������� ��������� �������)
	virtual void PreDestroyControls() = 0;
	// ������� �������������� �������� ( ���������� ��� �������� MainFrame ����� ����������� ��������� �������)
	virtual void DestroyControls() = 0;
	// ������� ����� ����� ��������� (�� ������-�����������)
	virtual void Create() = 0;
	// ������� ����� ����� ��������� (�� ������-�����������)
	virtual void Destroy() = 0;
	// ���������� �� ���������� �� ������ Save
	virtual void Save( bool bSaveChanges ) = 0;
	// ���������� ����� �� �������� Save
	virtual bool IsModified() = 0;
	// ������������ ��������� ���������
	virtual void SetModified( bool bModified ) = 0;
	// ���������� �� �������� ������ �������������
	virtual bool ShowProgress() = 0;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IEditorContainer : public CObjectBase
{
	enum { tidTypeID = 0x1408A3C0 };
	//
	// ��������� �� ������������� ���������
	virtual bool CanCreate( const string &rszObjectTypeName ) = 0;
	// ������ �������� � �������� ����������
	virtual void Create( const string &rszObjectTypeName ) = 0;
	virtual void AddExtendObjectType( const string &rszBaseObjectTypeName, const string &rszExtendObjectTypeName ) = 0;
	virtual void Destroy( const string &rszObjectTypeName, bool bDestroyChildFrame ) = 0;
	// �������� ��������
	virtual IEditor* Create( IManipulator* _pManipulator, const SObjectSet &rObjectSet ) = 0;
	// ����������� �������� ( ��� �������� ������� Enter )
	virtual void ReloadActiveEditor( bool bClearResources ) = 0;
	// ������� �������� �������� ( ��� �������� ������� Enter )
	virtual void DestroyActiveEditor( bool bDestroyChildFrame ) = 0;
	// �������� �������� ��������
	virtual IEditor* GetActiveEditor() = 0;
	// �������� IInputState ���� �������� ��������� �� DirectX ����
	virtual IInputState* GetActiveInputState() = 0;
	//
	// ����������� ������, ���������� �� MainFrame
	// ������� ������ CreateControls() � ���� ������������������ ����������
	virtual void CreateControls() = 0;
	virtual void PostCreateControls() = 0;
	// ������� ������ DestroyControls() � ���� ������������������ ����������
	virtual void PreDestroyControls() = 0;
	virtual void DestroyControls() = 0;
	// ���������� �� ���������� �� ������ Save
	virtual void Save( bool bSaveChanges ) = 0;
	// ���������� ����� �� �������� Save
	virtual bool IsModified() = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__EDITOR__)

