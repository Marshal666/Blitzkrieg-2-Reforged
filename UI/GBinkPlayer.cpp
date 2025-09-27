#include "StdAfx.h"
#include "../3DMotor/GfxBuffers.h"
#include "../vendor/Bink/bink.h"
#include "../vendor/fmod/api/inc/fmod.h"
#include <mmreg.h>
#include <dsound.h>
#include "GBinkPlayer.h"
#include "../System/VFSOperations.h"

#pragma comment(lib, "binkw32.lib")
#pragma comment(lib, "fmodvc.lib")
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NGScene
{
////////////////////////////////////////////////////////////////////////////////////////////////////
// CBinkVideoPlayer
////////////////////////////////////////////////////////////////////////////////////////////////////
class CBinkVideoPlayer: public IVideoPlayer
{
	OBJECT_NOCOPY_METHODS(CBinkVideoPlayer);
private:
	HBINK hBink;
	CDataStream *pStream;
	ZDATA
	bool bForceUpdate;
	bool bStopped;
	DWORD dwCopyFlags;
	DWORD dwPlayFlags;
	/////
	string szFileName;
	bool bNeedUpdate;		// BinkWait returned 0
	int nEndFrame;
	int nFrameSkip;
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&bForceUpdate); f.Add(3,&bStopped); f.Add(4,&dwCopyFlags); f.Add(5,&dwPlayFlags); f.Add(6,&szFileName); f.Add(7,&bNeedUpdate); f.Add(8,&nEndFrame); f.Add(9,&nFrameSkip); return 0; }

protected:
	void Recalc();
	bool NeedUpdate();

	bool OpenBink( const char *pszFileName );
	bool DoOneFrame( bool bCheckForStop = true );
	void CopyRects();

