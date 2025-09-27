#if !defined(__ELK__WM_DEFINES__)
#define __ELK__WM_DEFINES__
//
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
//
#define WM_INPUT_FORM_NOTIFY ( WM_USER + 0 )
#define IFN_STATE_CHANGED ( 0 )
#define IFN_NEXT_BUTTON_PRESED ( 1 )
#define IFN_BACK_BUTTON_PRESED ( 2 )
#define IFN_TRANSLATION_CHANGED ( 3 )

#define WM_ELK_TREE_NOTIFY ( WM_USER + 1 )
#define ETN_TEXT_SELECTED ( 0 )
#define ETN_FOLDER_SELECTED ( 1 )
#define ETN_STATE_CHANGED ( 2 )
#define ETN_SHOW_TREE_STATISTIC ( 3 )

#define WM_ELK_TRANSLATE_EDIT_NOTIFY ( WM_USER + 2 )
#define TEN_NKEYDOWN ( 0 )
//
#endif // !defined(__ELK__WM_DEFINES__)
