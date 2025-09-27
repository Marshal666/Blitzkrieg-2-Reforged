#include "StdAfx.h"
#include "..\ui\commandparam.h"
#include "..\ui\dbuserinterface.h"
#include "..\misc\2darray.h"
#include "..\zlib\zconf.h"
#include "..\stats_b2_m1\iconsset.h"
#include "InterfaceNivalNet.h"
#include "GameXClassIDs.h"
#include "..\UI\SceneClassIDs.h"
#include "..\SceneB2\Scene.h"
#include "InterfaceState.h"
#include "InterfaceMisc.h"
#include "../Misc/StrProc.h"

#include <objbase.h>
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const int nMIN_PASSWORD = 4;
const int nMIN_USERNAME = 4;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CInterfaceNivalNet
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CInterfaceNivalNet::CInterfaceNivalNet() : 
	CInterfaceMPScreenBase( "MPNivalNet", "nival_net" ),
	eState( ES_NORMAL )
{
	REGISTER_MPUI_MESSAGE_HANDLER( EMUI_CONNECT_RESULT, SMPUIConnectResultMessage, OnConnectResultMessage );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CInterfaceNivalNet::~CInterfaceNivalNet()
{
	if ( pScreen ) 
		Scene()->RemoveScreen( pScreen );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::Init()
{
	if ( CInterfaceScreenBase::Init() == false ) 
		return false;

	RegisterObservers();

	// load screen
	pScreen = MakeObjectVirtual<IScreen>( UI_SCREEN );
	if ( AddUIScreen(pScreen, "MPNivalNet", this) == false )
		return false;
	
	pMain = GetChildChecked<IWindow>( pScreen, "Main", true );
	if ( !pMain )
		return false;
	
	MakeInterior();
	
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CInterfaceNivalNet::RegisterObservers()
{
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CInterfaceNivalNet::MakeInterior()
{
	pWaitWindow = GetChildChecked<IWindow>( pMain, "WaitWindow", true );
	pWaitWindow->ShowWindow( false );

	pFrameRegister = GetChildChecked<IWindow>( pMain, "Registration", true );
	pFrameLogin = GetChildChecked<IWindow>( pMain, "Login", true );
	pFrameRecovery = GetChildChecked<IWindow> ( pMain, "Recovery", true );
	
	pLogin = GetChildChecked<IButton>( pFrameLogin, "ButtonLogin", true );
	pBack = GetChildChecked<IButton>( pFrameLogin, "ButtonBack", true );
	pRegistration = GetChildChecked<IButton>( pFrameLogin, "ButtonRegister", true );
	//pRegistration->Enable( true );//
	pRecovery = GetChildChecked<IButton>( pFrameLogin, "ButtonRecovery", true );
	pRecovery->Enable( false );
	pRecovery->ShowWindow( false );

	pRegisterOk = GetChildChecked<IButton>( pFrameRegister, "ButtonRegisterOk", true );
	pRegisterCancel = GetChildChecked<IButton>( pFrameRegister, "ButtonBackRegistration", true );

	pRecoverCancel = GetChildChecked<IButton>( pFrameRecovery, "ButtonBackRecovery", true );
	pRecoverOk = GetChildChecked<IButton>( pFrameRecovery, "ButtonRecover", true );;

	pLoginLoginEdit = GetChildChecked<IEditLine>( pMain, "edit_login_login", true );
	pLoginPasswordEdit = GetChildChecked<IEditLine>( pMain, "edit_login_password", true );
	
	pUserNameRecovery = GetChildChecked<IEditLine>( pFrameRecovery, "edit_username_recovery", true );

	pCDKey = GetChildChecked<IEditLine>( pFrameRegister, "edit_CDKey", true );
	pConfirmEmail = GetChildChecked<IEditLine>( pFrameRegister, "edit_confirm_email", true );
	pConfirmPassword = GetChildChecked<IEditLine>( pFrameRegister, "edit_confirm_password", true );
	pEmail = GetChildChecked<IEditLine>( pFrameRegister, "edit_email", true );;
	pRegistrationPassword = GetChildChecked<IEditLine>( pFrameRegister, "edit_registration_password", true );
	pRegistrationUserName = GetChildChecked<IEditLine>( pFrameRegister, "edit_registration_username", true );

	pRememberPassword = GetChildChecked<IButton>( pFrameLogin, "ButtonRememberPassword", true );
	wstring wszStoredPassword = NGlobal::GetVar( "Multiplayer.NivalNet.StoredPassword", "" ).GetString();
	wstring wszStoredLogin = NGlobal::GetVar( "Multiplayer.NivalNet.StoredLogin", "" ).GetString();	
	pLoginLoginEdit->SetText( wszStoredLogin.c_str() );
	pLoginPasswordEdit->SetText( wszStoredPassword.c_str() );
	pRememberPassword->SetState( ( wszStoredLogin == L"" ) ? 0 : 1 );

	if ( pFrameRecovery )
		pFrameRecovery->ShowWindow( false );
	
	
	if ( pFrameRegister )
		pFrameRegister->ShowWindow( false );
	eState = ES_NORMAL;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CInterfaceNivalNet::UpdateInterior()
{
	pFrameLogin->ShowWindow( eState == ES_NORMAL || eState == ES_LOGIN );
	pFrameRegister->ShowWindow( eState == ES_REGISTER );
	pFrameRecovery->ShowWindow( eState == ES_RECOVER );
	switch ( eState )
	{
		case ES_NORMAL: 
		case ES_LOGIN: UpdateInteriorLogin();	break;
		case ES_REGISTER: UpdateInteriorRegister(); break;
		case ES_RECOVER: UpdateInteriorRecover(); 
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CInterfaceNivalNet::UpdateInteriorLogin()
{
	/*if ( pLogin )
		pLogin->Enable( eState == ES_NORMAL );
	if ( pBack )
		pBack->Enable( eState == ES_NORMAL || eState == ES_LOGIN );
	if ( pRegistration )
		pRegistration->Enable( eState == ES_NORMAL );
	if ( pRecovery )
		pRecovery->Enable( eState == ES_NORMAL );*/
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CInterfaceNivalNet::UpdateInteriorRegister()
{
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CInterfaceNivalNet::UpdateInteriorRecover()
{
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CInterfaceNivalNet::OnGetFocus( bool bFocus )
{
	CInterfaceScreenBase::OnGetFocus( bFocus );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::Execute( const string &szSender, const string &szReaction )
{
	if ( szReaction == "back" )
		return OnBackReaction( szSender );
		
	if ( szReaction == "login" )
		return OnLoginReaction( szSender );

	if ( szReaction == "login_register" )
	{		
		return OnLoginRegister();
	}
	if ( szReaction == "login_recovery" )
	{		
		return OnLoginRecovery();
	}

	if ( szReaction == "register" )
		return OnRegisterReaction( szSender );

	if ( szReaction == "register_ok" )
		return OnRegisterOkReaction( szSender );
	if ( szReaction == "register_cancel" )
		return OnRegisterCancelReaction( szSender );

	if ( szReaction == "recovery_ok" )
		return OnRecoveryOkReaction( szSender );
	if ( szReaction == "recovery_cancel" )
		return OnRecoveryCancelReaction( szSender );

	return false;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnLoginRegister()
{
	eState = ES_REGISTER;
//	DebugTrace("Register");
	UpdateInterior();
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnLoginRecovery()
{
	/*eState = ES_RECOVER;
//	DebugTrace("Recovery");
	UpdateInterior();*/
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CInterfaceNivalNet::Check( const string &szCheckName ) const
{
	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnConnectResultMessage( SMPUIConnectResultMessage *pMsg )
{
	if ( pMsg->bSuccess )
	{
		NMainLoop::Command( ML_COMMAND_PREVIOUS_MENU, "" );
		NMainLoop::Command( ML_COMMAND_MP_GAME_LOBBY, "" );
		return true;
	}
	else
	{
		// Hide "connecting"
		pWaitWindow->ShowWindow( false );

		eState = ES_NORMAL;
		NMainLoop::Command( ML_COMMAND_MESSAGE_BOX, 
			CICMessageBox::MakeConfigString( "MessageBoxWindowOk", 
			GetScreen()->GetTextEntry( pMsg->szTextTag ) ).c_str() );
	}

	UpdateInterior();
	
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnBackReaction( const string &szSender )
{
	Singleton<IMPToUIManager>()->AddUIMessage( EMUI_NO_NET );

	NMainLoop::Command( ML_COMMAND_PREVIOUS_MENU, "" );
	NMainLoop::Command( ML_COMMAND_MULTIPLAYER_MENU, "" );
	
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnLoginReaction( const string &szSender )
{
	if ( pLoginLoginEdit && pLoginPasswordEdit )
	{
		wstring wszLogin = pLoginLoginEdit->GetText();
		if ( wszLogin.empty() )
		{
			NMainLoop::Command( ML_COMMAND_MESSAGE_BOX, CICMessageBox::MakeConfigString( "MessageBoxWindowOk", 
				GetScreen()->GetTextEntry( "CONNECT_ERR_NO_NICK" ) ).c_str() );
			return true;
		}

		// Show "connecting"
		pWaitWindow->ShowWindow( true );

		eState = ES_LOGIN;
		Singleton<IMPToUIManager>()->AddUIMessage( new SMPUILoginNivalNetMessage( 
			wszLogin, pLoginPasswordEdit->GetText(), ( pRememberPassword->GetState() == 1 ) ) );

		UpdateInterior();
	}

	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnRegisterReaction( const string &szSender )
{
	eState = ES_REGISTER;

	if ( pFrameRegister )
		pFrameRegister->ShowWindow( true );

	UpdateInterior();

	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::CheckRegistrationData( string &szReason )
{
	if ( !pRegistrationPassword || !pRegistrationUserName || !pEmail || !pConfirmPassword || !pConfirmEmail || !pCDKey )
	{
		szReason = "REGISTER_ERR_UNKNOWN";
		return false;
	}
	wstring szName = pRegistrationUserName->GetText();
	if ( szName.size() < nMIN_USERNAME )
	{
		szReason = "REGISTER_ERR_NICK_TOO_SHORT";
		return false;
	}
	wstring szPass1 = pRegistrationPassword->GetText();
	wstring szPass2 = pConfirmPassword->GetText();
	if ( szPass1.size()< nMIN_PASSWORD || szPass2.size()< nMIN_PASSWORD )
	{
		szReason = "REGISTER_ERR_PASSWORD_TOO_SHORT";
		return false;
	}
	if ( szPass1 != szPass2 )
	{
		szReason = "REGISTER_ERR_PASSWORDS_DIFFER";
		return false;
	}
	wstring wszEmail1 = pEmail->GetText();
	wstring wszEmail2 = pConfirmEmail->GetText();
	if ( wszEmail1 != wszEmail2 )
	{
		szReason = "REGISTER_ERR_EMAILS_DIFFER";
		return false;
	}
	if ( wszEmail1.size() == 0 || wszEmail2.size() == 0 ) 
	{
		szReason = "REGISTER_ERR_NO_EMAIL";
		return false;
	}
	if ( !IsEmailValid( wszEmail1 ) )
	{
		szReason = "REGISTER_ERR_BAD_EMAIL";
		return false;
	}

	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::IsEmailValid( const wstring &wszEmail )
{
	string szEmail = NStr::ToMBCS( wszEmail );
	vector<string> parts;
	NStr::SplitString( szEmail, &parts, '@' );
	if ( parts.size() != 2 )
		return false;

	if ( parts[0].empty() || parts[1].empty() )
		return false;
	
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnRegisterOkReaction( const string &szSender )
{
	string szRejectReasonCode;
	if ( !CheckRegistrationData( szRejectReasonCode ) )
	{
		NMainLoop::Command( ML_COMMAND_MESSAGE_BOX, CICMessageBox::MakeConfigString( "MessageBoxWindowOk", 
			GetScreen()->GetTextEntry( szRejectReasonCode ) ).c_str() );
		return true;
	}

	wstring wszPass = pRegistrationPassword->GetText();
	wstring wszName = pRegistrationUserName->GetText();
	wstring wszEmail = pEmail->GetText();

	string szGUID;
	GUID guidCDKey;
	CoCreateGuid( &guidCDKey );
	NStr::GUID2String( &szGUID, guidCDKey );
	wstring wszCDKey = NStr::ToUnicode( szGUID ); //pCDKey->GetText();

	Singleton<IMPToUIManager>()->AddUIMessage( new SMPUIRegisterMessage( wszName, wszPass, wszCDKey, wszEmail ) );
	eState = ES_NORMAL;

	UpdateInterior();

	// Show "connecting"
	pWaitWindow->ShowWindow( true );

	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnRegisterCancelReaction( const string &szSender )
{
	eState = ES_NORMAL;
	UpdateInterior();

	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnRecoveryCancelReaction( const string &szSender )
{
	eState = ES_NORMAL;

	UpdateInterior();

	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::OnRecoveryOkReaction( const string &szSender )
{
	
	wstring text;
	if ( pUserNameRecovery )
		text = pUserNameRecovery->GetText();
	// validate text
	if ( text.empty() )
	{
		NMainLoop::Command( ML_COMMAND_MESSAGE_BOX, 
			CICMessageBox::MakeConfigString( "MessageBoxWindowOk", 
			wstring( L"Error: Empty user name" ) ).c_str() );
		return true;
	}
	//Singleton<IMPToUIManager>()->AddUIMessage( new SMPUIRecoverPasswordMessage( text ) );

	eState = ES_NORMAL;
	UpdateInterior();

	return true;
}//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CInterfaceNivalNet::ProcessEvent( const SGameMessage &msg )
{
	return CInterfaceScreenBase::ProcessEvent( msg );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CInterfaceNivalNet::AfterLoad()
{
	CInterfaceScreenBase::AfterLoad();

	RegisterObservers();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef _SINGLE_DEMO
// CICNivalNet
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CICNivalNet::PreCreate()
{
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CICNivalNet::PostCreate( IInterface *pInterface )
{
	NMainLoop::PushInterface( pInterface );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CICNivalNet::Configure( const char *pszConfig )
{
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
REGISTER_SAVELOAD_CLASS( 0x17132441, CInterfaceNivalNet );
REGISTER_SAVELOAD_CLASS( ML_COMMAND_NIVAL_NET_MENU, CICNivalNet );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // _SINGLE_DEMO