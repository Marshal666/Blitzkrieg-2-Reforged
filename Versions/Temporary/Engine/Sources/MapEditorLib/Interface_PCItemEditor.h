#if !defined(__INTERFACE__PROPERTY_CONTROL_ITEM_EDITOR__)
#define __INTERFACE__PROPERTY_CONTROL_ITEM_EDITOR__
#pragma once

#include "../libdb/Manipulator.h"
#include "Interface_Controller.h"
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// �������� ������ ������ ���� � EPCIEType
// �������� bmp � IDB_PC_TYPES_IMAGE_LIST ( � ������ � � ����� )
// ����� �� ���� ��� ��������� ��������� �������� � �������� ����� �����������:
//	[x] 1. CPCIEMnemonics::CPCIEMnemonics() - �������� ����� ������
//	[x] 2. GetPCItemStringValue() - �������� ������ �� CVariant
//  [x] 3. GetPCItemValue() - �������� CVariant �� ������
//  [x] 4. IPCItemEditor* CPCMainTreeControl::CreatePCItemEditor( HTREEITEM hItem ) - �������� ����� ������������
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EPCIEType
{
	PCIE_UNKNOWN								= 0,
	PCIE_FOLDER									= 1,
	PCIE_INT_INPUT							= 2,
	PCIE_INT_SLIDER							= 3,
	PCIE_INT_COMBO							= 4,
	PCIE_INT_COLOR							= 5,
	PCIE_INT_COLOR_WITH_ALPHA		= 6,
	PCIE_FLOAT_INPUT						= 7,
	PCIE_FLOAT_SLIDER						= 8,
	PCIE_FLOAT_COMBO						= 9,
	PCIE_BOOL_COMBO							= 10,
	PCIE_BOOL_CHECKBOX					= 11,
	PCIE_BOOL_SWITCHER					= 12,
	PCIE_STRING_REF							= 13,
	PCIE_STRING_MULTI_REF				= 14,
	PCIE_STRING_INPUT						= 15,
	PCIE_STRING_BIG_INPUT				= 16,
	PCIE_STRING_COMBO						= 17,
	PCIE_STRING_COMBO_REF				= 18,
	PCIE_STRING_COMBO_MULTI_REF	= 19,
	PCIE_STRING_FILE_REF				= 20,
	PCIE_STRING_DIR_REF					= 21,
	PCIE_BINARY_BIT_FIELD				= 22,
	PCIE_STRING_NEW_REF					= 23,
	PCIE_STRING_NEW_MULTI_REF		= 24,
	PCIE_GUID										= 25,
	PCIE_TEXT_FILE							= 26,
	PCIE_NEW_TEXT_FILE					= 27,
	PCIE_VEC3_COLOR							= 28,
	PCIE_LIST										= 29,
	PCIE_STRUCT									= 30,
	PCIE_COUNT									= 31,
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface  IPCItemEditor : public CObjectBase
{
	// �������� �������� ����� �������� ������ ( ��� ������������� )
	virtual const string& GetName() const = 0;
	// �������� �������� ���� �������� ������ ( ��� ������������� )
	virtual EPCIEType GetItemEditorType() const = 0;
	// �������� ��������� �������� ������ ( ��� ������������� )
	virtual const	SPropertyDesc* GetPropertyDesc() const = 0;
	// �������� ������������� ���� ���������� � ���������� 
	virtual int GetControlID() const = 0;
	// �������� ���� ���� ���������� �������� ��� ��������� ( IC_... )
	virtual class CWnd* GetTargetWindow() = 0;
	//
	// ������� ���� ��������� ( CDialog - ��� ���� ����� ����� ���� ������������� �� ��������� )
	virtual bool CreateEditor( const string &rszName, EPCIEType _nEditorType, const SPropertyDesc* _pPropertyDesc, int _nControlID, const SObjectSet &rObjectSet, class CWnd *_pwndTargetWindow ) = 0;
	// ���������� ���� ��������� � ������������ �������
	virtual bool PlaceEditor( const CTRect<int> &rPlaceRect ) = 0;
	// ��������� ����� �� ���� ���������
	virtual bool ActivateEditor( class CDialog *pwndActiveDialog ) = 0;
	//
	// ���������� ��������
	virtual void SetValue( const CVariant &rValue ) = 0;
	// �������� ��������
	virtual void GetValue( CVariant *pValue ) = 0;
	// ���������� �������� �� ���������
	virtual void SetDefaultValue() = 0;
	// ���������� ��� �������� �� ��������
	virtual bool IsDefaultValue() = 0;
	// ���������� ����� ������ ���������
	virtual void EnableEdit( bool bEnable ) = 0;
	//
	virtual bool IsEditEnabled() = 0;
	// ���������� ���� ��������� ���������� �� ���������, ������� �� ������� c �������� ����������
	// ������������ ��� ��������� ��������� �� Slider
	virtual void ProcessMessage( UINT nMessage, WPARAM wParam, LPARAM lParam ) = 0;
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__PROPERTY_CONTROL_ITEM_EDITOR__)
