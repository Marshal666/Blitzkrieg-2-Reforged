#ifndef _interfaceBase_h_included_
#define _interfaceBase_h_included_
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "commandparam.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EKeyboardFlags
{
	EKF_NONE		= 0,
	EKF_SHIFT		= 1,
	EKF_ALT			= 2,
	EKF_CTRL		= 4,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef DWORD STime;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EXTERNVAR bool s_bUICommonShowWarnings;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NGScene
{
	class I2DGameView;
	class IGameView;
}
namespace NDb
{
	struct SUIStateBase;
	struct SComplexSoundDesc;
	struct SUIGameConsts;
	struct SMaterial;
	struct SUIDesc;
	struct SWindowShared;
	enum EButtonSubstateType;
	struct SUIStateSequence;
	struct SText;
	struct STexture;
	struct SBackground;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EWindowPlacementFlags
{
	EWPF_POS_X					= 1,
	EWPF_POS_Y					= 2,
	EWPF_SIZE_X					= 4,
	EWPF_SIZE_Y					= 8,
	
	EWPF_ALL						= 0xffff,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IVirtualScreenController : public CObjectBase
{
	virtual void SetResolution( int nSizeX, int nSizeY ) = 0;
	virtual void GetResolution( int *nSizeX, int *nSizeY ) = 0;
	virtual void SetOrigin( int nOrgX, int nOrgY ) = 0;
	virtual void GetOrigin( int *pOrgX, int *pOrgY ) = 0;
	virtual void VirtualToScreen( const CTRect<float> &src, CTRect<float> *pRes ) = 0;
	virtual void VirtualToScreen( class CRectLayout *pRects ) = 0;
	virtual void ScreenToVirtual( const CVec2 &vPos, CVec2 *pScreenPos ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IUIInitialization : public CObjectBase
{
	enum { tidTypeID = 0x1109BC00 };

	virtual void SetUIConsts( const struct NDb::SUIGameConsts *pConsts ) = 0;
	// default handlers for custom ML tags
	virtual void SetMLHandler( const wstring &wsTAG, interface IMLHandler *pHandler ) = 0;
	virtual interface IWindow * CreateWindowFromDesc( const struct NDb::SUIDesc *pDesc ) = 0;
	virtual interface IWindow * CreateScreenFromDesc( const struct NDb::SUIDesc *pDesc, 
																										const NDb::SUIGameConsts *pConsts, 
																										interface IProgrammedReactionsAndChecks *pReactionsAndChecks,
																										NGScene::I2DGameView * p2DView, 
																										NGScene::IGameView *pGView, NGScene::IGameView *pInterface3DView ) = 0;
	virtual IVirtualScreenController * GetVirtualScreenController() = 0;

	virtual void Set2DGameView( NGScene::I2DGameView* pView ) = 0;
	virtual int operator&( IBinSaver &saver ) = 0;
};
IUIInitialization* CreateUIInitialization();
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// UI operates in fixed resolution. to draw on screen it cals these functions.
CRectLayout &VirtualToScreen( class CRectLayout *pRects );
CVec2 &VirtualToScreen( CVec2 *src );
CTRect<float> &VirtualToScreen( CTRect<float> *src );
CTPoint<float> &VirtualToScreen( CTPoint<float> *src );
void VirtualToScreen( const CTRect<float> &src, CTRect<float> *pRes );
void VirtualToScreen( const CTPoint<float> &src, CTPoint<float> *pRes );
int VirtualToScreenX( float fX );
int VirtualToScreenY( float fY );

int ScreenToVirtualX( float fX );
int ScreenToVirtualY( float fY );
void ScreenToVirtual( const CVec2 &vPos, CVec2 *pScreenPos );
void ScreenToVirtual( const CTPoint<int> &vPos, CTPoint<int> *pScreenPos );
CVec2 ScreenToVirtual( const CVec2 &vPos );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// window notify about being clicked
interface IClickNotify : virtual public CObjectBase
{
	virtual void Clicked( interface IWindow *pWho, int nButton ) {};
	virtual void DoubleClicked( interface IWindow *pWho, int nButton ) {};
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SWindowAnimationContext : public CObjectBase
{
	OBJECT_BASIC_METHODS( SWindowAnimationContext );

	CParam<string> szAnimatedWindow;
public:

	int operator&( IBinSaver &saver )
	{
		saver.Add( 1, &szAnimatedWindow );
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// window may have context. when window executes command sequence, it passes its context.
// if message reaction or command doesn't have enough parameters it asks context about it.
struct SWindowContext : public CObjectBase
{
public:
	ZDATA
	//for MoveTo
	CParam<CVec2> vOffset;
	CParam<float> fMoveTime;
	CParam<string> szElementToMove;
	// for SoundCommand
	CParam<CDBPtr<NDb::SComplexSoundDesc> > pSoundToPlay;
	//
	// for RunReaction
	CParam<string> szReactionForward;
	CParam<string> szReactionBack;
	//
	// for SendUIMessage
	CParam<string> szMessageID;
	CParam<string> szParam;
	CParam<int> nForwardParam;
	CParam<int> nBackParam;
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&vOffset); f.Add(3,&fMoveTime); f.Add(4,&szElementToMove); f.Add(5,&pSoundToPlay); f.Add(6,&szReactionForward); f.Add(7,&szReactionBack); f.Add(8,&szMessageID); f.Add(9,&szParam); f.Add(10,&nForwardParam); f.Add(11,&nBackParam); return 0; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SWindowContextCommon : public SWindowContext
{
	OBJECT_BASIC_METHODS( SWindowContextCommon );
public:
	int operator&( IBinSaver &saver )
	{
		//{ for compability with old saves
/*		saver.Add( 1, &szElementToMove );
		saver.Add( 2, &pSoundToPlay );
		saver.Add( 3, &vOffset);
		saver.Add( 4, &fMoveTime );
		saver.Add( 5, &szReactionForward  );
		saver.Add( 6, &szReactionBack );
		saver.Add( 7, &szMessageID );
		saver.Add( 8, &szParam );
		saver.Add( 9, &nForwardParam );
		saver.Add( 10, &nBackParam );*/
		//}

		saver.Add( 11, static_cast<SWindowContext*>( this ) );

		return 0;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// generic window functionality
interface IWindow : virtual public CObjectBase
{
	virtual bool ProcessEvent( const struct SGameMessage &msg ) = 0;
	virtual bool ProcessMessage( const struct SBUIMessage &msg ) = 0;
	// modality
	virtual void SetModal( bool _bIsModal ) = 0;
	virtual bool IsModal() const = 0;
	// return true if processed
	virtual bool OnButtonDown( const CVec2 &vPos, const int nButton ) = 0;
	virtual bool OnButtonUp( const CVec2 &vPos, const int nButton ) = 0; 
	virtual bool OnButtonDblClk( const CVec2 &vPos, const int nButton ) = 0;
	virtual bool OnMouseMove( const CVec2 &vPos, const int nMouseState ) = 0;
	// pick
	virtual IWindow* Pick( const CVec2 &vPos, const bool bRecursive ) = 0;
	// priority
	virtual int GetPriority() const = 0;
	virtual void SetPriority( int n ) = 0;
	//
	virtual bool IsPointInsideOfChildren( const CVec2 &vPoint ) = 0;
	// DRAWING
	virtual void Visit( interface IUIVisitor *pVisitor ) = 0;
	// dynamic behaviour
	virtual void Segment( const int timeDiff ) {  }
	//enabled / disabled
	virtual void Enable( const bool bEnable ) = 0;
	virtual bool IsEnabled() const = 0;
	// visible / invisible
	virtual void ShowWindow( const bool bShow ) = 0;
	virtual bool IsVisible() const = 0;
	// window's placement
	virtual void GetPlacement( int *pX, int *pY, int *pSizeX, int *pSizeY ) const = 0;

	virtual void SetPlacement( const float x, const float y, const float sizeX, const float sizeY, const DWORD flags ) = 0;
	virtual CTRect<int> GetPlacement() const = 0;
	virtual void SetPlacement( const CTRect<int> &rc, const DWORD flags ) = 0;
	//
	virtual bool IsInside( const CVec2 &vPos ) const = 0;
	//
	virtual const wstring &GetDBTooltipStr() const { static wstring wszEmpty; return wszEmpty; } // old function, need to be removed
	virtual void SetTooltip( const wstring &wszTooltip ) { };
	virtual void SetTooltipIDForMLHandler( int nID ) = 0;
	virtual int GetTooltipIDForMLHandler() const = 0;
	virtual void SetTooltip( IWindow *pTooltipWindow ) { }
	virtual IWindow *DemandTooltip() { return 0; }
	//
	virtual void AddChild( IWindow *pWnd, bool bDoReposition = false ) = 0;
	virtual int GetNumChildren() = 0;
	virtual IWindow *GetChild( int nIndex ) =0;
	virtual IWindow* GetChild( const string &_szName, const bool bRecursive = false ) = 0;
	virtual IWindow* GetVisibleChild( const string &_szName, const bool bRecursive = false ) = 0;
	// copy background from another window to this window
	virtual void CopyBackground( const IWindow *pSrcWnd ) = 0;
	// assign background texture for window
	virtual void SetTexture( const struct NDb::STexture *pDesc ) = 0;
	// after window being created, it must be initialized with data
	virtual void InitByDesc( const struct NDb::SUIDesc *pDesc ) = 0;
	virtual void RegisterObservers() = 0;
	virtual void SetOutline( const CDBID &outlineType=CDBID() ) {}
	virtual void SetTextString( const wstring &szText ) = 0;
	virtual const wchar_t *GetTextString() const = 0;
	virtual wstring GetDBText() const = 0;
	// get access to window context. may return 0 if window doesn't have context.
	virtual SWindowContext * GetContext() = 0;
	virtual void Init() = 0;
	virtual const struct NDb::SUIDesc * GetDesc() const = 0;
	virtual void FillWindowRect( CTRect<float> *pRect ) const = 0;
	virtual CTRect<float> GetWindowRect() const = 0;
	virtual IWindow* GetParentWindow() const = 0;
	virtual interface IScreen* GetScreen() = 0;
	virtual const struct NDb::SWindowShared * GetSharedDesc() const = 0;
	virtual void RemoveChild( IWindow *_pChild ) = 0;
	virtual IWindow* GetChild( const int _nTypeID, const int _nID, const bool bRecursive = false ) = 0;
	virtual const string& GetName() const = 0;
	virtual void SetName( const string &szName ) = 0;
	// must be called after load from binary file
	virtual void AfterLoad() { }

	virtual void SetFocus( const bool bFocus ) = 0;
	virtual bool IsFocused() const = 0;

	// fade entire control, fValue[0..1]
	virtual void SetFadeValue( float fValue ) = 0;
	virtual void SetBackground( interface IWindowPart *_pBackground ) {}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// console
interface IConsole : virtual public IWindow
{
};
// console strings (add to bottom, scroll automatically to the top)
interface IConsoleOutput : virtual public IWindow
{
	virtual void AddString( const wstring &szString, const DWORD color  ) = 0;
	virtual void Scroll( const int bUp ) = 0;
	virtual void ToBegin() = 0;
	virtual void ToEnd() = 0;
	virtual void ClearContent() = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IStatsSystemWindow : virtual public IWindow
{
	virtual void UpdateEntry( const wstring &szEntry, const wstring &szValue, const DWORD dwColor ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IButtonNotify : virtual public CObjectBase
{
	virtual void Released( class CWindow *pWho ) = 0;
	virtual void Pushed( class CWindow *pWho  ) = 0;
	virtual void Entered( class CWindow *pWho ) = 0;
	virtual void Leaved( class CWindow *pWho ) = 0;
	virtual void StateChanged( class CWindow *pWho ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IDataViewer : virtual public CObjectBase
{
	// Creates an interior for the "window" by the user data
	// Pass pData == 0 for make interior for empty context
	virtual void MakeInterior( CObjectBase *pWindow, const CObjectBase *pData ) const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// specific to button functionality
interface IButton : virtual public IWindow
{
	virtual void SetNotifySink( interface IButtonNotify *pNotify ) = 0;
	virtual bool IsPushed() const = 0;
	virtual void Enable( const bool bEnable ) = 0;
	virtual void SetNextState() = 0;
	virtual void SetState( const int nState ) = 0;
	virtual void SetStateWithVisual( const int nState ) = 0;
	virtual int GetState() const = 0;
	virtual class CButtonGroup* GetButtonGroup() = 0;
	virtual void SetButtonGroup( const int nGroup ) = 0;
	virtual void SetOutline( const CDBID &outlineType ) = 0;
	virtual void SetEffectSubState( const NDb::EButtonSubstateType eSubState, bool bEffect ) = 0;
	// Returns state index or -1
	virtual int GetState( const string &szName ) = 0;
};
// edit line
interface IEditLine : virtual public IWindow
{
	virtual void SetText( const wchar_t *pszText ) = 0;
	virtual void SetCursor( const int nPos ) = 0;
	virtual void SetSelection( const int nBegin, const int nEnd ) = 0;
	virtual const wchar_t * GetText() const = 0;
};
// window that has text must support this
interface ITextView : virtual public IWindow
{
	// we can retrieve pure formatting info etc.
	virtual const wstring& GetText() const = 0;
	// return true if height of window is updated
	virtual bool SetText( const wstring &szText ) = 0;
	virtual void SetWidth( const int nWidth ) = 0;
	virtual const CTPoint<int> GetSize() const = 0;
	virtual void SetIDForMLHandler( int nID ) = 0;
	virtual int GetIDForMLHandler() const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ISlider's owner extend this interface to be notified about slider events
interface ISliderNotify : virtual public CObjectBase
{
	// fPosition 0..1
	virtual void SliderPosition( const float fPosition, class CWindow *pWho ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface ISlider : virtual public IWindow
{
	//return true if lever is visible
	virtual bool IsLeverVisible() const = 0;
	virtual void SetRange( const float fMin, const float fMax, const float fPageSize ) = 0;
	virtual void GetRange( float *pMax, float *pMin ) const = 0;
	virtual void SetPos( const float fCur ) = 0;
	virtual float GetPos() const = 0;
	virtual void SetNotifySink( interface ISliderNotify *pNotify ) = 0;
	virtual bool IsHorisontal() const = 0;
	// mouse-wheel scrolling can be allowed or disallowed
	virtual void AllowMouseScrolling( const bool bAllow ) = 0;

	virtual void SetNSpecialPositions( int nPositions ) = 0;
	virtual int GetNSpecialPositions() = 0;
	virtual void SetSpecialPosition( int nPosition ) = 0;
	virtual int GetCurrentSpecialPosition() const = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// screen may implement reactions and checks to enable it's functionality
interface IProgrammedReactionsAndChecks : virtual public CObjectBase
{
	//{ for compatibility with old sources
	virtual bool NeedFlags() const { return false; }
	virtual bool Execute( const string &szSender, const string &szReaction ) { return false; }
	virtual int Check( const string &szCheckName ) const { return 0; }
	//}

	// new method, use it in new code
	virtual bool Execute( const string &szSender, const string &szReaction, WORD wKeyboardFlags ) { return false; }
	virtual int Check( const string &szCheckName, WORD wKeyboardFlags ) const { return 0; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// specific screen funcitonality
interface IScreen : virtual public IWindow
{
	virtual void OnGetFocus( const bool bFocus ) = 0;
	virtual void SetGView( NGScene::I2DGameView *_p2DGameView ) = 0;
	virtual void Load( const struct NDb::SUIDesc *pDesc, IProgrammedReactionsAndChecks *pReactionsAndChecks ) = 0;
	virtual void SetReactionsAndChecks( IProgrammedReactionsAndChecks *pReactionsAndChecks ) = 0;
	virtual void UpdateResolution() = 0;
	// set child window text
	virtual void SetWindowText( const string &szWindowName, const wstring &szText ) = 0;

	virtual void SetGView( NGScene::I2DGameView *_p2DGameView, NGScene::IGameView *_pGameView, NGScene::IGameView *_pInterface3DView ) = 0;
	virtual NGScene::IGameView *GetInterface3DView() = 0;

	virtual bool RunReaction( const string &szSender, const string &szReactionName ) = 0;
	virtual bool RunReaction( const string &szSender, const NDb::SUIDesc *pReaction ) = 0;
	
	// run animation sequience on provided window. return ID of animation
	virtual int /*AnimationID*/RunAnimationSequienceForward( const NDb::SUIStateSequence &seq, class CWindow *pWindow ) = 0;
	virtual void RunAnimationSequienceBack( const int nAnimationID ) = 0;

	// run szCmdSeq effect. if ID provided, then wait untill effect with this ID is finished, then run szCmdSeq.
	virtual void RunStateCommandSequience( const string &szCmdSeq, interface IWindow *pSequenceParent, SWindowContext *pContext, const bool bForward, const int nAnimationToWait = 0 ) = 0;
	// instantly undo command sequence (run in backward direction)
	virtual void UndoStateCommandSequence( const string &szCmdSeq ) = 0;

	// 
	virtual void RegisterEffect( const string &szEffect, const struct NDb::SUIStateSequence &cmds ) = 0;
	virtual void RegisterEffect( const string &szEffect, const vector<CDBPtr<NDb::SUIStateBase> > &cmds, const bool bReversable ) = 0;
	virtual void RegisterReaction( const string &szReactionKey, interface IMessageReactionB2 *pReaction ) = 0;

	virtual void RegisterToSegment( interface IWindow *pWnd, const bool bRegister ) = 0;
	virtual bool IsRegisteredToSegment( interface IWindow *pWnd ) const = 0;

	virtual void SetScreenSize( const CTRect<float> &rcScreen ) = 0;

	virtual IWindow* AddElement( const struct NDb::SUIDesc *pDesc ) = 0;
	virtual IWindow* GetElement( const string &szName, const bool bRecursive = false ) = 0;
	virtual IWindow* GetVisibleElement( const string &szName, const bool bRecursive = false ) = 0;
	
	virtual void SetTooltipContext( const int nContext ) = 0;
	virtual IWindow *CreateTooltipWindow( const wstring &wszTooltipText, IWindow *pTooltipOwner ) = 0;

	virtual void ProcessUIMessage( const struct SBUIMessage &cmd ) = 0;
	virtual void Reposition( IWindow *pWindow = 0 ) = 0;
	virtual class CButtonGroup * CreateButtonGroup( const int nID, IWindow *pButton, IWindow *pParent ) = 0;

	virtual const wstring &GetTextEntry( const string &szName ) const = 0; // Get "misc texts" entry by name
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// may contain any number of windows. scrolls them if needed
interface IScrollableContainer : virtual public IWindow
{
	virtual void InsertAfter( IWindow *pElement, IWindow *pInsert, const bool bSelectable ) = 0;
	virtual void Remove( IWindow *pRemove ) = 0;
	virtual void PushBack( IWindow *pElement, const bool bSelectable ) = 0;
	virtual void Update() = 0;
	virtual void Select( IWindow *pElement ) = 0;
	virtual IWindow *GetSelectedItem() const = 0;
	virtual IWindow *GetItem( const string &szName ) = 0;
	virtual void EnsureElementVisible( IWindow *pElement ) = 0;
	virtual int GetItemNumber( IWindow *pElement ) = 0;
	virtual void RemoveItems() = 0;			//remove all
	virtual void ResetScroller() = 0; // set scroller to initial pos
	// set the discrete scrolling (or reset it back to the smooth by set -1)
	// CRAP - should use after ANY container's changes
	virtual void SetDiscreteScroll( int nVisibleSlots ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface I1LvlTreeControl : virtual public IWindow
{
	virtual IWindow* AddItem() = 0;
	virtual IWindow* AddSubItem( IWindow *pItem ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// displays position.
// position range is [0.0f ... 1.0f]
interface IProgressBar : virtual public IWindow
{
	virtual void SetPosition( const float fPos ) = 0;
	virtual float GetPosition() const = 0;
	virtual void ShowFirstElement( bool bShow ) = 0;
	virtual void SetForward( const NDb::SBackground *pForward ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// displays positions for some units.
// position range is [0.0f ... 1.0f]
// can display solid bar or dotted bar
interface IMultiTextureProgressBar : virtual public IWindow
{
	virtual bool IsSolid() const = 0;
	virtual void GetPositions( vector<float> *pPositions ) const = 0;
	virtual void SetPositions( const vector<float> &positions, bool bSolid ) = 0;
};
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface ITooltip : virtual public IWindow
{
	// return position on screen
	// set GlobalVar( "TOOLTIP_X" & "TOOLTIP_Y" )
	virtual void InitTooltip( const CVec2 &vPos, const CTRect<float> &wndRect, const wstring &szText, 
		IScreen *pScreen, const int nTooltipWidth, const float fHorisontalToVerticalRatio, int nIDForMLHandler ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface ITabControl : virtual public IWindow
{
	virtual int GetNTabs() const = 0;
	virtual void SetActive( const int nTab ) = 0;
	virtual int GetActive() const = 0;
	// provide button name. it is ignored if no buttons in tab control.
	virtual void AddTab( const wstring &szButtonName ) = 0;
	virtual void AddElement( const int nTab, IWindow *pWnd ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// effect on interface
interface IUIEffector : public CObjectBase
{
	// effect may want to calculate something 
	// return consumed time. if time is completely consumed, return timeDiff
	// this needed for effect fast forward
	virtual const int Segment( const int timeDiff, interface IScreen *pScreen, const bool bFastForward ) = 0;
	// effect may want to draw somwthing
	virtual void Visit( interface IUIVisitor *pVisitor ) = 0;
	// effect is finished
	virtual bool IsFinished() const = 0;
	// configure effect with commad
	virtual void Configure( const NDb::SUIStateBase *pCmd, interface IScreen *pScreen, SWindowContext *pContext, const string &szAnimatedWindow ) = 0;
	// reversed effect ( that effect + effect->Reverse() = NULL );
	virtual void Reverse() = 0;
};
/////////////////////////////////////////////////////////////////////////////
// window part, such as background, foreground.
interface IWindowPart : public CObjectBase
{
	virtual void Visit( interface IUIVisitor *pVisitor ) = 0;

	// notify background about window position and size change
	virtual void SetPos( const CVec2 &vPos, const CVec2 &vSize ) = 0;
	virtual void InitByDesc( const struct NDb::SUIDesc *pDesc ) { NI_ASSERT(false,""); }
	virtual void SetTexture(const struct NDb::STexture *_pDesc) { NI_ASSERT( 0, "SetTexture works only with BackgroundSimpleTexture or BackgroundSimpleScalingTexture!!!"); }
	virtual void SetOutline( const CDBID &outlineType ) { NI_ASSERT( 0, "OutLine works only with BackgroundSimpleTexture!!!"); }
	virtual void Init() = 0;
	
	virtual void SetFadeValue( float fValue ) = 0;
};
/////////////////////////////////////////////////////////////////////////////
interface IListControlItem : virtual public IWindow
{
	virtual IWindow * GetSubItem( const int nSubItem ) = 0;
	
	virtual CObjectBase* GetUserData() const = 0;
	virtual void SetUserData( CObjectBase *pData ) = 0;
};
/////////////////////////////////////////////////////////////////////////////
// sorter for list control. user may define own one
interface IWindowSorter : public CObjectBase
{
	virtual bool Compare( IWindow *pSubItem1, IWindow *pSubItem2 ) = 0;
	virtual void SetDirection( const bool bAscending ) = 0;
	virtual void SetColumn( const int nColumn ) = 0;
	// 
	virtual bool IsAscending() const = 0;
};
/////////////////////////////////////////////////////////////////////////////
interface IListControl : virtual public IWindow
{
	virtual IListControlItem* AddItem() = 0; // CRAP - obsolete
	virtual IListControlItem* AddItem( CObjectBase *pData ) = 0;
	virtual void RemoveItem( IListControlItem *pItem ) = 0;

	virtual void Resort( const int nColumn = -1, const bool bAscending = true ) = 0;
	virtual void SetSorter( IWindowSorter *pSorter, const int nColumn ) = 0;

	virtual void SetViewer( IDataViewer *pViewer ) = 0;
	virtual void RemoveAllElements() = 0;
	
	virtual	const int GetNColumns() const = 0;
	virtual int GetItemCount() const = 0;
	virtual IListControlItem* GetSelectedListItem() const = 0;
	virtual void SelectItem( CObjectBase *pData ) = 0;
	
	virtual void Update() = 0;
};
/////////////////////////////////////////////////////////////////////////////
interface IDebugSingleton : public CObjectBase
{
	enum { tidTypeID = 0x11095440 };

	virtual interface IWindow * GetConsole() = 0;
	virtual interface IWindow * GetDebug() = 0;
	
	virtual void ShowDebugInfo( const bool bShow ) = 0;
	virtual void ShowStatsWindow( const bool bShow ) = 0;
	virtual interface IWindow * GetDebugInfoWindow( const int nWindow ) = 0;
	virtual interface IStatsSystemWindow * GetStatsWindow() = 0;
	virtual int operator&( IBinSaver &saver ) = 0;
};
IDebugSingleton *CreateDebugSingleton();
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IPlayer : virtual public IWindow
{
	virtual void SetSequence( const string &szFileName ) = 0;
	virtual void Play() = 0;
	virtual bool Stop() = 0;
	virtual bool Pause( bool bPause ) = 0;
	virtual bool IsPlaying() const = 0;
	virtual bool IsPaused() const = 0;
	virtual void SkipMovie() = 0;
	virtual void SkipSequence() = 0;

	virtual int GetCurrentFrame() const = 0;
	virtual void SetCurrentFrame( int nFrame ) = 0;
	virtual int GetNumFrames() const = 0;

	virtual void PlayFragment( int nStartFrame, int nEndFrame, int nFrameSkip = 0 ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IComboBox : virtual public IWindow
{
	// Creates item by user data
	virtual void AddItem( CObjectBase *pData ) = 0;
	// Removes item by user data
	virtual void RemoveItem( CObjectBase *pData ) = 0;
	virtual void RemoveAllItems() = 0;
	virtual int GetItemCount() const = 0;
	virtual IListControlItem* GetItem( int nIndex ) const = 0;
	// Returns index of the selected item or -1
	virtual int GetSelectedIndex() const = 0;
	virtual void Select( int nIndex ) = 0;

	virtual void SetViewer( IDataViewer *pViewer ) = 0;
	virtual void SetLine( CObjectBase *pData ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ���������� ��������� ������ ��� ������� ��������� ���� ���������������� ����, 
// ����� ���������� 0 � ������ ��������������
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ������ �������������� ��� ���������� ���� ������� ����
template<class TCheck>
inline TCheck* GetChildChecked( IWindow *pParent, const string &szName, const bool bRecursive )
{
	if ( !pParent )
		return 0;
	IWindow *pWnd = pParent->GetChild( szName, bRecursive );
	TCheck *pCheck = dynamic_cast<TCheck*>( pWnd );
	NI_ASSERT( !s_bUICommonShowWarnings || pCheck, StrFmt( "Window not found: \"%s\"", szName.c_str() ) );
	return pCheck;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif //_interfaceBase_h_included_
