#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// automatically generated file, don't change manually!

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IXmlSaver;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{

	enum EUserAction
	{
		USER_ACTION_UNKNOWN = 0,
		USER_ACTION_MOVE = 1,
		USER_ACTION_ATTACK = 2,
		USER_ACTION_SWARM = 3,
		USER_ACTION_BOARD = 4,
		USER_ACTION_LEAVE = 5,
		USER_ACTION_ROTATE = 6,
		USER_ACTION_INSTALL = 7,
		USER_ACTION_UNINSTALL = 8,
		USER_ACTION_GUARD = 9,
		USER_ACTION_AMBUSH = 10,
		USER_ACTION_FORMATION = 11,
		USER_ACTION_RANGING = 12,
		USER_ACTION_FOLLOW = 13,
		USER_ACTION_ENTRENCH_SELF = 14,
		USER_ACTION_STAND_GROUND = 15,
		USER_ACTION_MOVE_TO_GRID = 16,
		USER_ACTION_CAPTURE_ARTILLERY = 17,
		USER_ACTION_ENGINEER_PLACE_MINES = 18,
		USER_ACTION_ENGINEER_CLEAR_MINES = 19,
		USER_ACTION_ENGINEER_BUILD_DEFENSE = 20,
		USER_ACTION_ENGINEER_BUILD_ENTRENCHMENT = 21,
		USER_ACTION_ENGINEER_REPAIR = 22,
		USER_ACTION_SUPPORT_RESUPPLY = 23,
		USER_ACTION_FILL_RU = 24,
		USER_ACTION_HOOK_ARTILLERY = 25,
		USER_ACTION_DEPLOY_ARTILLERY = 26,
		USER_ACTION_FORMATION_0 = 27,
		USER_ACTION_FORMATION_3 = 28,
		USER_ACTION_FORMATION_2 = 29,
		USER_ACTION_FORMATION_1 = 30,
		USER_ACTION_FORMATION_4 = 31,
		USER_ACTION_USE_SHELL_DAMAGE = 32,
		USER_ACTION_USE_SHELL_AGIT = 33,
		USER_ACTION_USE_SHELL_SMOKE = 34,
		USER_ACTION_PLACE_MARKER = 35,
		USER_ACTION_CHANGE_MOVEMENT_ORDER = 36,
		USER_ACTION_DISBAND_SQUAD = 37,
		USER_ACTION_FORM_SQUAD = 38,
		USER_ACTION_STOP = 39,
		USER_ACTION_SPYGLASS = 40,
		USER_ACTION_MECH_BOARD = 41,
		USER_ACTION_ENGINEER_BUILD_FENCE = 42,
		USER_ACTION_ABILITY = 43,
		USER_ACTION_CAMOFLAGE = 44,
		USER_ACTION_THROW = 45,
		USER_ACTION_ADVANCED_CAMOFLAGE = 46,
		USER_ACTION_LAND_MINE = 47,
		USER_ACTION_BLASTING_CHARGE = 48,
		USER_ACTION_CONTROLLED_CHARGE = 49,
		USER_ACTION_DETONATE = 50,
		USER_ACTION_HOLD_SECTOR = 51,
		USER_ACTION_TRACK_TARGETING = 52,
		USER_ACTION_SUPPRESS = 53,
		USER_ACTION_CRITICAL_TARGETTING = 54,
		USER_ACTION_RAPID_FIRE = 55,
		USER_ACTION_COVER_FIRE = 56,
		USER_ACTION_LINKED_GRENADES = 57,
		USER_ACTION_SUPPORT_FIRE = 58,
		USER_ACTION_PATROL = 59,
		USER_ACTION_KAMIKAZE = 60,
		USER_ACTION_FLAMETHROWER = 61,
		USER_ACTION_CAUTION = 62,
		USER_ACTION_EXACT_SHOT = 63,
		USER_ACTION_COUNTER_FIRE = 64,
		USER_ACTION_FIRST_AID = 65,
		USER_ACTION_SPY_MODE = 66,
		USER_ACTION_MOBILE_FORTRESS = 67,
		USER_ACTION_MOVING_SHOOT = 68,
		USER_ACTION_MASTER_OF_STREETS = 69,
		USER_ACTION_ADRENALINE_RUSH = 70,
		USER_ACTION_ZEROING_IN = 71,
		USER_ACTION_DROP_BOMB = 72,
		USER_ACTION_EXACT_BOMBING = 73,
		USER_ACTION_SMOKE_SHOTS = 74,
		USER_ACTION_GLOBE_BOMB_MISSION = 75,
		USER_ACTION_GLOBE_ATTACK_MISSION = 76,
		USER_ACTION_GLOBE_BEGIN_WAR = 77,
		USER_ACTION_DROP_PARATROOPERS = 78,
		USER_ACTION_MASTER_PILOT = 79,
		USER_ACTION_SKY_GUARD = 80,
		USER_ACTION_SURVIVAL = 81,
		USER_ACTION_TANK_HUNTER = 82,
		USER_ACTION_REINF_COMMON = 83,
		USER_ACTION_REINF_BOMB = 84,
		USER_ACTION_REINF_PARATROOPERS = 85,
		USER_ACTION_MOVE_LIKE_TERRAIN = 86,
		USER_ACTION_REINF_NONE = 87,
		USER_ACTION_ADD_UNIT = 88,
		USER_ACTION_REMOVE_UNIT = 89,
		USER_ACTION_FORBIDDEN = 90,
		USER_ACTION_SUPER_WEAPON_MODE = 91,
		USER_ACTION_RADIO_CONTROLLED_MODE = 92,
		USER_ACTION_MOVE_TRACK = 93,
		USER_ACTION_MOVE_WHELL = 94,
		USER_ACTION_MOVE_HUMAN = 95,
	};

	enum ESpecialAbilityParam
	{
		PARAM_ABILITY_ON = 0,
		PARAM_ABILITY_OFF = 1,
		PARAM_ABILITY_AUTOCAST_ON = 2,
		PARAM_ABILITY_AUTOCAST_OFF = 3,
	};
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	string EnumToString( NDb::EUserAction eValue );
	EUserAction StringToEnum_NDb_EUserAction( const string &szValue );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
template <>
struct SKnownEnum<NDb::EUserAction>
{
	enum { isKnown = 1 };
	static string ToString( NDb::EUserAction eValue ) { return NDb::EnumToString( eValue ); }
	static NDb::EUserAction ToEnum( const string &szValue ) { return NDb::StringToEnum_NDb_EUserAction( szValue ); }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	string EnumToString( NDb::ESpecialAbilityParam eValue );
	ESpecialAbilityParam StringToEnum_NDb_ESpecialAbilityParam( const string &szValue );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
template <>
struct SKnownEnum<NDb::ESpecialAbilityParam>
{
	enum { isKnown = 1 };
	static string ToString( NDb::ESpecialAbilityParam eValue ) { return NDb::EnumToString( eValue ); }
	static NDb::ESpecialAbilityParam ToEnum( const string &szValue ) { return NDb::StringToEnum_NDb_ESpecialAbilityParam( szValue ); }
};
