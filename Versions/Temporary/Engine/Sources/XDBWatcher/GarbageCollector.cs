using System.Diagnostics;
using System.Threading;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CGarbageCollector
{
	private int nAllowCounter = 0;
	private Thread collectGarbageThread;
	private CXDB xDB;
	
	public CGarbageCollector()
	{
	}

	public void SetXDB( CXDB _xDB )
	{
		xDB = _xDB;
	}

	public void ForbidGarbageCollection()
	{
		lock( this )
		{
			--nAllowCounter;

			if ( collectGarbageThread != null )
			{
				collectGarbageThread.Abort();
				collectGarbageThread = null;
			}
		}
	}

	public void AllowGarbageCollection()
	{
		lock( this )
		{
			++nAllowCounter;
			Debug.Assert( nAllowCounter <= 0, "Wrong allow counter" );

			if ( nAllowCounter == 0 )
			{
				collectGarbageThread = new Thread( new ThreadStart( xDB.CollectGargabe ) );
				collectGarbageThread.Priority = ThreadPriority.BelowNormal;
				collectGarbageThread.Start();
			}
		}
	}

	public bool IsGarbageCollectionForbidden()
	{
		return nAllowCounter < 0;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

