// automatically generated file, don't change manually!

#include "stdafx.h"
#include "../libdb/ReportMetaInfo.h"
#include "../libdb/Checksum.h"
#include "../System/XmlSaver.h"
#include "animationtype.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EAnimationType eValue )
{
	switch ( eValue )
	{
	case NDb::ANIMATION_UNKNOWN:
		return "ANIMATION_UNKNOWN";
	case NDb::ANIMATION_IDLE:
		return "ANIMATION_IDLE";
	case NDb::ANIMATION_IDLE_DOWN:
		return "ANIMATION_IDLE_DOWN";
	case NDb::ANIMATION_IDLE_REST:
		return "ANIMATION_IDLE_REST";
	case NDb::ANIMATION_IDLE_DIVING:
		return "ANIMATION_IDLE_DIVING";
	case NDb::ANIMATION_MOVE:
		return "ANIMATION_MOVE";
	case NDb::ANIMATION_MARCH:
		return "ANIMATION_MARCH";
	case NDb::ANIMATION_WALK:
		return "ANIMATION_WALK";
	case NDb::ANIMATION_CRAWL:
		return "ANIMATION_CRAWL";
	case NDb::ANIMATION_DIVING:
		return "ANIMATION_DIVING";
	case NDb::ANIMATION_LIE:
		return "ANIMATION_LIE";
	case NDb::ANIMATION_STAND:
		return "ANIMATION_STAND";
	case NDb::ANIMATION_WEAPON_HIDE:
		return "ANIMATION_WEAPON_HIDE";
	case NDb::ANIMATION_WEAPON_SHOW:
		return "ANIMATION_WEAPON_SHOW";
	case NDb::ANIMATION_SHOOT:
		return "ANIMATION_SHOOT";
	case NDb::ANIMATION_SHOOT_DOWN:
		return "ANIMATION_SHOOT_DOWN";
	case NDb::ANIMATION_SHOOT_TRENCH:
		return "ANIMATION_SHOOT_TRENCH";
	case NDb::ANIMATION_THROW:
		return "ANIMATION_THROW";
	case NDb::ANIMATION_THROW_TRENCH:
		return "ANIMATION_THROW_TRENCH";
	case NDb::ANIMATION_THROW_DOWN:
		return "ANIMATION_THROW_DOWN";
	case NDb::ANIMATION_DEATH:
		return "ANIMATION_DEATH";
	case NDb::ANIMATION_DEATH_DOWN:
		return "ANIMATION_DEATH_DOWN";
	case NDb::ANIMATION_DEATH_DIVING:
		return "ANIMATION_DEATH_DIVING";
	case NDb::ANIMATION_DEATH_FATALITY:
		return "ANIMATION_DEATH_FATALITY";
	case NDb::ANIMATION_DEATH_FATALITY_FLOOR1:
		return "ANIMATION_DEATH_FATALITY_FLOOR1";
	case NDb::ANIMATION_DEATH_FATALITY_FLOOR2:
		return "ANIMATION_DEATH_FATALITY_FLOOR2";
	case NDb::ANIMATION_USE:
		return "ANIMATION_USE";
	case NDb::ANIMATION_USE_DOWN:
		return "ANIMATION_USE_DOWN";
	case NDb::ANIMATION_USE_LIE:
		return "ANIMATION_USE_LIE";
	case NDb::ANIMATION_ENTRENCH:
		return "ANIMATION_ENTRENCH";
	case NDb::ANIMATION_POINT:
		return "ANIMATION_POINT";
	case NDb::ANIMATION_POINT_DOWN:
		return "ANIMATION_POINT_DOWN";
	case NDb::ANIMATION_BINOCULARS:
		return "ANIMATION_BINOCULARS";
	case NDb::ANIMATION_BINOCULARS_DOWN:
		return "ANIMATION_BINOCULARS_DOWN";
	case NDb::ANIMATION_AIMING:
		return "ANIMATION_AIMING";
	case NDb::ANIMATION_AIMING_TRENCH:
		return "ANIMATION_AIMING_TRENCH";
	case NDb::ANIMATION_AIMING_DOWN:
		return "ANIMATION_AIMING_DOWN";
	case NDb::ANIMATION_INSTALL:
		return "ANIMATION_INSTALL";
	case NDb::ANIMATION_UNINSTALL:
		return "ANIMATION_UNINSTALL";
	case NDb::ANIMATION_INSTALL_ROT:
		return "ANIMATION_INSTALL_ROT";
	case NDb::ANIMATION_UNINSTALL_ROT:
		return "ANIMATION_UNINSTALL_ROT";
	case NDb::ANIMATION_INSTALL_PUSH:
		return "ANIMATION_INSTALL_PUSH";
	case NDb::ANIMATION_UNINSTALL_PUSH:
		return "ANIMATION_UNINSTALL_PUSH";
	case NDb::__ANIMATION_TYPE_COUNTER:
		return "__ANIMATION_TYPE_COUNTER";
	default:
		return "ANIMATION_UNKNOWN";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EAnimationType NDb::StringToEnum_NDb_EAnimationType( const string &szValue )
{
	if ( szValue == "ANIMATION_UNKNOWN" )
		return NDb::ANIMATION_UNKNOWN;
	if ( szValue == "ANIMATION_IDLE" )
		return NDb::ANIMATION_IDLE;
	if ( szValue == "ANIMATION_IDLE_DOWN" )
		return NDb::ANIMATION_IDLE_DOWN;
	if ( szValue == "ANIMATION_IDLE_REST" )
		return NDb::ANIMATION_IDLE_REST;
	if ( szValue == "ANIMATION_IDLE_DIVING" )
		return NDb::ANIMATION_IDLE_DIVING;
	if ( szValue == "ANIMATION_MOVE" )
		return NDb::ANIMATION_MOVE;
	if ( szValue == "ANIMATION_MARCH" )
		return NDb::ANIMATION_MARCH;
	if ( szValue == "ANIMATION_WALK" )
		return NDb::ANIMATION_WALK;
	if ( szValue == "ANIMATION_CRAWL" )
		return NDb::ANIMATION_CRAWL;
	if ( szValue == "ANIMATION_DIVING" )
		return NDb::ANIMATION_DIVING;
	if ( szValue == "ANIMATION_LIE" )
		return NDb::ANIMATION_LIE;
	if ( szValue == "ANIMATION_STAND" )
		return NDb::ANIMATION_STAND;
	if ( szValue == "ANIMATION_WEAPON_HIDE" )
		return NDb::ANIMATION_WEAPON_HIDE;
	if ( szValue == "ANIMATION_WEAPON_SHOW" )
		return NDb::ANIMATION_WEAPON_SHOW;
	if ( szValue == "ANIMATION_SHOOT" )
		return NDb::ANIMATION_SHOOT;
	if ( szValue == "ANIMATION_SHOOT_DOWN" )
		return NDb::ANIMATION_SHOOT_DOWN;
	if ( szValue == "ANIMATION_SHOOT_TRENCH" )
		return NDb::ANIMATION_SHOOT_TRENCH;
	if ( szValue == "ANIMATION_THROW" )
		return NDb::ANIMATION_THROW;
	if ( szValue == "ANIMATION_THROW_TRENCH" )
		return NDb::ANIMATION_THROW_TRENCH;
	if ( szValue == "ANIMATION_THROW_DOWN" )
		return NDb::ANIMATION_THROW_DOWN;
	if ( szValue == "ANIMATION_DEATH" )
		return NDb::ANIMATION_DEATH;
	if ( szValue == "ANIMATION_DEATH_DOWN" )
		return NDb::ANIMATION_DEATH_DOWN;
	if ( szValue == "ANIMATION_DEATH_DIVING" )
		return NDb::ANIMATION_DEATH_DIVING;
	if ( szValue == "ANIMATION_DEATH_FATALITY" )
		return NDb::ANIMATION_DEATH_FATALITY;
	if ( szValue == "ANIMATION_DEATH_FATALITY_FLOOR1" )
		return NDb::ANIMATION_DEATH_FATALITY_FLOOR1;
	if ( szValue == "ANIMATION_DEATH_FATALITY_FLOOR2" )
		return NDb::ANIMATION_DEATH_FATALITY_FLOOR2;
	if ( szValue == "ANIMATION_USE" )
		return NDb::ANIMATION_USE;
	if ( szValue == "ANIMATION_USE_DOWN" )
		return NDb::ANIMATION_USE_DOWN;
	if ( szValue == "ANIMATION_USE_LIE" )
		return NDb::ANIMATION_USE_LIE;
	if ( szValue == "ANIMATION_ENTRENCH" )
		return NDb::ANIMATION_ENTRENCH;
	if ( szValue == "ANIMATION_POINT" )
		return NDb::ANIMATION_POINT;
	if ( szValue == "ANIMATION_POINT_DOWN" )
		return NDb::ANIMATION_POINT_DOWN;
	if ( szValue == "ANIMATION_BINOCULARS" )
		return NDb::ANIMATION_BINOCULARS;
	if ( szValue == "ANIMATION_BINOCULARS_DOWN" )
		return NDb::ANIMATION_BINOCULARS_DOWN;
	if ( szValue == "ANIMATION_AIMING" )
		return NDb::ANIMATION_AIMING;
	if ( szValue == "ANIMATION_AIMING_TRENCH" )
		return NDb::ANIMATION_AIMING_TRENCH;
	if ( szValue == "ANIMATION_AIMING_DOWN" )
		return NDb::ANIMATION_AIMING_DOWN;
	if ( szValue == "ANIMATION_INSTALL" )
		return NDb::ANIMATION_INSTALL;
	if ( szValue == "ANIMATION_UNINSTALL" )
		return NDb::ANIMATION_UNINSTALL;
	if ( szValue == "ANIMATION_INSTALL_ROT" )
		return NDb::ANIMATION_INSTALL_ROT;
	if ( szValue == "ANIMATION_UNINSTALL_ROT" )
		return NDb::ANIMATION_UNINSTALL_ROT;
	if ( szValue == "ANIMATION_INSTALL_PUSH" )
		return NDb::ANIMATION_INSTALL_PUSH;
	if ( szValue == "ANIMATION_UNINSTALL_PUSH" )
		return NDb::ANIMATION_UNINSTALL_PUSH;
	if ( szValue == "__ANIMATION_TYPE_COUNTER" )
		return NDb::__ANIMATION_TYPE_COUNTER;
	return NDb::ANIMATION_UNKNOWN;
}
}
using namespace NDb;
