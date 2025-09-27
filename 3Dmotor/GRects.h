#ifndef __GRECTS_H__
#define __GRECTS_H__
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
////////////////////////////////////////////////////////////////////////////////////////////////////
#include "RectLayout.h"
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NGfx
{
	class CTexture;
	class C2DQuadsRenderer;
};
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NGScene
{
enum ELayoutRenderMode
{
	LRM_NORMAL,
	LRM_CLEAR_RECT
};
void RenderRectLayout( NGfx::C2DQuadsRenderer *pRes, NGfx::CTexture *pTex, const CRectLayout &sLayout, float fZ = 1.0f, ELayoutRenderMode lrm = LRM_NORMAL );
bool ClipRect( CTRect<float> *pClippedRect, CRectLayout::STextureCoord *pTex, const CRectLayout::SRect &sRect, const CTPoint<float> &sPosition, const CTRect<float> &sWindow );
void RenderRectLayoutClipped( NGfx::C2DQuadsRenderer *pRes, NGfx::CTexture *pTex, const CRectLayout &sLayout, const CTPoint<float> &sPosition, const CTRect<float> &sWindow, float fZ = 1.0f, ELayoutRenderMode lrm = LRM_NORMAL );
void RenderRect( NGfx::C2DQuadsRenderer *pRes, NGfx::CTexture *pTex, 
	const CVec2 *pPos4, const NGfx::SPixel8888 *pColors4, const CTRect<float> &rSrc, float fZ = 1.0f );
////////////////////////////////////////////////////////////////////////////////////////////////////
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#endif
