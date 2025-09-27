// WindowConsole.h: interface for the CWindowConsole class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_WINDOWCONSOLE_H__3222DEC4_B4EB_4831_9CE4_417F561454C6__INCLUDED_)
#define AFX_WINDOWCONSOLE_H__3222DEC4_B4EB_4831_9CE4_417F561454C6__INCLUDED_

#pragma ONCE

#include "Window.h"

struct SWindowEditLine;
class CWindowEditLine;

interface IML;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CWindowConsole : public CWindow, public IConsole
{
	OBJECT_BASIC_METHODS(CWindowConsole)
	
	CUIMORegConttainer impotantMsgs;

	struct SColorString
	{
	public:
		ZDATA
		wstring szString;
		DWORD dwColor;
		CPtr<IML> pGfxText;
		ZEND int operator&( IBinSaver &f ) { f.Add(2,&szString); f.Add(3,&dwColor); f.Add(4,&pGfxText); return 0; }

		SColorString() : dwColor( 0xffffffff ) {  }
		SColorString( const wchar_t *pszStr, DWORD col, const int nWidth );
	};
	
	typedef vector<wstring> CVectorOfStrings;
	typedef vector<SColorString> CVectorOfColorStrings;
	typedef hash_set<string> CConsoleFunctions;
	
	ZDATA_ (CWindow)
	CDBPtr<NDb::SWindowConsoleShared> pShared;
	CPtr<NDb::SWindowConsole> pInstance;
	CPtr<IML> pUpperSign;
	CVectorOfColorStrings vectorOfStrings;		//��� ������� � �������
	CVectorOfStrings vectorOfCommands;				//����������� ������� � �������, ��� ������ ���������� ������ �� ���������� �����/����
	CConsoleFunctions consoleFunctions;
	CObj<CWindowEditLine> pEditLine;
	int currTime;
	int nBeginString;						//��������� ������������ ������ �� ������ �����. 0 ��������� ����� ������ ��������
	int nBeginCommand;					//������� ������� �� ���� ������
	int nConsoleSequenceID;
	ZEND int operator&( IBinSaver &f ) { f.Add(1,(CWindow*)this); f.Add(2,&pShared); f.Add(3,&pInstance); f.Add(4,&pUpperSign); f.Add(5,&vectorOfStrings); f.Add(6,&vectorOfCommands); f.Add(7,&consoleFunctions); f.Add(8,&pEditLine); f.Add(9,&currTime); f.Add(10,&nBeginString); f.Add(11,&nBeginCommand); f.Add(12,&nConsoleSequenceID); return 0; }

	//��� ���� ���������� ����� ���������� ����� �������� �� ������
	void ParseCommand( const wstring &szCommand );
	void ReadConsoleStrings();
protected:
	virtual NDb::SWindow* GetInstance() { return pInstance; }

public:
	virtual bool ProcessEvent( const struct SGameMessage &msg );

	CWindowConsole();// : currTime( 0 ), nBeginCommand( 0 ), nBeginString( 0 ) {  }
	virtual void NotifyStateSequenceFinished();
	virtual void InitByDesc( const struct NDb::SUIDesc *pDesc );
	virtual void SetParent( CWindow *_pParent );

	bool OnUp( const struct SGameMessage &msg );
	bool OnDown( const struct SGameMessage &msg );
	bool OnCtrlHome( const struct SGameMessage &msg );
	bool OnCtrlEnd( const struct SGameMessage &msg );
	bool OnPgUp( const struct SGameMessage &msg );
	bool OnPgDn( const struct SGameMessage &msg );
	
	bool OnKeyDown( const SGameMessage &msg );
	bool OnChar( const SGameMessage &msg );
	
	bool OnShowConsole( const struct SGameMessage &msg );

	virtual void Reposition( const CTRect<float> &rcParent );

	virtual void Visit( interface IUIVisitor *pVisitor );
	virtual void Segment( const int timeDiff );
	//virtual void RegisterObservers();

	virtual void Init();	

	//virtual int operator&( IBinSaver &saver );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CDebugSingleton : public IDebugSingleton 
{
	OBJECT_BASIC_METHODS( CDebugSingleton )
	CObj<IWindow> pConsole;
	CObj<IWindow> pDebugInfo;
	bool bDebugShown;
	CObj<IWindow> pStatsWindow;

	void CreateDebugInfo();
	void CreateConsole();
	void CreateStatsWindow();
public:
	CDebugSingleton() : bDebugShown( false ) {  }
	int operator&( IBinSaver &saver )
	{
		saver.Add( 1, &pConsole );
		saver.Add( 2, &pDebugInfo );
		saver.Add( 3, &pStatsWindow );
		saver.Add( 4, &bDebugShown );
		return 0;
	}
	interface IWindow * GetConsole();
	interface IWindow * GetDebug();
	interface IWindow * GetDebugInfoWindow( const int nWindow );
	void ShowDebugInfo( const bool bShow );
	void ShowStatsWindow( const bool bShow );
	interface IStatsSystemWindow * GetStatsWindow();
};

#endif // !defined(AFX_WINDOWCONSOLE_H__3222DEC4_B4EB_4831_9CE4_417F561454C6__INCLUDED_)
