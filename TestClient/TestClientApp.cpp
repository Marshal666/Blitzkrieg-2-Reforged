#include "stdafx.h"
#include <crtdbg.h>

#include "Console.h"
#include "TestClient.h"
#include "TestClientApp.h"

#include "../System/FileUtils.h"
#include "../Misc/StrProc.h"

#include "../Scintilla/Platform.h"
#include "../Scintilla/Scintilla.h"

#include "../Server_Client_Common/Commands.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CTestClientApp theApp;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CTestClientApp::CTestClientApp()
{
	_CrtSetDbgFlag( _CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF );
	const int nBreakId = -1;
	_CrtSetBreakAlloc( nBreakId );
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CALLBACK TimerProc( HWND hwnd, UINT uMsg, UINT idEvent, DWORD dwTime )
{
	theApp.Segment();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const string GetBaseDir()
{
	char buffer[1024];
	GetCurrentDirectory( 1024, buffer );
	//
	string szTemp = buffer;
	NI_ASSERT( !szTemp.empty(), "Can't get current directory" );
	if ( szTemp[szTemp.size() - 1] != '\\' )
		szTemp += '\\';
	szTemp += "..\\";

	string szBaseDir;
	NFile::GetFullName( &szBaseDir, szTemp );
	NStr::ToLower( &szBaseDir );

	return szBaseDir;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BOOL CTestClientApp::InitInstance()
{
	CWinApp::InitInstance();

#if defined( _DO_SEH ) && !defined( _DEBUG )
	// set StructuredExceptionHandler 
	SetCrashHandler();
#endif // defined( _DO_SEH ) && !defined( _DEBUG )

	::CoInitialize( 0 );
	HINSTANCE hInstance = ::AfxGetResourceHandle();
	Scintilla_RegisterClasses( hInstance );

	pCmds = new CCommands( false );
	pConsole = new CConsole( pCmds, "Client" );
	m_pMainWnd = pConsole;

	const string szBaseDir = GetBaseDir();
	pTestClient = new CTestClient( pCmds, szBaseDir + "client.xml" );

	SetTimer( 0, 1, 50, &TimerProc );

	return true;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CTestClientApp::ExitInstance() 
{
#if defined( _DO_SEH ) && !defined( _DEBUG )
	// set StructuredExceptionHandler 
	ResetCrashHandler();
#endif // defined( _DO_SEH ) && !defined( _DEBUG )
	//
	Scintilla_ReleaseResources();
	::CoUninitialize();

	delete pConsole;
	pTestClient = 0;
	//
	return CWinApp::ExitInstance();
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CTestClientApp::Segment()
{
	pTestClient->Segment();
	pConsole->Segment();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
