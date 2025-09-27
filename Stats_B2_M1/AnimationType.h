#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// automatically generated file, don't change manually!

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IXmlSaver;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{

	enum EAnimationType
	{
		ANIMATION_UNKNOWN = 0,
		ANIMATION_IDLE = 1,
		ANIMATION_IDLE_DOWN = 2,
		ANIMATION_IDLE_REST = 3,
		ANIMATION_IDLE_DIVING = 4,
		ANIMATION_MOVE = 5,
		ANIMATION_MARCH = 6,
		ANIMATION_WALK = 7,
		ANIMATION_CRAWL = 8,
		ANIMATION_DIVING = 9,
		ANIMATION_LIE = 10,
		ANIMATION_STAND = 11,
		ANIMATION_WEAPON_HIDE = 12,
		ANIMATION_WEAPON_SHOW = 13,
		ANIMATION_SHOOT = 14,
		ANIMATION_SHOOT_DOWN = 15,
		ANIMATION_SHOOT_TRENCH = 16,
		ANIMATION_THROW = 17,
		ANIMATION_THROW_TRENCH = 18,
		ANIMATION_THROW_DOWN = 19,
		ANIMATION_DEATH = 20,
		ANIMATION_DEATH_DOWN = 21,
		ANIMATION_DEATH_DIVING = 22,
		ANIMATION_DEATH_FATALITY = 23,
		ANIMATION_DEATH_FATALITY_FLOOR1 = 24,
		ANIMATION_DEATH_FATALITY_FLOOR2 = 25,
		ANIMATION_USE = 26,
		ANIMATION_USE_DOWN = 27,
		ANIMATION_USE_LIE = 28,
		ANIMATION_ENTRENCH = 29,
		ANIMATION_POINT = 30,
		ANIMATION_POINT_DOWN = 31,
		ANIMATION_BINOCULARS = 32,
		ANIMATION_BINOCULARS_DOWN = 33,
		ANIMATION_AIMING = 34,
		ANIMATION_AIMING_TRENCH = 35,
		ANIMATION_AIMING_DOWN = 36,
		ANIMATION_INSTALL = 37,
		ANIMATION_UNINSTALL = 38,
		ANIMATION_INSTALL_ROT = 39,
		ANIMATION_UNINSTALL_ROT = 40,
		ANIMATION_INSTALL_PUSH = 41,
		ANIMATION_UNINSTALL_PUSH = 42,
		__ANIMATION_TYPE_COUNTER = 43,
	};
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	string EnumToString( NDb::EAnimationType eValue );
	EAnimationType StringToEnum_NDb_EAnimationType( const string &szValue );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
template <>
struct SKnownEnum<NDb::EAnimationType>
{
	enum { isKnown = 1 };
	static string ToString( NDb::EAnimationType eValue ) { return NDb::EnumToString( eValue ); }
	static NDb::EAnimationType ToEnum( const string &szValue ) { return NDb::StringToEnum_NDb_EAnimationType( szValue ); }
};
