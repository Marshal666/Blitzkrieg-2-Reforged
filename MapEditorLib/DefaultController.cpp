#include "StdAfx.h"

#include "Interface_View.h"
#include "DefaultController.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CDefaultController::Undo(  bool bUpdateManipulator, bool bUpdateViews, IView *pViewToExlude )
{
	// �������������� ��������� �������
	bool bResult = true;
	if ( bUpdateManipulator )
	{ 
		bResult = UndoWithoutUpdateViews();
	}
	// �������� Views
	if ( bResult &&	bUpdateViews )
	{
		CViewSet viewSet;
		Singleton<IViewContainer>()->GetViewSet( &viewSet, objectSet, pViewToExlude );
		for ( CViewSet::iterator itView = viewSet.begin(); itView != viewSet.end(); ++itView )
		{
			itView->first->Undo( this );
		}
	}
	return bResult;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CDefaultController::Redo(  bool bUpdateManipulator, bool bUpdateViews, IView *pViewToExlude )
{
	// �������������� ��������� �������
	bool bResult = true;
	if ( bUpdateManipulator )
	{
		bResult = RedoWithoutUpdateViews();
	}
	// �������� Views
	if ( bResult && bUpdateViews )
	{
		CViewSet viewSet;
		Singleton<IViewContainer>()->GetViewSet( &viewSet, objectSet, pViewToExlude );
		for ( CViewSet::iterator itView = viewSet.begin(); itView != viewSet.end(); ++itView )
		{
			itView->first->Redo( this );
		}
		return true;
	}
	return false;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CDefaultController::GetNameListToUpdate( IManipulator::CNameMap *pNameMap, const IManipulator::CNameMap &rManipulatorNameMap, const string &rszName ) const
{
	if ( pNameMap )
	{
		// ���� �� ���-�� ���������
		if ( !rManipulatorNameMap.empty() )
		{
			// ��������� ����� ��� ������ ����
			for ( IManipulator::CNameMap::const_iterator posName = nameMap.begin(); posName != nameMap.end(); ++posName )
			{
				( *pNameMap )[posName->first + rszName] = 0;
			}
			// ��� ����� ���� ������ �������
			for ( IManipulator::CNameMap::const_iterator posName = rManipulatorNameMap.begin(); posName != rManipulatorNameMap.end(); ++posName )
			{
				if ( rszName.compare( 0, posName->first.size(), posName->first ) == 0 )
				{
					const string szName = rszName.substr( posName->first.size() );
					( *pNameMap )[szName] = 0;
				}
			}
			// ��� ����� ���� ������� �� �������������� ������������
			( *pNameMap )[rszName] = 0;
		}
		// ���� �� ������ �� ���������
		else
		{
			if ( nameMap.empty() )
			{
				( *pNameMap )[rszName] = 0;
			}
			else
			{
				for ( IManipulator::CNameMap::const_iterator posName = nameMap.begin(); posName != nameMap.end(); ++posName )
				{
					( *pNameMap )[posName->first + rszName] = 0;
				}
			}
		}
		/**
		for ( IManipulator::CNameMap::const_iterator posName = pNameMap->begin(); posName != pNameMap->end(); ++posName )
		{
			DebugTrace( "GetNameListToUpdate: <%s>", posName->first.c_str() );
		}
		/**/
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// basement storage  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
