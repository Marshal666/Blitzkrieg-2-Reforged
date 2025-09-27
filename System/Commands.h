#ifndef __A5_GLOBAL_H__
#define __A5_GLOBAL_H__
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NGlobal
{
////////////////////////////////////////////////////////////////////////////////////////////////////
// global var set value handlers storing variable value to specified in pContext place in bool/int/float format
void VarBoolHandler( const string &szID, const NGlobal::CValue &sValue, void *pContext );
void VarIntHandler( const string &szID, const NGlobal::CValue &sValue, void *pContext );
void VarFloatHandler( const string &szID, const NGlobal::CValue &sValue, void *pContext );
void VarWStrHandler( const string &szID, const NGlobal::CValue &sValue, void *pContext );
void VarStrHandler( const string &szID, const NGlobal::CValue &sValue, void *pContext );
////////////////////////////////////////////////////////////////////////////////////////////////////
// helper class for temporary command registration
class CCmd
{
	void *pContext;
	string szID;
	CmdHandler pHandler;
	int nID;

public:
	CCmd( const string &szID, CmdHandler pHandler, void *pContext );
	~CCmd();

	void Run( const vector<wstring> &paramsSet );
};
////////////////////////////////////////////////////////////////////////////////////////////////////
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#endif
