#pragma once

namespace NGScene
{
struct SUserRTInfo;
////////////////////////////////////////////////////////////////////////////////////////////////////
bool SetModeFromConfig( bool bReinit, const SUserRTInfo &rtInfo );
//bool CanRenderShadows();
//bool CanCacheLighting();
//bool CanCalcAmbient();
//bool CanRenderPrecisePointShadows();
//int GetCLSkyTexturesNumber();
//int GetCLCubeResolution();
bool CanCalcLM();
int GetShadowsQuality();
bool IsUsing16bitShadows();
}
