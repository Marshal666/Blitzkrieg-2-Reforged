#include "stdafx.h"
#include "dbminimap.h"
#include "MinimapMnemonics.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CMinimapLayerMnemonics::CMinimapLayerMnemonics() : 
CMnemonicsCollector<int>( NDb::LAYER_UNKNOWN, "LAYER_UNKNOWN" )
{
	Insert( NDb::LAYER_UNKNOWN,		"LAYER_UNKNOWN" );
	Insert( NDb::LAYER_BRIDGE,		"LAYER_BRIDGE" );
	Insert( NDb::LAYER_BUILDING,	"LAYER_BUILDING" );	
	Insert( NDb::LAYER_RIVER,			"LAYER_RIVER" );
	Insert( NDb::LAYER_RAILOAD,		"LAYER_RAILOAD" );
	Insert( NDb::LAYER_ROAD,			"LAYER_ROAD" );
	Insert( NDb::LAYER_FLORA,			"LAYER_FLORA" );
	Insert( NDb::LAYER_SWAMP,			"LAYER_SWAMP" );
	Insert( NDb::LAYER_LAKE,			"LAYER_LAKE" );
	Insert( NDb::LAYER_OCEAN,			"LAYER_OCEAN" );
	Insert( NDb::LAYER_TERRAIN,		"LAYER_TERRAIN" );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CImageScaleMethod::CImageScaleMethod() : 
CMnemonicsCollector<int>( NDb::IMAGE_SCALE_METHOD_DEFAULT, "IMAGE_SCALE_METHOD_DEFAULT" )
{
	Insert( NDb::IMAGE_SCALE_METHOD_DEFAULT,	"IMAGE_SCALE_METHOD_DEFAULT" );
	Insert( NDb::IMAGE_SCALE_METHOD_FILTER,		"IMAGE_SCALE_METHOD_FILTER" );
	Insert( NDb::IMAGE_SCALE_METHOD_BOX,			"IMAGE_SCALE_METHOD_BOX" );
	Insert( NDb::IMAGE_SCALE_METHOD_TRIANGLE,	"IMAGE_SCALE_METHOD_TRIANGLE" );
	Insert( NDb::IMAGE_SCALE_METHOD_BELL,			"IMAGE_SCALE_METHOD_BELL" );
	Insert( NDb::IMAGE_SCALE_METHOD_BSPLINE,	"IMAGE_SCALE_METHOD_BSPLINE" );
	Insert( NDb::IMAGE_SCALE_METHOD_LANCZOS3,	"IMAGE_SCALE_METHOD_LANCZOS3" );
	Insert( NDb::IMAGE_SCALE_METHOD_MITCHELL,	"IMAGE_SCALE_METHOD_MITCHELL" );
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CMinimapLayerMnemonics typeMinimapLayer;
CImageScaleMethod typeImageScaleMethod;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
