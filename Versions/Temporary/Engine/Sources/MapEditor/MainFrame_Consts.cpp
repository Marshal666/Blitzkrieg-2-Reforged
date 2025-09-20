#include "stdafx.h"

#include "..\mapeditorlib\resourcedefines.h"
#include "MainFrame.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const int CMainFrame::WM_SECTOOLBARWNDNOTIFY = RegisterWindowMessage( _T( "WM_SECTOOLBARWNDNOTIFY" ) );

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const UINT CMainFrame::TOOLBAR_ID[TOOLBARS_COUNT] = 
{
	IDT_MAIN,
	IDT_CONTROLLER_CONTAINER,
	IDT_SELECTION,
	IDT_OBJECT,
	IDT_PROPERTY_CONTROL,
	IDT_VIEW,
};
//
//AFX_IDW_TOOLBAR + n, where n=0,4,5,... (1,2,3 will conflict with existing MFC resources)
const UINT CMainFrame::TOOLBAR_CONTROL_ID[TOOLBARS_COUNT] =
{
	AFX_IDW_TOOLBAR,
	AFX_IDW_TOOLBAR + 4,
	AFX_IDW_TOOLBAR + 5,
	AFX_IDW_TOOLBAR + 6,
	AFX_IDW_TOOLBAR + 7,
	AFX_IDW_TOOLBAR + 8,
};
//
const UINT CMainFrame::TOOLBAR_NAME_ID[TOOLBARS_COUNT] =
{
	IDS_TOOLBAR_MAIN,
	IDS_TOOLBAR_CONTROLLER_CONTAINER,
	IDS_TOOLBAR_SELECTION,
	IDS_TOOLBAR_OBJECT,
	IDS_TOOLBAR_PROPERTY_CONTROL,
	IDS_TOOLBAR_VIEW,
};
//
const UINT CMainFrame::TOOLBAR_CONTROL_ID_TO_ARRANGE = AFX_IDW_TOOLBAR + 4;
//
const DWORD CMainFrame::TOOLBAR_STYLE[TOOLBARS_COUNT] =
{
	CBRS_ALIGN_ANY,
	CBRS_ALIGN_ANY,
	CBRS_ALIGN_ANY,
	CBRS_ALIGN_ANY,
	CBRS_ALIGN_ANY,
	CBRS_ALIGN_ANY,
	//CBRS_ALIGN_TOP | CBRS_ALIGN_BOTTOM,
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const bool CMainFrame::TOOLBAR_SHOW[TOOLBARS_COUNT] = 
{
	true,
	true,
	false,
	false,
	false,
	false,
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const UINT CMainFrame::TOOLBAR_MAIN_ELEMENTS_ID[TOOLBAR_MAIN_ELEMENTS_COUNT] = 
{
	ID_MAIN_NEW,
	ID_MAIN_OPEN,
	ID_MAIN_OPEN_RESOURCE,
	ID_MAIN_SAVE,
	ID_MAIN_SELECT,
};
//
const UINT CMainFrame::TOOLBAR_OBJECT_ELEMENTS_ID[TOOLBAR_OBJECT_ELEMENTS_COUNT] = 
{
	ID_OBJECT_LOAD,
	ID_MAIN_OBJECT_LOCATE,
	ID_OBJECT_REF_LOOKUP,
	ID_SEPARATOR,
	ID_OBJECT_NEW_FOLDER,
	ID_OBJECT_NEW,
	ID_SEPARATOR,
	ID_OBJECT_CHECK,
	ID_OBJECT_EXPORT,
	ID_OBJECT_EXPORT_FORCE,
	ID_OBJECT_EXPORT_NO_REF,
	ID_OBJECT_EXPORT_NO_REF_FORCE,
};
//
const UINT CMainFrame::TOOLBAR_CC_ELEMENTS_ID[TOOLBAR_CC_ELEMENTS_COUNT] = 
{
	ID_CC_UNDO,
	ID_CC_REDO,
};
//
const UINT CMainFrame::TOOLBAR_SELECTION_ELEMENTS_ID[TOOLBAR_SELECTION_ELEMENTS_COUNT] = 
{
	ID_SELECTION_CUT,
	ID_SELECTION_COPY,
	ID_SELECTION_PASTE,
	ID_SELECTION_CLEAR,
	ID_SELECTION_RENAME,
	ID_SEPARATOR,
	ID_SELECTION_FIND,
	ID_SEPARATOR,
	ID_SELECTION_PROPERTIES,
};
//
const UINT CMainFrame::TOOLBAR_PC_ELEMENTS_ID[TOOLBAR_PC_ELEMENTS_COUNT] = 
{
	ID_PC_EXPAND_ALL,
	ID_PC_EXPAND,
	ID_PC_COLLAPSE,
	ID_PC_COLLAPSE_ALL,
	ID_SEPARATOR,
	ID_PC_OPTIMAL_WIDTH,
	ID_SEPARATOR,
	ID_PC_REFRESH,
	ID_SEPARATOR,
	ID_PC_ADD_NODE,
	ID_PC_DELETE_ALL_NODES,
	ID_SEPARATOR,
	ID_PC_INSERT_NODE,
	ID_PC_DELETE_NODE,
	ID_SEPARATOR,
	ID_PC_SHOW_HIDDEN
};
//
const UINT CMainFrame::TOOLBAR_VIEW_ELEMENTS_ID[TOOLBAR_VIEW_ELEMENTS_COUNT] = 
{
	ID_VIEW_DW_GDB_BROWSER_FIRST,
	ID_VIEW_DW_PROPERTY_BROWSER,
	ID_VIEW_DW_LOG,
};
//
/**
#define TOOLBAR_..._ELEMENTS_COUNT 5
static UINT TOOLBAR_..._ELEMENTS_ID[TOOLBAR_..._ELEMENTS_COUNT] = 
{
	...,
	...,
	...,
};
/**/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const DWORD CMainFrame::TOOLBAR_ELEMENTS_COUNT[TOOLBARS_COUNT] =
{
	TOOLBAR_MAIN_ELEMENTS_COUNT,
	TOOLBAR_CC_ELEMENTS_COUNT,
	TOOLBAR_SELECTION_ELEMENTS_COUNT,
	TOOLBAR_OBJECT_ELEMENTS_COUNT,
	TOOLBAR_PC_ELEMENTS_COUNT,
	TOOLBAR_VIEW_ELEMENTS_COUNT,
};
//
const UINT* CMainFrame::TOOLBAR_ELEMENTS_ID[TOOLBARS_COUNT] =
{
	TOOLBAR_MAIN_ELEMENTS_ID,
	TOOLBAR_CC_ELEMENTS_ID,
	TOOLBAR_SELECTION_ELEMENTS_ID,
	TOOLBAR_OBJECT_ELEMENTS_ID,
	TOOLBAR_PC_ELEMENTS_ID,
	TOOLBAR_VIEW_ELEMENTS_ID,
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const UINT CMainFrame::STATUSBAR_INDICATORS_ID[STATUSBAR_ELEMENTS] =
{
	ID_SEPARATOR,
	ID_INDICATOR_0,
	ID_INDICATOR_1,
};
//
const UINT CMainFrame::STATUSBAR_INDICATORS_SIZE[STATUSBAR_ELEMENTS] =
{
	0,
	500,
	200,
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CBRS_ALIGN_LEFT | CBRS_ALIGN_RIGHT,
const UINT CMainFrame::DOCKING_WINDOWS_DOCK_STYLE[DOCKING_WINDOWS_COUNT] =
{
	CBRS_ALIGN_ANY,
	CBRS_ALIGN_ANY,
	CBRS_ALIGN_ANY,
};
//
const UINT CMainFrame::DOCKING_WINDOWS_DOCK_PLACE[DOCKING_WINDOWS_COUNT] =
{
	AFX_IDW_DOCKBAR_LEFT,
	AFX_IDW_DOCKBAR_LEFT,
	AFX_IDW_DOCKBAR_BOTTOM,
};
//
const float CMainFrame::DOCKING_WINDOWS_RATE[DOCKING_WINDOWS_COUNT] =
{
	0.5f,
	0.5f,
	1.0f,
};
//
const int CMainFrame::DOCKING_WINDOWS_WIDTH[DOCKING_WINDOWS_COUNT] =
{
	265,
	265,
	265,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// basement storage  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
