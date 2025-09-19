using System;
using System.Collections;
using System.Threading;

class CDBFixer
{
	private CChangesList changesList;
	private ArrayList changes;
	private CXDB xDB;
	private string szRootDir;
	private CGarbageCollector garbageCollector;
	private bool bPause;
	private bool bCanSetPause;

	public CDBFixer( CChangesList _changesList, CXDB _xDB, string _szRootDir, CGarbageCollector _garbageCollector )
	{
		changesList = _changesList;
		changes = new ArrayList();
		xDB = _xDB;
		szRootDir = _szRootDir;
		garbageCollector = _garbageCollector;
		bCanSetPause = false;
	}
	public void Pause( bool _bPause )
	{
		bPause = _bPause;
		if ( !bPause )
			changesList.newChangesEvent.Set();
	}
	public bool CanSetPause()
	{
		return bCanSetPause;
	}
	public bool IsLoading()
	{
		return !bCanSetPause;
	}

	public void MainFunc()
	{
		try
		{
			xDB.LoadDB();

			bCanSetPause = true;
			while ( true )
			{
				changesList.newChangesEvent.WaitOne();
				lock( xDB )
				{
					garbageCollector.ForbidGarbageCollection();

					int nChange = 0;
					bool bCanFinish = false;
					while ( !bCanFinish && !bPause )
					{
						bCanFinish = true;

						changesList.CopyAndClearChanges( changes );
						CChangesList.MarkDeleted( changes );
						while ( nChange < changes.Count )
						{
							CChangesList.CChange change = (CChangesList.CChange)changes[nChange];
							try
							{
								if ( !change.bDeleted )
								{
									if ( change.eChangeType == CChangesList.CChange.EChangeType.CT_CREATED || change.eChangeType == CChangesList.CChange.EChangeType.CT_CHANGED )
										xDB.Read( szRootDir + "/" + change.szName );
									else if ( change.eChangeType == CChangesList.CChange.EChangeType.CT_DELETED )
										xDB.Remove( szRootDir + "/" + change.szName );
								}
							}
							catch ( System.IO.IOException )
							{
								bCanFinish = false;
								break;
							}
							catch ( UnauthorizedAccessException )
							{
								bCanFinish = false;
								break;
							}
							catch ( System.Xml.XmlException )
							{
								bCanFinish = false;
								break;
							}

							++nChange;
						}

						Thread.Sleep( 100 );
					}

					if ( bCanFinish )
						changes = new ArrayList();
					garbageCollector.AllowGarbageCollection();
				}
			}
		}
		finally
		{
			garbageCollector.ForbidGarbageCollection();
		}
	}
};
