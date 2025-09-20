#ifndef __G2DSCENESOFTWARE_H_
#define __G2DSCENESOFTWARE_H_
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
////////////////////////////////////////////////////////////////////////////////////////////////////
#include "..\System\DG.h"
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	struct STexture;
};
namespace NGfx
{
	class CTexture;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
class CRectLayout;
namespace NGScene
{
class CSWTextureData;
class CSWTexture;

CSWTexture* GetSWTex( const NDb::STexture *pTex );
////////////////////////////////////////////////////////////////////////////////////////////////////
class ISW2DScene: public CObjectBase
{
public:
	virtual CObjectBase* CreateRects( CPtrFuncBase<CSWTextureData> *pTexture, const CRectLayout &layout ) = 0;
	virtual CObjectBase* CreateSpot( CPtrFuncBase<CSWTextureData> *pTexture, const CVec2 &_ptPos, const CVec2 &_ptSize, float _fAngle ) = 0;

	virtual void AddPostFilter( CPtrFuncBase<CSWTextureData> *pTexture, int _nCenterX, int _nCenterY ) = 0;
	virtual void AddGrayingFilter( const CVec4 &vConvolution ) = 0;

	virtual void Draw( NGfx::CTexture *pTarget, const CTPoint<int> &vViewport, bool bClear ) = 0;
	virtual void DrawFog( CArray2D<int> *pFogMap, const CTPoint<int> &vViewport ) = 0;
	virtual void DrawBump( NGfx::CTexture *pTarget, const CTPoint<int> &vViewport, float fScale ) = 0;
};
////////////////////////////////////////////////////////////////////////////////////////////////////
ISW2DScene* Make2DSWScene();
////////////////////////////////////////////////////////////////////////////////////////////////////
} // NAMESPACE
////////////////////////////////////////////////////////////////////////////////////////////////////
#endif
