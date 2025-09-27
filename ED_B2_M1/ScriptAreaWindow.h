#if !defined( __SCRIPT_AREA_WINDOW__ )
#define __SCRIPT_AREA_WINDOW__
#pragma once

#include "ResourceDefines.h"
#include "../MapEditorLib/Interface_CommandHandler.h"
#include "../MapEditorLib/ResizeDialog.h"
#include "../Stats_B2_M1/DBMapinfo.h"
#include "../libdb/Manipulator.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//		SCRIPT AREA WINDOW DATA
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SScriptAreaWindowData
{
	NDb::EScriptAreaTypes eAreaType;	// ����� �����-������ ������� � �������
	//
	struct SScriptArea	// ������ ��� �������� row � ������ ��������
	{
		string szName;
		int nScriptAreaID;
		NDb::EScriptAreaTypes eType;
		//
		SScriptArea() : nScriptAreaID( INVALID_NODE_ID ), eType( NDb::EAT_CIRCLE ) {}
	};
	vector<SScriptArea> scriptAreaList;				// ���������� ����-��������
	vector<UINT> selectedScriptAreaIDList;		// ID ������������� ��������
	//
	enum EChangeMask	// ��� ���������� ( GET ) ��� ��� ����� �������� � ������� ( SET )
	{
		CHANGE_NONE				= 0x00000000,
		CHANGE_AREAS			= 0x00000001,	// �������� ������ �������� ( SET )
		CHANGE_SELECTION	= 0x00000002,	// �������� selection ( GET+SET )
		CHANGE_DEL_SEL		= 0x00000004,	// ������� ���������� ������� ( GET )
		CHANGE_AREA_TYPE	= 0x00000008,	// ����� �����-������ ������� � ������� ( GET + SET )
		CHANGE_SET_ALL		= ( CHANGE_AREAS | CHANGE_SELECTION | CHANGE_AREA_TYPE ),
	};
	EChangeMask eChangeMask; 
	//
	SScriptAreaWindowData()
	{
		Clear();
	}
	//
	void Clear()
	{
		eAreaType = NDb::EAT_CIRCLE;
		scriptAreaList.clear();
		selectedScriptAreaIDList.clear();
		eChangeMask = CHANGE_NONE;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//		SCRIPT AREA WINDOW
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CScriptAreaWindow : public CResizeDialog, public ICommandHandler
{
	// controls
	CButton rbnCircle;
	CButton rbnRectangle;
	CListCtrl lcAreas;
	//
	bool bIsDataBeginSet;
	SScriptAreaWindowData dialogData;

	bool IsDrawGripper() { return false; }
	//
	// CScriptAreaWindow
	void GetDialogData( SScriptAreaWindowData *pData );
	void SetDialogData( const SScriptAreaWindowData *pData );
	void NotifyHandler();
	void UpdateControls();

public:
	enum { IDD = IDD_TAB_MI_SCRIPT_AREA };

	CScriptAreaWindow( CWnd* pParentWindow = 0 );
	virtual ~CScriptAreaWindow();

	virtual void DoDataExchange( CDataExchange *pDX );
	virtual BOOL OnInitDialog();

	virtual void OnOK() {}
	virtual void OnCancel() {}

	// ICommandHandler
	virtual bool HandleCommand( UINT nCommandID, DWORD dwData );
	virtual bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );

	DECLARE_MESSAGE_MAP()
	afx_msg void OnItemchangedAreaList( NMHDR* pNMHDR, LRESULT* pResult );
	afx_msg void OnDestroy();
	afx_msg void OnButtonDel();
	afx_msg void OnRadioCircle();
	afx_msg void OnRadioRectangle();
	afx_msg void OnButtonSelect();
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // #if !defined( __SCRIPT_AREA_WINDOW__ )
