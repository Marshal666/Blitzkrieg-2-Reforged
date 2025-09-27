#pragma once

#include "SFX.h"
#include "ITerrainSounds.h"
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ��� ������, ��������� �� Terrain � �� ����������� ��������.
class CTerrainSounds
{
public:
	// ��� �������� ����� � ��� ���������
	class CTerrainSound 
	{
		public: int operator&( IBinSaver &saver ); private:;

		struct SSoundInfo
		{
		public: int operator&( IBinSaver &saver ); private:;
		public:
			CPtr<ISound> pSound;
			bool bPeaceful;
			SSoundInfo() {  }
			SSoundInfo( CPtr<ISound> pSound, bool bPeaceful )
				: pSound( pSound ), bPeaceful( bPeaceful )
			{
			}
		};
		typedef list<SSoundInfo> CCycledSounds;
		CVec3 vSoundPos;									// placement of nonCycleSound

		CCycledSounds cycledSounds;				//cycle sounds from that terrain

		float fVolume;
		float fPan;
		CVec2 vOffset;										//offset of this sound from camera
		NTimer::STime timeRestart;				//time when sound must be restarted
		bool bMustPlay;
		bool bNeedUpdate;
		WORD wSound;
	public:
		CTerrainSound() : fVolume ( 0.0f ), fPan ( 0.0f ), 
			bMustPlay( false ),
			timeRestart ( 0 ), vOffset( VNULL2 ),
			bNeedUpdate ( false ), vSoundPos( VNULL3 ), wSound( 0 ) {  }
		//returns true if update of sounds is needed.
		void SetSound( const NDb::SComplexSoundDesc *pStats, NTimer::STime timeWhenRestart, interface ISoundScene *pScene );
		bool HasCycleSound() const { return !cycledSounds.empty(); }
		void AddCycledSound( const NDb::SComplexSoundDesc *pStats );
		void StartCycledSounds( ISFX *pSFX, bool bNonPeacefulOnly );

		NTimer::STime GetRestartTime() { return timeRestart; }
		// ���� ���������� ��������� ������ IsNeedUpdate ������ true
		void Update(	const struct SSoundTerrainInfo& info, 
			const CVec3 &vCameraAnchor, const float fViewSize, const float fRelativeVolume );
		void SetMustPlay( bool _bMustPlay ) ;
		bool IsMustPlay() const { return bMustPlay; }

		bool IsNeedUpdate() const { return bNeedUpdate; }
		void DoUpdate( ISFX * pSFX );

		void StopSounds( ISFX * pSFX, bool bOnlyPeaceful );
	};

private:
	CPtr<ISFX> pSFX;
	CVec3 vListener;									//to determine weather coordinates changed
	// for every terrain there will be separate sound
	typedef hash_map< BYTE, CTerrainSound > CSounds;
	CSounds terrainSounds;
	CPtr<ITerrainSounds> pTerrain;						// to get terrain sounds
	NTimer::STime lastUpdateTime;
	bool bMuteAll;												// mute terrain sounds
public:
	CTerrainSounds() : vListener( CVec3(-1,-1,-1) ), lastUpdateTime( 0 ), bMuteAll( false ) {  }
	void Init( interface ITerrainSounds *pTerrain );
	void Update( const CVec3 &vNewListener, const float fViewSize, const bool bCombat, interface ISoundScene *pScene  );
	void Mute( const bool bMute );
	void Clear();
	int operator&( IBinSaver &saver );
};
