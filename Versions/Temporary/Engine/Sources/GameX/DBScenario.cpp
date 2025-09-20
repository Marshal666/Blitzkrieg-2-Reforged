// automatically generated file, don't change manually!

#include "stdafx.h"
#include "../libdb/ReportMetaInfo.h"
#include "../libdb/Checksum.h"
#include "../System/XmlSaver.h"
#include "dbscenario.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SRankExperience::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "Experience", (BYTE*)&fExperience - pThis, sizeof(fExperience), NTypeDef::TYPE_TYPE_FLOAT );
	NMetaInfo::ReportMetaInfo( szAddName + "Rank", (BYTE*)&pRank - pThis, sizeof(pRank), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( szAddName + "AddPromotion", (BYTE*)&nAddPromotion - pThis, sizeof(nAddPromotion), NTypeDef::TYPE_TYPE_INT );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SRankExperience::operator&( IXmlSaver &saver )
{
	saver.Add( "Experience", &fExperience );
	saver.Add( "Rank", &pRank );
	saver.Add( "AddPromotion", &nAddPromotion );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SRankExperience::operator&( IBinSaver &saver )
{
	saver.Add( 2, &fExperience );
	saver.Add( 3, &pRank );
	saver.Add( 4, &nAddPromotion );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SRankExperience::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << fExperience << pRank << nAddPromotion;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SLeaderExpLevel::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "RankNameFileRef", (BYTE*)&szRankNameFileRef - pThis, sizeof(szRankNameFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( szAddName + "ExpNeeded", (BYTE*)&nExpNeeded - pThis, sizeof(nExpNeeded), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "StatsBonus", (BYTE*)&pStatsBonus - pThis, sizeof(pStatsBonus), NTypeDef::TYPE_TYPE_REF );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SLeaderExpLevel::operator&( IXmlSaver &saver )
{
	saver.Add( "RankNameFileRef", &szRankNameFileRef );
	saver.Add( "ExpNeeded", &nExpNeeded );
	saver.Add( "StatsBonus", &pStatsBonus );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SLeaderExpLevel::operator&( IBinSaver &saver )
{
	saver.Add( 2, &szRankNameFileRef );
	saver.Add( 3, &nExpNeeded );
	saver.Add( 4, &pStatsBonus );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SLeaderExpLevel::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << nExpNeeded << pStatsBonus;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SMedalConditions::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "Medal", (BYTE*)&pMedal - pThis, sizeof(pMedal), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( szAddName + "Parameter", (BYTE*)&fParameter - pThis, sizeof(fParameter), NTypeDef::TYPE_TYPE_FLOAT );
	NMetaInfo::ReportMetaInfo( szAddName + "StartingChapter", (BYTE*)&nStartingChapter - pThis, sizeof(nStartingChapter), NTypeDef::TYPE_TYPE_INT );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMedalConditions::operator&( IXmlSaver &saver )
{
	saver.Add( "Medal", &pMedal );
	saver.Add( "Parameter", &fParameter );
	saver.Add( "StartingChapter", &nStartingChapter );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMedalConditions::operator&( IBinSaver &saver )
{
	saver.Add( 2, &pMedal );
	saver.Add( 3, &fParameter );
	saver.Add( 4, &nStartingChapter );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SMedalConditions::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << pMedal << fParameter << nStartingChapter;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SCampaign::SLeader::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "NameFileRef", (BYTE*)&szNameFileRef - pThis, sizeof(szNameFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( szAddName + "Picture", (BYTE*)&pPicture - pThis, sizeof(pPicture), NTypeDef::TYPE_TYPE_REF );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SCampaign::SLeader::operator&( IXmlSaver &saver )
{
	saver.Add( "NameFileRef", &szNameFileRef );
	saver.Add( "Picture", &pPicture );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SCampaign::SLeader::operator&( IBinSaver &saver )
{
	saver.Add( 2, &szNameFileRef );
	saver.Add( 3, &pPicture );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SCampaign::SLeader::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SCampaign::ReportMetaInfo() const
{
	NMetaInfo::StartMetaInfoReport( "Campaign", typeID, sizeof(*this) );

	BYTE *pThis = (BYTE*)this;
	NMetaInfo::ReportSimpleArrayMetaInfo( "Chapters", &chapters, pThis );
	NMetaInfo::ReportMetaInfo( "LocalizedNameFileRef", (BYTE*)&szLocalizedNameFileRef - pThis, sizeof(szLocalizedNameFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "LocalizedDescFileRef", (BYTE*)&szLocalizedDescFileRef - pThis, sizeof(szLocalizedDescFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "ScriptFileRef", (BYTE*)&szScriptFileRef - pThis, sizeof(szScriptFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportStructArrayMetaInfo( "Screens", &screens, pThis );
	NMetaInfo::ReportMetaInfo( "TextureNotStarted", (BYTE*)&pTextureNotStarted - pThis, sizeof(pTextureNotStarted), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "TextureCompleted", (BYTE*)&pTextureCompleted - pThis, sizeof(pTextureCompleted), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "TextureNotStartedSelected", (BYTE*)&pTextureNotStartedSelected - pThis, sizeof(pTextureNotStartedSelected), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "TextureCompletedSelected", (BYTE*)&pTextureCompletedSelected - pThis, sizeof(pTextureCompletedSelected), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "TextureMissionCompleted", (BYTE*)&pTextureMissionCompleted - pThis, sizeof(pTextureMissionCompleted), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "TextureMenuBackground", (BYTE*)&pTextureMenuBackground - pThis, sizeof(pTextureMenuBackground), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "TextureMenuIcon", (BYTE*)&pTextureMenuIcon - pThis, sizeof(pTextureMenuIcon), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "TextureChapterFinishBonus", (BYTE*)&pTextureChapterFinishBonus - pThis, sizeof(pTextureChapterFinishBonus), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportStructArrayMetaInfo( "RankExperiences", &rankExperiences, pThis );
	NMetaInfo::ReportStructArrayMetaInfo( "LeaderRanks", &leaderRanks, pThis );
	NMetaInfo::ReportStructArrayMetaInfo( "Leaders", &leaders, pThis );
	NMetaInfo::ReportSimpleArrayMetaInfo( "DifficultyLevels", &difficultyLevels, pThis );
	NMetaInfo::ReportMetaInfo( "IntroMovie", (BYTE*)&szIntroMovie - pThis, sizeof(szIntroMovie), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "OutroMovie", (BYTE*)&szOutroMovie - pThis, sizeof(szOutroMovie), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "ReinforcementTypes", (BYTE*)&pReinforcementTypes - pThis, sizeof(pReinforcementTypes), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "IntermissionMusic", (BYTE*)&pIntermissionMusic - pThis, sizeof(pIntermissionMusic), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "SaveLoadFlag", (BYTE*)&pSaveLoadFlag - pThis, sizeof(pSaveLoadFlag), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportStructArrayMetaInfo( "MedalsForChapter", &medalsForChapter, pThis );
	NMetaInfo::ReportStructArrayMetaInfo( "MedalsForKills", &medalsForKills, pThis );
	NMetaInfo::ReportStructArrayMetaInfo( "MedalsForTactics", &medalsForTactics, pThis );
	NMetaInfo::ReportStructArrayMetaInfo( "MedalsForEconomy", &medalsForEconomy, pThis );
	NMetaInfo::ReportMetaInfo( "MedalForMunchkinism", (BYTE*)&pMedalForMunchkinism - pThis, sizeof(pMedalForMunchkinism), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::FinishMetaInfoReport();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SCampaign::operator&( IXmlSaver &saver )
{
	NMetaInfo::STerminalClassReporter reporter( this, saver );
	saver.Add( "Chapters", &chapters );
	saver.Add( "LocalizedNameFileRef", &szLocalizedNameFileRef );
	saver.Add( "LocalizedDescFileRef", &szLocalizedDescFileRef );
	saver.Add( "ScriptFileRef", &szScriptFileRef );
	saver.Add( "Screens", &screens );
	saver.Add( "TextureNotStarted", &pTextureNotStarted );
	saver.Add( "TextureCompleted", &pTextureCompleted );
	saver.Add( "TextureNotStartedSelected", &pTextureNotStartedSelected );
	saver.Add( "TextureCompletedSelected", &pTextureCompletedSelected );
	saver.Add( "TextureMissionCompleted", &pTextureMissionCompleted );
	saver.Add( "TextureMenuBackground", &pTextureMenuBackground );
	saver.Add( "TextureMenuIcon", &pTextureMenuIcon );
	saver.Add( "TextureChapterFinishBonus", &pTextureChapterFinishBonus );
	saver.Add( "RankExperiences", &rankExperiences );
	saver.Add( "LeaderRanks", &leaderRanks );
	saver.Add( "Leaders", &leaders );
	saver.Add( "DifficultyLevels", &difficultyLevels );
	saver.Add( "IntroMovie", &szIntroMovie );
	saver.Add( "OutroMovie", &szOutroMovie );
	saver.Add( "ReinforcementTypes", &pReinforcementTypes );
	saver.Add( "IntermissionMusic", &pIntermissionMusic );
	saver.Add( "SaveLoadFlag", &pSaveLoadFlag );
	saver.Add( "MedalsForChapter", &medalsForChapter );
	saver.Add( "MedalsForKills", &medalsForKills );
	saver.Add( "MedalsForTactics", &medalsForTactics );
	saver.Add( "MedalsForEconomy", &medalsForEconomy );
	saver.Add( "MedalForMunchkinism", &pMedalForMunchkinism );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SCampaign::operator&( IBinSaver &saver )
{
	saver.Add( 2, &chapters );
	saver.Add( 3, &szLocalizedNameFileRef );
	saver.Add( 4, &szLocalizedDescFileRef );
	saver.Add( 5, &szScriptFileRef );
	saver.Add( 6, &screens );
	saver.Add( 7, &pTextureNotStarted );
	saver.Add( 8, &pTextureCompleted );
	saver.Add( 9, &pTextureNotStartedSelected );
	saver.Add( 10, &pTextureCompletedSelected );
	saver.Add( 11, &pTextureMissionCompleted );
	saver.Add( 12, &pTextureMenuBackground );
	saver.Add( 13, &pTextureMenuIcon );
	saver.Add( 14, &pTextureChapterFinishBonus );
	saver.Add( 15, &rankExperiences );
	saver.Add( 16, &leaderRanks );
	saver.Add( 17, &leaders );
	saver.Add( 18, &difficultyLevels );
	saver.Add( 19, &szIntroMovie );
	saver.Add( 20, &szOutroMovie );
	saver.Add( 21, &pReinforcementTypes );
	saver.Add( 22, &pIntermissionMusic );
	saver.Add( 23, &pSaveLoadFlag );
	saver.Add( 24, &medalsForChapter );
	saver.Add( 25, &medalsForKills );
	saver.Add( 26, &medalsForTactics );
	saver.Add( 27, &medalsForEconomy );
	saver.Add( 28, &pMedalForMunchkinism );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SCampaign::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << chapters << screens << rankExperiences << leaderRanks << leaders << difficultyLevels << pReinforcementTypes << medalsForChapter << medalsForKills << medalsForTactics << medalsForEconomy << pMedalForMunchkinism;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SUnitClassEntry::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "Reinforcement", (BYTE*)&pReinforcement - pThis, sizeof(pReinforcement), NTypeDef::TYPE_TYPE_REF );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SUnitClassEntry::operator&( IXmlSaver &saver )
{
	saver.Add( "Reinforcement", &pReinforcement );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SUnitClassEntry::operator&( IBinSaver &saver )
{
	saver.Add( 3, &pReinforcement );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SUnitClassEntry::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << pReinforcement;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SEnemyEntry::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "MechUnit", (BYTE*)&pMechUnit - pThis, sizeof(pMechUnit), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( szAddName + "Squad", (BYTE*)&pSquad - pThis, sizeof(pSquad), NTypeDef::TYPE_TYPE_REF );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SEnemyEntry::operator&( IXmlSaver &saver )
{
	saver.Add( "MechUnit", &pMechUnit );
	saver.Add( "Squad", &pSquad );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SEnemyEntry::operator&( IBinSaver &saver )
{
	saver.Add( 2, &pMechUnit );
	saver.Add( 3, &pSquad );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SEnemyEntry::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << pMechUnit << pSquad;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EMissionEnableType eValue )
{
	switch ( eValue )
	{
	case NDb::MET_REGULAR:
		return "MET_REGULAR";
	case NDb::MET_CHAPTER_START:
		return "MET_CHAPTER_START";
	case NDb::MET_CHAPTER_END:
		return "MET_CHAPTER_END";
	case NDb::MET_CHAPTER_START_END:
		return "MET_CHAPTER_START_END";
	default:
		return "MET_REGULAR";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EMissionEnableType NDb::StringToEnum_NDb_EMissionEnableType( const string &szValue )
{
	if ( szValue == "MET_REGULAR" )
		return NDb::MET_REGULAR;
	if ( szValue == "MET_CHAPTER_START" )
		return NDb::MET_CHAPTER_START;
	if ( szValue == "MET_CHAPTER_END" )
		return NDb::MET_CHAPTER_END;
	if ( szValue == "MET_CHAPTER_START_END" )
		return NDb::MET_CHAPTER_START_END;
	return NDb::MET_REGULAR;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EMissionType eValue )
{
	switch ( eValue )
	{
	case NDb::EMT_FINAL:
		return "EMT_FINAL";
	case NDb::EMT_AIR_COVER:
		return "EMT_AIR_COVER";
	case NDb::EMT_ART_COVER:
		return "EMT_ART_COVER";
	case NDb::EMT_ATTACK:
		return "EMT_ATTACK";
	case NDb::EMT_DEFENCE:
		return "EMT_DEFENCE";
	case NDb::EMT_CONVOY_PROTECT:
		return "EMT_CONVOY_PROTECT";
	case NDb::EMT_CONVOY_DESTROY:
		return "EMT_CONVOY_DESTROY";
	default:
		return "EMT_FINAL";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EMissionType NDb::StringToEnum_NDb_EMissionType( const string &szValue )
{
	if ( szValue == "EMT_FINAL" )
		return NDb::EMT_FINAL;
	if ( szValue == "EMT_AIR_COVER" )
		return NDb::EMT_AIR_COVER;
	if ( szValue == "EMT_ART_COVER" )
		return NDb::EMT_ART_COVER;
	if ( szValue == "EMT_ATTACK" )
		return NDb::EMT_ATTACK;
	if ( szValue == "EMT_DEFENCE" )
		return NDb::EMT_DEFENCE;
	if ( szValue == "EMT_CONVOY_PROTECT" )
		return NDb::EMT_CONVOY_PROTECT;
	if ( szValue == "EMT_CONVOY_DESTROY" )
		return NDb::EMT_CONVOY_DESTROY;
	return NDb::EMT_FINAL;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EMissionWeather eValue )
{
	switch ( eValue )
	{
	case NDb::EMW_SUN:
		return "EMW_SUN";
	case NDb::EMW_RAIN:
		return "EMW_RAIN";
	case NDb::EMW_SNOW:
		return "EMW_SNOW";
	case NDb::EMW_SANDSTORM:
		return "EMW_SANDSTORM";
	default:
		return "EMW_SUN";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EMissionWeather NDb::StringToEnum_NDb_EMissionWeather( const string &szValue )
{
	if ( szValue == "EMW_SUN" )
		return NDb::EMW_SUN;
	if ( szValue == "EMW_RAIN" )
		return NDb::EMW_RAIN;
	if ( szValue == "EMW_SNOW" )
		return NDb::EMW_SNOW;
	if ( szValue == "EMW_SANDSTORM" )
		return NDb::EMW_SANDSTORM;
	return NDb::EMW_SUN;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EMissionDayTime eValue )
{
	switch ( eValue )
	{
	case NDb::EMDT_DAY:
		return "EMDT_DAY";
	case NDb::EMDT_DUSK:
		return "EMDT_DUSK";
	case NDb::EMDT_NIGHT:
		return "EMDT_NIGHT";
	case NDb::EMDT_DAWN:
		return "EMDT_DAWN";
	default:
		return "EMDT_DAY";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EMissionDayTime NDb::StringToEnum_NDb_EMissionDayTime( const string &szValue )
{
	if ( szValue == "EMDT_DAY" )
		return NDb::EMDT_DAY;
	if ( szValue == "EMDT_DUSK" )
		return NDb::EMDT_DUSK;
	if ( szValue == "EMDT_NIGHT" )
		return NDb::EMDT_NIGHT;
	if ( szValue == "EMDT_DAWN" )
		return NDb::EMDT_DAWN;
	return NDb::EMDT_DAY;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EMissionDifficulty eValue )
{
	switch ( eValue )
	{
	case NDb::EMD_EASY:
		return "EMD_EASY";
	case NDb::EMD_MEDIUM:
		return "EMD_MEDIUM";
	case NDb::EMD_HARD:
		return "EMD_HARD";
	case NDb::EMD_VERY_HARD:
		return "EMD_VERY_HARD";
	default:
		return "EMD_EASY";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EMissionDifficulty NDb::StringToEnum_NDb_EMissionDifficulty( const string &szValue )
{
	if ( szValue == "EMD_EASY" )
		return NDb::EMD_EASY;
	if ( szValue == "EMD_MEDIUM" )
		return NDb::EMD_MEDIUM;
	if ( szValue == "EMD_HARD" )
		return NDb::EMD_HARD;
	if ( szValue == "EMD_VERY_HARD" )
		return NDb::EMD_VERY_HARD;
	return NDb::EMD_EASY;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SMissionEnableInfo::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "Map", (BYTE*)&pMap - pThis, sizeof(pMap), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportStructMetaInfo( szAddName + "PlaceOnChapterMap", &vPlaceOnChapterMap, pThis ); 
	NMetaInfo::ReportMetaInfo( szAddName + "MissionsToEnable", (BYTE*)&nMissionsToEnable - pThis, sizeof(nMissionsToEnable), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "MissionEnableType", (BYTE*)&eMissionEnableType - pThis, sizeof(eMissionEnableType), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportSimpleArrayMetaInfo( szAddName + "Reward", &reward, pThis );
	NMetaInfo::ReportStructArrayMetaInfo( szAddName + "ExpectedEnemy", &expectedEnemy, pThis );
	NMetaInfo::ReportMetaInfo( szAddName + "RecommendedCalls", (BYTE*)&nRecommendedCalls - pThis, sizeof(nRecommendedCalls), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "PotentialIncomplete", (BYTE*)&fPotentialIncomplete - pThis, sizeof(fPotentialIncomplete), NTypeDef::TYPE_TYPE_FLOAT );
	NMetaInfo::ReportMetaInfo( szAddName + "PotentialComplete", (BYTE*)&fPotentialComplete - pThis, sizeof(fPotentialComplete), NTypeDef::TYPE_TYPE_FLOAT );
	NMetaInfo::ReportMetaInfo( szAddName + "Type", (BYTE*)&eType - pThis, sizeof(eType), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( szAddName + "Difficulty", (BYTE*)&eDifficulty - pThis, sizeof(eDifficulty), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( szAddName + "Time", (BYTE*)&eTime - pThis, sizeof(eTime), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( szAddName + "Weather", (BYTE*)&eWeather - pThis, sizeof(eWeather), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( szAddName + "ShowPotentialComplete", (BYTE*)&bShowPotentialComplete - pThis, sizeof(bShowPotentialComplete), NTypeDef::TYPE_TYPE_BOOL );
	NMetaInfo::ReportMetaInfo( szAddName + "RecommendedOrder", (BYTE*)&nRecommendedOrder - pThis, sizeof(nRecommendedOrder), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportStructMetaInfo( szAddName + "EndOffset", &vEndOffset, pThis ); 
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMissionEnableInfo::operator&( IXmlSaver &saver )
{
	saver.Add( "Map", &pMap );
	saver.Add( "PlaceOnChapterMap", &vPlaceOnChapterMap );
	saver.Add( "MissionsToEnable", &nMissionsToEnable );
	saver.Add( "MissionEnableType", &eMissionEnableType );
	saver.Add( "Reward", &reward );
	saver.Add( "ExpectedEnemy", &expectedEnemy );
	saver.Add( "RecommendedCalls", &nRecommendedCalls );
	saver.Add( "PotentialIncomplete", &fPotentialIncomplete );
	saver.Add( "PotentialComplete", &fPotentialComplete );
	saver.Add( "Type", &eType );
	saver.Add( "Difficulty", &eDifficulty );
	saver.Add( "Time", &eTime );
	saver.Add( "Weather", &eWeather );
	saver.Add( "ShowPotentialComplete", &bShowPotentialComplete );
	saver.Add( "RecommendedOrder", &nRecommendedOrder );
	saver.Add( "EndOffset", &vEndOffset );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMissionEnableInfo::operator&( IBinSaver &saver )
{
	saver.Add( 2, &pMap );
	saver.Add( 3, &vPlaceOnChapterMap );
	saver.Add( 4, &nMissionsToEnable );
	saver.Add( 5, &eMissionEnableType );
	saver.Add( 6, &reward );
	saver.Add( 7, &expectedEnemy );
	saver.Add( 8, &nRecommendedCalls );
	saver.Add( 9, &fPotentialIncomplete );
	saver.Add( 10, &fPotentialComplete );
	saver.Add( 11, &eType );
	saver.Add( 12, &eDifficulty );
	saver.Add( 13, &eTime );
	saver.Add( 14, &eWeather );
	saver.Add( 15, &bShowPotentialComplete );
	saver.Add( 16, &nRecommendedOrder );
	saver.Add( 17, &vEndOffset );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SMissionEnableInfo::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << pMap << vPlaceOnChapterMap << nMissionsToEnable << eMissionEnableType << reward << expectedEnemy << nRecommendedCalls << fPotentialIncomplete << fPotentialComplete << eType << eDifficulty << eTime << eWeather << bShowPotentialComplete << nRecommendedOrder << vEndOffset;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SScenarioUnitModifier::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "Type", (BYTE*)&eType - pThis, sizeof(eType), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( szAddName + "Quantity", (BYTE*)&nQuantity - pThis, sizeof(nQuantity), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "Units", (BYTE*)&pUnits - pThis, sizeof(pUnits), NTypeDef::TYPE_TYPE_REF );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SScenarioUnitModifier::operator&( IXmlSaver &saver )
{
	saver.Add( "Type", &eType );
	saver.Add( "Quantity", &nQuantity );
	saver.Add( "Units", &pUnits );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SScenarioUnitModifier::operator&( IBinSaver &saver )
{
	saver.Add( 2, &eType );
	saver.Add( 3, &nQuantity );
	saver.Add( 4, &pUnits );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SScenarioUnitModifier::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << eType << nQuantity << pUnits;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SBaseReinforcements::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportSimpleArrayMetaInfo( szAddName + "Reinforcements", &reinforcements, pThis );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SBaseReinforcements::operator&( IXmlSaver &saver )
{
	saver.Add( "Reinforcements", &reinforcements );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SBaseReinforcements::operator&( IBinSaver &saver )
{
	saver.Add( 2, &reinforcements );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SBaseReinforcements::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << reinforcements;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EChapterBonusType eValue )
{
	switch ( eValue )
	{
	case NDb::CBT_REINF_DISABLE:
		return "CBT_REINF_DISABLE";
	case NDb::CBT_REINF_CHANGE:
		return "CBT_REINF_CHANGE";
	case NDb::CBT_ADD_CALLS:
		return "CBT_ADD_CALLS";
	default:
		return "CBT_REINF_DISABLE";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EChapterBonusType NDb::StringToEnum_NDb_EChapterBonusType( const string &szValue )
{
	if ( szValue == "CBT_REINF_DISABLE" )
		return NDb::CBT_REINF_DISABLE;
	if ( szValue == "CBT_REINF_CHANGE" )
		return NDb::CBT_REINF_CHANGE;
	if ( szValue == "CBT_ADD_CALLS" )
		return NDb::CBT_ADD_CALLS;
	return NDb::CBT_REINF_DISABLE;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SChapterGeneralInfo::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "DescFileRef", (BYTE*)&szDescFileRef - pThis, sizeof(szDescFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( szAddName + "Portrait", (BYTE*)&pPortrait - pThis, sizeof(pPortrait), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( szAddName + "ReinforcementType", (BYTE*)&eReinforcementType - pThis, sizeof(eReinforcementType), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( szAddName + "StatBonus", (BYTE*)&pStatBonus - pThis, sizeof(pStatBonus), NTypeDef::TYPE_TYPE_REF );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SChapterGeneralInfo::operator&( IXmlSaver &saver )
{
	saver.Add( "DescFileRef", &szDescFileRef );
	saver.Add( "Portrait", &pPortrait );
	saver.Add( "ReinforcementType", &eReinforcementType );
	saver.Add( "StatBonus", &pStatBonus );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SChapterGeneralInfo::operator&( IBinSaver &saver )
{
	saver.Add( 2, &szDescFileRef );
	saver.Add( 3, &pPortrait );
	saver.Add( 4, &eReinforcementType );
	saver.Add( 5, &pStatBonus );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SChapterGeneralInfo::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << eReinforcementType << pStatBonus;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SChapterBonus::ReportMetaInfo() const
{
	NMetaInfo::StartMetaInfoReport( "ChapterBonus", typeID, sizeof(*this) );

	BYTE *pThis = (BYTE*)this;
	NMetaInfo::ReportMetaInfo( "BonusType", (BYTE*)&eBonusType - pThis, sizeof(eBonusType), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( "ApplyToEnemy", (BYTE*)&bApplyToEnemy - pThis, sizeof(bApplyToEnemy), NTypeDef::TYPE_TYPE_BOOL );
	NMetaInfo::ReportMetaInfo( "ReinforcementType", (BYTE*)&eReinforcementType - pThis, sizeof(eReinforcementType), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( "ReinforcementSet", (BYTE*)&pReinforcementSet - pThis, sizeof(pReinforcementSet), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "NumberOfCalls", (BYTE*)&nNumberOfCalls - pThis, sizeof(nNumberOfCalls), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::FinishMetaInfoReport();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SChapterBonus::operator&( IXmlSaver &saver )
{
	NMetaInfo::STerminalClassReporter reporter( this, saver );
	saver.Add( "BonusType", &eBonusType );
	saver.Add( "ApplyToEnemy", &bApplyToEnemy );
	saver.Add( "ReinforcementType", &eReinforcementType );
	saver.Add( "ReinforcementSet", &pReinforcementSet );
	saver.Add( "NumberOfCalls", &nNumberOfCalls );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SChapterBonus::operator&( IBinSaver &saver )
{
	saver.Add( 2, &eBonusType );
	saver.Add( 3, &bApplyToEnemy );
	saver.Add( 4, &eReinforcementType );
	saver.Add( 5, &pReinforcementSet );
	saver.Add( 6, &nNumberOfCalls );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SChapterBonus::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << eBonusType << bApplyToEnemy << eReinforcementType << pReinforcementSet << nNumberOfCalls;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SChapter::ReportMetaInfo() const
{
	NMetaInfo::StartMetaInfoReport( "Chapter", typeID, sizeof(*this) );

	BYTE *pThis = (BYTE*)this;
	NMetaInfo::ReportMetaInfo( "LocalizedNameFileRef", (BYTE*)&szLocalizedNameFileRef - pThis, sizeof(szLocalizedNameFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "LocalizedNameSaveLoadFileRef", (BYTE*)&szLocalizedNameSaveLoadFileRef - pThis, sizeof(szLocalizedNameSaveLoadFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "LocalizedDateFileRef", (BYTE*)&szLocalizedDateFileRef - pThis, sizeof(szLocalizedDateFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "LocalizedDescriptionFileRef", (BYTE*)&szLocalizedDescriptionFileRef - pThis, sizeof(szLocalizedDescriptionFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportStructArrayMetaInfo( "MissionPath", &missionPath, pThis );
	NMetaInfo::ReportMetaInfo( "ScriptFileRef", (BYTE*)&szScriptFileRef - pThis, sizeof(szScriptFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "UseMapReinforcements", (BYTE*)&bUseMapReinforcements - pThis, sizeof(bUseMapReinforcements), NTypeDef::TYPE_TYPE_BOOL );
	NMetaInfo::ReportStructArrayMetaInfo( "BasePlayerReinforcements", &basePlayerReinforcements, pThis );
	NMetaInfo::ReportStructArrayMetaInfo( "ReinforcementModifiers", &reinforcementModifiers, pThis );
	NMetaInfo::ReportMetaInfo( "MapPicture", (BYTE*)&pMapPicture - pThis, sizeof(pMapPicture), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "SeaNoiseMask", (BYTE*)&szSeaNoiseMask - pThis, sizeof(szSeaNoiseMask), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "DifferentColourMap", (BYTE*)&szDifferentColourMap - pThis, sizeof(szDifferentColourMap), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "PositiveColour", (BYTE*)&nPositiveColour - pThis, sizeof(nPositiveColour), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "NegativeColour", (BYTE*)&nNegativeColour - pThis, sizeof(nNegativeColour), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "MainStrikeAngle", (BYTE*)&fMainStrikeAngle - pThis, sizeof(fMainStrikeAngle), NTypeDef::TYPE_TYPE_FLOAT );
	NMetaInfo::ReportMetaInfo( "MainStrikePower", (BYTE*)&fMainStrikePower - pThis, sizeof(fMainStrikePower), NTypeDef::TYPE_TYPE_FLOAT );
	NMetaInfo::ReportMetaInfo( "ReinforcementCalls", (BYTE*)&nReinforcementCalls - pThis, sizeof(nReinforcementCalls), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "DetailsMap", (BYTE*)&pDetailsMap - pThis, sizeof(pDetailsMap), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportSimpleArrayMetaInfo( "ArrowTextures", &arrowTextures, pThis );
	NMetaInfo::ReportMetaInfo( "IntroMovie", (BYTE*)&szIntroMovie - pThis, sizeof(szIntroMovie), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportStructMetaInfo( "General", &general, pThis ); 
	NMetaInfo::FinishMetaInfoReport();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SChapter::operator&( IXmlSaver &saver )
{
	NMetaInfo::STerminalClassReporter reporter( this, saver );
	saver.Add( "LocalizedNameFileRef", &szLocalizedNameFileRef );
	saver.Add( "LocalizedNameSaveLoadFileRef", &szLocalizedNameSaveLoadFileRef );
	saver.Add( "LocalizedDateFileRef", &szLocalizedDateFileRef );
	saver.Add( "LocalizedDescriptionFileRef", &szLocalizedDescriptionFileRef );
	saver.Add( "MissionPath", &missionPath );
	saver.Add( "ScriptFileRef", &szScriptFileRef );
	saver.Add( "UseMapReinforcements", &bUseMapReinforcements );
	saver.Add( "BasePlayerReinforcements", &basePlayerReinforcements );
	saver.Add( "ReinforcementModifiers", &reinforcementModifiers );
	saver.Add( "MapPicture", &pMapPicture );
	saver.Add( "SeaNoiseMask", &szSeaNoiseMask );
	saver.Add( "DifferentColourMap", &szDifferentColourMap );
	saver.Add( "PositiveColour", &nPositiveColour );
	saver.Add( "NegativeColour", &nNegativeColour );
	saver.Add( "MainStrikeAngle", &fMainStrikeAngle );
	saver.Add( "MainStrikePower", &fMainStrikePower );
	saver.Add( "ReinforcementCalls", &nReinforcementCalls );
	saver.Add( "DetailsMap", &pDetailsMap );
	saver.Add( "ArrowTextures", &arrowTextures );
	saver.Add( "IntroMovie", &szIntroMovie );
	saver.Add( "General", &general );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SChapter::operator&( IBinSaver &saver )
{
	saver.Add( 3, &szLocalizedNameFileRef );
	saver.Add( 4, &szLocalizedNameSaveLoadFileRef );
	saver.Add( 5, &szLocalizedDateFileRef );
	saver.Add( 6, &szLocalizedDescriptionFileRef );
	saver.Add( 7, &missionPath );
	saver.Add( 8, &szScriptFileRef );
	saver.Add( 9, &bUseMapReinforcements );
	saver.Add( 10, &basePlayerReinforcements );
	saver.Add( 11, &reinforcementModifiers );
	saver.Add( 12, &pMapPicture );
	saver.Add( 13, &szSeaNoiseMask );
	saver.Add( 14, &szDifferentColourMap );
	saver.Add( 15, &nPositiveColour );
	saver.Add( 16, &nNegativeColour );
	saver.Add( 17, &fMainStrikeAngle );
	saver.Add( 18, &fMainStrikePower );
	saver.Add( 19, &nReinforcementCalls );
	saver.Add( 20, &pDetailsMap );
	saver.Add( 21, &arrowTextures );
	saver.Add( 22, &szIntroMovie );
	saver.Add( 23, &general );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SChapter::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << missionPath << bUseMapReinforcements << basePlayerReinforcements << reinforcementModifiers << nPositiveColour << nNegativeColour << fMainStrikeAngle << fMainStrikePower << nReinforcementCalls << pDetailsMap << arrowTextures << general;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SMedal::ReportMetaInfo() const
{
	NMetaInfo::StartMetaInfoReport( "Medal", typeID, sizeof(*this) );

	BYTE *pThis = (BYTE*)this;
	NMetaInfo::ReportMetaInfo( "LocalizedNameFileRef", (BYTE*)&szLocalizedNameFileRef - pThis, sizeof(szLocalizedNameFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "LocalizedDescFileRef", (BYTE*)&szLocalizedDescFileRef - pThis, sizeof(szLocalizedDescFileRef), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( "IconTexture", (BYTE*)&pIconTexture - pThis, sizeof(pIconTexture), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::ReportMetaInfo( "PictureTexture", (BYTE*)&pPictureTexture - pThis, sizeof(pPictureTexture), NTypeDef::TYPE_TYPE_REF );
	NMetaInfo::FinishMetaInfoReport();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMedal::operator&( IXmlSaver &saver )
{
	NMetaInfo::STerminalClassReporter reporter( this, saver );
	saver.Add( "LocalizedNameFileRef", &szLocalizedNameFileRef );
	saver.Add( "LocalizedDescFileRef", &szLocalizedDescFileRef );
	saver.Add( "IconTexture", &pIconTexture );
	saver.Add( "PictureTexture", &pPictureTexture );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMedal::operator&( IBinSaver &saver )
{
	saver.Add( 2, &szLocalizedNameFileRef );
	saver.Add( 3, &szLocalizedDescFileRef );
	saver.Add( 4, &pIconTexture );
	saver.Add( 5, &pPictureTexture );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SMedal::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
using namespace NDb;
REGISTER_DATABASE_CLASS( 0x10083400, SCampaign ) 
REGISTER_DATABASE_CLASS( 0x1917A440, SChapterBonus ) 
REGISTER_DATABASE_CLASS( 0x10083401, SChapter ) 
REGISTER_DATABASE_CLASS( 0x170C9480, SMedal ) 
