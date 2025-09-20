#if !defined(__COMMON_TOOLS__REGISTRY__)
#define __COMMON_TOOLS__REGISTRY__
#pragma once

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//����� ��� ������ � Registry, ������ REG_SZ, REG_DWORD
//������������ �������� - ERROR_SUCCES (0) ��� ��� GetLastError()
//��� ���������� ����� ����������� ������������ �������� ������, ����� ����������� ���������
class CRegistrySection
{
  protected:
	HKEY hRegistrySection;

  public:
  //Constructor
	//HKEY_CURRENT_USER
	//HKEY_LOCAL_MACHINE
  CRegistrySection( HKEY hKey, REGSAM samDesired, LPCTSTR pszRegistrySection );
  ~CRegistrySection();

	bool IsValid() { return ( hRegistrySection != 0 ); }

  //STL ������
	LONG LoadString( LPCTSTR pszRegistryKey, string *pszLoadValue, const string &rszDefaultValue ) const;
  LONG SaveString( LPCTSTR pszRegistryKey, const string &szSaveValue ) const;
 
	//DWORD
	LONG LoadDWORD( LPCTSTR pszRegistryKey, DWORD *pdwLoadValue, DWORD dwDefaultValue ) const;
  LONG SaveDWORD( LPCTSTR pszRegistryKey, DWORD dwSaveValue ) const;

	//����� ����� ( ������ ������� ���� ), ����������� � ����������� �� ����� pszMask, �������� � ���� ������ ��� �����������
	template<class TValue>
	LONG LoadNumber( LPCTSTR pszRegistryKey, LPCTSTR pszMask, TValue *pLoadValue, const TValue rDefaultValue ) const
	{
		if ( pLoadValue != 0 )
		{
			( *pLoadValue ) = rDefaultValue;
			
			string szBuffer;
			LONG eResult = LoadString( pszRegistryKey, &szBuffer, "" );
			if ( ( eResult == ERROR_SUCCESS ) && ( !szBuffer.empty() ) )
			{
				if ( sscanf( szBuffer.c_str(), pszMask, pLoadValue ) < 1 )
				{
					( *pLoadValue ) = rDefaultValue;
					eResult = ERROR_INVALID_DATA;
				}
			}
			return eResult;
		}
		else
		{
			return ERROR_INVALID_PARAMETER;
		}
	}

	template<class TValue>
  LONG SaveNumber( LPCTSTR pszRegistryKey, LPCTSTR pszMask, const TValue &rSaveValue ) const
	{
		const string szBuffer = StrFmt( pszMask, rSaveValue );
		return SaveString( pszRegistryKey, szBuffer );
	}

  //CTRect<TValue>, ������ ���� ����������� � ����������� �� ����� pszMask,  �������� � ���� ������ ��� �����������
	template<class TValue>
	LONG LoadRect( LPCTSTR pszRegistryKey, LPCTSTR pszMask, CTRect<TValue> *pLoadValue, const CTRect<TValue> &rDefaultValue ) const
	{
		if ( pLoadValue != 0 )
		{
			( *pLoadValue ) = rDefaultValue;
			
			string szBuffer;
			LONG eResult = LoadString( pszRegistryKey, &szBuffer, "" );
			if ( ( eResult == ERROR_SUCCESS ) && ( !szBuffer.empty() ) )
			{
				if ( sscanf( szBuffer.c_str(),
										 StrFmt( "%s %s %s %s", pszMask, pszMask, pszMask, pszMask ),
										 &( pLoadValue->minx ),
										 &( pLoadValue->miny ),
										 &( pLoadValue->maxx ),
										 &( pLoadValue->maxy ) ) < 4 )
				{
					( *pLoadValue ) = rDefaultValue;
					eResult = ERROR_INVALID_DATA;
				}
			}
			return eResult;
		}
		else
		{
			return ERROR_INVALID_PARAMETER;
		}
	}

	template<class TValue>
  LONG SaveRect( LPCTSTR pszRegistryKey, LPCTSTR pszMask, const CTRect<TValue> &rSaveValue ) const
	{
		const string szFormat = StrFmt( "%s %s %s %s", pszMask, pszMask, pszMask, pszMask );
		const string szBuffer = StrFmt( szFormat.c_str(), rSaveValue.minx, rSaveValue.miny, rSaveValue.maxx, rSaveValue.maxy );
		return SaveString( pszRegistryKey, szBuffer );
	}
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif //#if !defined(__COMMON_TOOLS__REGISTRY__)


