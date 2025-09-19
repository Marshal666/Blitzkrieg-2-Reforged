using System;
using System.IO;
using System.Diagnostics;

class CWatcher
{
	FileSystemWatcher fileWatcher;
	CChangesList changesList;

	private void OnRenamed( object source, RenamedEventArgs	args )
	{
		string szOldName = args.OldName.Replace( @"\", "/" );
		string szName = args.Name.Replace( @"\", "/" );
		Trace.WriteLine( "renamed: " + szOldName + " -> " + szName );

		changesList.Renamed( args.OldName, args.Name );
	}

	private void OnCreated( object source, FileSystemEventArgs args )
	{
		string szName = args.Name.Replace( @"\", "/" );
		Trace.WriteLine( "created: " + szName );
		changesList.Created( szName );
	}

	private void OnDeleted( object source, FileSystemEventArgs args )
	{
		string szName = args.Name.Replace( @"\", "/" );
		Trace.WriteLine( "deleted: " + szName );
		changesList.Deleted( szName );
	}

	private void OnChanged( object source, FileSystemEventArgs args )
	{
		string szName = args.Name.Replace( @"\", "/" );
		Trace.WriteLine( "changed: " + szName );
		changesList.Changed( szName );
	}

	private void OnError( object senter, ErrorEventArgs args  )
	{
		Trace.WriteLine( "Error: " + args.ToString() );
	}

	public CWatcher( string szWatchDir, CChangesList _changesList )
	{
		changesList = _changesList;
		
		fileWatcher = new FileSystemWatcher( szWatchDir, @"*.*" );
		fileWatcher.InternalBufferSize += 8192 * 3;
		
		fileWatcher.IncludeSubdirectories = true;
		fileWatcher.NotifyFilter = NotifyFilters.FileName | NotifyFilters.DirectoryName | NotifyFilters.LastWrite;

		fileWatcher.Renamed += new RenamedEventHandler( this.OnRenamed );
		fileWatcher.Deleted += new FileSystemEventHandler( this.OnDeleted );
		fileWatcher.Created += new FileSystemEventHandler( this.OnCreated );
		fileWatcher.Changed += new FileSystemEventHandler( this.OnChanged );
		
		fileWatcher.Error += new ErrorEventHandler( this.OnError );

		fileWatcher.EnableRaisingEvents = true;
	}
}
