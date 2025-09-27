#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EScenarioTrackerMissionTypes
{

	STMT_NUM_ELEMENTS_TO_SHOW_AFTERMISSION = 0,

	_STMT_BEGIN_STATS = 1,
	STMT_PLAYER_EXPERIENCE = _STMT_BEGIN_STATS,
	STMT_ENEMY_KILLED		= 2,
	STMT_FRIENDLY_KILLED  = 3,
	STMT_FLAGS_CAPTURED  = 4,
	STMT_HOUSES_DESTROYED = 5,
	STMT_FLAGPOINTS  = 6,
	STMT_OBJECTIVES_RECIEVED = 7,
	STMT_TIME_ELAPSED = 8,

	STMT_NUM_ELEMENTS												= 9
	/*

	STMT_ENEMY_KILLED = _STMT_BEGIN_STATS,		  // KILLED ENEMYS NUMBER 
	STMT_ENEMY_KILLED_AI_PRICE							= 2,// AI PRICE OF KILLED ENEMYS

	STMT_FRIENDLY_KILLED										= 3,// PLAYER'S UNITS KILLED NUMBER
	STMT_FRIENDLY_KILLED_AI_PRICE						= 4,// PLAYER'S UNITS KILLED AI PRICE

	STMT_ENEMY_MACHINERY_CAPTURED						= 5,// CAPTURED ARTILLERY

	STMT_AVIATION_CALLED										= 6,// NUMBER OF AVIATION CALL

	STMT_RESOURCES_USED											= 7,// QUIANTITY OF RESOURCES USED

	STMT_HOUSES_DESTROYED										= 8,// BUILDINGS DESTROYED

	STMT_UNITS_LEVELED_UP										= 9,// NUMBER OF UNITS, THAT GAIN LEVEL DURING MISSION

	STMT_FLAGS_CAPTURED											= 10,// NUMBER OF CAPTURED FLAGS(PER TEAM)

	STMT_FLAGPOINTS													= 11,// NUMBER OF FLAGPOINTS (PER TEAM)

	_STMT_END_STATS													= 12,

	// OLD STATISTICS
	STMT_UNITS_LOST_UNRECOVERABLY							= _STMT_END_STATS,
	STMT_UNITS_RETURN_AFTER_DAMAGE					= 13	,
	STMT_REINFORCEMENT_USED									= 14,
	STMT_UNITS_GAIN_STARS										= 15,
	STMT_NEW_UNITS													= 16,
	//END OLD STATISTICS

	//common statistics
	STMT_TIME_ELAPSED												= 17,
	STMT_OBJECTIVES_COMPLETED								= 18,
	STMT_OBJECTIVES_FAILED									= 19,
	STMT_UNITS_UPGRADED											= 20,
	STMT_GAME_LOADED												= 21,
	STMT_OBJECTIVES_RECIEVED								= 22,


	// player's experience
	STMT_PLAYER_EXPERIENCE									= 23,									



	//
	//
	STMT_NUM_ELEMENTS												= 24*/
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EScenarioTrackerUnitTypes
{
	STUT_EXP = 0,
	STUT_LEVEL,
	STUT_KILLS,
	STUT_STARS,
	STUT_EXP_NEXT_LEVEL,
	STUT_EXP_CURR_LEVEL,
	//
	//
	STUT_NUM_ELEMENTS
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
