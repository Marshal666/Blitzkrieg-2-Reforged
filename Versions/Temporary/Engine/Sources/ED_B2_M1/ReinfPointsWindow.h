#if !defined( __REINF_POINTS_WINDOW__ )
#define __REINF_POINTS_WINDOW__
#pragma once

#include "../MapEditorLib/ResizeDialog.h"
#include "../MapEditorLib/Interface_CommandHandler.h"
#include "ResourceDefines.h"
#include "../Stats_B2_M1/RPGStats.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//						REINFPOINTS WINDOW DATA
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SReinfPointsWindowData
{
	struct STypedTemplate
	{
		NDb::EReinforcementType reinfType;
		string szTemplate;
	};
	//
	int nPlayerIndex;
	int nPlayerCount;
	//
	struct SReinfPoint
	{
		CVec2 vPosition;
		CVec2 vAviationPosition;
		NDb::EReinforcementType eType;
		bool bIsDefault;
		int nNumPoints;
		string szDeployTemplate;
		vector<STypedTemplate> typedTemplates;
		//
		SReinfPoint() :
			vPosition( VNULL2 ),
			eType( NDb::EReinforcementType(-1) ),
			bIsDefault( false ),
			nNumPoints( 0 ),
			szDeployTemplate( "" )
		{
		}
	};
	vector<SReinfPoint> reinfPoints;
	int nSelectedPoint;
	bool bAviationPointSelected;
	//
	enum EReinfWndLastAction
	{
		RWA_UNKNOWN,
		RWA_NO_ACTIONS,
		RWA_POINT_ADD,
		RWA_POINT_DEL,
		RWA_POINT_EDIT_DEPLOY,
		RWA_POINT_EDIT_TYPED,
		RWA_POINT_JUMP,
		RWA_POINT_SEL_CHANGE,
		RWA_PLAYER_CHANGE
	};
	EReinfWndLastAction eLastAction;
	//
	SReinfPointsWindowData() :
		nPlayerIndex(-1),
		nPlayerCount( 0 ),
		nSelectedPoint(-1),
		bAviationPointSelected( false ),
		eLastAction(RWA_NO_ACTIONS)
	{
	}
	//
	void Clear()
	{
		nPlayerIndex = -1;
		nPlayerCount = 0;
		reinfPoints.clear();
		nSelectedPoint = -1;
		bAviationPointSelected = false;
		eLastAction = RWA_NO_ACTIONS;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//						REINFPOINTS WINDOW
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CReinfPointsWindow : public CResizeDialog, public ICommandHandler
{
protected:
	//
	CListCtrl lcReinfPoints;
	CComboBox	wndPlayerComboBox;
	CButton btnDel;
	CButton btnDeploy;
	CButton btnTyped;

	bool bIsDataSetting;
	bool bIsAvia;
	int nSelectedIndex;
	SReinfPointsWindowData::EReinfWndLastAction eLastAction;
	//
	void Enter();
	void Leave();
	void GetDialogData( SReinfPointsWindowData *pData );
	void SetDialogData( const SReinfPointsWindowData *pData );
	void Draw( class CPaintDC *pPaintDC );
	void NotifyHandler();

	// ICommandHandler
	bool HandleCommand( UINT nCommandID, DWORD dwData );
	bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );

public:
	enum { IDD = IDD_TAB_MI_REINF_POINTS };

	CReinfPointsWindow( CWnd* pParentWindow = 0 );
	virtual ~CReinfPointsWindow();

	BOOL OnInitDialog();
	void DoDataExchange( CDataExchange *pDX );

	int GetMinimumXDimension() { return 100; }
	int GetMinimumYDimension() { return 130; }
	bool IsDrawGripper() { return false; }

	virtual void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);

	virtual void OnOK() {}
	virtual void OnCancel() {}

	DECLARE_MESSAGE_MAP()
	afx_msg void OnDestroy();
	afx_msg void OnCbnSelchangeComboPlayer();
	afx_msg void OnBnClickedButtonReinfPointsAdd();
	afx_msg void OnBnClickedButtonReinfPointsDel();
	afx_msg void OnBnClickedButtonReinfPointsDeploy();
	afx_msg void OnBnClickedButtonReinfPointsTyped();
	afx_msg void OnNMClickListReinfPoints(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnLvnItemchangedListReinfPoints(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnLvnDblclkListReinfPoints(NMHDR *pNMHDR, LRESULT *pResult);
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // #if !defined( __REINF_POINTS_WINDOW__ )
