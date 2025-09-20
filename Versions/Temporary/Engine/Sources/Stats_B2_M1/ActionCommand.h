#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ************************************************************************************************************************ //
// **
// **
// **		command action
// **
// **
// ************************************************************************************************************************ //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ����� �������:
//	�������, ������� ���������� �� ������������, ���������� �� 0 �� 999
//	�������, ������� ���������� ������ AI ���������� �� 1000 �� 32767 � ���������� �� 4 ���� ������ (��� ����, ����� ���� ����� ��������)

// ��� ���������� ����� ���������������� ������� ���������� � pointtogo � GetGoPointByCommand ���
// ���������� ������ �������� ��������� � ������ � �������

// ���� � ������� ��������� ������� ��� 0x8000, �� ��� self-action

// �������� ������ ���� �� ������, ��� 65535!
enum EActionCommand
{
	ACTION_COMMAND_MOVE_TO									= 0,		// move to location
	ACTION_COMMAND_ATTACK_UNIT							= 1,		// attack unit
	ACTION_COMMAND_ATTACK_OBJECT						= 2,		// attack non-unit object
	ACTION_COMMAND_SWARM_TO									= 3,		// swarm to point (x, y)
	ACTION_COMMAND_LOAD											= 4,		// load units / attach for towing
	ACTION_COMMAND_UNLOAD										= 5,		// unload units / detach from towing
	ACTION_COMMAND_ENTER										= 6,		// enter to building/trench
	ACTION_COMMAND_LEAVE										= 7,		// leave building/trench
	ACTION_COMMAND_ROTATE_TO								= 8,		// rotate to point
	ACTION_COMMAND_STOP											= 9,		// stop all actions
	ACTION_COMMAND_PARADE										= 10,		// ����������� � ��������
	//
	ACTION_COMMAND_DIE															= 1000,	// (AI only)
	//
	ACTION_COMMAND_LOAD_NOW													= 1001,	// (AI only)
	ACTION_COMMAND_UNLOAD_NOW												= 1002,	// (AI only)
	ACTION_COMMAND_LEAVE_NOW												= 1003,	// (AI only)
	//
	ACTION_MOVE_BY_DIR															= 1004,	// (AI only)
	ACTION_MOVE_BY_OWN_DIR													= 1005,	// (AI only)
	ACTION_COMMAND_WAIT_FOR_UNITS										= 1006,	// (AI only)
	ACTION_COMMAND_DISAPPEAR												= 1007,	// (AI only)
	ACTION_COMMAND_IDLE_TRENCH											= 1008,	// (AI only)
	ACTION_COMMAND_IDLE_BUILDING										= 1009,	// (AI only)
	ACTION_COMMAND_ENTER_TRANSPORT_NOW							= 1010,// (AI only)
	ACTION_COMMAND_IDLE_TRANSPORT										=	1011,	// (AI only)
	//
	ACTION_COMMAND_PLACEMINE								= 11,
	ACTION_COMMAND_CLEARMINE								= 12,
	ACTION_COMMAND_CLEARMINE_RADIUS									= 1012,	// (AI only)
	ACTION_COMMAND_PLACEMINE_NOW										= 1013,	// (AI only)
	ACTION_COMMAND_GUARD										= 13,
	ACTION_COMMAND_AMBUSH										= 14,

	ACTION_COMMAND_STOP_THIS_ACTION									= 1014,	// (AI only)

	ACTION_COMMAND_RANGE_AREA								= 15,
	ACTION_COMMAND_ART_BOMBARDMENT					= 16,
	ACTION_COMMAND_INSTALL									= 17,
	ACTION_COMMAND_UNINSTALL								= 18,
	//
	ACTION_MOVE_PLANE_LEAVE													= 1017,	// (AI only)
	
	ACTION_MOVE_PARACHUTE														= 1019,	// (AI only)
	//
	ACTION_COMMAND_RESUPPLY									= 23,
	ACTION_MOVE_RESUPPLY_UNIT												= 1020,	// (AI only)

	ACTION_COMMAND_REPAIR										= 24,
	ACTION_MOVE_REPAIR_UNIT													= 1021,	// (AI only)

	ACTION_MOVE_SET_HOME_TRANSPORT									= 1022,	// (AI only)

	ACTION_MOVE_CATCH_TRANSPORT											= 1023,	// (AI only)

	ACTION_COMMAND_BUILD_FENCE_BEGIN				= 26,
	ACTION_COMMAND_BUILD_FENCE_END					= 25,//				= 1024,	// (AI only)

	ACTION_COMMAND_ENTRENCH_BEGIN						=	27,
	ACTION_COMMAND_ENTRENCH_END							= 64, //				=	1025,	// (AI only)

	///ACTION_COMMAND_CATCH_ARTILLERY	=	28,		// assign gunners to artillery
	ACTION_MOVE_GUNSERVE														= 1026,	// (AI only)

	ACTION_COMMAND_USE_SPYGLASS							= 29,		// officer command - use spyglasses


