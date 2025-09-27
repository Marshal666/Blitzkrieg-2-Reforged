#pragma once

#include "SFX.h"
#include "DBSound.h"
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CSubstSound;
namespace NDb
{
	enum ESoundType;
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//����
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CSound : public CObjectBase
{
	OBJECT_NOCOPY_METHODS( CSound );
	int wID;														// 
	CPtr<ISound> pSample;								// ����, ������� ����� ������
	CPtr<CSubstSound> pSubstitute;						// ����, ������� �������� ������ pSample

	NDb::ESoundType eCombatType;				// ��������� ����� �� ����� ���
	NTimer::STime timeBegin;						// ������ ��������� �����. 
	NTimer::STime timeToPlay;						// ����� ������ �����
	NTimer::STime timeBeginDim;

	CDBPtr<NDb::SSoundDesc> pDesc;
	enum ESoundMixType eMixType;
	CVec3 vPos;
	CVec3 vSpeed;
	bool bLooped;

	int nMaxRadius, nMinRadius;

	bool bStartedMark;											// ���� ��������� ���
	bool bFinishedMark;											// ���� ��� �������
	bool bDimMark;												  // ������ ��������� �����
	NTimer::STime timeLastPosUpdate;
public:
	CSound() {  }
	CSound( int _nID, const NDb::SSoundDesc *pDesc, interface ISound *pSound, 
		      const enum ESoundMixType eMixType, const CVec3 &vPos, const bool bLooped,
					const NDb::ESoundType eCombatType, float fMinRadius, float fMaxRadius );
	~CSound();
	int operator&( IBinSaver &saver );


	// �������� ������� ��� ��������
	unsigned int GetSamplesPassed();
	bool IsTimeToFinish() const;

	//����� ��������� ����� �����
	NTimer::STime GetPlayTime() const { return timeToPlay; }

	// ������ �����
	bool IsSubstituted() const { return pSubstitute != 0; }
	CSubstSound * GetSubst();
	void Substitute( CSubstSound *_pSubstitute, NTimer::STime nStartTime );
	void UnSubstitute();

	bool IsLooped() const { return bLooped; }

	//������ ��������� ����� �����
	void MarkStarted();
	bool IsMarkedStarted() const { return bStartedMark; }
	//����� ��������� �����
	bool IsMarkedFinished() const { return bFinishedMark; }
	void MarkFinished( bool bFinished = true ) { bFinishedMark=bFinished; }
	// ��� ��������� ����� ��� ��������
	void MarkToDim( const NTimer::STime time );
	bool IsMarkedForDim() const { return bDimMark; }
	// ��-�� ��������� (�� �������) ��� ��-�� ���������� ��������� ����� ���� �� ������.
	float GetVolume( const NTimer::STime time, const float fDist  ) const;

	void SetBeginTime( const NTimer::STime time );
	const NTimer::STime & GetBeginTime() const {return timeBegin;}


	int GetRadiusMax() const;								// ��������� (� �������) �� ������ ���� ���� ������
	ISound * GetSound();
	ESoundMixType GetMixType() const { return eMixType; }
	const int GetID() { return wID; }
	const NDb::SSoundDesc* GetDesc() const;

	void SetPos( const class CVec3 & vPos );
	void SetSpeed( const CVec3 &_vSpeed );
	const CVec3& GetPos() const { return vPos; }
	const CVec3& GetSpeed() const { return vSpeed; }

	NDb::ESoundType GetCombatType() const { return eCombatType; }
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
