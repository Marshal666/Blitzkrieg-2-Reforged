#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// func is called on var set or cmd call
#define REGISTER_CMD( var, func ) NGlobal::RegisterCmd( var, func, 0 );
#define REGISTER_VAR( var, func, defval, save ) NGlobal::RegisterVar( var, func, 0, defval, save );
#define REGISTER_VAR_EX( var, func, cont, defval, save ) NGlobal::RegisterVar( var, func, cont, defval, save );

enum EStorageClass
{
	STORAGE_DONT_CARE = -1,
	STORAGE_NONE = 0,
	STORAGE_GLOBAL = 1,
	STORAGE_USER = 2,
	STORAGE_SAVE = 3,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NGlobal
{
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CValue
{
	ZDATA
	float fVal;
	wstring szVal;
public:
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&fVal); f.Add(3,&szVal); return 0; }
private:
	//
	void SetVal( const char *pszString )
	{
		const int nLen = strlen( pszString );
		szVal.resize( nLen );
		copy( pszString, pszString + nLen, szVal.begin() );
	}
public:
	CValue() : fVal( 0 ) {}
	CValue( float _fVal ) : fVal( _fVal ) { SetVal( StrFmt("%g", _fVal) ); }
	CValue( int _n ) : fVal( _n ) { SetVal( StrFmt( "%g", fVal ) ); }
	CValue( const wstring &_szVal )	: fVal( _wtof( _szVal.c_str() ) ), szVal( _szVal ) {}
	CValue( const wchar_t *pszVal )	: fVal( _wtof( pszVal ) ), szVal(pszVal) {}
	CValue( const string &_szVal )	: fVal( atof( _szVal.c_str() ) ) { SetVal( _szVal.c_str() ); }
	CValue( const char *pszVal )	: fVal( atof( pszVal ) ) { SetVal( pszVal ); }

	float GetFloat() const { return fVal; }
	const wstring& GetString() const { return szVal; }

	operator float() const { return fVal; }
	operator wstring() const { return szVal; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef void (*VarHandler)( const string &szID, const CValue &sValue, void *pContext );
typedef void (*CmdHandler)( const string &szID, const vector<wstring> &paramsSet, void *pContext );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int RegisterCmd( const string &szID, CmdHandler pHandler, void *pContext );
int RegisterVar( const string &szID, VarHandler pHandler, void *pContext, const CValue &sValue, EStorageClass storage );
void UnregisterCmd( const string &szID, int nID );
void UnregisterVar( const string &szID, int nID );
void RemoveVar( const string &szID );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const CValue &GetVar( const string &szName, const CValue &sDefault = CValue() );
void SetVar( const string &szName, const CValue &sValue, EStorageClass storage = STORAGE_DONT_CARE );
void GetIDList( vector<string> *pList );
void GetVarsByClass( vector< pair<string, CValue> > *pList, EStorageClass eStorageClass );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void ProcessCommand( const wstring &szCmd );
void LoadConfig( const string &szFileName, EStorageClass _newVarStorage = STORAGE_DONT_CARE );
void ResetVarsToDefault( EStorageClass storage );
void SaveAllVars( const string &szGlobalName, const string &szUserName );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
