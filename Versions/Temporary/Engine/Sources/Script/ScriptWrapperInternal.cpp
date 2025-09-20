#include "StdAfx.h"
#include "ScriptWrapperInternal.h"
#include "../System/VFSOperations.h"
////////////////////////////////////////////////////////////////////////////////////////////////////
CPtr<NScript::CScriptWrapper> pScript;
////////////////////////////////////////////////////////////////////////////////////////////////////
IScriptWrapper* CreateScriptWrapper()
{
	return new NScript::CScriptWrapper;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NScript
{
	extern SRegFunction pCommonRegList[];
////////////////////////////////////////////////////////////////////////////////////////////////////
void AddScriptFunctionsToSaveLoad( const SRegFunction *pRegList )
{
	Script script;
	script.RegisterSaveLoad( pRegList );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void RegisterCommonFunctionsToSaveLoad()
{
	AddScriptFunctionsToSaveLoad( NScript::pCommonRegList );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
SRegFunction pLuaPtrTagFuncList[] = { (0,0) };

////////////////////////////////////////////////////////////////////////////////////////////////////
Script * GetScript()
{
	if ( !IsValid( pScript ) )
		return 0;
	return &pScript->script;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
int CScriptWrapper::CallScriptFunction( const char *pszFunction, const bool bLogToConsole )
{
	pScript = this;
	const int oldtop = script.GetTop();
	int nDoResult = script.DoString( pszFunction );

	if ( nDoResult != 0 )
		return -1;

	const int nNumRetArgs = script.GetTop();
	string szAnswer("");

	int nResult = 0;
	if ( nNumRetArgs == 1 )
	{
		Script::Object obj = script.GetObject( 1 );
		if( obj.IsNumber() )
			nResult = obj.GetNumber();
	}
	
	for ( int i = 1; i <= nNumRetArgs; ++i )
	{
		Script::Object obj = pScript->GetScript()->GetObject( i );

		if ( obj.IsNumber() )
			szAnswer += string( StrFmt( "%d", int(obj) ) );
		else if ( const char *pszAnswer = obj.GetString() )
			szAnswer += pszAnswer;

		if ( i < nNumRetArgs )
			szAnswer += ", ";
	}

	script.SetTop(oldtop);

	if ( bLogToConsole )
	{
		if ( !szAnswer.empty() )
			Singleton<IConsoleBuffer>()->WriteASCII( CONSOLE_STREAM_CONSOLE, szAnswer.c_str(), 0xff00ff00 );
	}

	return nResult;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CScriptWrapper::AddRegFunctions( const SRegFunction *pRegList )
{
	script.Register( pRegList );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CScriptWrapper::Init()
{
	AddRegFunctions( pCommonRegList );
	int nTag = 0;
	nTag = script.RegisterNewTag( pLuaPtrTagFuncList );
	ASSERT( nTag == tagLuaCPtr );
	nTag = script.RegisterNewTag( pLuaPtrTagFuncList );
	ASSERT( nTag == tagLuaCObj );
	RunCommonFiles();
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CScriptWrapper::Segment()
{
	pScript = this;
	script.ExecuteThreads();
}
////////////////////////////////////////////////////////////////////////////////////////////////////
int CScriptWrapper::RunScriptByID( int nID )
{
	/*
	CDBPtr<NDb::CScriptWrapper> pDBScript = NDb::GetDBScript( nID );
	if ( IsValid( pDBScript ) )
	{
		return script.DoBuffer( (const char *)pDBScript->strCode.c_str(), pDBScript->strCode.length() );
	}*/
	return -1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
int CScriptWrapper::RunScript( const char *pszScriptText )
{
	if ( pszScriptText == 0 || !strlen( pszScriptText ) ) return 0;
	return (script.DoBuffer( &(pszScriptText[0]), strlen(pszScriptText), "Script" ) == 0) ; 
}
////////////////////////////////////////////////////////////////////////////////////////////////////
int CScriptWrapper::RunScriptFile( const char *pszFileName )
{
	CFileStream stream( NVFS::GetMainVFS(), pszFileName );
	NI_ASSERT( stream.IsOk() != 0, StrFmt( "Can't find script file \"%s\"", pszFileName ) );
	const int nSize = stream.GetSize();
	// +10 �� ������ ������
	vector<char> buffer( nSize + 10 );
	stream.Read( &(buffer[0]), nSize );
	return (script.DoBuffer( &(buffer[0]), nSize, "Script" ) == 0) ; 
}
////////////////////////////////////////////////////////////////////////////////////////////////////
} // namespace
using namespace NScript;
REGISTER_SAVELOAD_CLASS( 0x11061C00, CScriptWrapper )
BASIC_REGISTER_CLASS(IScriptWrapper)
