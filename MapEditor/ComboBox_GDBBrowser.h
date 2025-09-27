#if !defined(__COMBOBOX__GDB_BROWSER__)
#define __COMBOBOX__GDB_BROWSER__
#pragma once

#include "Tree_GDBBrowserBase.h"

#define GDB_BROWSER_CBN_SELCHANGE 0

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CComboBoxGDBBrowser : public ICommandHandler
{
	vector<CTreeGDBBrowserBase*> tabList;
	//
	int nGDBBrowserID;
	CWnd *pwndParent;
	CComboBox wndComboBox;
	UINT nControlID;
	CImageList typesImageList;
	CImageList headerImageList;
	bool bEnableEdit;
	//
	void InitImageLists();
	//
	bool GetObjectSet( SObjectSet *pObjectSet );
	bool GetSelectionSet( SSelectionSet *pSelectionSet );

public:
	CComboBoxGDBBrowser( int _nGDBBrowserID );
	virtual ~CComboBoxGDBBrowser();
	//
	void MoveWindow( const CRect &rRect );
	bool Create( CWnd *_pwndParent, UINT _nControlID );
	//
	void SwitchTabs();
	bool GetActiveTab( CTreeGDBBrowserBase** ppwndActiveTab );
	bool ActivateTab( CTreeGDBBrowserBase* pwndActiveTab );
	inline int GetTabCount() { return tabList.size(); }
	CTreeGDBBrowserBase* GetTab( int nTabIndex );
	CTreeGDBBrowserBase* GetTab( const string &rszObjectTypeName );
	bool GetActiveTabName( string *pszName );
	bool ShowWindow( int nCmdShow );
	bool IsFocused();
	//
	template<class TTAB>
	TTAB* AddNewTab( TTAB *pwndCreatedTab,  const string &rszTabLabel ) 
	{
		TTAB *pwndNewTab = pwndCreatedTab;
		if ( pwndNewTab == 0 )
		{
			pwndNewTab = new TTAB( false, false, nGDBBrowserID );

			DWORD dwStyle = TVS_SHOWSELALWAYS |
											TVS_HASBUTTONS |
											TVS_LINESATROOT |
											TVS_HASLINES |
											TVS_EDITLABELS |
											LVS_SHAREIMAGELISTS |
											LVS_NOSORTHEADER |
											TVS_DISABLEDRAGDROP |
											WS_CHILD;// | WS_VISIBLE;

			DWORD dwStyleEx = WS_EX_CLIENTEDGE |
												TVXS_MULTISEL |
												TVXS_ANIMATE |
												TVXS_FLYBYTOOLTIPS |
												LVXS_HILIGHTSUBITEMS;

			pwndNewTab->Create( dwStyle, dwStyleEx, CRect( 0, 0, 0, 0 ), pwndParent, IDC_GDB_TREE_0 + GetTabCount() );
			pwndNewTab->SetImageList( &typesImageList, TVSIL_NORMAL );
			pwndNewTab->SetImageList( &headerImageList, LVSIL_HEADER );

			//CRect treeRect;
			//tree.GetWindowRect( &treeRect );
			//ScreenToClient( &treeRect );

			pwndNewTab->EnableHeaderCtrl( true, false );
			pwndNewTab->StoreSubItemText( true );
			pwndNewTab->ModifyListCtrlStyleEx( 0, LVXS_HILIGHTSUBITEMS );

			//tree.ModifyListCtrlStyleEx( 0, LVXS_LINESBETWEENCOLUMNS );
			//tree.ModifyListCtrlStyleEx( 0, LVXS_LINESBETWEENITEMS );

			CString strHeaderName;
			//tree.MoveWindow( CRect( 0, 0, 0, 0 ) ); //disable visual errors in stingray tree 
			
			// ������ ������� ��� ����������
			strHeaderName.LoadString( CTreeGDBBrowserBase::TABGDBB_TREE_COLUMN_NAME[0] );
			pwndNewTab->SetColumnHeading( 0, strHeaderName );
			pwndNewTab->SetColumnFormat( 0, CTreeGDBBrowserBase::TABGDBB_TREE_COLUMN_FORMAT[0] );
			pwndNewTab->SetColumnWidth( 0, CTreeGDBBrowserBase::TABGDBB_TREE_COLUMN_WIDTH[0] );
			pwndNewTab->SetColumnImage( 0, 0 );
			// ��������� ������ �������
			for ( int index = 1; index < TABGDBB_TREE_COLUMN_COUNT; ++index )
			{
				strHeaderName.LoadString( CTreeGDBBrowserBase::TABGDBB_TREE_COLUMN_NAME[index] );
				pwndNewTab->InsertColumn( index, strHeaderName, CTreeGDBBrowserBase::TABGDBB_TREE_COLUMN_FORMAT[index], CTreeGDBBrowserBase::TABGDBB_TREE_COLUMN_WIDTH[index], index, 0 );
				pwndNewTab->SetColumnImage( index, index );
			}
			pwndNewTab->LoadHeaderWidth();
			//tree.MoveWindow( &treeRect ); //disable visual errors in stingray tree 
			pwndNewTab->EnableEdit( bEnableEdit );
		}
		tabList.push_back( pwndNewTab );
		const int nNewString = wndComboBox.AddString( rszTabLabel.c_str() );
		if ( ( nNewString != CB_ERR ) && ( nNewString != CB_ERRSPACE ) )
		{
			wndComboBox.SetItemData( nNewString, tabList.size() - 1 );
		}
		return pwndNewTab;
	}
	void RemoveAllTabs();
	void EnableEdit( bool bEnable );

	// ICommandHandler
	bool HandleCommand( UINT nCommandID, DWORD dwData );
	bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__COMBOBOX__GDB_BROWSER__)
