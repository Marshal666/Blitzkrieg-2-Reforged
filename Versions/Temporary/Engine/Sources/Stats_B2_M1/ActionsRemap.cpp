#include "StdAfx.h"
#include "..\misc\2darray.h"
#include "..\zlib\zconf.h"
#include "actioncommand.h"
#include "ActionsRemap.h"
#include "..\Misc\HashFuncs.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static const int actionCommandToUserAction[][2] = 
{
	{ ACTION_COMMAND_MOVE_TO						, NDb::USER_ACTION_MOVE },
	{ ACTION_COMMAND_ATTACK_UNIT				, NDb::USER_ACTION_ATTACK },
	{ ACTION_COMMAND_ATTACK_OBJECT			, NDb::USER_ACTION_ATTACK },
	{ ACTION_COMMAND_SWARM_TO						, NDb::USER_ACTION_SWARM },
	{ ACTION_COMMAND_LOAD								, NDb::USER_ACTION_BOARD },
	{ ACTION_COMMAND_UNLOAD							, NDb::USER_ACTION_LEAVE },
	{ ACTION_COMMAND_ENTER							, NDb::USER_ACTION_BOARD },
	{ ACTION_COMMAND_LEAVE							, NDb::USER_ACTION_LEAVE },
	{ ACTION_COMMAND_ROTATE_TO					, NDb::USER_ACTION_ROTATE },
	{ ACTION_COMMAND_STOP								, NDb::USER_ACTION_STOP },
	{ ACTION_COMMAND_PARADE							, NDb::USER_ACTION_FORMATION },
	{ ACTION_COMMAND_STAND_GROUND				, NDb::USER_ACTION_STAND_GROUND },
	{ ACTION_COMMAND_PLACEMINE					, NDb::USER_ACTION_ENGINEER_PLACE_MINES },
	{ ACTION_COMMAND_CLEARMINE					, NDb::USER_ACTION_ENGINEER_CLEAR_MINES },
	{ ACTION_COMMAND_GUARD							, NDb::USER_ACTION_GUARD },
	{ ACTION_COMMAND_AMBUSH							, NDb::USER_ACTION_AMBUSH },
	{ ACTION_COMMAND_PATROL							, NDb::USER_ACTION_PATROL										 },
	{ ACTION_COMMAND_ART_BOMBARDMENT		, NDb::USER_ACTION_SUPPRESS },
	{ ACTION_COMMAND_INSTALL						, NDb::USER_ACTION_INSTALL },
	{ ACTION_COMMAND_UNINSTALL					, NDb::USER_ACTION_UNINSTALL },
	{ ACTION_COMMAND_RESUPPLY						, NDb::USER_ACTION_SUPPORT_RESUPPLY },
	{ ACTION_COMMAND_REPAIR							, NDb::USER_ACTION_ENGINEER_REPAIR },
	{ ACTION_COMMAND_REPEAR_OBJECT			, NDb::USER_ACTION_ENGINEER_REPAIR		},
	{ ACTION_COMMAND_ENTRENCH_BEGIN			, NDb::USER_ACTION_ENGINEER_BUILD_ENTRENCHMENT },
	{ ACTION_COMMAND_PLACE_ANTITANK			, NDb::USER_ACTION_ENGINEER_BUILD_DEFENSE			},
	{ ACTION_COMMAND_BUILD_FENCE_BEGIN	, NDb::USER_ACTION_ENGINEER_BUILD_FENCE				},
	{ ACTION_COMMAND_USE_SPYGLASS				, NDb::USER_ACTION_SPYGLASS										},
	{ ACTION_COMMAND_TAKE_ARTILLERY			, NDb::USER_ACTION_HOOK_ARTILLERY							},
	{ ACTION_COMMAND_DEPLOY_ARTILLERY		, NDb::USER_ACTION_DEPLOY_ARTILLERY						},
	{ ACTION_COMMAND_DISBAND_FORMATION	, NDb::USER_ACTION_DISBAND_SQUAD							},
	{ ACTION_COMMAND_FORM_FORMATION			, NDb::USER_ACTION_FORM_SQUAD									},
	{ ACTION_COMMAND_FOLLOW							, NDb::USER_ACTION_FOLLOW											},
	{ ACTION_COMMAND_ENTRENCH_SELF			, NDb::USER_ACTION_ENTRENCH_SELF							},
	{ ACTION_COMMAND_FILL_RU						, NDb::USER_ACTION_FILL_RU										},
	{ ACTION_COMMAND_MOVE_TO_GRID				, NDb::USER_ACTION_MOVE_TO_GRID								},
	{ ACTION_COMMAND_CATCH_ARTILLERY		, NDb::USER_ACTION_CAPTURE_ARTILLERY					},
	{ ACTION_COMMAND_CAMOFLAGE_MODE			,	NDb::USER_ACTION_CAMOFLAGE									},
	{ ACTION_COMMAND_ADAVNCED_CAMOFLAGE_MODE		,	NDb::USER_ACTION_ADVANCED_CAMOFLAGE										},
	{ ACTION_COMMAND_THROW_GRENADE			, NDb::USER_ACTION_THROW											},
	{ ACTION_COMMAND_MASTER_OF_STREETS	, NDb::USER_ACTION_MASTER_OF_STREETS					},
//	{ ACTION_COMMAND_LAND_MINE				, NDb::USER_ACTION_LAND_MINE										},
	{ ACTION_COMMAND_PLACE_CHARGE				, NDb::USER_ACTION_BLASTING_CHARGE					},
	{ ACTION_COMMAND_PLACE_CONTROLLED_CHARGE	, NDb::USER_ACTION_CONTROLLED_CHARGE	},
	{ ACTION_COMMAND_DETONATE									, NDb::USER_ACTION_DETONATE						},
	{ ACTION_COMMAND_HOLD_SECTOR				, NDb::USER_ACTION_HOLD_SECTOR							},
	{ ACTION_COMMAND_TRACK_TARGETING		, NDb::USER_ACTION_TRACK_TARGETING					},
	{ ACTION_COMMAND_SUPPORT_FIRE				, NDb::USER_ACTION_SUPPORT_FIRE							},
	{ ACTION_COMMAND_MECH_ENTER					, NDb::USER_ACTION_MECH_BOARD								},
	{ ACTION_COMMAND_CRITICAL_TARGETING	,	NDb::USER_ACTION_CRITICAL_TARGETTING			},
	{ ACTION_COMMAND_RAPID_FIRE_MODE		, NDb::USER_ACTION_RAPID_FIRE								},
	{ ACTION_COMMAND_FLAMETHROWER				, NDb::USER_ACTION_FLAMETHROWER							},
	{ ACTION_COMMAND_MOBILE_FORTRESS		, NDb::USER_ACTION_MOBILE_FORTRESS					},
	{ ACTION_COMMAND_CAUTION						, NDb::USER_ACTION_CAUTION									},
	{ ACTION_COMMAND_ADRENALINE_RUSH		, NDb::USER_ACTION_ADRENALINE_RUSH					},
	{ ACTION_COMMAND_COUNTER_FIRE				, NDb::USER_ACTION_COUNTER_FIRE							},
	{ ACTION_COMMAND_MOBILE_SHOOT				, NDb::USER_ACTION_MOVING_SHOOT							},
	{ ACTION_COMMAND_DROP_BOMBS					, NDb::USER_ACTION_DROP_BOMB								},
	{ ACTION_COMMAND_EXACT_BOMBING			, NDb::USER_ACTION_EXACT_BOMBING						},
	{ ACTION_COMMAND_EXACT_SHOT					, NDb::USER_ACTION_EXACT_SHOT								},
	{ ACTION_COMMAND_COVER_FIRE					, NDb::USER_ACTION_COVER_FIRE								},
	{ ACTION_COMMAND_FIRST_AID					, NDb::USER_ACTION_FIRST_AID								},
	{ ACTION_COMMAND_SMOKE_SHOTS				, NDb::USER_ACTION_SMOKE_SHOTS							},
	{ ACTION_COMMAND_RANGE_AREA					, NDb::USER_ACTION_ZEROING_IN								},
	{ ACTION_COMMAND_LINKED_GRENADES		, NDb::USER_ACTION_LINKED_GRENADES					},
	{ ACTION_COMMAND_DROP_PARATROOPERS	, NDb::USER_ACTION_DROP_PARATROOPERS				},
	{ ACTION_COMMAND_SPY_MODE						, NDb::USER_ACTION_SPY_MODE									},
	{ ACTION_COMMAND_TANK_HUNTER				, NDb::USER_ACTION_TANK_HUNTER							},
	{ ACTION_COMMAND_SKY_GUARD					, NDb::USER_ACTION_SKY_GUARD								},
	{ ACTION_COMMAND_OVERLOAD_MODE			, NDb::USER_ACTION_KAMIKAZE									},		//!!! no action OVERLOAD
	{ ACTION_COMMAND_MASTER_PILOT				, NDb::USER_ACTION_MASTER_PILOT							},
	{ ACTION_COMMAND_SURVIVAL						, NDb::USER_ACTION_SURVIVAL									},
	{ ACTION_COMMAND_RADIO_CONTROLLED_MODE	, NDb::USER_ACTION_RADIO_CONTROLLED_MODE	},

	{ -1, -1 }
};