public:
	CBinkVideoPlayer();
	CBinkVideoPlayer( const string &szFileName, DWORD dwFlags );
	virtual ~CBinkVideoPlayer();

	void Play();
	bool Stop();
	bool Pause( bool bPause );
	bool IsPlaying() const;

	int GetCurrentFrame() const;
	void SetCurrentFrame( int nFrame );

	int GetLength() const;
	int GetNumFrames() const;
	void GetSize( CTPoint<int> *pSize ) const;

	virtual void PlayFragment( int nStartFrame, int _nEndFrame, int _nFrameSkip = 0 );
};
////////////////////////////////////////////////////////////////////////////////////////////////////
IVideoPlayer* CreateVideoPlayer( const string &szFileName, DWORD dwFlags )
{
	return new CBinkVideoPlayer( szFileName, dwFlags );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
CBinkVideoPlayer::CBinkVideoPlayer():
	hBink( 0 ), bStopped( false ), bForceUpdate( false ), dwCopyFlags( 0 ), dwPlayFlags( 0 ),
	bNeedUpdate( false ), nEndFrame( -1 ), nFrameSkip( 0 ), pStream( 0 )
{
}
////////////////////////////////////////////////////////////////////////////////////////////////////
CBinkVideoPlayer::CBinkVideoPlayer( const string &_szFileName, DWORD _dwFlags ):
	szFileName( _szFileName ), dwPlayFlags( _dwFlags ), 
	bStopped( false ), bForceUpdate( false ), hBink( 0 ), dwCopyFlags( 0 ), bNeedUpdate( false ), 
	nEndFrame( -1 ), nFrameSkip( 0 ), pStream( 0 )
{
}
////////////////////////////////////////////////////////////////////////////////////////////////////
CBinkVideoPlayer::~CBinkVideoPlayer()
{
	if ( hBink ) 
		BinkClose( hBink );

	if ( pStream )
		delete pStream;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
int CBinkVideoPlayer::GetCurrentFrame() const
{
	if ( !IsPlaying() ) 
		return -1;
	return hBink->FrameNum;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CBinkVideoPlayer::SetCurrentFrame( int nFrame )
{
	//ASSERT( IsPlaying() );
	if ( !IsPlaying() ) 
		return;

	BinkGoto( hBink, nFrame, 0 );
	Updated();
	bForceUpdate = true;

	if ( ( dwPlayFlags & PLAY_NO_TIME_UPDATE ) != 0 )
	{
		// "SlideShow" mode
		while ( BinkWait( hBink )	!= 0 )
		{
			Sleep( 0 );
		}
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CBinkVideoPlayer::Play()
{
	//ASSERT( !IsPlaying() );

	/*
	if ( bLoop )
		dwPlayFlags |= IVideoPlayer::PLAY_LOOPED;
	else
		dwPlayFlags &= ~IVideoPlayer::PLAY_LOOPED;
		*/

	if ( dwPlayFlags & IVideoPlayer::PLAY_WITH_SOUND )
	{
		LPDIRECTSOUND pDS = reinterpret_cast<LPDIRECTSOUND>( FSOUND_GetOutputHandle() );
		if ( pDS != 0 ) 
		{
			s32 sRet = BinkSoundUseDirectSound( pDS );
			ASSERT( sRet );
		}
	}

	if ( OpenBink( szFileName.c_str() ) == false ) 
		return;

	// for non-multiple to 16 movies do COPY ALL
	if ( ( ( hBink->Width % 16 ) != 0 ) || ( ( hBink->Height % 16 ) != 0 ) )
	{
		DebugTrace( "WARNING: movie \"%s\" has non-multiple to 16 size (%d : %d)!\n", szFileName.c_str(), hBink->Width, hBink->Height );
		dwCopyFlags |= BINKCOPYALL;
	}
	if ( dwPlayFlags & IVideoPlayer::COPY_ALL ) 
		dwCopyFlags |= BINKCOPYALL;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
bool CBinkVideoPlayer::Stop()
{
	if ( hBink ) 
	{
		BinkClose( hBink );
		hBink = 0;
		if ( pStream )
			delete pStream;
		pStream = 0;
	}

	return true;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
bool CBinkVideoPlayer::Pause( bool bPause )
{
	if ( hBink == 0 ) 
		return false;

	return BinkPause( hBink, bPause );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
bool CBinkVideoPlayer::IsPlaying() const
{
	return ( hBink != 0 ) && !bStopped;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
int CBinkVideoPlayer::GetLength() const
{
	ASSERT( hBink );
	return ( hBink != 0 ) && ( hBink->FrameRate > 0 ) ? 1000 * hBink->Frames / hBink->FrameRate : 0;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
int CBinkVideoPlayer::GetNumFrames() const
{
	ASSERT( hBink );
	return hBink != 0 ? hBink->Frames : 0;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CBinkVideoPlayer::GetSize( CTPoint<int> *pSize ) const
{
	ASSERT( pSize );
	if ( hBink == 0 ) 
	{
		pSize->x = 0;
		pSize->y = 0;
		return;
	}

	pSize->x = hBink->Width;
	pSize->y = hBink->Height;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// Internal functions
////////////////////////////////////////////////////////////////////////////////////////////////////
void CBinkVideoPlayer::Recalc()
{
	if ( hBink == 0 ) 
		return;

	if ( !IsValid( pValue ) )
	{
		CTPoint<int> sSize( GetNextPow2( hBink->Width ), GetNextPow2( hBink->Height ) );
		if ( NGfx::Is16BitTextures() )
			pValue = NGfx::MakeTexture( sSize.x, sSize.y, 1, NGfx::SPixel1555::ID, NGfx::DYNAMIC_TEXTURE, NGfx::CLAMP );
		else
			pValue = NGfx::MakeTexture( sSize.x, sSize.y, 1, NGfx::SPixel8888::ID, NGfx::DYNAMIC_TEXTURE, NGfx::CLAMP );
	}
	if ( !IsValid( pValue ) )
		return;

	bool bFrameUpdated = false;
	if ( ( dwPlayFlags & IVideoPlayer::PLAY_NO_TIME_UPDATE ) == 0 )
	{
		while ( !bStopped && bNeedUpdate )
		{
			bFrameUpdated = true;
			BinkDoFrame( hBink );
			BinkNextFrame( hBink );

			if ( nEndFrame >= 0 )
			{
				for ( int i = 0; i < nFrameSkip && hBink->FrameNum < nEndFrame; ++i )
					BinkNextFrame( hBink );

				if ( hBink->FrameNum == nEndFrame )
				{
					Pause( true );
					nEndFrame = -1;
					nFrameSkip = 0;
					bFrameUpdated = false;
					bForceUpdate = true;
					break;
				}
			}

			bNeedUpdate = ( BinkWait( hBink ) == 0 );

			if ( ( ( dwPlayFlags & IVideoPlayer::PLAY_LOOPED ) == 0 ) && ( hBink->FrameNum == hBink->Frames ) )
				bStopped = true;
		}
	}

	if ( bForceUpdate && !bFrameUpdated )
		BinkDoFrame( hBink );

	if ( NGfx::Is16BitTextures() )
	{
		NGfx::CTextureLock<NGfx::SPixel1555> sLock( pValue, 0, NGfx::INPLACE );
		int nRet = BinkCopyToBuffer( hBink, (void*)(&sLock[0][0]), sLock.GetStride(), hBink->Height, 0, 0,  dwCopyFlags | BINKSURFACE5551 );
//		ASSERT( nRet == 0 );
	}
	else
	{
		NGfx::CTextureLock<NGfx::SPixel8888> sLock( pValue, 0, NGfx::INPLACE );
		int nRet = BinkCopyToBuffer( hBink, (void*)(&sLock[0][0]), sLock.GetStride(), hBink->Height, 0, 0,  dwCopyFlags | BINKSURFACE32A );
//		ASSERT( nRet == 0 );
	}

	bForceUpdate = false;
	bNeedUpdate = false;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
bool CBinkVideoPlayer::NeedUpdate()
{
	if ( BinkWait( hBink ) == 0 || bForceUpdate )
	{
		// Set NeedUpdate flag
		bNeedUpdate = true;
		return true;
	}
	return false;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
bool CBinkVideoPlayer::OpenBink( const char *pszFileName )
{
	DWORD dwOpenFlags = BINKSURFACE32A | BINKALPHA | BINKNOSKIP;
//	if ( dwPlayFlags & IVideoPlayer::PLAY_FROM_MEMORY ) 
	{
		if ( pStream )
			delete pStream;
		pStream = 0;

		pStream = NVFS::GetMainVFS()->OpenFile( szFileName );
		if ( !pStream || !pStream->IsOk() || !pStream->CanRead() )
			return false;

		hBink = BinkOpen( (char*)(pStream->GetBuffer()), dwOpenFlags | BINKFROMMEMORY );
	}
//	else
//		hBink = BinkOpen( pszFileName, dwOpenFlags /*| BINKPRELOADALL*/ );

	if ( hBink != 0 )
	{
		const float fSFXMasterVolume = NGlobal::GetVar( "Sound.SFXVolume", 1.0f );
		s32 nVolume = 32768 * fSFXMasterVolume;
		BinkSetVolume( hBink, 0, nVolume );
	}

	return hBink != 0;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CBinkVideoPlayer::PlayFragment( int nStartFrame, int _nEndFrame, int _nFrameSkip )
{
	if ( !IsPlaying() )
		Play();

	if ( !IsPlaying() )		
		return;			// Something went wrong

	int nStart = Clamp( nStartFrame, 0, int( hBink->Frames - 1 ) );
	nEndFrame = Clamp( _nEndFrame, nStart, int( hBink->Frames - 1 ) );
	SetCurrentFrame( nStart );
	nFrameSkip = _nFrameSkip;
	Pause( false );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
} // namespace
////////////////////////////////////////////////////////////////////////////////////////////////////
using namespace NGScene;
REGISTER_SAVELOAD_CLASS( 0xB3320170, CBinkVideoPlayer );
