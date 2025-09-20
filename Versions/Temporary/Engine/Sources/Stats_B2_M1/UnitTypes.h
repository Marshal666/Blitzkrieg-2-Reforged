#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
enum EUnitRPGClass
{
	RPG_CLASS_UNKNOWN					= 0,
	RPG_CLASS_ARTILLERY				= 1,
	RPG_CLASS_TANK						= 2,
	RPG_CLASS_SNIPER					= 3,
	RPG_CLASS_FORCE_DWORD	= 0x7fffffff
};
enum EUnitRPGType
{
	// main types
	RPG_TYPE_INFANTRY						= 0x00010000,
	RPG_TYPE_TRANSPORT					= 0x00020000,
	RPG_TYPE_ARTILLERY					= 0x00040000,
	RPG_TYPE_SPG								= 0x00080000,
	RPG_TYPE_ARMOR							= 0x00100000,
	RPG_TYPE_AVIATION						= 0x00200000,
	RPG_TYPE_TRAIN							= 0x00400000,
	// infantry
	RPG_TYPE_SOLDIER						= 0x00010001,
	RPG_TYPE_ENGINEER						= 0x00010002,
	RPG_TYPE_SNIPER							= 0x00010003,
	RPG_TYPE_OFFICER						= 0x00010004,
	// transport
	RPG_TYPE_TRN_CARRIER				= 0x00020001,
	RPG_TYPE_TRN_SUPPORT				= 0x00020002,
	RPG_TYPE_TRN_MEDICINE				= 0x00020003,
	RPG_TYPE_TRN_TRACTOR				= 0x00020004,
	RPG_TYPE_TRN_MILITARY_AUTO	= 0x00020005,
	RPG_TYPE_TRN_CIVILIAN_AUTO	= 0x00020006,
	// artillery
	RPG_TYPE_ART_GUN						= 0x00040001,
	RPG_TYPE_ART_HOWITZER				= 0x00040002,
	RPG_TYPE_ART_HEAVY_GUN			= 0x00040003,
	RPG_TYPE_ART_AAGUN					= 0x00040004,
	RPG_TYPE_ART_ROCKET					= 0x00040005,
	RPG_TYPE_ART_SUPER					= 0x00040006,
	RPG_TYPE_ART_MORTAR					= 0x00040007,
	RPG_TYPE_ART_HEAVY_MG				= 0x00040008,
	// SPG
	RPG_TYPE_SPG_ASSAULT				= 0x00080001,
	RPG_TYPE_SPG_ANTITANK				= 0x00080002,
	RPG_TYPE_SPG_SUPER					= 0x00080003,
	RPG_TYPE_SPG_AAGUN					= 0x00080004,
	// armor
	RPG_TYPE_ARM_LIGHT					= 0x00100001,
	RPG_TYPE_ARM_MEDIUM					= 0x00100002,
	RPG_TYPE_ARM_HEAVY					= 0x00100003,
	RPG_TYPE_ARM_SUPER					= 0x00100004,
	// aviation
	RPG_TYPE_AVIA_SCOUT					= 0x00200001,
	RPG_TYPE_AVIA_BOMBER				= 0x00200002,
	RPG_TYPE_AVIA_ATTACK				= 0x00200003,
	RPG_TYPE_AVIA_FIGHTER				= 0x00200004,
	RPG_TYPE_AVIA_SUPER					= 0x00200005,
	RPG_TYPE_AVIA_LANDER				= 0x00200006,
	// train
	RPG_TYPE_TRAIN_LOCOMOTIVE		= 0x00400001,
	RPG_TYPE_TRAIN_CARGO				= 0x00400002,
	RPG_TYPE_TRAIN_CARRIER			= 0x00400003,
	RPG_TYPE_TRAIN_SUPER				= 0x00400004,
	RPG_TYPE_TRAIN_ARMOR				= 0x00400005
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EUnitRPGType ReMapRPGType( enum EDBUnitRPGType eType );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EUnitRPGType GetMainType( EUnitRPGType type );
bool IsInfantry( EUnitRPGType type );
bool IsTransport( EUnitRPGType type );
bool IsArtillery( EUnitRPGType type );
bool IsSPG( EUnitRPGType type );
bool IsArmor( EUnitRPGType type );
bool IsAviation( EUnitRPGType type );
bool IsTrain( EUnitRPGType type );
const EUnitRPGClass GetRPGClass( const EUnitRPGType eType );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
