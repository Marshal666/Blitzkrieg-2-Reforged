#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "..\Misc\HashFuncs.h"
#include "InterfaceScreenBase.h"
#include "../B2_M1_World/Notifications.h"
#include "../Stats_B2_M1/UserActions.h"
#include "../Stats_B2_M1/SpecialAbilities.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CWorldClient;
class CMapObj;
struct SObjectStatus;
class CMissionReinf;
interface IScenarioTracker;
class CMissionSuperWeapon;
enum EActionMode;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	enum EActionButtonPanel;
	struct SUIConstsB2;
	struct SMapInfo;
	struct SWeaponRPGStats;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EActiveControl 
{
	AC_NONE,
	AC_SCREEN, 
	AC_WORLD,
	AC_MINIMAP,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SSlotPosition
{
	int x;
	int y;
	int sizeX;
	int sizeY;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef pair< NDb::EUserAction, CPtr<IWindow> > CActionButton;
typedef list< CActionButton > CActionButtons;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SChatMessage
{
	ZDATA
	CPtr< IWindow > pWnd;
	NTimer::STime nVisibleTime;
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&pWnd); f.Add(3,&nVisibleTime); return 0; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CInterfaceMission : public CInterfaceScreenBase
{
	OBJECT_NOCOPY_METHODS( CInterfaceMission );

public:
	class CReactions : public IProgrammedReactionsAndChecks
	{
		OBJECT_NOCOPY_METHODS(CReactions);
		ZDATA
		CPtr<IWindow> pScreen;
		CPtr<CInterfaceMission> pInterface;
		ZEND int operator&( IBinSaver &f ) { f.Add(2,&pScreen); f.Add(3,&pInterface); return 0; }
	public:
		CReactions() {}
		CReactions( IWindow *_pScreen, CInterfaceMission *_pInterface ) :
			pScreen( _pScreen ),
			pInterface( _pInterface )
		{
		}
		//
		bool NeedFlags() const { return true; }
		bool Execute( const string &szSender, const string &szReaction, WORD wKeyboardFlags );
	};
private:
	struct SWeaponInfo
	{
		ZDATA
		CDBPtr<NDb::SWeaponRPGStats> pWeaponID;
		int nCount;
		bool bPrimary;
		wstring szLocalizedName;
		int nAmmo;
		int nMaxAmmo;
		CPtr<IWindow> pName;
		CPtr<IWindow> pAmmo;
		ZEND int operator&( IBinSaver &f ) { f.Add(2,&pWeaponID); f.Add(3,&nCount); f.Add(4,&bPrimary); f.Add(5,&szLocalizedName); f.Add(6,&nAmmo); f.Add(7,&nMaxAmmo); f.Add(8,&pName); f.Add(9,&pAmmo); return 0; }
	};
	
	struct SNewActionButton
	{
		ZDATA
		CPtr<IButton> pBtn;
		bool bAbility;
		NDb::EActionButtonPanel ePanel;
		NDb::EActionButtonPanel eTargetPanel;
		bool bPressEffect;
		CDBPtr< NDb::STexture > pIcon;
		CDBPtr< NDb::STexture > pForegroundIcon;
		CDBPtr< NDb::STexture > pIconDisabled;
		CDBPtr< NDb::STexture > pForegroundIconDisabled;

		ZSKIP //CPtr< IWindow > pIconBgWnd;
		CPtr< IWindow > pIconFgWnd;
		CPtr< IWindowRoundProgressBar > pClockWnd;
		CPtr< IWindowFrameSequence > pAutocastWnd;
		CPtr< IWindow > pStaticBorderWnd;
		CPtr< IWindow > pActiveBorderWnd;
		
		bool bAutocast;
		bool bPassive;
		
		SAbilitySwitchState curState;
		int nSlot;

		CPtr< IWindow > pIconBgDisabledWnd;
		CPtr< IWindow > pIconFgDisabledWnd;
		
		bool bCurPresent; // ������������ �� ����� �� �������

		CPtr< IWindow > pAutocastBorderWnd;
		string szHotkeyCmd;
		wstring wszTooltip;
		bool bEnabled;
		CPtr<IWindow> pBlinkWnd;
		ZEND int operator&( IBinSaver &f ) { f.Add(2,&pBtn); f.Add(3,&bAbility); f.Add(4,&ePanel); f.Add(5,&eTargetPanel); f.Add(6,&bPressEffect); f.Add(7,&pIcon); f.Add(8,&pForegroundIcon); f.Add(9,&pIconDisabled); f.Add(10,&pForegroundIconDisabled); f.Add(12,&pIconFgWnd); f.Add(13,&pClockWnd); f.Add(14,&pAutocastWnd); f.Add(15,&pStaticBorderWnd); f.Add(16,&pActiveBorderWnd); f.Add(17,&bAutocast); f.Add(18,&bPassive); f.Add(19,&curState); f.Add(20,&nSlot); f.Add(21,&pIconBgDisabledWnd); f.Add(22,&pIconFgDisabledWnd); f.Add(23,&bCurPresent); f.Add(24,&pAutocastBorderWnd); f.Add(25,&szHotkeyCmd); f.Add(26,&wszTooltip); f.Add(27,&bEnabled); f.Add(28,&pBlinkWnd); return 0; }
		
		void Enable( bool bEnable );
		void SetProgress( float fProgress );
	};
	typedef hash_map< NDb::EUserAction, SNewActionButton, SEnumHash > CNewActionButtons;
	
	struct SIconSlot
	{
		ZDATA
		CPtr<IButton> pBtn;
		CPtr<IWindow> pIconWnd;
		CPtr<IProgressBar> pProgressBar;
		CPtr<ITextView> pCountView;
		CPtr<IWindow> pFlagBgWnd;
		ZEND int operator&( IBinSaver &f ) { f.Add(2,&pBtn); f.Add(3,&pIconWnd); f.Add(4,&pProgressBar); f.Add(5,&pCountView); f.Add(6,&pFlagBgWnd); return 0; }
	};
	
	enum EUIState
	{
		EUIS_NORMAL,
		EUIS_ON_ENTER_TRANSIT_START,
		EUIS_ON_ENTER_TRANSIT_START_DONE,
	};
	
	enum ESkipMovieState
	{
		_ESMS_DEBUG = 0,
		ESMS_NONE,
		ESMS_FADING_OUT,
		ESMS_PREPARE_FOR_FAST_FORWARD,
		ESMS_FAST_FORWARD,
		ESMS_FADING_IN,
		ESMS_DONE,
	};
	ESkipMovieState eSkipState;
	NTimer::STime timeSkipProgress;
	float fInitialBrightness;

	//
	CObj<CReactions> pReactions;
	CPtr<CWorldClient> pWorld;

	EActiveControl eActiveControl;
	bool bIsActiveScreen;
	NDb::EUserAction eForcedAction;
	vector<SSlotPosition> vAbilitySlots;
	CActionButtons lActiveAbilities;
	CActionButtons actionButtons;
	int nCurrentSlot;
	//vector< CPtr<IWindow> > vIconSlots;
	vector< SIconSlot > iconSlots;
	CPtr< IMiniMap > pMiniMap;
	CPtr< IWindow > pChatMessages;
	CPtr< IWindow > pChatMessagesElement;
	list<SChatMessage> chatMessages;
	CPtr< ITabControl > pMultiFunctionTab;
	CPtr< ITabControl > pActionTab;
	CPtr< ITabControl > pAppearanceTab;

	int nCurrentIconSlot;
	int nCurrentReinfPoint;

	bool bScreenLoaded;
	bool bNeedWarFogRecalc;

	NTimer::STime nLastStepTime;

	bool bShowWarFog;
	//SInterfaceMissionWarFogInfo warFogInfo;
	NTimer::STime timeLastWarFogUpdate;

	float fBorderScrollX;
	float fBorderScrollY;
	bool bAllowBorderScroll;

	CDBPtr<NDb::SMapInfo> pMission;
	bool bFrozen;
	
	bool bMultiSelectSubMode;
	bool bPreSelectSubMode; // don't save
	
	CObj<IVisualNotifications> pNotifications;
	
	NTimer::STime nChatTime;
	
	CPtr<IWindow> pShowObjectives;
	CPtr<IWindow> pPause;
	CPtr<ITransceiver> pTransceiver;
	
	bool bEscMenuPressed; // DEBUG - ����� �� ���������� ��������� Esc-menu ��� �������
	int nGameSpeed;													// game speed before script movie
	
	CObj<CMissionReinf> pReinf;
	
	string szButtonsBindSection;
	
	ZSKIP //CPtr<IWindow> pReinfLight;
	CPtr<IButton> pFlareBtn;
	CPtr<IButton> pMinimizeBtn;
	CPtr<IWindow> pMultifunctionWnd;
	bool bMultifunctionPanelMinimized;
	CObj<class CMissionUnitFullInfo> pUnitFullInfo;
	vector< CPtr<IButton> > specialSelectBtns;
	
	CNewActionButtons newActionButtons;
	NDb::EActionButtonPanel eActivePanel;
	NDb::EUserAction eActiveAction;
	vector<CVec2> newActionButtonSlots;

	CVec3 vPrevCameraLine; // don't save
	
	float fViewportBottom;
	
//	int nMissionTime; // at seconds
	__int64 nMissionTimeMSec;
	NTimer::STime timeMissionLastCheck; // don't save
	
	CPtr<IScenarioTracker> pScenarioTracker;

	BYTE nFrameTransition;
	CVec2 vFrameTransitionTo;

	EUIState eUIState; // don't save
	
	NTimer::STime timeAbsLast; // don't save
	CObj<IScreen> pMovieBorder;
	NInput::CGMORegContainer scriptMovieMessageProcessor;
	bool bScriptMoivie;
	float fFormerVolume;
	bool bCheckShowHelpScreen;
	bool bMovieMode;
	
	CObj<CMissionSuperWeapon> pSuperWeapon;
	wstring wszTooltipSlot;
	wstring wszTooltipSlotUnit;

	float fEndGameRestTime; // don't save

	bool bTryExitWindows;

	struct SChatInput
	{
		ZDATA
		CPtr<IWindow> pPanel;
		CPtr<ITextView> pView;
		CPtr<IEditLine> pEdit;
		wstring wszAll;
		wstring wszTeam;
		float fEditBaseX;
		float fEditBaseWidth;
		bool bTeamByDefault;
		ZSKIP //bool bCrapIgnoreMessage;
		bool bMultifunctionPanelMinimized;
		bool bTeam;
		ZEND int operator&( IBinSaver &f ) { f.Add(2,&pPanel); f.Add(3,&pView); f.Add(4,&pEdit); f.Add(5,&wszAll); f.Add(6,&wszTeam); f.Add(7,&fEditBaseX); f.Add(8,&fEditBaseWidth); f.Add(9,&bTeamByDefault); f.Add(11,&bMultifunctionPanelMinimized); f.Add(12,&bTeam); return 0; }
	};
	
	SChatInput chatInput;
	CPtr<IWindow> pObjectivesBlink;
private:
	void UpdateMultiplayerScoreBoard();
	void UpdateInterfacePause();

	void RegisterObservers();
	bool StepLocal( bool bAppActive );

	bool IsScreenControl( const CVec2 &vPos ) const;

	void AddActionButton( NDb::EUserAction eUserAction, IWindow *pWnd );
	void SetAbilityState( const NDb::EUserAction eUserAction, const SAbilitySwitchState &state );
	void MsgToggleWarFog( const SGameMessage &msg );
	void MsgTestCommand( const SGameMessage &msg );

	void UpdateChat( NTimer::STime nDeltaTime );
	void UpdateChatAbs( NTimer::STime nDeltaTime );
	void UpdateWarFog( NTimer::STime nGameTime, bool bFirst, bool bForced );

	void UpdateSelectMode();

	void MsgToggleGamePause( const SGameMessage &msg );

	void MsgNotificationsCameraBack( const SGameMessage &msg );
	void TrySkipMovie( const SGameMessage &msg );
	
	void InitMinimapColors( const NDb::SUIConstsB2 *pUIConsts );

	void MakeActionTooltip( NDb::EUserAction eUserAction, const string &szCommand, bool bHotkey );
	void MakeAbilityTooltip( NDb::EUserAction eUserAction, int nSlot );
	void MakeCommandTooltip( NDb::EUserAction eUserAction );
	
	bool IsAbility( NDb::EUserAction eAction ) const;
	NDb::EUserAction GetActionByButtonName( const string &szName ) const;
	void UpdateActionPanel();
	
	void UpdateActionButtons();
	
	void RegisterActionObservers();
	bool MsgActionCmd( const SGameMessage &msg, int nAction );
	
	void UpdateMissionTime( bool bAppActive );
	
	void CRAP_CheckEndGame();
	
	void MakeScreen( const NDb::SMapInfo *pMapInfo, const NDb::SUIConstsB2 *pUIConsts );
	void EndScriptMovieSequence();
	
	void SetActionMode( EActionMode eActionMode );
	void CheckInactiveInput();
	
	void StartChatInput( bool bTeam );
	void SendChat( const wstring &wszText, bool bTeam );
	void FastMinimizePanels();
	void FastMaximizePanels();
	void OnChatInputLostFocus();
	void CloseChatInput();
protected:
	void OnMouseMove( const CVec2 &vPos );
	void CheckMouseBorder( const CVec2 &vPos, const bool bAllowScroll );
	void OnButtonDown( const CVec2 &vPos, int nButton );
	void OnButtonUp( const CVec2 &vPos, int nButton );
	void OnButtonDblClk( const CVec2 &vPos, int nButton );

	void MsgWinLoose( const SGameMessage &msg );
	void MsgEscMenu( const SGameMessage &msg );
	void MsgOk( const SGameMessage &msg );
	void MsgCancel( const SGameMessage &msg );
	void MsgTryExitWindows( const SGameMessage &msg );
	void MsgShowObjectives( const SGameMessage &msg );
	
	void MsgSelectMode( const SGameMessage &msg );
	void MsgMultiSelectMode( const SGameMessage &msg );
	void MsgSingleSelectMode( const SGameMessage &msg );
	void MsgPreSelectMode( const SGameMessage &msg );
	void MsgUpdateSingleUnit( const SGameMessage &msg );
	void MsgUpdateUnitStats( const SGameMessage &msg );
	void MsgUpdateSuperWeaponStats( const SGameMessage &msg );
	void MsgUpdateButtons( const SGameMessage &msg );
	void MsgUnpdateIcon( const SGameMessage &msg );
	void MsgHighlightUnits( const SGameMessage &msg );
	void MsgSetAbilityState( const SGameMessage &msg );
	void MsgSetAbilityParam( const SGameMessage &msg );
	void MsgMiniMapShowObjectives( const SGameMessage &msg );
	void MsgMiniMapHideObjectives( const SGameMessage &msg );
	void MsgNewUpdateReinfAvail( const SGameMessage &msg );
	void MsgNewUpdateReinfPoint( const SGameMessage &msg );
	void MsgForcedActionCallReinf( const SGameMessage &msg );
	void MsgForcedActionCallNoReinf( const SGameMessage &msg );
	void MsgForcedActionCallSuperWeapon( const SGameMessage &msg );
	void MsgResetTarget( const SGameMessage &msg );
	void MsgQuickSave( const SGameMessage &msg );
	void MsgQuickLoad( const SGameMessage &msg );
	void MsgShowGamePaused( const SGameMessage &msg );
	bool MsgBeginScriptMovieSequence( const SGameMessage &msg );
	void MsgUpdateMinimapPos( const SGameMessage &msg );
	void MsgReinfMode( const SGameMessage &msg );
	void MsgBadWeather( const SGameMessage &msg );
	void MsgAviaReturns( const SGameMessage &msg );
	void MsgUserAbilitySlot( const SGameMessage &msg, int nParam );
	void MsgMultistatePanelMinimize( const SGameMessage &msg );
	void MsgMultistatePanelMaximize( const SGameMessage &msg );
	void MsgMultistatePanelToggle( const SGameMessage &msg );
	void MsgUpdateSpecialSelectBtn( const SGameMessage &msg );
	void MsgResetForcedAction( const SGameMessage &msg );
	void MsgUnitViewClick( const SGameMessage &msg );
	void UpdateWinLooseState();
	void MsgUpdateWinLooseState( const SGameMessage &msg );
	void MsgMultiplayerWin( const SGameMessage &msg );
	void MsgMultiplayerLoose( const SGameMessage &msg );
	bool MsgOnBeforeMouseMove( const SGameMessage &msg );
	bool MsgScrollMap( const SGameMessage &msg );
	void MsgMessageBoxOk( const SGameMessage &msg );
	void MsgNotificationOpenReinf( const SGameMessage &msg );
	void MsgOnRemovePlayer( const SGameMessage &msg );
	void MsgOnMultiplayerPause( const SGameMessage &msg );
	void MsgOnScriptBlinkActionButton( const SGameMessage &msg );
	void MsgBlinkObjectiveBtn( const SGameMessage &msg );

	bool OnReinfSelect( const string &szSender );
	bool OnReinfSelectDblClick( const string &szSender );
	bool OnToggleReinf( const string &szSender );
	bool OnReinfUnitInfo( const string &szSender );
	bool OnReinfFullInfoBack( const string &szSender );
	bool OnReinfMouseOverForward( const string &szSender );
	bool OnReinfMouseOverBackward( const string &szSender );
	bool OnReinfCallMode( const string &szSender );
	bool OnReinfAutoShowReinf( const string &szSender, bool bOn );

	bool OnClickMultiSelectUnit( const string &szSender, WORD wKeyboardFlags );
	bool OnSelectSpecialGroup( const string &szSender, WORD wKeyboardFlags );
	bool OnUnselectSpecialGroup( const string &szSender, WORD wKeyboardFlags );

	bool OnNewActionButtonClick( const string &szSender, WORD wKeyboardFlags );
	void NewActionButtonClick( NDb::EUserAction eAction );
	bool OnNewActionButtonRightClick( const string &szSender, WORD wKeyboardFlags );
	bool OnNotificationEventBtn( const string &szSender, bool bRightBtn );
	bool OnEnterPressed( WORD wKeyboardFlags );
	bool OnChatInputEnterPressed();
	bool OnChatInputEscPressed();
	bool OnChatInputFocusLost();
	
	void ResetAbilityButtons();
	void AddAbilityButton( NDb::EUserAction eAction, IWindow *pWnd, bool bFixedPlace );
	void SetArmyPoints( int nPoints );
	void UpdateMultiUnitsInfo( CMapObj *pMO, int nCount );
	bool OnClickFullInfoMember( const string &szSender );
	bool OnFullInfoMemberOverOn( const string &szSender );
	bool OnFullInfoMemberOverOff( const string &szSender );
	bool OnFullInfoWeaponOverOn( const string &szSender );
	bool OnFullInfoWeaponOverOff( const string &szSender );

	bool ProcessEvent( const struct SGameMessage &msg );

	void RestoreBindSection();

	bool IsShowHelpScreenOnInit() { return false; }
	void MultifunctionPanelMinimize();
	void MultifunctionPanelMaximize();
	void BlinkActionButton( int nButton, bool bOn );
	
	~CInterfaceMission();
public:	
	CInterfaceMission();
	//
	bool Init();
	void OnGetFocus( bool bFocus );
	// ������� � ����� ���������� �� ������� ��������������
	void StartInterface();
	//
	void NewMission( const NDb::SMapInfo *_pMap, interface ITransceiver *pTransceiver, IScenarioTracker *pScenarioTracker, int nPlayer );
	//
	void SetWarForVisibility( const bool bShowWarFog );
	//
	void AfterLoad();
	//
	virtual void Freeze( const bool bFreeze );
	class CWorldClient* GetWorld() { return pWorld; }

	void GetObjectHPs( const CMapObj *pMO, vector<float> *pHPs, bool *pIsSquad );

	virtual void Draw( NGScene::CRTPtr *pTexture = 0 );

	//
	int operator&( IBinSaver &saver );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CICMission : public CInterfaceCommandBase<CInterfaceMission>
{
	OBJECT_BASIC_METHODS( CICMission );
	//
public:
	CDBPtr<NDb::SMapInfo> pMap;
	bool bReplay;
	string szReplayFileName;
	bool bFromInterface;
	CPtr<ITransceiver> pTrans;
	int nPlayerForWarFog;
	//
	void PreCreate();
	void PostCreate( IInterface *pInterface );
	CICMission() : nPlayerForWarFog( -1 ) {}
	CICMission( const NDb::SMapInfo *_pMap, const string &_szReplay, bool _bFromInterface )
		: pMap(_pMap), szReplayFileName(_szReplay), bFromInterface(_bFromInterface),
		nPlayerForWarFog( -1 )
	{ 
		bReplay = szReplayFileName != ""; 
	}
		CICMission( ITransceiver *pTransceiver );

		void Configure( const char *pszConfig );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
