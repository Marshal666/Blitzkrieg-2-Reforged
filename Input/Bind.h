#ifndef __BIND_H__
#define __BIND_H__

#include "Input.h"
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NInput
{
	struct SCommand;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
struct SGameMessage
{
	NInput::SMessage mMessage;
	vector<NInput::SCommand*> commands;
#ifndef _FINALRELEASE
	string szEventName;
#endif
	// general-purpose params
	struct  
	{
		int nParam1;//union { int nParam1; DWORD dwParam1; float fParam1; };
		int nParam2; //union { int nParam2; DWORD dwParam2; float fParam2; };
	};
	SGameMessage() : nParam1(0), nParam2(0) {}
};
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NInput
{
////////////////////////////////////////////////////////////////////////////////////////////////////
enum EMappingType
{
	MTYPE_EVENT,
	MTYPE_EVENT_UP,
	MTYPE_SLIDER,
	MTYPE_SLIDER_MINUS,
	MTYPE_UNKNOWN
};
////////////////////////////////////////////////////////////////////////////////////////////////////
struct SBind
{
	string szSection;
	EMappingType eType;
	vector<string> controlsSet;
};
class CBind
{
	float fDelta;
	SCommand* pBindCommand;
#ifndef _FINALRELEASE
	string szBindName;
#endif
public:
	CBind( const string &sCmd );

	bool IsActive() const;
	float GetDelta();
	float GetSpeed() const;

	bool ProcessEvent( const SGameMessage &eEvent );
};
////////////////////////////////////////////////////////////////////////////////////////////////////
const vector<string>& GetSections();
void SetSection( const string &_szSection, bool bUpdate = true );
void SetSection( const vector<string> &sections, bool bUpdate = true );
////
void Bind( const string &szCmd, const SBind &sCmdBind );
void Unbind( const string &szCmd );
void GetBind( const string &szCmd, list<SBind> *pRes );
void UpdateBinds();
////
float GetControlCoeff( const string &szControl );
void SetControlCoeff( const string &szControl, float fCoeff );
////
float GetCommandCoeff( const string &szControl );
void SetCommandCoeff( const string &szControl, float fCoeff );
////
bool GetEvent( SGameMessage *pGameMessage );
void MakeEvent( SGameMessage *pMSG,  const string &szGameMessage, int nParam1, int nParam2, EControlType ct );
void PostEvent( const string &szGameMessage, int nParam1, int nParam2 );
void PostWinEvent( const string &szGameMessage, int nParam1, int nParam2 );
void PurgeEvents();
void PurgeUIEvents();
////////////////////////////////////////////////////////////////////////////////////////////////////
};
////////////////////////////////////////////////////////////////////////////////////////////////////
#endif
