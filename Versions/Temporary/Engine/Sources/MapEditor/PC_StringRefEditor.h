#if !defined(__COMMON_CONTROLS__PROPERTY_CONTROL_STRING_REF__)
#define __COMMON_CONTROLS__PROPERTY_CONTROL_STRING_REF__
#pragma once

#include "PC_StringBrowseEditor.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CPCStringRefEditor : public CPCStringBrowseEditor
{
	OBJECT_NOCOPY_METHODS( CPCStringRefEditor );

public:
	//CPCItemEditor
	void SetValue( const CVariant &rValue );
	void GetValue( CVariant *pValue );

private:
	// CPCStringBrowseEditor
	void OnBrowse();
	//
	void SetWindowTextByTypeAndName( const string &szObjectTypeName, const string &szObjectName );
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__COMMON_CONTROLS__PROPERTY_CONTROL_STRING_REF__)
