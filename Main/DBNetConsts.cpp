// automatically generated file, don't change manually!

#include "stdafx.h"
#include "../libdb/ReportMetaInfo.h"
#include "../libdb/Checksum.h"
#include "../System/XmlSaver.h"
#include "dbnetconsts.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SNetGameConsts::ReportMetaInfo() const
{
	NMetaInfo::StartMetaInfoReport( "NetGameConsts", typeID, sizeof(*this) );

	BYTE *pThis = (BYTE*)this;
	NMetaInfo::ReportMetaInfo( "MaxLatency", (BYTE*)&nMaxLatency - pThis, sizeof(nMaxLatency), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "TimeToStartLagByNoSegmentData", (BYTE*)&nTimeToStartLagByNoSegmentData - pThis, sizeof(nTimeToStartLagByNoSegmentData), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "TimeToAllowDropByLag", (BYTE*)&nTimeToAllowDropByLag - pThis, sizeof(nTimeToAllowDropByLag), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "TimeOutTime", (BYTE*)&nTimeOutTime - pThis, sizeof(nTimeOutTime), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "TimeBWTimeOuts", (BYTE*)&nTimeBWTimeOuts - pThis, sizeof(nTimeBWTimeOuts), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "Port", (BYTE*)&nPort - pThis, sizeof(nPort), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::FinishMetaInfoReport();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SNetGameConsts::operator&( IXmlSaver &saver )
{
	NMetaInfo::STerminalClassReporter reporter( this, saver );
	saver.Add( "MaxLatency", &nMaxLatency );
	saver.Add( "TimeToStartLagByNoSegmentData", &nTimeToStartLagByNoSegmentData );
	saver.Add( "TimeToAllowDropByLag", &nTimeToAllowDropByLag );
	saver.Add( "TimeOutTime", &nTimeOutTime );
	saver.Add( "TimeBWTimeOuts", &nTimeBWTimeOuts );
	saver.Add( "Port", &nPort );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SNetGameConsts::operator&( IBinSaver &saver )
{
	saver.Add( 2, &nMaxLatency );
	saver.Add( 3, &nTimeToStartLagByNoSegmentData );
	saver.Add( 4, &nTimeToAllowDropByLag );
	saver.Add( 5, &nTimeOutTime );
	saver.Add( 6, &nTimeBWTimeOuts );
	saver.Add( 7, &nPort );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
using namespace NDb;
REGISTER_DATABASE_CLASS( 0x300A7B40, SNetGameConsts ) 
