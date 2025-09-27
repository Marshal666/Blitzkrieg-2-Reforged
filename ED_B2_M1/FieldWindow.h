#if !defined(__MAPINFO_DW_FIELD_WINDOW__)
#define __MAPINFO_DW_FIELD_WINDOW__
#pragma once

#include "../MapEditorLib/ResizeDialog.h"
#include "ResourceDefines.h"
#include "FieldState.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CFieldWindow : public CResizeDialog, public ICommandHandler
{
	bool bCreateControls;
	CComboBox	wndFieldComboBox;

	bool GetEditParameters( CFieldState::SEditParameters *pEditParameters );
	bool SetEditParameters( const CFieldState::SEditParameters &rEditParameters );

protected:
	virtual void DoDataExchange( CDataExchange* pDX );
	virtual BOOL OnInitDialog();
	
	afx_msg void OnMoveRatio();
	afx_msg void OnSelchangeFieldComboBox();
	afx_msg void OnRandomizeCheckBox();
	afx_msg void OnFillTerrainCheckBox();
	afx_msg void OnFillObjectsCheckBox();
	afx_msg void OnFillHeightsCheckBox();

	//CResizeDialog
	bool IsDrawGripper() { return false; }

public:
	enum { IDD = IDD_TAB_MI_TERRAIN_FIELD };

	CFieldWindow( CWnd* pParent = 0 );
	~CFieldWindow();


	// ICommandHandler
	bool HandleCommand( UINT nCommandID, DWORD dwData );
	bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );

	DECLARE_MESSAGE_MAP()
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__MAPINFO_DW_FIELD_WINDOW__)
