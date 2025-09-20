#ifndef __ANTI_ARTILLERY_MANAGER_H__
#define __ANTI_ARTILLERY_MANAGER_H__

#pragma ONCE
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CAntiArtillery;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CAntiArtilleryManager
{
	// ����� �� ��������� �� ����������� ���������� ��� ������ �� ������
	typedef hash_set<int> CAntiArtilleries;
	ZDATA
	vector<CAntiArtilleries> antiArtilleries;
	public: ZEND int operator&( IBinSaver &f ) { f.Add(2,&antiArtilleries); return 0; }
	static bool IsHeardForParty( CAntiArtillery *pAntiArt, const int nParty );
public:
	void Init();
	void Clear();

	void AddAA( CAntiArtillery *pAA );
	void RemoveAA( CAntiArtillery *pAA );
	void Segment();

	// �� ��������!
	class CIterator
	{
		int nIterParty;
		int nCurParty;
		CAntiArtilleries::iterator curIter;

		public:
			CIterator( const int nParty );

			const CCircle operator*() const;
			CAntiArtillery* GetAntiArtillery() const;

			void Iterate();
			bool IsFinished() const;
	};

	friend class CIterator;
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // __ANTI_ARTILLERY_MANAGER_H__
