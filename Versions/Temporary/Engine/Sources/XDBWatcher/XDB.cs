using System;
using System.Collections;
using System.Collections.Specialized;
using System.IO;
using System.Text;
using System.Xml;
using System.Threading;
using System.Diagnostics;

class CXDB : CRefsAnswerer
{
	private static bool ListContains( ArrayList list, long nEl )
	{
		for ( int i = 0; i < list.Count; ++i )
		{
			if ( (long)list[i] == nEl )
				return true;
		}

		return false;
	}

	private class CFileInfo
	{
		public long nIndex;

		public ArrayList refsListTo = new ArrayList( 0 );
		public ArrayList refsListFrom = new ArrayList( 0 );

		public string GetDir( CFilesIndex index )
		{
			string szDir = "";
			string szName = index.GetFileName( nIndex );
			int nLastSlash = szName.LastIndexOf( "/" );
			if ( nLastSlash != -1 )
				szDir = szName.Remove( nLastSlash, szName.Length - nLastSlash );

			return szDir;
		}

		public CFileInfo( long _nIndex )
		{
			nIndex = _nIndex;
		}
	};
	private class CFileInfoDictionary : DictionaryBase
	{
		public CFileInfo this[ long nIndex ]  
		{
			get { return( (CFileInfo) Dictionary[nIndex] ); }
			set { Dictionary[nIndex] = value; }
		}

		public ICollection Keys 
		{
			get { return( Dictionary.Keys ); }
		}

		public ICollection Values  
		{
			get { return( Dictionary.Values ); }
		}

		public void Add( long nIndex, CFileInfo value )  
		{
			if ( !Contains( nIndex ) )
				Dictionary.Add( nIndex, value );
		}

		public bool Contains( long nIndex )
		{
			return( Dictionary.Contains( nIndex ) );
		}

		public void Remove( long nIndex )
		{
			Dictionary.Remove( nIndex );
		}
	};
	private class CFilesIndex
	{
		private Hashtable strToLong = new Hashtable();
		private Hashtable longToStr = new Hashtable();
		private CFileInfoDictionary files = new CFileInfoDictionary();
		private long nIndex = 0;

		public bool Contains( string szFile )
		{
			return strToLong.Contains( szFile );
		}
		public bool Contains( long nIndex )
		{
			return longToStr.Contains( nIndex );
		}
		public long GetIndex( string szFile )
		{
			Debug.Assert( strToLong.Contains( szFile ), "", "file " + szFile + " doesn't exist in index" );
			return (long)strToLong[szFile];
		}
		public string GetFileName( long nIndex )
		{
			Debug.Assert( longToStr.Contains( nIndex ), "", "can't find index " + nIndex );
			return (string)longToStr[nIndex];
		}
		public CFileInfo GetFile( long nIndex )
		{
			Debug.Assert( files.Contains( nIndex ), "", "can't file index " + nIndex );
			return files[nIndex];
		}
		public CFileInfo GetFile( string szFile )
		{
			long nIndex = GetIndex( szFile );
			return files[nIndex];
		}

		public long Add( string szFile )
		{
			Debug.Assert( !strToLong.Contains( szFile ), "", "file " + szFile + " is already added" );
			long nNewIndex = ++nIndex;
			strToLong.Add( szFile, nNewIndex );
			longToStr.Add( nNewIndex, szFile );
			files.Add( nNewIndex, new CFileInfo( nNewIndex ) );

			return nNewIndex;
		}
		public void Remove( string szFile )
		{
			if ( strToLong.Contains( szFile ) )
			{
				long nIndex = (long)strToLong[szFile];
				strToLong.Remove( szFile );
				longToStr.Remove( nIndex );
				files.Remove( nIndex );
			}
		}

		public IEnumerator GetEnumerator() { return files.GetEnumerator(); }
		public int Size() { return files.Count; }
	};
	private string szRootDir;
	private CFilesIndex index = new CFilesIndex();
	private CGarbageCollector garbageCollector;

