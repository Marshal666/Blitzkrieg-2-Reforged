#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "../B2_M1_World/CommonB2M1AI.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	struct SMapInfo;
	struct SAIGameConsts;
}

struct SMiniMapUnitInfo;
struct SAIAcknowledgment;
struct SAIBoredAcknowledgement;
struct SAIBasicUpdate;
struct SAIUnitCmd;
struct SShootAreas;

interface ICheckSumLog;
interface IProgressHook;
enum EActionCommand;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IAILogic : public ICommonB2M1AI
{
	enum { tidTypeID = 0x3015CB01 };
	
	virtual void Suspend() = 0;
	virtual void Resume() = 0;
	virtual void ClearAI() = 0;
	virtual bool IsMissionLoaded() const = 0;

	virtual void SetProgressHook( IProgressHook *pProgress ) = 0;
	virtual void Init( ICheckSumLog *pCheckSumLog, const struct NDb::SMapInfo *pMapInfo, const NDb::SAIGameConsts *pConsts, interface IAIScenarioTracker *_pScenarioTracker ) = 0;
	virtual void LogCheckSum( ICheckSumLog *pCheckSumLog ) { }
	virtual void InitAfterMapLoad( const struct NDb::SMapInfo *pMapInfo ) = 0;
	virtual void PostMapLoad() {}

	virtual void ToggleWarFog( const bool bWarFog ) = 0;
	virtual int GetMiniMapWarFogSizeX() const = 0;
	virtual int GetMiniMapWarFogSizeY() const = 0;
	virtual const bool GetMiniMapUnitsInfo( vector< SMiniMapUnitInfo > &vUnits ) = 0;
	virtual bool GetMiniMapWarForInfo( CArray2D<BYTE> **pWarFogInfo, bool bFirstTime ) = 0;

	virtual bool UpdateAcknowledgment( SAIAcknowledgment &pAck ) = 0;
	virtual bool UpdateAcknowledgment( SAIBoredAcknowledgement &pAck ) = 0;

	virtual bool IsCombatSituation() = 0;

	virtual void PrepareUpdates() = 0;
	virtual CObjectBase* GetUpdate() = 0;

	virtual float GetZ( const CVec2 &vPoint ) const = 0;
	virtual const bool GetIntersectionWithTerrain( CVec3 *pvResult, const CVec3 &vBegin, const CVec3 &vEnd ) const = 0;
	virtual const DWORD GetNormal( const CVec2 &vPoint ) const  = 0;
	virtual interface ITerraAIObserver* CreateTerraAIObserver( const int nSizeX, const int nSizeY ) = 0;

	virtual void RegisterGroup( const vector<int> &vIDs, const int nGroup ) = 0;
	virtual void UnregisterGroup( const int nGroup ) = 0;
	virtual void GroupCommand( SAIUnitCmd *pCommand, const WORD wGroup, bool bPlaceInQueue ) = 0;
	virtual void UnitCommand( SAIUnitCmd *pCommand, const WORD wGroupID, const int nPlayer ) = 0;
	virtual const	int GenerateGroupNumber() = 0;

	virtual void RequestBuildPreview( const EActionCommand eBuildCommand, const CVec2 &vStart, const CVec2 &vEnd, bool bFinished = false ) = 0;

	virtual void ShowAreas( const vector<int> &units, enum EActionNotify &eAction, bool bShow ) = 0;
	virtual void GetShootAreas( int nUnitID, SShootAreas *pAreas ) = 0;

	virtual const int WAR_FOG_FULL_UPDATE() const = 0;
	virtual const int VIS_POWER() const = 0;

	virtual void PickedObj( const int nObjID ) = 0;
	virtual void PickEmpty() = 0;

	virtual void SetGlobeScriptHandler( interface IGlobeScriptHandler *pHandler ) = 0;

	virtual class CStaticMapHeights* GetHeights() const = 0;

	virtual void Segment() = 0;
	virtual bool IsSuspended() const = 0;

	virtual void NetGameStarted() = 0;
	virtual bool IsNetGameStarted() const = 0;

	virtual void SetMyDiplomacyInfo( const int nParty, const int nNumber ) = 0;
	virtual void SetNPlayers( const int nPlayers ) = 0;
	virtual void SetNetGame( const bool bNetGame ) = 0;
	virtual void NeutralizePlayer( const int nPlayer ) = 0;

	virtual const int GetPlayerDiplomacy( const int nPlayer ) const = 0;

	virtual const int GetUnitCount( const int nPlayer ) const = 0;
	virtual const bool HasPlayerNoUnits( const int nPlayer ) const = 0;

	virtual void SetNeedNewGroupNumber() = 0;
	virtual const bool NeedNewGroupNumber() const = 0;
	virtual void ResetNeedNewGroupNumber() = 0;

	virtual const NDb::SAIGameConsts *GetAIConsts() const = 0;
	virtual void DumpAfterAssinc() const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
