#pragma once
#include "ExecutorUnitBonus.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CExecutorUnitCombatBonus	(abstract)
//
// Provides ability control according to combat situation: has callbacks on combat events.
// Is registered on events: START_IDLE, STOP_IDLE
//
// Used to derive another class (e.g. Ambush)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CExecutorUnitCombatBonus : public CExecutorUnitBonus
{
	WORD modeFlags;

protected:
	//Callbacks
	enum EAbilityCombatReaction
	{
		EACR_IGNORE,
		EACR_FORCE_ACTIVATE,
		EACR_FORCE_DEACTIVATE,
		EACR_FORCE_RECHARGE,
	};

	enum EUnitMode
	{
		EUM_MOVING		= 1<<0,
		EUM_FIGHTING	= 1<<1,
	};

	virtual EAbilityCombatReaction OnModeChange( const WORD oldModeFlags, const WORD newModeFlags ) = 0;

public:
	CExecutorUnitCombatBonus( EUnitSpecialAbility eAbility, CAIUnit *_pUnit, EExecutorTypeID eTID );
	CExecutorUnitCombatBonus() { }

	int Segment();
	int operator&( IBinSaver &saver );
};
