using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Tcp;

class CRemoteHost
{
	private TcpChannel channel;
	WellKnownServiceTypeEntry remObj;

	public CRemoteHost( CRefsAnswerer refsAnswerer, CPause pause )
	{
		CRemoteRefsAnswerer.refsAnswerer = refsAnswerer;
		CRemoteRefsAnswerer.pause = pause;

		channel = new TcpChannel( 4300 );
		ChannelServices.RegisterChannel( channel );

		remObj = new WellKnownServiceTypeEntry( typeof(CRemoteRefsAnswerer), "CRemoteRefsAnswerer", WellKnownObjectMode.SingleCall );
 		RemotingConfiguration.RegisterWellKnownServiceType( remObj ); 
	}
};