	ACTION_MOVE_ATTACK_FORMATION										= 1027,	// (AI only)

	ACTION_COMMAND_TAKE_ARTILLERY						= 31,
	ACTION_COMMAND_DEPLOY_ARTILLERY					= 32,
	ACTION_MOVE_BEING_TOWED													= 1028,	// (AI only)
	ACTION_MOVE_LOAD_RU															= 1029,	// (AI only)

	ACTION_MOVE_IDLE																= 1032,	// (AI only)
	ACTION_COMMAND_PLACE_ANTITANK						= 33,		// place anti-tank
	ACTION_COMMAND_DISBAND_FORMATION				= 34,		// disband squad
	ACTION_COMMAND_FORM_FORMATION						= 35,		// form squad (after disbanding)

	ACTION_COMMAND_WAIT_TO_FORM											= 1033, // (AI only) - �����, ���� ������ ����� �� ������ � ������ ���������, ����� ������������ ��������

	ACTION_COMMAND_SNEAK_ON													= 1034,
	ACTION_COMMAND_SNEAK_OFF												= 1035,

	ACTION_COMMAND_FOLLOW										= 39,
	ACTION_COMMAND_FOLLOW_NOW												= 1037, // (AI only) ����� �� �������

	ACTION_COMMAND_CATCH_FORMATION									= 1038, // (AI only) �������������� � ��������

	ACTION_COMMAND_RESUPPLY_HR							= 43,

	ACTION_COMMAND_SWARM_ATTACK_UNIT								= 1040, // (AI only) ����� � ��������������� ����������� ���� (��������, ��� swarm)
	ACTION_MOVE_SWARM_ATTACK_FORMATION							= 1041, // (AI only) ����� � ��������������� ����������� ���� (��������, ��� swarm)

	ACTION_COMMAND_ENTRENCH_SELF						= 45,
	ACTION_COMMAND_SWARM_ATTACK_OBJECT							= 1042,
	ACTION_COMMAND_CHANGE_SHELLTYPE					= 46,

	ACTION_MOVE_BUILD_LONGOBJECT										= 1044,
	ACTION_MOVE_FLY_DEAD														= 1045,
	ACTION_COMMAND_REPEAR_OBJECT						= 47,
	ACTION_COMMAND_BUILD_BRIDGE							= 48,

	ACTION_MOVE_REPAIR_BRIDGE												= 1046,	// (AI only) engineers repair bridge
	ACTION_MOVE_CLEARMINE														= 1047,	// (AI only) for engineers
	ACTION_MOVE_PLACEMINE														= 1048,	// (AI only) for engineers
	ACTION_MOVE_PLACE_ANTITANK											= 1049,	// (AI only) for engineers
	ACTION_MOVE_REPAIR_BUILDING											= 1050,	// (AI only) for engineers

	ACTION_COMMAND_RESUPPLY_MORALE					= 49,						// car with this command gives morale support to units
	ACTION_COMMAND_STAND_GROUND							= 50,
	ACTION_MOVE_WAIT_FOR_TRUCKREPAIR								= 1051, // (AI only) for waiting something during swarm

	ACTION_SET_APPEAR_POINT													= 1052, // (AI only) AVIATION REMEMBER CURRENT APPEAR POINT
	ACTION_COMMAND_HEAL_INFANTRY						= 51,					

	ACTION_MOVE_TO_NOT_PRESIZE  										= 1053, // (AI general only)
	ACTION_COMMAND_PLACE_MARKER											= 1054, // (AI only) service command, client only

	ACTION_COMMAND_CHANGE_MOVEMENT					= 53,					// change movement order - move to point or mode parallel

	ACTION_COMMAND_ROTATE_TO_DIR										= 1055,	// ����������� � �����������, vPos ����� ������ �����������
	ACTION_COMMAND_USE															= 1056,
	ACTION_MOVE_ENTER_TRANSPORT_CHEAT_PATH					= 1057, // enter transport ignore locked tiles

	ACTION_COMMAND_ENTER_BUILDING_NOW								= 1058,
	ACTION_COMMAND_ENTER_ENTREHCMNENT_NOW						= 1059,

	ACTION_COMMAND_FILL_RU									= 54,
	ACTION_COMMAND_MOVE_TO_GRID							= 55,
	ACTION_COMMAND_CATCH_ARTILLERY					= 56,

	// abilities
	ACTION_COMMAND_PLACE_CHARGE							= 57,
	ACTION_COMMAND_PLACE_CONTROLLED_CHARGE	= 58,

