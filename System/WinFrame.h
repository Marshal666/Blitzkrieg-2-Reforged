#ifndef __WINFRAME_H__
#define __WINFRAME_H__
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
////////////////////////////////////////////////////////////////////////////////////////////////////
#include "..\misc\HPTimer.h"
//
namespace NWinFrame
{
	struct SWindowsMsg
	{
		enum EMsg
		{
			MOUSE_WHEEL,
			MOUSE_MOVE,
			RB_DOWN,
			LB_DOWN,
			RB_UP,
			LB_UP,
			RB_DBLCLK,
			LB_DBLCLK,
			KEY_DOWN,
			KEY_UP,
			CHAR,
			TIME,
			CLOSE,
		};
		NHPTimer::STime time;
		EMsg msg;
		union
		{
			struct { int x,y; };         // mouse
			struct { int nKey, nRep; };  // key
		};
		DWORD dwFlags;
	};
	// WinFrame interface
	bool GetMessage( SWindowsMsg *pRes );
	bool IsAppActive();
	bool IsExit();
	void Exit();
	void ResetExit(); // b2`s cheat to show movie on exit
	HWND GetWnd();
	void PumpMessages();
	bool __declspec(dllexport) SFLB1_InitApplication( HINSTANCE hInstance, const char *pszAppName, const char *pszWndName, LPCSTR nIcon );
	void SetCursor( HCURSOR _hCursor );
	void ShowCursor( bool bShow );
	void EnableCursorManagement( bool bEnable );
};
////////////////////////////////////////////////////////////////////////////////////////////////////
#endif
