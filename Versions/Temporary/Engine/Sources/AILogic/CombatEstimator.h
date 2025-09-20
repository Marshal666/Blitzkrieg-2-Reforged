#ifndef __COMBATESTIMATOR_H__
#define __COMBATESTIMATOR_H__
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CAIUnit;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ��� ����������� ��������� �������
class CCombatEstimator
{
	struct SShellInfo
	{
		NTimer::STime time;
		float fDamage;
		//
		SShellInfo() {}
		SShellInfo( NTimer::STime time, float fDamage )
			:time( time ), fDamage( fDamage ) { }
	};

	typedef hash_set<int> CRegisteredUnits;
	typedef list<SShellInfo> CShellTimes;
ZDATA
	float fDamage;
	CRegisteredUnits registeredMechUnits;			// ��������� ����� (�� ������)� ��������� ������� ���������
	CRegisteredUnits registeredInfantry;			// ��������� ����� (������)� ��������� ������� ���������

	CShellTimes shellTimes;								// ����� ��������
public:
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&fDamage); f.Add(3,&registeredMechUnits); f.Add(4,&registeredInfantry); f.Add(5,&shellTimes); return 0; }
public:
	CCombatEstimator();

	void Clear();
	void Segment();

	bool IsCombatSituation() const ;

	void AddShell( NTimer::STime time, float fDamage );
	
	void AddUnit( CAIUnit *pUnit );
	void DelUnit( CAIUnit *pUnit );
	                                                                                                                          
};
#endif // __COMBATESTIMATOR_H__

