#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ServerClientInterface.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CServerClient : public IServerClient
{
	OBJECT_NOCOPY_METHODS( CServerClient )

	CPtr<class CNet> pNet;

	list< CPtr<class CPacketProcessor> > processors;
	list< CPtr<class CNetPacket> > packets;

	CPtr<class CPlayGameProcessor> pPlayGameProcessor;

	// debug pause
	bool bDebugPaused;
	list< CPtr<class CNetPacket> > pausedPackets;

	struct SPausedGamePacket
	{
		CPtr<class CNetPacket> pPacket;
		bool bBroadcast;

		SPausedGamePacket() : bBroadcast( false ) { }
		SPausedGamePacket( class CNetPacket *_pPacket, bool _bBroadcast )
			: pPacket( _pPacket ), bBroadcast( _bBroadcast ) { }
	};
	list<SPausedGamePacket> pausedGamePackets;
	int nTimeOut;

	void PushPacket( class CNetPacket *pPacket );
	void GetPacketsFromNet();
public:
	CServerClient() { }
	CServerClient( const char* pServerIPAddress, const int nNetGameVersion, const int nServerPort, const int _nTimeOut );
	~CServerClient();

	virtual class CNetPacket* GetPacket();
	virtual void SendPacket( class CNetPacket *pPacket );
	virtual void SendGamePacket( class CNetPacket *pPacket, bool bBroadcast );

	virtual void Segment();

	// debug functions
	void TogglePause( bool bPause );
	void TogglePauseServerConnection( bool bPause );
	void TogglePauseAcceptGamers( bool bPause );
	void TogglePauseConnectGamer( const int nGamer, bool bPause );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
