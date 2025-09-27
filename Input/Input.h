#ifndef __INPUT_H__
#define __INPUT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////
typedef DWORD STime;
////////////////////////////////////////////////////////////////////////////////////////////////////
#include "..\System\WinFrame.h"
namespace NInput
{
////////////////////////////////////////////////////////////////////////////////////////////////////
enum EPOVAxis
{
	PA_UNKNOWN,
	PA_X,
	PA_Y
};
enum EControlType
{
	CT_KEY,
	CT_POV,
	CT_AXIS,
	CT_TIME,
	CT_LIMAXIS,
	CT_WINDOWS,
	CT_UNKNOWN
};
////////////////////////////////////////////////////////////////////////////////////////////////////
struct SMessage
{
	int nAction;
	EPOVAxis ePOVAxis;
	EControlType cType;

	int nParam;
	bool bState;
	STime tTime;

	SMessage() {}
	SMessage( int _nAction, EPOVAxis _ePOVAxis, EControlType _cType, int _nParam, bool _bState, STime _tTime )
		: nAction(_nAction), ePOVAxis(_ePOVAxis), cType(_cType), nParam(_nParam), bState(_bState), tTime(_tTime) {}
};
////////////////////////////////////////////////////////////////////////////////////////////////////
bool InitInput( HWND hWnd, bool bDebugMouse = false, bool bNonExclusiveMode = false, int nSampleBufferSize = -1 );
bool DoneInput();

void PumpMessages( bool bFocus );
bool GetMessage( SMessage *pMsg );
bool IsDInputDiscardableKey( const SMessage &mMsg );
STime GetLastEventTime();
	
int GetControlID( const string &sCommand );
void GetControlInfo( int nAction, EControlType *pcType, float *pfGranularity );
string GetControlLocalName( int nAction );

void StartSaveInput( CDataStream *pStream );
void StopSaveInput();
void StartEmulateInput( CDataStream *pStream );
void StopEmulateInput();
bool IsMouseDisabledDebug();
//
bool ConvertMessage( const NWinFrame::SWindowsMsg &rWindowMsg, string *pszGameMessage, int *pnParam1, int *pnParam2, int *pnCount, NInput::EControlType *peControlType );
////////////////////////////////////////////////////////////////////////////////////////////////////
};
////////////////////////////////////////////////////////////////////////////////////////////////////
#endif
