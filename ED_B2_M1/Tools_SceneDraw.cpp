#include "stdafx.h"

#include "..\misc\2darray.h"
#include "..\zlib\zconf.h"
#include "..\mapeditorlib\tools_hashset.h"
#include "Tools_SceneDraw.h"
#include "../Stats_B2_M1/AnimModes.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const float CSceneDrawTool::SCENE_Z_SHIFT = AI_TILE_SIZE / 16.0f;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CSceneDrawTool::CSceneDrawTool()
{
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CSceneDrawTool::~CSceneDrawTool()
{
	Clear();
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CSceneDrawTool::Draw()
{
	Clear();
	if ( IEditorScene *pScene = EditorScene() )
	{
		for ( CModelInfoList::const_iterator itModelInfo = modelInfoList.begin(); itModelInfo != modelInfoList.end(); ++itModelInfo )
		{
			const nModelID = pScene->AddObject( -1, itModelInfo->pModel, itModelInfo->vPos, itModelInfo->qRot, itModelInfo->vScale, OBJ_ANIM_MODE_DEFAULT, 0 );
			if ( nModelID != ( -1 ) )
			{
				InsertHashSetElement( &modelIDSet, nModelID );
			}
		}
		//
		for ( CPolylineInfoList::const_iterator itPolylineInfo = polylineInfoList.begin(); itPolylineInfo != polylineInfoList.end(); ++itPolylineInfo )
		{
			const nPolylineID = pScene->AddPolyline( -1, itPolylineInfo->points, CVec4(itPolylineInfo->vColor, 1), itPolylineInfo->bDepthCheck );
			if ( nPolylineID != ( -1 ) )
			{
				InsertHashSetElement( &polylineIDSet, nPolylineID );
			}
		}
		modelInfoList.clear();
		polylineInfoList.clear();
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CSceneDrawTool::Clear()
{
	if ( IEditorScene *pScene = EditorScene() )
	{
		for ( CModelIDSet::const_iterator itModelID = modelIDSet.begin(); itModelID != modelIDSet.end(); ++itModelID )
		{
			pScene->RemoveObject( itModelID->first );
		}
		//
		for ( CPolylineIDSet::const_iterator itPolylineID = polylineIDSet.begin(); itPolylineID != polylineIDSet.end(); ++itPolylineID )
		{
			pScene->RemovePolyline( itPolylineID->first );
		}
		//
		modelIDSet.clear();
		polylineIDSet.clear();
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// basement storage  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
