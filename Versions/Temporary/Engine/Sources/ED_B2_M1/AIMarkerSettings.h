#if !defined(__AIMARKERSETTINGS__)
#define __AIMARKERSETTINGS__
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ��������� �������� ��������� ��������� � ��������� ��������
struct SAIMarkerSettings
{ 
	struct SObjTypeShowMarker
	{
		string szObjTypeName;
		bool bShowMarker;
		///
		SObjTypeShowMarker() : bShowMarker( false ) {}
		///
		int operator&( IXmlSaver &xs )
		{
			xs.Add( "ObjTypeName", &szObjTypeName );
			xs.Add( "ShowMarker", &bShowMarker );
			return 0;
		}
	};
	vector<SObjTypeShowMarker> objTypeMarkers;		// ���������� ��� ��� ������� 
	bool bForSelectionOnly;														// ���������� ������� ������ ��� ���������� �������
	int nPlayer;																			// ��� ������ ������ ������ ���������� ������� (-1 -- ��� ����)
	///
	SAIMarkerSettings() :
		bForSelectionOnly( false ),
		nPlayer( -1 )
	{
		for ( int i = 0; i < typeUnitDesignTypeMnemonics.Size(); ++i )
		{
			SObjTypeShowMarker sm;
			sm.szObjTypeName = typeUnitDesignTypeMnemonics.GetMnemonic( i );
			sm.bShowMarker = true;
			objTypeMarkers.push_back( sm );
		}
	}
	///
	void SetDefault()
	{
		*this = SAIMarkerSettings();
	}
	///
	int operator&( IXmlSaver &xs )
	{
		xs.Add( "objTypeMarkers", &objTypeMarkers );
		xs.Add( "bForSelectionOnly", &bForSelectionOnly );	
		xs.Add( "nPlayer", &nPlayer );	
		//
		if ( xs.IsReading() )
		{
			vector<string> newTypeNames;
			// �������� ������ ��������� �� ����� �� �����, ������� ��� � EDesignUnitType
			for ( vector<SObjTypeShowMarker>::iterator it = objTypeMarkers.begin(); it != objTypeMarkers.end(); )
			{
				bool bInvalidType = true;
				for ( int j = 0; j < typeUnitDesignTypeMnemonics.Size() ; ++j )
				{
					string szTypeName = typeUnitDesignTypeMnemonics.GetMnemonic( j );
					if ( szTypeName == it->szObjTypeName )
					{
						bInvalidType = false;
						break;
					}
				}
				if ( bInvalidType )
				{
					objTypeMarkers.erase( it );
					if (  it == objTypeMarkers.end() )
						break;
				}
				else
				{
					++it;
				}
			}
			// �������� ����, ������� ��� ��� � ����� �� �����
			for ( int i = 0; i < typeUnitDesignTypeMnemonics.Size(); ++i )
			{
				bool bNew = true;
				string szTypeName = typeUnitDesignTypeMnemonics.GetMnemonic( i );
				for ( int j = 0; j < objTypeMarkers.size(); ++j )
				{
					if ( objTypeMarkers[j].szObjTypeName == szTypeName )
					{
						bNew = false;
						break;
					}
				}
				if ( bNew )
				{
					SObjTypeShowMarker sm;
					sm.szObjTypeName = szTypeName;
					sm.bShowMarker = false;
					objTypeMarkers.push_back( sm );
				}
			}
		}
		//
		return 0;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // #if !defined(__AIMARKERSETTINGS__)
