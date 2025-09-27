#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "..\misc\2darray.h"
#include "..\zlib\zconf.h"
#include "Vis2AI.h"
#include "..\System\RandomGen.h"

namespace NDb
{
	struct SComplexSoundDesc;
	enum EUnitAckType;
	enum EReinforcementType;
};
// optimisation (singleton cache)
typedef class CConstructorInfo * PCConstructorInfo;
PCConstructorInfo & ConstructorInfo();
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
enum EArmorDirection
{
	RPG_FRONT		= 0,
	RPG_LEFT		= 1,
	RPG_BACK		= 2,
	RPG_RIGHT		= 3,
	RPG_TOP			= 4,
	RPG_BOTTOM	= 5,
};
*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// mega for_each for vectors
#define FOR_EACH(vec,fun) for( int i = 0; i < vec.size(); ++i ) \
{\
	vec[i].fun();\
}
#define FOR_EACH_ARR(arr,fun,count) for ( int i = 0; i < count; ++i )\
{\
	arr[i].fun();\
}
#define FOR_EACH_VAL(vec,fun, val) for( int i = 0; i < vec.size(); ++i ) \
{\
	vec[i].fun(val);\
}
#define FOR_EACH_ARR_VAL(arr,fun,count, val) for ( int i = 0; i < count; ++i )\
{\
	arr[i].fun(val);\
}
/*
enum EAIClass
{
	AI_CLASS_WHEEL,
	AI_CLASS_HALFTRACK,
	AI_CLASS_TRACK,
	AI_CLASS_HUMAN,
	AI_CLASS_TECHNICS,
	AI_CLASS_ANY,
	AI_CLASS_FORCE_DWORD,
};
*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
inline int GetRandom( int nAverage, int nRandom )
{
	return nRandom <= 0 ? nAverage : NRandom::RandomCheck( nAverage - nRandom, nAverage + nRandom );
}
inline float GetRandom( float fAverage, int nRandom )
{
	return nRandom <= 0 ? fAverage : NRandom::RandomCheck( fAverage - float(nRandom), fAverage + float(nRandom) );
}
inline int GetPositiveRandom( int nAverage, int nRandom )
{
	return Max( 0, NRandom::Random( nAverage - nRandom,  nAverage + nRandom) );
}
inline float GetPositiveRandom( float fAverage, int nRandom )
{
	return Max( 0.0f, NRandom::Random( fAverage - float(nRandom), fAverage + float(nRandom) ) );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Special Ability
namespace NDb
{
	struct SUnitSpecialAblityDesc;
	enum EUnitSpecialAbility;
	struct SAIGameConsts;
	struct SAckSetRPGStats;
};

const NDb::SComplexSoundDesc *ChooseAcknowledgement( const NDb::SAckSetRPGStats *pSet, const NDb::EUnitAckType type );

//inline int GetCommandByAbility( int nAbility );
//inline int GetAbilityByCommand( int nCommand );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const float fCellSizeY = 16;
const float fCellSizeX = fCellSizeY * 2.0f;
const float fWorldCellSize = VIS_TILE_SIZE;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
