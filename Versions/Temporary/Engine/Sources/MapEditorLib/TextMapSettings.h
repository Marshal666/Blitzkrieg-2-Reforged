#if !defined(__TEXTMAP_SETTINGS__)
#define __TEXTMAP_SETTINGS__
#pragma once

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CTextMapSettings
{
	typedef hash_map<string, string> CTextMap;
	CTextMap textMap;

public:
	CTextMapSettings() {}

	int operator&( IXmlSaver &xs )
	{
		xs.Add( "textmap", &textMap );
		return 0;
	}

	bool IsEmpty()
	{
		return textMap.empty();
	}

	const char * GetText( const char * pszKey ) const
	{
		CTextMap::const_iterator iter = textMap.find( pszKey );
		return (iter != textMap.end() ? iter->second.c_str() : pszKey);
	}

	void SetText( const string &szKey, const string &szValue )
	{
		textMap[szKey] = szValue;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif //#define __TEXTMAP_SETTINGS__
