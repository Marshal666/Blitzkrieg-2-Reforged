#pragma once

#include "../3DMotor/GAnimation.hpp"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
using namespace NAnimation;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface ITreeFallingMutator : public IAnimMutator
{
	enum { typeID = 0x12094B80 };
	virtual void Setup( ISkeletonAnimator *pAnimator, const CVec2 &vDir, float _fEndAngle, const CQuat &qRot,
											const vector<string> &leafNames, int nEffectID, const CVec3 &vPos,
											float fEffectHeight, float fFallCycles, int nFallDuration, NTimer::STime timeStart ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface ITreeWindMutator : public IAnimMutator
{
	enum { typeID = 0x19132B40 };
	virtual void Setup( ISkeletonAnimator *pAnimator, const CVec3 &_vPos3, const vector<string> &leafNames ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IMechUnitJoggingMutator : public IAnimMutator
{
	enum { typeID = 0x15095B00 };
	//
	struct SJoggingParams
	{
		float fPeriod1, fPeriod2;
		float fAmp1, fAmp2;
		float fPhaze1, fPhaze2;
	};
	//
	virtual void Setup( const int nBasisBoneIndex, const SJoggingParams &_joggingX, const SJoggingParams &_joggingY ) = 0;
	virtual void Play() = 0;
	virtual void Stop() = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IWingScaleMutator : public IAnimMutator
{
	enum { typeID = 0x3119AB00 };
	virtual bool Setup( ISkeletonAnimator *pAnimator, const string &szScaledWingPrefix, const string &szStaticWingName ) = 0;
	virtual void SetScale( const float fScale ) = 0;
	virtual void ShowStatic( const bool bShow ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
