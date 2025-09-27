#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ActionNotify.h"
#include "AnimationType.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
inline int GetAnimationFromAction( int nAction )
{
	switch ( nAction )
	{
	case ACTION_NOTIFY_IDLE:
		return NDb::ANIMATION_IDLE;
	case ACTION_NOTIFY_IDLE_LYING:
		return NDb::ANIMATION_IDLE_DOWN;
	case ACTION_NOTIFY_MOVE:
		return NDb::ANIMATION_MOVE;
	case ACTION_NOTIFY_CRAWL:
		return NDb::ANIMATION_CRAWL;
	case ACTION_NOTIFY_AIM:
		return NDb::ANIMATION_AIMING;
	case ACTION_NOTIFY_DIE:
		return NDb::ANIMATION_DEATH;
	case ACTION_NOTIFY_AIM_LYING:
		return NDb::ANIMATION_AIMING_DOWN;
	case ACTION_NOTIFY_DIE_LYING:
		return NDb::ANIMATION_DEATH_DOWN;
	case ACTION_NOTIFY_IDLE_TRENCH:
		return NDb::ANIMATION_IDLE;
	case ACTION_NOTIFY_AIM_TRENCH:
		return NDb::ANIMATION_AIMING_TRENCH;
	case ACTION_NOTIFY_THROW:
		return NDb::ANIMATION_THROW;
	case ACTION_NOTIFY_THROW_TRENCH:
		return NDb::ANIMATION_THROW_TRENCH;
	case ACTION_NOTIFY_MECH_SHOOT:
		return NDb::ANIMATION_SHOOT;
	case ACTION_NOTIFY_INFANTRY_SHOOT:
		return NDb::ANIMATION_SHOOT;
	case ACTION_NOTIFY_SHOOT_LYING:
		return NDb::ANIMATION_SHOOT_DOWN;
	case ACTION_NOTIFY_SHOOT_TRENCH:
		return NDb::ANIMATION_SHOOT_TRENCH;
	case ACTION_NOTIFY_USE_UP:
		return NDb::ANIMATION_USE;
	case ACTION_NOTIFY_USE_DOWN:
		return NDb::ANIMATION_USE_DOWN;
		//case ACTION_NOTIFY_INSTALL:
		//return NDb::ANIMATION_INSTALL;
		//case ACTION_NOTIFY_UNINSTALL:
		//return NDb::ANIMATION_UNINSTALL;
		//case ACTION_NOTIFY_UNINSTALL_ROTATE:
		//return NDb::ANIMATION_UNINSTALL_ROT;
		//case ACTION_NOTIFY_INSTALL_ROTATE:
		//return NDb::ANIMATION_INSTALL_ROT;
		//case ACTION_NOTIFY_UNINSTALL_TRANSPORT:
		//return NDb::ANIMATION_UNINSTALL;
		//case ACTION_NOTIFY_INSTALL_TRANSPORT:
		//return NDb::ANIMATION_INSTALL;
	case ACTION_NOTIFY_USE_SPYGLASS:
		return NDb::ANIMATION_BINOCULARS;
	case ACTION_NOTIFY_USE_SPYGLASS_LYING:
		return NDb::ANIMATION_BINOCULARS_DOWN;

		//case ACTION_NOTIFY_INSTALL_MOVE:
		//return NDb::ANIMATION_INSTALL_PUSH;
		//case ACTION_NOTIFY_UNINSTALL_MOVE:
		//return NDb::ANIMATION_UNINSTALL_PUSH;

		//		case ACTION_NOTIFY_FALLING:
		//			return NDb::ANIMATION_THROW;
		//		case ACTION_NOTIFY_OPEN_PARASHUTE:
		//			return NDb::ANIMATION_USE;
		//		case ACTION_NOTIFY_PARASHUTE:
		//			return NDb::ANIMATION_IDLE;
		//		case ACTION_NOTIFY_CLOSE_PARASHUTE:
		//			return NDb::ANIMATION_USE_DOWN;

	case ACTION_NOTIFY_STAYING_TO_LYING:
		return NDb::ANIMATION_LIE;
	case ACTION_NOTIFY_LYING_TO_STAYING:
		return NDb::ANIMATION_STAND;
	case ACTION_NOTIFY_THROW_LYING:
		return NDb::ANIMATION_THROW_DOWN;
	}

	return -1;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
inline bool IsDeathAnimation( const int nAnimation )
{
	return ( nAnimation == NDb::ANIMATION_DEATH || nAnimation == NDb::ANIMATION_DEATH_DOWN );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
