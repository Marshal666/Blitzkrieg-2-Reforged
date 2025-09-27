#include "stdAfx.h"
#include "EffectorRunReaction.h"

REGISTER_SAVELOAD_CLASS(0x11075C04,CEffectorRunReaction)
/////////////////////////////////////////////////////////////////////////////
int CEffectorRunReaction::operator&( IBinSaver &saver )
{
	saver.Add( 1, &szFwd );
	saver.Add( 2, &bFinished );
	saver.Add( 3, &bForward );
	saver.Add( 4, &szBack );
	saver.Add( 5, &szAnimatedWindow );
	return 0;
}
/////////////////////////////////////////////////////////////////////////////
bool CEffectorRunReaction::IsFinished() const 
{ 
	return bFinished; 
}
/////////////////////////////////////////////////////////////////////////////
void CEffectorRunReaction::Configure( const NDb::SUIStateBase *_pCmd, interface IScreen *pScreen, SWindowContext *pContext, const string &_szAnimatedWindow ) 
{ 
	szAnimatedWindow = _szAnimatedWindow;
	const NDb::SUISRunReaction *pCmd( checked_cast<const NDb::SUISRunReaction*>( _pCmd ) );
	CParam<string> szReactionF( pCmd->szReactionForward );
	CParam<string> szReactionB( pCmd->szReactionBack );
	if ( pContext )
	{
		szReactionF.Merge( pContext->szReactionForward );
		szReactionB.Merge( pContext->szReactionBack );
	}
//	NI_ASSERT( szReactionB.IsValid(), "back reaction is invalid" );
//	NI_ASSERT( szReactionF.IsValid(), "forward reaction is invalid" );
	
	szFwd = szReactionF.Get();
	szBack = szReactionB.Get();

	bFinished = false;
	bForward = true;
}
/////////////////////////////////////////////////////////////////////////////
const int CEffectorRunReaction::Segment( const int timeDiff, interface IScreen *pScreen, const bool bFastForward ) 
{ 
	// to do RUN COMMAND cmd.szParam
	// in messageReaction
	// this effect is instant
	if ( bForward ? !szFwd.empty() : !szBack.empty() )
	{
		const string &szReactionName = bForward ? szFwd : szBack;
		pScreen->RunReaction( szAnimatedWindow, szReactionName );
	}
	bFinished = true;
	return 0;
}
/////////////////////////////////////////////////////////////////////////////
void CEffectorRunReaction::Reverse()
{
	bForward = !bForward;
	bFinished = false;
}
/////////////////////////////////////////////////////////////////////////////
