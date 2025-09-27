#include "StdAfx.h"

#include "MPManagerMode.h"
#include "InterfaceState.h"
#include "MPTransceiver.h"
#include "ScenarioTracker.h"
#include "../Misc/StrProc.h"
#include "../AILogic/B2AI.h"
#include "../Input/Bind.h"
#include "../Client/ServerClientInterface.h"
#include "DBMPConsts.h"
#include "GetConsts.h"
#include "../SceneB2/Scene.h"
#include "../Misc/Win32Random.h"
#include "CommandsHistory.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CMPManagerMode - game control - scoring, different modes, win/lose conditions, etc
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::StartGame()
{
	// Do all initialising
	SB2StartGameParams tranParams;
	tranParams.pMapInfo = gameDesc.pMPMap->pMap;
	tranParams.clients.resize( nSlotsUsed );
	tranParams.nSpeedAdjustment = gameDesc.nGameSpeed;

	// Scenario tracker
	InterfaceState()->VerifyScenarioTracker( IInterfaceState::ESTT_NONE );
	InterfaceState()->MakeScenarioTracker( IInterfaceState::ESTT_MULTI );
	IScenarioTracker *pScenarioTracker = Singleton<IScenarioTracker>();

	Scene()->ResetTimer( GetTickCount() );
	IScenarioTracker::SMultiplayerInfo scenarioInfo;
	pScenarioTracker->SetGameType( IAIScenarioTracker::EGT_MULTI_FLAG_CONTROL );
	pScenarioTracker->MissionStart( gameDesc.pMPMap->pMap, gameDesc.nTechLevel );

	dwLaggers = 0;
	dwLaggersOld = 0;
	bWaitWindowShown = false;
	bInitialLoadInProgress = true;
	lags.resize( slots.size() );
	lagsUpdate.bUpdating = false;
	lagsUpdate.timeUpdatePeriod = 500;
	int nMaxLagTime = ( NGameX::GetMPConsts()->nTimeUserMPLag + NGameX::GetMPConsts()->nTimeUserMPPause ) * 1000;

	dwInitialPlayers = 0;
	int nTranSlot = 0;
	for ( int i = 0; i < slots.size(); ++i )
	{
		if ( !IsPlayerPresent( i ) )
			continue;
		SMPSlot &slot = slots[i];

		dwInitialPlayers |= 1UL << i;

		lags[i].nLagLeft = nMaxLagTime;
		lags[i].timeStartLag = 0;

		pScenarioTracker->AddPlayer( i );
		pScenarioTracker->SetPlayerSide( i, slot.nTeam );
		pScenarioTracker->SetPlayerParty( i, slot.nCountry );
		pScenarioTracker->SetPlayerColour( i, slot.nColour );

		IScenarioTracker::SMultiplayerInfo::SPlayer &scenarioPlayer = scenarioInfo.players.push_back();
		scenarioPlayer.wszName = NStr::ToUnicode( slot.szName );
		scenarioPlayer.nTeam = slot.nTeam;
		scenarioPlayer.nIndex = i;
		scenarioPlayer.nCountry = slot.nCountry;
		scenarioPlayer.nLevel = 1;
		scenarioPlayer.wszRank = L"";

		if ( nTranSlot < tranParams.clients.size() )
		{
			tranParams.clients[nTranSlot].nClientID = slot.nClientID;
			tranParams.clients[nTranSlot].nPlayer = i;
			tranParams.clients[nTranSlot].nTeam = slot.nTeam;
			++nTranSlot;
		}
		NI_ASSERT( nTranSlot <= nSlotsUsed, "PRG: Incorrectly counted used slots." );
	}
	pScenarioTracker->SetMultiplayerInfo( scenarioInfo );
	NI_ASSERT( nTranSlot == nSlotsUsed, StrFmt( "PRG: Incorrectly counted used slots - %d/%d.", nTranSlot, nSlotsUsed ) );
	pScenarioTracker->SetLocalPlayer( nOwnSlot );

	NGlobal::SetVar( "multiplayer_time_limit", -1 );
	NGlobal::SetVar( "multiplayer_loss_timeout", -1 );
	timeNextInstaLoseCheck = 0;

	// Set AI.MultiplayerCaptureTime
	NGlobal::SetVar( "AI.MultiplayerCaptureTime", gameDesc.nCaptureTime * 1000 );

	NGlobal::SetVar( "multiplayer_unit_experience", gameDesc.bUnitExp ? 1 : 0 );

	// Create transciever
	pTransceiver = new CMPTransceiver;
	pTransceiver->Init( pClient, tranParams, nOwnSlot );
	pTransceiver->StartMission();

	timeEndMatch = 0;
	bOutcomeKnown = false;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::WinGame()
{
//	WriteToPipe( PIPE_CHAT, StrFmt( "You won the game" ) );

	Singleton<IScenarioTracker>()->MissionWin();
	nWinningSide = slots[nOwnSlot].nTeam;
	NInput::PostEvent( "multiplayer_win", 0, 0 );
	pTransceiver->EndGame();
	EndGame();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::LoseGame()
{
//	WriteToPipe( PIPE_CHAT, StrFmt( "You lost the game" ) );

	Singleton<IScenarioTracker>()->MissionCancel();
	nWinningSide = ( slots[nOwnSlot].nTeam == 0 ) ? 1 : 0;
	NInput::PostEvent( "multiplayer_loose", 0, 0 );
	pTransceiver->EndGame();
	EndGame();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::ScheduleLoseGame()
{
	CB2GameLostPacket *pPkt = new CB2GameLostPacket( 0, nGameID, pTransceiver->ScheduleGameEnd( 0 ) );
	pClient->SendGamePacket( pPkt, true );
	bWinOnGameEnd = false;
	bOutcomeKnown = true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::EndGame()
{
	if ( IsValid( pTransceiver ) )
		pCommandsHistory = dynamic_cast<CCommandsHistory*>(pTransceiver->GetCommandsHistory());
	else
		pCommandsHistory = 0;
	SaveReplay( "LastMatch" );
	pTransceiver = 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::CheckEndGameConditions()
{
	if ( !IsGameRunning() )
		return;

	if ( bOutcomeKnown )
	{
		if ( pTransceiver->IsGameEnded() )
		{
			if ( bWinOnGameEnd )
				WinGame();
			else
				LoseGame();
		}
		return;
	}

	if ( CheckAllLeftWin() )
		return;

	if ( CheckKeyBuildingsWinLose() )
		return;

	if ( CheckScoreWinLose() )
		return;

	if ( CheckInstantLose() )
	return;

	return;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CMPManagerMode::CheckAllLeftWin()
{
	if ( !pTransceiver || pTransceiver->IsGameEnded() )
		return true;
	if ( IsGameRunning() )
	{
		int nOppositePlayers = 0;
		for ( int i = 0; i < slots.size(); ++i )
		{
			if ( IsPlayerPresent( i ) && slots[nOwnSlot].nTeam + slots[i].nTeam == 1 )	
				++nOppositePlayers;		// one of them is 1 and another is 0, i.e. enemies
		}

		if ( nOppositePlayers == 0 )
		{
			WinGame();
			return true;
		}
	}
	return false;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CMPManagerMode::CheckScoreWinLose()
{
	IGameTimer *pTimer = Singleton<IGameTimer>();
	NTimer::STime curGameTime = pTimer->GetGameTime();
	float fTimeSpeedMultiplier = 1.0f;

	if ( gameDesc.nGameSpeed > 0 )
		fTimeSpeedMultiplier += gameDesc.nGameSpeed;
	else if ( gameDesc.nGameSpeed < 0 )
		fTimeSpeedMultiplier /= 1 - gameDesc.nGameSpeed;

	if ( timeEndMatch == 0 )
		timeEndMatch = curGameTime + gameDesc.nTimeLimit * 60000 * fTimeSpeedMultiplier;

	if ( timeEndMatch - curGameTime < 60000 )
	{
		if ( curGameTime > timeEndMatch )
			NGlobal::SetVar( "multiplayer_time_limit", -1 );
		else
			NGlobal::SetVar( "multiplayer_time_limit", int(timeEndMatch) / 1000 );
	}

	if ( timeEndMatch > 0 && curGameTime > timeEndMatch )
	{
		int nLostTeam = GetTeamWithLowestScore();
		int nOwnTeam = slots[nOwnSlot].nTeam;

		if ( nOwnTeam == nLostTeam )
		{
//			WriteToPipe( PIPE_CHAT, StrFmt( "Game time over, lost by score" ) );
			ScheduleLoseGame();
			return true;
		}
	}
	return false;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CMPManagerMode::GetTeamWithLowestScore()
{
	IScenarioTracker *pScenarioTracker = Singleton<IScenarioTracker>();
	pScenarioTracker->UpdateStatistics();

	int nScores[2];
	nScores[0] = 0;
	nScores[1] = 0;
	for ( int i = 0; i < slots.size(); ++i )
	{
		if ( !IsPlayerPresent( i ) )
			continue;
		nScores[slots[i].nTeam] += pScenarioTracker->GetStatistics( i, IScenarioTracker::ESK_SCORE );
	}

	if ( nScores[0] == nScores[1] )
		nScores[slots[0].nTeam] += 1;

	if ( nScores[0] > nScores[1] )
		return 1;
	else
		return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CMPManagerMode::CheckKeyBuildingsWinLose()
{
	IGameTimer *pTimer = Singleton<IGameTimer>();
	NTimer::STime curGameTime = pTimer->GetGameTime();
	IScenarioTracker *pScenarioTracker = Singleton<IScenarioTracker>();

	pair<int, int> flags = pScenarioTracker->GetKeyBuildingSummary();

	int nNewWinningSide = 2;
	if ( flags.first > 0 && flags.second == 0 )
		nNewWinningSide = 0;
	else if ( flags.first == 0 && flags.second > 0 )
		nNewWinningSide = 1;

	int nSecondsLeft = -1;
	if ( nNewWinningSide == nWinningSide )
	{
		if ( nNewWinningSide != 2 )
		{
			nSecondsLeft = Max ( 0, int( ( int(timeResolution) - int(curGameTime) ) / 1000 ) );
			if ( curGameTime > timeResolution )
			{
				if ( nWinningSide != slots[nOwnSlot].nTeam )
				{
//					WriteToPipe( PIPE_CHAT, StrFmt( "Lost all keypoints, timeout exceeded" ) );
					ScheduleLoseGame();
					return true;
				}
			}
		}
	}
	else
	{
		if ( nNewWinningSide != 2 )
		{
			nSecondsLeft = 60;
			timeResolution = curGameTime + nSecondsLeft * 1000;
		}
		else
			timeResolution = 0;
	}
	nWinningSide = nNewWinningSide;

	NGlobal::SetVar( "multiplayer_loss_timeout", nSecondsLeft );
	return false;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CMPManagerMode::CheckInstantLose()
{
	IGameTimer *pTimer = Singleton<IGameTimer>();
	NTimer::STime curGameTime = pTimer->GetGameTime();
	IScenarioTracker *pScenarioTracker = Singleton<IScenarioTracker>();
	int nOwnTeam = slots[nOwnSlot].nTeam;

	if ( curGameTime > timeNextInstaLoseCheck )
	{
		timeNextInstaLoseCheck = curGameTime + 5000;

		if ( nWinningSide + nOwnTeam == 1 && Singleton<IAILogic>()->HasPlayerNoUnits( nOwnSlot ) )
		{
//			WriteToPipe( PIPE_CHAT, StrFmt( "All keypoints lost, instant loss" ) );
			ScheduleLoseGame();
			return true;
		}
	}
	return false;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::AnalyzeLaggers()
{
	NTimer::STime curTime = GameTimer()->GetAbsTime();

	if ( bInitialLoadInProgress )
	{
		if ( lagsUpdate.CheckNeedUpdate() )
			SendLagInfo();
		return;
	}

	// Analyze my lag, if any
	// This should only happen if I set the pause myself
	if ( IsPlayerLagging( nOwnSlot ) )
	{
		SLagInfo &lagInfo = lags[nOwnSlot];
		int nTimeLeft = lagInfo.nLagLeft - ( curTime - lagInfo.timeStartLag );

		if ( nTimeLeft < NGameX::GetMPConsts()->nTimeUserMPLag )			// Too little time left, remove pause
		{
			lagInfo.nLagLeft = Max( nTimeLeft, 0 );
			pTransceiver->CommandTimeOut( false );
			dwLaggers &= ~( 1UL << nOwnSlot );
			ShowWaitWindow( false );
		}
	}

	DWORD dwPlayers = 0;
	for ( int i = 0; i < slots.size(); ++i )
	{
		if ( IsPlayerPresent( i ) )
			dwPlayers &= ( 1UL << i );
	}

	// Analyze other laggers
	for ( int i = 0; i < slots.size(); ++i )
	{
		if ( i == nOwnSlot || !IsPlayerPresent( i ) )
			continue;

		SLagInfo &lagInfo = lags[i];

		if ( HasPlayerStartedLagging( i ) )
		{
			lagInfo.timeStartLag = curTime;
			//DebugTrace( "*** LAG START for player %d at time %d", i, curTime );
		}
		else if ( HasPlayerStoppedLagging( i ) )
		{
			int nTimeLeft = lagInfo.nLagLeft - ( curTime - lagInfo.timeStartLag );
			lagInfo.nLagLeft = Max( nTimeLeft, 0 );
			lagInfo.dwHatedBy = 0;
			lagInfo.timeStartLag = 0;
			CPtr<CB2LagTimeUpdatePacket> pPkt = new CB2LagTimeUpdatePacket( 0, i, lagInfo.nLagLeft );
			pClient->SendGamePacket( pPkt, true );
			//DebugTrace( "*** LAG STOP for player %d at time %d, time left %d", i, curTime, lagInfo.nLagLeft ); 
		}
		else if ( IsPlayerLagging( i ) )
		{
			int nTimeLeft = lagInfo.nLagLeft - ( curTime - lagInfo.timeStartLag );
			if ( nTimeLeft <= 0 )
			{
				if ( !( lagInfo.dwHatedBy & ( 1UL << nOwnSlot ) ) )
				{
					CPtr<CB2SuggestKickPacket> pPkt = new CB2SuggestKickPacket( 0, i );
					pClient->SendGamePacket( pPkt, true );
					lagInfo.dwHatedBy &= ( 1UL << nOwnSlot );
				}
				if ( lagInfo.dwHatedBy == ( dwPlayers & ~dwLaggers ) )				// FINISH HIM!!!
				{
					KickPlayerFromSlot( i );
					slots[i].bPresent = false;
					pTransceiver->PlayerRemoved( i );
				}
			}
		}
	}
	dwLaggersOld = dwLaggers;

	if ( lagsUpdate.CheckNeedUpdate() )
		SendLagInfo();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::CreateRehash( vector<BYTE> *pOrder )
{
	vector<BYTE> &order = *pOrder;
	int nSize = slots.size();
	order.resize( nSize, -1 );
	for ( int i = 0; i < nSize; ++i )
		order[i] = i;

	if ( !gameDesc.bRandomPlacement )
		return;

	for ( int i = 0; i < 2 * nSize; ++i )
	{
		int nIndex1 = NWin32Random::Random() % nSize;
		int nIndex2 = NWin32Random::Random() % nSize;
		swap( order[nIndex1], order[nIndex2] );
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMPManagerMode::RehashSlots( const vector<BYTE> &order )
{
	string szDebugOut = "+++ Rehash slots:";
	for ( int i = 0; i < order.size(); ++i )
	{
		szDebugOut += StrFmt( " %d,", order[i] );
	}
	DebugTrace( szDebugOut.c_str() );

	vector<SMPSlot> newSlots;
	newSlots.resize( slots.size() );
	for ( int i = 0; i < slots.size(); ++i )
	{
		newSlots[order[i]] = slots[i];
		newSlots[order[i]].nClientID = slots[i].nClientID;
	}
	nOwnSlot = order[nOwnSlot];
	for ( int i = 0; i < slots.size(); ++i )
	{
		SMPSlot &slot = slots[i];
		slot = newSlots[i];
		slot.nClientID = newSlots[i].nClientID;
		if ( !slot.bPresent )
			DebugTrace( "+++ New Slot %d: empty", i );
		else
			DebugTrace( "+++ New Slot %d: %s, CID %d, side %d, team %d", i, slot.szName.c_str(), slot.nClientID, slot.nCountry, slot.nTeam );
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