	private void AddRefTo( CFileInfo fileInfo, string _szRef )
	{
		string szRef = _szRef.ToLower();
		
		int nEnd = szRef.IndexOf( "#xpointer" );
		if ( nEnd == -1 )
			return;

		string szRefFileName = szRef.Remove( nEnd, szRef.Length - nEnd );
		if ( szRefFileName[0] == '/' )
			szRefFileName = szRefFileName.Substring( 1 );
		else
		{
			string[] refFilePath = szRefFileName.Split( '/' );
			string[] filePath = fileInfo.GetDir( index ).Split( '/' );

			int i = 0;
			while ( i < refFilePath.Length && i < filePath.Length && refFilePath[i] == ".." )
				++i;

			string szRefPathDir = "";
			for ( int j = 0; j < filePath.Length - i; ++j )
			{
				if ( filePath[j] != "" )
					szRefPathDir += "/" + filePath[j];
			}
			for ( int j = i; j < refFilePath.Length; ++j )
			{
				if ( refFilePath[j] != "" )
					szRefPathDir += "/" + refFilePath[j];
			}

			szRefFileName = szRefPathDir.Substring( 1 );
		}

		if ( !index.Contains( szRefFileName ) )
			index.Add( szRefFileName );

		long nRefFileIndex = index.GetIndex( szRefFileName );
		if ( !ListContains( fileInfo.refsListTo, nRefFileIndex ) )
			fileInfo.refsListTo.Add( nRefFileIndex );

		CFileInfo refFileInfo = index.GetFile( nRefFileIndex );
		if ( !ListContains( refFileInfo.refsListFrom, fileInfo.nIndex ) )
			refFileInfo.refsListFrom.Add( fileInfo.nIndex );
	}

	private void ReadDir( DirectoryInfo dirInfo )
	{
		FileInfo[] files = dirInfo.GetFiles( "*.xdb" );
		foreach ( FileInfo file in files )
			Read( file.FullName );

		DirectoryInfo[] dirs = dirInfo.GetDirectories();
		foreach ( DirectoryInfo dir in dirs )
		{
			if ( dir.Name != ".svn" )
				Read( dir.FullName );
		}
	}

	private void ClearRefsTo( long nIndex )
	{
		CFileInfo fileInfo = index.GetFile( nIndex );
		for ( int i = 0; i < fileInfo.refsListTo.Count; ++i )
		{
			long nIndexTo = (long)fileInfo.refsListTo[i];
			if ( index.Contains( nIndexTo ) )
			{
				CFileInfo fileTo = index.GetFile( nIndex );

				for ( int j = 0; j < fileTo.refsListFrom.Count; ++j )
				{
					if ( (long)fileTo.refsListFrom[j] == nIndex )
					{
						fileTo.refsListFrom.RemoveAt( j );
						break;
					}
				}
			}
		}

		fileInfo.refsListTo.Clear();
	}

	private void ReadFile( string szRawFullName )
	{
		string szFullName = szRawFullName.ToLower();
		
		if ( szFullName.LastIndexOf( ".xdb" ) != szFullName.Length - 4 )
			return;

		string szName = szFullName.Replace( szRootDir + "/", null );
		if ( index.Contains( szName ) )
			ClearRefsTo( index.GetIndex( szName ) );
		else
			index.Add( szName );

		long nIndex = index.GetIndex( szName );
		CFileInfo fileInfo = index.GetFile( nIndex );
		XmlTextReader xmlReader = null;
		try
		{
			xmlReader = new XmlTextReader( ReadToStream( szFullName ) );
			while ( xmlReader.Read() )
			{
				string refFile = xmlReader.GetAttribute( "href" );
				if ( refFile != null )
					AddRefTo( fileInfo, refFile );
			}
		}
		catch ( FileNotFoundException )
		{
			index.Remove( szName );
		}
		finally
		{
			if ( xmlReader != null )
				xmlReader.Close();
		}
	}

	private void Fix( CFileInfo fileInfo )
	{
		Hashtable invalidFiles = new Hashtable();
		for ( int i = 0; i < fileInfo.refsListFrom.Count; ++i )
		{
			long nIndex = (long)fileInfo.refsListFrom[i];
			if ( !index.Contains( nIndex ) )
				invalidFiles.Add( nIndex, -1 );
			else
			{
				string szFile = index.GetFileName( nIndex );
				FileInfo file = new FileInfo( szRootDir + "/" + szFile );
				if ( !file.Exists )
					invalidFiles.Add( nIndex, -1 );
			}
		}

		int nCnt = 0;
		for ( int i = 0; i < fileInfo.refsListFrom.Count; ++i )
		{
			if ( !invalidFiles.Contains( fileInfo.refsListFrom[i] ) )
				fileInfo.refsListFrom[nCnt++] = fileInfo.refsListFrom[i];
		}
		fileInfo.refsListFrom.RemoveRange( nCnt, fileInfo.refsListFrom.Count - nCnt );
	}

	Stream ReadToStream( string fullFileName )
	{
		MemoryStream memStream = null;
		FileStream fileStream = null;
		try
		{
			fileStream = new FileStream( fullFileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite );
			memStream = new System.IO.MemoryStream();
			memStream.SetLength( (int)fileStream.Length );
			fileStream.Read( memStream.GetBuffer(), 0, (int)memStream.Length );
		}
		finally
		{
			if ( fileStream != null )
				fileStream.Close();
		}

		return memStream;
	}

	public CXDB( string _szRootDir, CGarbageCollector _garbageCollector )
	{
		szRootDir = _szRootDir;
		garbageCollector = _garbageCollector;
	}

