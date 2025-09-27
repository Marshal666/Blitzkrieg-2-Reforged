#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "netaddress.h"
#include "NetDriver.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NNet
{
	class CLinksManagerCommon : public ILinksManager
	{
		SOCKET s;
		CNodeAddress broadcastAddr;
	protected:
		virtual bool IsGoodAddress( const sockaddr &addr ) const { return true; }
	public:
		CLinksManagerCommon();
		~CLinksManagerCommon();
		bool Init( const int nPort );

		virtual bool MakeBroadcastAddr( class CNodeAddress *pRes, int nPort ) const;
		virtual bool IsLocalAddr( const CNodeAddress &test ) const;
		virtual bool Send( const CNodeAddress &dst, CMemoryStream &pkt ) const;
		virtual bool Recv( class CNodeAddress *pSrc, CMemoryStream *pPkt ) const;
		virtual bool GetSelfAddress( class  CNodeAddressSet *pRes ) const;
	};
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
