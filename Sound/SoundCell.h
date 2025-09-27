#pragma once
#include "Sound.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//������, ���������� ����
class CSoundCell : public CObjectBase
{
	OBJECT_BASIC_METHODS( CSoundCell );
	int nRadius;												// ������ �������� ���� ������(� �������)
	typedef list< CPtr<CSound> > CSounds;
	CSounds sounds;												// ����� ���� ������
	void RecountForDelete();
	NTimer::STime timeLastCombatHear;
	bool IsSoundHearable( const CSound *pSound, const int nRadius ) const;
public:
	CSoundCell();
	void Clear();
	int operator&( IBinSaver &saver );

	int GetRadius() const { return nRadius; }
	void SetRadius( int nRad ) { nRadius = nRad; }
	void AddSound( class CSound *pSound );	// ��������� ���� � ������������� ������ ��������
	void RemoveSound( const WORD wID, ISFX * pSFX =0 );					// ������� ���� � ������������� ������ ��������
	CSound * GetSound( const WORD wID );
	const CSound * GetSound( const WORD wID ) const;

	// ������� ����� � ID == 0 , ������� �����������
	// ��� ���������� ����� �������� ��� ����������
	void Update( ISFX * pSFX );

	bool HasSounds() const { return sounds.begin() != sounds.end(); }
	//		bool HearSounds() const { return hearableCells.begin() != hearableCells.end(); } 

	void SetLastHearCombat( const NTimer::STime hearTime );
	bool IsCombat() const;


	// ��� ���� ������, ������� ������ �� ���������� ������ nRadius � ��� �� ��������
	template <class TEnumFunc> 
		void EnumHearableSounds( int nRadius, TEnumFunc func )
	{
		for ( CSounds::iterator it = sounds.begin(); it != sounds.end(); ++it )
		{
			if ( IsSoundHearable( *it, nRadius )	)
				func( *it );
		}
	}
	// ��� �������� ���� ������.
	template <class TEnumFunc>
		void EnumAllSounds( TEnumFunc func, int nRadius )
	{
		if ( nRadius <= GetRadius() )
		{
			for ( CSounds::iterator it = sounds.begin(); it != sounds.end(); ++it )
			{
				if ( IsSoundHearable( *it, nRadius ) )
					func( *it );
				else
					func( *it, false );
			}
		}
		else
		{
			// ������ �� ���� �� ������ ���� ������ �� ������
			for ( CSounds::iterator it = sounds.begin(); it != sounds.end(); ++it )
				func( *it, false );
		}
	}
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