	ACTION_COMMAND_DETONATE									= 59,	// become avalable only when charge is placed
	ACTION_COMMAND_EXACT_SHOT								= 61,
	ACTION_COMMAND_CRITICAL_TARGETING				= 62,
	ACTION_COMMAND_RAPID_SHOT_MODE					= 63,
	ACTION_COMMAND_HOLD_SECTOR							= 65,
	ACTION_COMMAND_TRACK_TARGETING					= 66,
	ACTION_COMMAND_LINKED_GRENADES					= 67,
	ACTION_COMMAND_MANUVERABLE_FIGHT_MODE		= 68,
	ACTION_COMMAND_USE_BINOCULAR						= 69,
	ACTION_COMMAND_REMOVE_MINE_FEILD				= 70,
	ACTION_COMMAND_RAPID_FIRE_MODE					= 71,
	ACTION_COMMAND_SUPPORT_FIRE							= 72,
	ACTION_COMMAND_HERIOC_SUICIDE						= 73,
	ACTION_COMMAND_ADRENALINE_RUSH					= 74,
	ACTION_COMMAND_PATROL										= 75,
	ACTION_COMMAND_DROP_PARATROOPERS				= 76,
	ACTION_COMMAND_CAMOFLAGE_MODE						= 77,
	ACTION_COMMAND_ADAVNCED_CAMOFLAGE_MODE	= 78,
	ACTION_COMMAND_THROW_GRENADE						= 79,
	ACTION_COMMAND_THROW_ANTITANK_GRENADE		= 80,
	ACTION_COMMAND_SPY_MODE									= 81,
	ACTION_COMMAND_SKY_GUARD								= 82,
	ACTION_COMMAND_OVERLOAD_MODE						= 83,
	ACTION_COMMAND_DROP_BOMBS_TO_TARGET			= 84,
	ACTION_COMMAND_FIRE_AA_MISSILES					= 85,
	ACTION_COMMAND_FIRE_AA_GUIDED_MISSILES	= 86,
	ACTION_COMMAND_FIRE_AS_MISSILES					= 87,
	ACTION_COMMAND_SURVIVAL									= 88,
	ACTION_COMMAND_MASTER_PILOT							= 89,
	ACTION_COMMAND_SMOKE_SHOTS							= 90,
	ACTION_COMMAND_ANTIATRILLERY_FIRE				= 91,
	ACTION_COMMAND_TANK_HUNTER							= 92,
	ACTION_COMMAND_MASTER_OF_STREETS				= 93,
	//ACTION_COMMAND_AUTHORITY								= 94,
	//ACTION_COMMAND_ARMOR_TUTOR							= 95,
	//ACTION_COMMAND_TAKE_PLACE								= 96,
	ACTION_COMMAND_TORPEDO_ATTACK						= 97,

	ACTION_MOVE_ATTACKPLANE_SETPOINT								= 1060,
	ACTION_MOVE_FIGHTER_SETPOINT										= 1061,

	ACTION_COMMAND_ORDER                    = 102,
	ACTION_COMMAND_LAND_MINE                = 103,
	ACTION_COMMAND_DROP_BOMBS								= 104,

	ACTION_MOVE_SELF_ENTRENCH												= 1062,
	ACTION_MOVE_LEAVE_SELF_ENTRENCH									= 1063,
	ACTION_COMMAND_WAIT											= 105,
	ACTION_MOVE_MECH_ON_BOARD												= 1064,
	ACTION_MOVE_ONBOARD_ATTACK_UNIT									= 1065,
	ACTION_COMMAND_MECH_ENTER								= 106,
	ACTION_COMMAND_FLAMETHROWER							= 107,
	ACTION_COMMAND_MOBILE_FORTRESS					= 108,
	ACTION_COMMAND_CAUTION									= 109,
	ACTION_MOVE_MECH_ENTER_NOW											= 1066,
	ACTION_COMMAND_MOBILE_SHOOT							= 110,
	ACTION_COMMAND_COUNTER_FIRE							= 111,
	ACTION_COMMAND_COVER_FIRE								= 112,
	ACTION_COMMAND_FIRST_AID								= 113,
	ACTION_COMMAND_EXACT_BOMBING						= 114,
	ACTION_MOVE_FIRST_AID														= 1067,

	ACTION_MOVE_BY_FORMATION												= 1071,		//! �������� ������ �������������� ������ (���������)};
	ACTION_MOVE_DROP_BOMBS_TO_POINT									= 1072,
	ACTION_MOVE_DROP_BOMBS_TO_TARGET								= 1073,

	// Train commands - given to the cars
	ACTION_COMMAND_TRAIN_MOVE												= 1074,		
	ACTION_COMMAND_TRAIN_ATTACK_OBJECT							= 1075,
	ACTION_COMMAND_TRAIN_ATTACK_UNIT								= 1076,
	ACTION_COMMAND_TRAIN_STOP												= 1077,
	ACTION_COMMAND_TRAIN_UNLOAD_NOW									= 1078,

	ACTION_COMMAND_USE_SUPER_WEAPON					= 115,
	ACTION_COMMAND_RADIO_CONTROLLED_MODE		= 116,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EActionLeaveParam 
{
	ALP_POSITION_VALID = 0,
	ALP_POSITION_INVALID = 1,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EActionThrowGrenadeParam 
{
	ATGP_ATACK_UNIT = 0,
	ATGP_ATACK_OBJECT = 1,
	ATGP_ATACK_POINT = 2,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
