#if !defined(__INTERFACE_LOGGER__)
#define __INTERFACE_LOGGER__
#pragma once

#include "Interface_MainFrame.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NLog
{
	struct SLogBuffer
	{
		ELogOutputType eLogOutputType;
		string szText;
	};
	typedef list<SLogBuffer> CLogBufferList;
	//
	interface ILoggerSink : public CObjectBase
	{
		virtual ILogger * GetLogger() = 0;
	};
	void SetLogger( ILoggerSink * pLoggerSink );
	//	
	ILogger * GetLogger();
//	void FlushLogBuffer();
	//
	void Log( ELogOutputType eLogOutputType, const char *pszFormat, ... );
	void ClearLog();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif //#define __INTERFACE_LOGGER__
