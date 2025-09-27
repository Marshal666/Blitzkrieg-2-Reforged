#include "StdAfx.h"

#include <crtdbg.h>
#include "resource.h"
#include "revision.h"
#include "../misc/2darray.h"
#include "../zlib/zconf.h"
#include "../stats_b2_m1/iconsset.h"

#include "../Misc/StrProc.h"
#include "../System/FileUtils.h"

#include "../Input/Input.h"
#include "../SceneB2/Scene.h"
#include "../SceneB2/Cursor.h"
#include "../System/GResource.h"

#include "../Sound/SFX.h"
#include "../3Dmotor/Gfx.h"

#include "../Main/Profiles.h"
#include "WinFrame2Input.h"
#include "../Main/MainLoopCommands.h"
#include "../AILogic/CreateAI.h"
#include "VersionInfo.h"
#include "../libdb/Db.h"

#include "../System/FilePath.h"
#include "../System/Commands.h"

#include "../System/VFSOperations.h"

#include "../System/SplashScreen.h"
#include "../Main/MODs.h"
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	void SaveChanges();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NGameX
{
	bool Initialize();
	void PostStorageInitialize();
};
bool IsRunningOnLocalDrive();
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool ProcessCommandLine( LPSTR lpCmdLine );
static void StoreBuildInfo()
{
	const string szVersion = StrFmt( "Build %d, %s %s", NVersionInfo::nBuild, NVersionInfo::szDate.c_str(), NVersionInfo::szTime.c_str() );
	NGlobal::SetVar( "version.info", szVersion );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
////#include <vtuneapi.h>
extern "C"
{
	void __declspec(dllimport) __cdecl VTPause(void);
	void __declspec(dllimport) __cdecl VTResume(void);
}
#pragma comment(lib, "vtuneapi.lib")

namespace NGfx
{
	EXTERNVAR int nTotalFrames;
	EXTERNVAR NHPTimer::STime timeFrameStart;
	EXTERNVAR int nCurrentFrame;
}
static int nLimitFrame = 150;
static volatile bool bFrameRateThreadEnabled = true;
static DWORD WINAPI VTuneThreadBreak( void* )
{
	SetThreadPriority( GetCurrentThread(), THREAD_PRIORITY_TIME_CRITICAL );
	for(;;)
	{
		Sleep(1);
		if ( NGfx::nTotalFrames < nLimitFrame )
			continue;
		NHPTimer::STime t = NGfx::timeFrameStart;
		if ( bFrameRateThreadEnabled && NHPTimer::GetTimePassed( &t ) > 1 / 10.0f )
		{
			nLimitFrame = NGfx::nTotalFrames + 100;
			__debugbreak();
		}
	}
}
static DWORD WINAPI VTuneThreadProfile( void* )
{
	SetThreadPriority( GetCurrentThread(), THREAD_PRIORITY_TIME_CRITICAL );
	for(;;)
	{
		Sleep(1);
		if ( NGfx::nTotalFrames < nLimitFrame )
			continue;

		if ( !bFrameRateThreadEnabled )
			continue;

		NHPTimer::STime t = NGfx::timeFrameStart;
		if ( NGfx::nCurrentFrame > 1000 && NHPTimer::GetTimePassed( &t ) > 1 / 20.0f )
		{
			VTResume();
		}
		else
		{
			VTPause();
		}
		// don`t forget about sampling during application shut down
	}
}
static void StartLagProfiling()
{
	DWORD dwThread;
	//CreateThread( 0, 1024, VTuneThreadBreak, 0, 0, &dwThread );	// for break at slow frame
	CreateThread( 0, 1024, VTuneThreadProfile, 0, 0, &dwThread );	// to profile slow frames.
}
*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static string szLaunchDirectory;
int WINAPI WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow )
{
	// CreateMutex( 0, TRUE, "NIVAL_RTS_ENGINE" ); // ��� ������ ������� ���� ��������� ���� mutex
	if ( GetLastError() == ERROR_ALREADY_EXISTS )
		return 0xDEAD;
#ifndef _FINALRELEASE
	if ( !IsRunningOnLocalDrive() ) 
	{
		MessageBox( 0, "IsRunningOnLocalDrive", "Error", MB_OK );
		return 0xDEAD;
	}
#endif
	//
	NGlobal::LoadConfig( "..\\profiles\\startup.cfg" );
	StoreBuildInfo();
	//
	_CrtSetDbgFlag( _CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF );
	_CrtSetReportMode( _CRT_ERROR, _CRTDBG_MODE_DEBUG );
	const int nLeakId = -1;
	_CrtSetBreakAlloc( nLeakId );

#if defined( _DO_SEH ) && !defined( _DEBUG )
	// set Structured exception handler 
	SetCrashHandler();
#endif // defined( _DO_SEH ) && !defined( _DEBUG )
	// disable system-critical errors displaying - just send it to calling process
	SetErrorMode( SEM_FAILCRITICALERRORS );
	//
	if ( ProcessCommandLine(lpCmdLine) == false )
		return 0xDEAD;

	string szLogFileName, szErrorFileName;
	{
		char buffer[1024];
		GetCurrentDirectory( 1024, buffer );
		szLaunchDirectory = buffer;
		if ( !szLaunchDirectory.empty() ) 
		{
			if ( szLaunchDirectory[szLaunchDirectory.size() - 1] != '\\' ) 
				szLaunchDirectory += '\\';
		}
		//
		szLogFileName = string(buffer) + "\\log.txt";
		szErrorFileName = string(buffer) + "\\error.txt";
		DeleteFile( szErrorFileName.c_str() );
		DeleteFile( szLogFileName.c_str() );
	}
	if ( IConsoleBuffer *pConsole = Singleton<IConsoleBuffer>() )
	{
		pConsole->SetLogfile( szLogFileName.c_str() );
		SetupPipeDumpToConsole( PIPE_CHAT, CONSOLE_STREAM_CONSOLE );
	}

	NGScene::SFLB3_RunResourceLoadingThread();
	// show splash screen during program starting
//	NWinFrame::ShowSplashScreen( hInstance, true );
	// load and initialize all dll modules, register and initialize singletons
	NGameX::Initialize();
	//
	CObj<CObjectBase> pSplashScreen = IsDebuggerPresent() ? 0 :NSplash::CreateSplashScreen( NMainLoop::GetBaseDir() + "splash.bmp", true );
	//
	CreateAI();
	//
	// initialize win app
	if ( !NWinFrame::SFLB1_InitApplication(hInstance, " Blitzkrieg II Reforged", "NIVAL_RTS_ENGINE", MAKEINTRESOURCE(IDI_MAIN)) )
	{
		MessageBox( 0, "InitApplication", "Error", MB_OK );
		return 0xDEAD;
	}
	// init graphics
	if ( !NGfx::Init3D(NWinFrame::GetWnd()) )
	{
		ASSERT(0); // DX not found
		MessageBox( 0, "Failed to initialize Direct3D9", "Error", MB_OK );
		return 0xDEAD;
	}
	// init input system
	NInput::InitInput( NWinFrame::GetWnd() );
	//Input()->Init( NWinFrame::GetWnd() );

	// init graphics system
	Singleton<ISFX>()->Init( NWinFrame::GetWnd(), 0, SFX_OUTPUT_DSOUND, 44100, 128 );

	// init profile and read configs
	NMOD::InstantAttachMOD( "", NDb::DATABASE_MODE_GAME );
	NProfile::LoadProfile();
	//
	string szMOD2Attach = NStr::ToMBCS( NGlobal::GetVar("current_attached_mod", "") );
	if ( !szMOD2Attach.empty() )
		szMOD2Attach = NMainLoop::GetBaseDir() + "MODs\\" + szMOD2Attach;
	if ( NMOD::DoesMODAttached(szMOD2Attach) == false )
		NMOD::InstantAttachMOD( szMOD2Attach, NDb::DATABASE_MODE_GAME );
	//
	NGlobal::LoadConfig( "..\\profiles\\autoexec.cfg" );
	NGlobal::LoadConfig( "..\\profiles\\game.cfg" );
	//
	NGlobal::SetVar( "code_version_number", REVISION_NUMBER_STR );
	NGlobal::SetVar( "code_build_date_time", BUILD_DATE_TIME_STR );



	// 
	pSplashScreen = 0;
	// setup video mode - SCENE_MODE was changed to windowed by default - easier black screen closing
	if ( !Scene()->SetupMode(SCENE_MODE_WINDOWED, false) )
	{
		MessageBox( 0, "Can't setup scene mode from config", "Error", MB_OK );
		return 0xDEAD;
	}
	// start
	//StartLagProfiling();
	Cursor()->Acquire( true );
	while ( 1 ) 
	{
		NWinFrame::PumpMessages();

		CWinToInputMessageConverter convert;
		convert.Do();

		const bool bAppActive = NWinFrame::IsAppActive();
		if ( NWinFrame::IsExit() )
		{
			NWinFrame::ResetExit();
			NMainLoop::Command( CreateICExitGame() );				// generate 'EXIT' command
		}
		if ( bAppActive )
			NGfx::CheckBackBufferSize();
		NGfx::SetGamma( bAppActive );//bSetGamma );
		if ( !NMainLoop::StepApp(bAppActive) )
			break;
		if ( !bAppActive )
			Sleep( 40 );
	}
	//
	NMainLoop::ResetStack();

	ClearHoldQueue();
	Scene()->Clear();
	NProfile::SaveProfile();

	NVFS::SetMainVFS( 0 );
	NVFS::SetMainFileCreator( 0 );

	NInput::DoneInput();
	NGfx::Done3D();
	NDb::SaveChanges();
	NDb::CloseDatabase();
	NSingleton::DoneSingletons();
	//
#if defined( _DO_SEH ) && !defined( _DEBUG )
	// reset StructuredExceptionHandler 
	ResetCrashHandler();
#endif // defined( _DO_SEH ) && !defined( _DEBUG )
	//
	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool ProcessCommandLine( LPSTR lpCmdLine )
{
	for ( NStr::CStringIterator<char, string, NStr::CBracketSeparator<char, NStr::SBracketsQuoteTest<char> > > it(lpCmdLine, ' '); 
	      !it.IsEnd(); it.Next() )
	{
		// get string
		string szString;
		it.Get( &szString );
		NStr::TrimBoth( szString );
		if ( szString.empty() ) 
			continue;
		// check for '-' at the begining
		if ( szString == "-show-version" )
		{
			string szVersion = StrFmt( "Version: %s\nBuild date/time: %s\n", REVISION_NUMBER_STR, BUILD_DATE_TIME_STR );
			printf( szVersion.c_str() );
			return false;
		}
		else if ( szString == "-show-version-mb" )
		{
			string szVersion = StrFmt( "Version: %s\nBuild date/time: %s\n", REVISION_NUMBER_STR, BUILD_DATE_TIME_STR );
			::MessageBox( 0, szVersion.c_str(), "Build version", MB_OK | MB_ICONEXCLAMATION );
			return false;
		}
		if ( szString[0] == '-' ) 
		{
			szString.erase( 0, 1 );
			NStr::TrimBoth( szString );
			if ( szString.empty() ) 
				continue;
		}
		// check for spacial cases - save (.sav) and map (.b2m or .b2x)
		if ( szString.size() > 4 ) 
		{
			const int nExtPos = szString.rfind( '.' );
			if ( nExtPos != string::npos ) 
			{
				string szExt = szString.substr( nExtPos );
				NStr::ToLower( &szExt );
				if ( szExt == ".sav" )
				{
					NGlobal::SetVar( "LoadSavedFile", szString );
					continue;
				}
				else if ( (szExt == ".b2m") || (szExt == ".b2x") ) 
				{
					NGlobal::SetVar( "StartNewMap", szString );
					continue;
				}
			}
		}
		// check for '\"' tag - string entry
		const int nFirstQuotePos = szString.find( '\"' );
		if ( nFirstQuotePos != string::npos ) 
		{
			const int nLastQuotePos = szString.rfind( '\"' );
			NI_ASSERT( nLastQuotePos != string::npos, StrFmt("Can't read string from cmd line string entry \"%s\"", szString.c_str()) );
			const string szVarName = szString.substr( 0, nFirstQuotePos );
			const string szValue = szString.substr( nFirstQuotePos + 1, nLastQuotePos - nFirstQuotePos );
			NGlobal::SetVar( szVarName, szValue );
			//
			continue;
		}
		// check for number
		const int nNumberPos = szString.find_first_of( "-0123456789" );
		if ( nNumberPos != string::npos ) 
		{
			const string szVarName = szString.substr( 0, nNumberPos );
			const string szValue = szString.substr( nNumberPos );
			NGlobal::SetVar( szVarName, NStr::ToInt(szValue) );
			continue;
		}
		// no special preferences for parsing - just store this var as integer '1'
		NGlobal::SetVar( szString, 1 );
	}
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
