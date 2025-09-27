#if !defined(__INTERFACE__VIEW__)
#define __INTERFACE__VIEW__
#pragma once

#include "Interface_Controller.h"
#include "../libdb/Manipulator.h"
#include "..\Misc\HashFuncs.h"

#define VIEW_COLLECTION_ID ("_VIEW_COLLECTION_ID_")
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ��, ��� ������� Undo Operation ����� �������������� ��������� �� �����
// ���� ����� ���� ���, �� ������� ������ ���� � ���� �����������
// Controller, View
interface IView
{
	virtual ~IView() {}
	//
	//	��������� �������� View ����� ������ ��������������
	virtual void Enter() = 0;
	//	��������� �������� View ����� ����� ��������������
	virtual void Leave() = 0;
	// ��������� Undo
	virtual void Undo( IController* pController ) = 0; 
	// ��������� Redo
	virtual void Redo( IController* pController ) = 0; 
	// �������� ��� ��������� �������� (���������� ��� ���������� ������� � IControllerContainer)
	//virtual void Update( IController* pController ) = 0; 
	//���������� �����������
	virtual void SetViewManipulator( IManipulator* _pViewManipulator,
																	 const SObjectSet &rObjectSet,
																	 const string &rszTemporaryLabel ) = 0;
	//�������� ����� ������������� �����������
	virtual IManipulator* GetViewManipulator() = 0;
	//������ �����������
	virtual void RemoveViewManipulator() = 0;
	virtual void GetObjectSet( SObjectSet *pObjectDet ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CRAP{ HASH_SET
typedef hash_map<IView*, DWORD, SDefaultPtrHash> CViewSet;
// CRAP} HASH_SET

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ��������� View
// rszObjectTypeName - ��� View
// nOnbjectID - ����� �������������� �������
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IViewContainer : public CObjectBase
{
	enum { tidTypeID = 0x1408A380 };
	// �������� target
	virtual void Add( IView *pView, const SObjectSet &rObjectSet ) = 0;
	// ������� target
	virtual void Remove( IView *pView, const SObjectSet &rObjectSet ) = 0;
	// �������� ��� ������������������ UndoT�rgets, �� ����������� ����������, ��������� ����� ���� 0
	// false	- ���� ��� �� ������
	// true		- ���� ���� ���� �� ����
	// ���� � �������� pViewSet ������ 0 �� ������ ���������� ������� ������������
	virtual bool GetViewSet( CViewSet *pViewSet, const SObjectSet &rObjectSet, IView *pViewToExlude ) const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__VIEW__)

