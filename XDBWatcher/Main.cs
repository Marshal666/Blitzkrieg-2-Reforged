using System;
using System.Windows.Forms;
using System.Threading;
using System.Xml;

public class CMain
{
	static Thread dbFixerThread;

	private static string GetWatchDir()
	{
		XmlTextReader xmlReader = null;
		try
		{
			xmlReader = new XmlTextReader( "xdbWatcher.xml" );
			xmlReader.MoveToContent();

			while ( xmlReader.Read() )
			{
				xmlReader.MoveToContent();
				string szElement = xmlReader.Name;
				if ( szElement == "WatchDir" )
					return xmlReader.ReadInnerXml();
			}

			MessageBox.Show( "can't find WatchDir in xdbWatcher.xml" );
			return "";
		}
		catch ( XmlException e )
		{
			MessageBox.Show( "error reading xdbWatcher.xml: " + e.Message );
			return "";
		}
		catch ( System.IO.FileNotFoundException e )
		{
			MessageBox.Show( "error reading xdbWatcher.xml: " + e.Message );
			return "";
		}
		finally
		{
			if ( xmlReader != null )
				xmlReader.Close();
		}
	}

	public static void Main()
	{
		bool bCreatedNewMutex = false;
		Mutex mutWatching = new Mutex( true, "Nival.XDBWatcher.67589847-c848-4db4-82dc-56384a1c1f3b", out bCreatedNewMutex );

		if ( bCreatedNewMutex == false )
			return;

		string szWatchDir = GetWatchDir();
		if ( szWatchDir == "" )
			return;

		try
		{
			CChangesList changesList = new CChangesList();
			CWatcher watcher = new CWatcher( szWatchDir, changesList );

			CGarbageCollector garbageCollector = new CGarbageCollector();
			CXDB xDB = new CXDB( szWatchDir, garbageCollector );
			CDBFixer dbFixer = new CDBFixer( changesList, xDB, szWatchDir, garbageCollector );
			garbageCollector.SetXDB( xDB );

			dbFixerThread = new Thread( new ThreadStart( dbFixer.MainFunc ) );
			dbFixerThread.Start();

			CNotifyIconAppContext applicationContext = new CNotifyIconAppContext( szWatchDir, xDB, dbFixer );
			CRemoteHost host = new CRemoteHost( xDB, applicationContext );

			Application.Run(applicationContext);

			dbFixerThread.Abort();
		}
		finally
		{
			mutWatching.ReleaseMutex();
		}
	}
}
