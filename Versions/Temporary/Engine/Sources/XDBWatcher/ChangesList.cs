using System;
using System.Collections;
using System.Collections.Specialized;
using System.Threading;

class CChangesList
{
	public class CChange
	{
		public enum EChangeType
		{
			CT_CREATED,
			CT_DELETED,
			CT_CHANGED,
		};

		public EChangeType eChangeType = EChangeType.CT_CREATED;
		public string szName;
		public bool bDeleted = false;

		public CChange() { }
		public CChange( EChangeType _eChangeType, string _szName )
		{
			szName = _szName;
			eChangeType = _eChangeType;
		}
	};

	private ArrayList changes;

	public static void MarkDeleted( ArrayList changes )
	{
		StringDictionary toDelete = new StringDictionary();
		for ( int i = changes.Count - 1; i >= 0; --i )
		{
			CChange change = (CChange)changes[i];
			if ( !change.bDeleted )
			{
				if ( toDelete.ContainsKey( change.szName ) )
					change.bDeleted = true;
				else if ( change.eChangeType == CChange.EChangeType.CT_DELETED )
					toDelete.Add( change.szName, "" );
			}
		}
	}

	public AutoResetEvent newChangesEvent;

	public CChangesList()
	{
		changes = new ArrayList();
		newChangesEvent = new AutoResetEvent( false );
	}

	public void Changed( string szFileName )
	{
		lock( this )
		changes.Add( new CChange( CChange.EChangeType.CT_CHANGED, szFileName ) );
		newChangesEvent.Set();
	}

	public void Deleted( string szName )
	{
		lock( this )
		changes.Add( new CChange( CChange.EChangeType.CT_DELETED, szName ) );
		newChangesEvent.Set();
	}

	public void Created( string szName )
	{
		lock( this )
		changes.Add( new CChange( CChange.EChangeType.CT_CREATED, szName ) );
		newChangesEvent.Set();
	}

	public void Renamed( string szOldName, string szNewName )
	{
		Deleted( szOldName );
		Created( szNewName );
	}

	public void CopyAndClearChanges( ArrayList dst )
	{
		{
			lock( this )
			dst.AddRange( changes );
			changes = new ArrayList();
		}
	}
}
