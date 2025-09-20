#if !defined(__DEFAULT_VIEW__)
#define __DEFAULT_VIEW__
#pragma once

#include "Interface_View.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CDefaultView : public IView
{
	// ����� ��� ������������ �������� Undo Operation �� �������
	string szTemporaryLabel;
	// ����� ���������� ��������
	SObjectSet objectSet;
	// �������������� ��������� �������� (����� ���� MultiManipulator)
	CPtr<IManipulator> pViewManipulator;

public:
	CDefaultView() {}
	~CDefaultView() { RemoveViewManipulator(); }
	//
	// ������� �������� Controller
	template <class TController>
	TController* CreateController( TController *pTYPEObject )
	{
		if ( pTYPEObject == 0 )
		{
			pTYPEObject = new TController();
		}
		//
		if ( CDefaultController* pController = dynamic_cast<CDefaultController*>( pTYPEObject ) )
		{
			pController->objectSet = objectSet;
			pController->szTemporaryLabel = szTemporaryLabel;
			pController->GetNameList().clear();
			if ( pViewManipulator )
			{
				pViewManipulator->GetNameList( &( pController->GetNameList() ) );
			}
		}
		return pTYPEObject;
	}
	inline const SObjectSet& GetObjectSet() const { return objectSet; }
	inline const string& GetTemporaryLabel() const { return szTemporaryLabel; }
	//
	virtual void SetViewManipulator( IManipulator* _pViewManipulator,
																	 const SObjectSet &rObjectSet,
																	 const string &rszTemporaryLabel );
	virtual IManipulator* GetViewManipulator() { return pViewManipulator; }
	virtual void RemoveViewManipulator();
	//
	virtual void SetTemporaryLabel( const string &rszTemporaryLabel ) { szTemporaryLabel = rszTemporaryLabel; }
	virtual void GetTemporaryLabel( string *pszTemporaryLabel ) { if ( pszTemporaryLabel ) { ( *pszTemporaryLabel ) = szTemporaryLabel; } }
	//
	virtual void GetObjectSet( SObjectSet *pObjectSet ) { if ( pObjectSet != 0 ) { ( *pObjectSet ) = objectSet; } }
	virtual void Enter();
	virtual void Leave();
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__DEFAULT_VIEW__)