static const int abilityToActionCommand[][2] = 
{
	{ ACTION_COMMAND_PLACE_CHARGE							, NDb::ABILITY_PLACE_CHARGE							},
	{ ACTION_COMMAND_PLACE_CONTROLLED_CHARGE	, NDb::ABILITY_PLACE_CONTROLLED_CHARGE	},
	{ ACTION_COMMAND_DETONATE									, NDb::ABILITY_DETONATE									},
	{ ACTION_COMMAND_EXACT_SHOT								, NDb::ABILITY_EXACT_SHOT								},
	{ ACTION_COMMAND_CRITICAL_TARGETING				, NDb::ABILITY_CRITICAL_TARGETING				},
	{ ACTION_COMMAND_RAPID_SHOT_MODE					, NDb::ABILITY_RAPID_SHOT_MODE					},
	{ ACTION_COMMAND_MASTER_OF_STREETS				, NDb::ABILITY_MASTER_OF_STREETS				},
	{ ACTION_COMMAND_HOLD_SECTOR							, NDb::ABILITY_HOLD_SECTOR							},
	{ ACTION_COMMAND_TRACK_TARGETING					, NDb::ABILITY_TRACK_TARGETING					},
	{ ACTION_COMMAND_TANK_HUNTER							, NDb::ABILITY_TANK_HUNTER							},
	//{ ACTION_COMMAND_MANUVERABLE_FIGHT_MODE		, NDb::ABILITY_MANUVERABLE_FIGHT_MODE		},
	{ ACTION_COMMAND_SKY_GUARD								, NDb::ABILITY_SKY_GUARD								},
	{ ACTION_COMMAND_MASTER_PILOT							, NDb::ABILITY_MASTER_PILOT							},
	{ ACTION_COMMAND_RAPID_FIRE_MODE					, NDb::ABILITY_RAPID_FIRE_MODE					},
	//{ ACTION_COMMAND_ARTILLERY_GUIDE					, NDb::ABILITY_ARTILLERY_GUIDE					},
	//{ ACTION_COMMAND_HERIOC_SUICIDE						, NDb::ABILITY_HERIOC_SUICIDE						},
	{ ACTION_COMMAND_ADRENALINE_RUSH					, NDb::ABILITY_ADRENALINE_RUSH					},
	//{ ACTION_COMMAND_DIE_HARD									, NDb::ABILITY_DIE_HARD									},
	//{ ACTION_COMMAND_MOMENT_OF_TRUTH					, NDb::ABILITY_MOMENT_OF_TRUTH					},
	{ ACTION_COMMAND_CAMOFLAGE_MODE						, NDb::ABILITY_CAMOFLAGE_MODE						},
	{ ACTION_COMMAND_ADAVNCED_CAMOFLAGE_MODE	, NDb::ABILITY_ADAVNCED_CAMOFLAGE_MODE	},
	{ ACTION_COMMAND_THROW_GRENADE        		, NDb::ABILITY_THROW_GRENADE						},
	{ ACTION_COMMAND_THROW_ANTITANK_GRENADE		, NDb::ABILITY_THROW_ANTITANK_GRENADE		},
	{ ACTION_COMMAND_SPY_MODE									, NDb::ABILITY_SPY_MODE									},
	//{ ACTION_COMMAND_LOW_HEIGHT_MODE					, NDb::ABILITY_LOW_HEIGHT_MODE					},
	{ ACTION_COMMAND_OVERLOAD_MODE						, NDb::ABILITY_OVERLOAD_MODE						},
	{ ACTION_COMMAND_DROP_BOMBS								, NDb::ABILITY_DROP_BOMBS								},
	{ ACTION_COMMAND_FIRE_AA_MISSILES					, NDb::ABILITY_FIRE_AA_MISSILES					},
	{ ACTION_COMMAND_FIRE_AA_GUIDED_MISSILES	, NDb::ABILITY_FIRE_AA_GUIDED_MISSILES	},
	{ ACTION_COMMAND_FIRE_AS_MISSILES					, NDb::ABILITY_FIRE_AS_MISSILES					},
	//{ ACTION_COMMAND_REPEAT_LAST_SHOT					, NDb::ABILITY_REPEAT_LAST_SHOT					},
	{ ACTION_COMMAND_PATROL										, NDb::ABILITY_PATROL										},
	{ ACTION_COMMAND_SMOKE_SHOTS							, NDb::ABILITY_SMOKE_SHOTS							},
	{ ACTION_COMMAND_ANTIATRILLERY_FIRE				, NDb::ABILITY_ANTIATRILLERY_FIRE				},
	//{ ACTION_COMMAND_TAKE_HIDED_REINFORCEMENT , NDb::ABILITY_TAKE_HIDED_REINFORCEMENT },
	//{ ACTION_COMMAND_COMMAND_VOICE						, NDb::ABILITY_COMMAND_VOICE						},
	//{ ACTION_COMMAND_AUTHORITY								, NDb::ABILITY_AUTHORITY								},
	//{ ACTION_COMMAND_ARMOR_TUTOR							, NDb::ABILITY_ARMOR_TUTOR							},
	{ ACTION_COMMAND_SUPPORT_FIRE							, NDb::ABILITY_SUPPORT_FIRE							},
	{ ACTION_COMMAND_LAND_MINE								, NDb::ABILITY_LAND_MINE								},
	{ ACTION_COMMAND_ENTRENCH_SELF						, NDb::ABILITY_ENTRENCH_SELF						},
	{ ACTION_COMMAND_AMBUSH										, NDb::ABILITY_AMBUSH										},
	{ ACTION_COMMAND_FLAMETHROWER							, NDb::ABILITY_FLAMETHROWER							},
	{ ACTION_COMMAND_MOBILE_FORTRESS					, NDb::ABILITY_MOBILE_FORTRESS					},
	{ ACTION_COMMAND_CAUTION									, NDb::ABILITY_CAUTION									},
	{ ACTION_COMMAND_ADRENALINE_RUSH					, NDb::ABILITY_ADRENALINE_RUSH					},
	{ ACTION_COMMAND_COUNTER_FIRE							, NDb::ABILITY_ANTIATRILLERY_FIRE				},
	{ ACTION_COMMAND_MOBILE_SHOOT							, NDb::ABILITY_MANUVERABLE_FIGHT_MODE		},
	{ ACTION_COMMAND_COVER_FIRE								, NDb::ABILITY_COVER_FIRE								},
	{ ACTION_COMMAND_FIRST_AID								, NDb::ABILITY_FIRST_AID								},
	{ ACTION_COMMAND_EXACT_BOMBING						, NDb::ABILITY_EXACT_BOMBING						},
	{ ACTION_COMMAND_RANGE_AREA								, NDb::ABILITY_ZEROING_IN								},
	{ ACTION_COMMAND_LINKED_GRENADES					, NDb::ABILITY_LINKED_GRENADES					},
	{ ACTION_COMMAND_ART_BOMBARDMENT					, NDb::ABILITY_SUPRESS									},
	{ ACTION_COMMAND_DROP_PARATROOPERS				, NDb::ABILITY_DROP_PARATROOPERS				},
	{ ACTION_COMMAND_ENTRENCH_BEGIN 					, NDb::ABILITY_DIG_TRENCHES             },
	{ ACTION_COMMAND_CLEARMINE								, NDb::ABILITY_REMOVE_MINE_FIELD				},
	{ ACTION_COMMAND_SURVIVAL									, NDb::ABILITY_SURVIVAL									},
	{ ACTION_COMMAND_RADIO_CONTROLLED_MODE		, NDb::ABILITY_RADIO_CONTROLLED_MODE		},
	{ -1, -1 },
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static hash_map< EActionCommand,					 NDb::EUnitSpecialAbility, SEnumHash > mapCommandToAbility;
static hash_map< NDb::EUnitSpecialAbility, EActionCommand,           SEnumHash > mapAbilityToCommand;
static hash_map< EActionCommand,           NDb::EUserAction,         SEnumHash > mapCommandToAction;
static hash_map< NDb::EUserAction,				 EActionCommand,           SEnumHash > mapActionToCommand;
static vector< NDb::EUserAction > mapAbilityToAction;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EUnitSpecialAbility GetAbilityByCommand( EActionCommand actionCommand )
{
	hash_map< EActionCommand, NDb::EUnitSpecialAbility, SEnumHash >::const_iterator pos = mapCommandToAbility.find( actionCommand );
	return pos != mapCommandToAbility.end() ? pos->second : NDb::ABILITY_NOT_ABILITY;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EActionCommand GetCommandByAbility( NDb::EUnitSpecialAbility specialAbility )
{
	hash_map< NDb::EUnitSpecialAbility, EActionCommand, SEnumHash >::const_iterator pos = mapAbilityToCommand.find( specialAbility );
	return pos != mapAbilityToCommand.end() ? pos->second : (EActionCommand)-1;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EActionCommand GetCommandByAction( NDb::EUserAction action )
{
	hash_map< NDb::EUserAction, EActionCommand, SEnumHash >::const_iterator pos = mapActionToCommand.find( action );
	return pos != mapActionToCommand.end() ? pos->second : (EActionCommand)-1;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EUserAction GetActionByCommand( EActionCommand actionCommand )
{
	hash_map< EActionCommand, NDb::EUserAction, SEnumHash >::const_iterator pos = mapCommandToAction.find( actionCommand );
	return pos != mapCommandToAction.end() ? pos->second : NDb::USER_ACTION_UNKNOWN;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EUserAction GetActionByAbility( NDb::EUnitSpecialAbility specialAbility )
{
	const nIndex = (int)specialAbility;
	NI_ASSERT( (nIndex >= 0 && nIndex < NDb::_ABILITY_COUNT), StrFmt( "Unknown ability index: %d", nIndex ) );
	return ( nIndex >= 0 && nIndex < NDb::_ABILITY_COUNT ) ? mapAbilityToAction[nIndex] : NDb::USER_ACTION_UNKNOWN;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CActionsRemapAutomagic
{
public:
	CActionsRemapAutomagic()
	{
		for ( int i = 0; actionCommandToUserAction[i][0] != -1; ++i )
		{
			mapCommandToAction[ (EActionCommand)actionCommandToUserAction[i][0] ] = (NDb::EUserAction)actionCommandToUserAction[i][1];
			mapActionToCommand[ (NDb::EUserAction)actionCommandToUserAction[i][1] ] = (EActionCommand)actionCommandToUserAction[i][0];
		}
		for ( int i = 0; abilityToActionCommand[i][0] != -1; ++i )
		{
			mapCommandToAbility[ (EActionCommand)abilityToActionCommand[i][0] ] = (NDb::EUnitSpecialAbility)abilityToActionCommand[i][1];
			mapAbilityToCommand[ (NDb::EUnitSpecialAbility)abilityToActionCommand[i][1] ] = (EActionCommand)abilityToActionCommand[i][0];
		}
		mapAbilityToAction.resize( NDb::_ABILITY_COUNT );
		for ( int i = 0; i < NDb::_ABILITY_COUNT; ++i )
			mapAbilityToAction[i] = GetActionByCommand( GetCommandByAbility( (NDb::EUnitSpecialAbility)i ) );
	}
};
static CActionsRemapAutomagic theActionsRemapAutomagic;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
