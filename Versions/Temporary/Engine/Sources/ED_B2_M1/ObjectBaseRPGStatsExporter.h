#if !defined(__OBJECTBASERPGSTATS_EXPORTER__)
#define __OBJECTBASERPGSTATS_EXPORTER__
#pragma once

#include "StaticObjectRPGStatsExporter.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CObjectBaseRPGStatsExporter : public CStaticObjectRPGStatsExporter
{
	bool ExportDynamicDebris( IManipulator *pManipulator, const string &szObjectName );
protected:
	virtual bool NeedCreatePassability() = 0;
public:
	// CStaticObjectRPGStatsExporter
	EXPORT_RESULT ExportObject( IManipulator* pManipulator,
															const string &rszObjectTypeName,
															const string &rszObjectName,
															bool bForce,
															EXPORT_TYPE exportType );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__OBJECTBASERPGSTATS_EXPORTER__)