	public void LoadDB()
	{
		int nTickCount = Environment.TickCount;

		garbageCollector.ForbidGarbageCollection();
		Monitor.Enter( this );
		try
		{
			DirectoryInfo dirInfo = new DirectoryInfo( szRootDir );

			FileInfo[] filesInDir = dirInfo.GetFiles( "*.xdb" );
			foreach ( FileInfo file in filesInDir )
				Read( file.FullName );

			DirectoryInfo[] dirs = dirInfo.GetDirectories();
			foreach ( DirectoryInfo dir in dirs )
				Read( dir.FullName );
		}
		finally
		{
			garbageCollector.AllowGarbageCollection();
			Monitor.Exit( this );
		}

		System.Diagnostics.Trace.WriteLine( "loaded in " + (Environment.TickCount - nTickCount)/1000.0f + " seconds" );
	}

	public void Remove( string szFileName )
	{
		if ( index.Contains( szFileName ) )
			index.Remove( szFileName );
	}
	public void Read( string szRawFullName )
	{
		Debug.Assert( garbageCollector.IsGarbageCollectionForbidden() == true, "can't remove cause of garbage collection" );
		
		string szFullName = szRawFullName.Replace( "\\", "/" );
		DirectoryInfo dirInfo = new DirectoryInfo( szFullName );
		if ( dirInfo.Exists )
		{
			if ( dirInfo.Name != ".svn" )
				ReadDir( dirInfo );
		}
		else
			ReadFile( szFullName );
	}

	public override bool GetRefsTo( string szRawFileName, out string[] refFiles )
	{
		System.Diagnostics.Debugger.Log( 0, "message", "get ref " + szRawFileName );
		
		refFiles = new string[0];

		if ( !Monitor.TryEnter( this ) )
			return false;
		try
		{
			garbageCollector.ForbidGarbageCollection();

			string szFileName = szRawFileName.ToLower();
			szFileName = szFileName.Replace( "\\", "/" );
			szFileName = szFileName.Trim();

			if ( index.Contains( szFileName ) )
			{
				CFileInfo fileInfo = index.GetFile( szFileName );
				Fix( fileInfo );

				refFiles = new string[fileInfo.refsListFrom.Count];
				int i = 0;
				for ( int j = 0; j < fileInfo.refsListFrom.Count; ++j )
				{
					string szFile = index.GetFileName( (long)fileInfo.refsListFrom[j] );
					refFiles[i++] = szFile.Replace( "/", @"\" );
				}
			}
		}
		finally
		{
			garbageCollector.AllowGarbageCollection();
			Monitor.Exit( this );
		}
		return true;
	}
	public override bool DumpAllRefs( string szFileName )
	{
		FileStream fStream = null;
		StreamWriter writer = null;
		
		if ( !Monitor.TryEnter( this, 2000 ) )
			return false;
		try
		{
			garbageCollector.ForbidGarbageCollection();
			
			fStream = new FileStream( szFileName, FileMode.Create, FileAccess.Write, FileShare.None );
			writer = new StreamWriter( fStream );

			foreach ( DictionaryEntry entry in index )
			{
				writer.WriteLine( index.GetFileName( (long)entry.Key ) + ":" );
				CFileInfo fileInfo = (CFileInfo)entry.Value;
				if ( fileInfo.refsListFrom.Count == 0 )
					writer.WriteLine( "\tno refs" );
				else
				{
					for ( int i = 0; i < fileInfo.refsListFrom.Count; ++i )
						writer.WriteLine( "\t" + index.GetFileName( (long)fileInfo.refsListFrom[i] ) );
				}

				writer.WriteLine();
			}
		}
		catch ( System.IO.IOException )
		{
		}
		finally
		{
			if ( writer != null )
				writer.Close();
			if ( fStream != null )
				fStream.Close();

			garbageCollector.AllowGarbageCollection();
			Monitor.Exit( this );
		}

		return true;
	}
	public void CollectGargabe()
	{
		ArrayList invalidFiles = new ArrayList();
		foreach ( DictionaryEntry entry in index )
		{
			CFileInfo fileInfo = (CFileInfo)entry.Value;
			Fix( fileInfo );

			string szFile = index.GetFileName( (long)entry.Key );
			FileInfo file = new FileInfo( szRootDir + "/" + szFile );
			if ( !file.Exists )
				invalidFiles.Add( szFile );
		}

		foreach ( string szFile in invalidFiles )
			Remove( szFile );
	}

	public string GetStats()
	{
		System.Globalization.NumberFormatInfo nfi = new System.Globalization.CultureInfo( "en-US", false ).NumberFormat;
		nfi.NumberGroupSeparator = " ";
		nfi.NumberDecimalDigits = 0;

		return "objects: " + index.Size().ToString( "N", nfi ) + "\nmemory used: " + GC.GetTotalMemory( false ).ToString( "N", nfi );
	}
};
