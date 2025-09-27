#ifndef __FREE_FIRE_MANAGER_H__
#define __FREE_FIRE_MANAGER_H__

#pragma ONCE
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CAIUnit;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ��� ����� ��������������� �������.
// ���� ������, �� ������� ����������� ����� �� ��������, �� ������� ������.
class CFreeFireManager
{
	enum { TIME_TO_CHECK = 1500 };

	struct SShotInfo
	{
	public:
		ZDATA 
		CPtr<CAIUnit> pTarget;
		CVec2 shootingPos;
		SAIAngle unitDir;
		SAIAngle gunDir;

		public: ZEND int operator&( IBinSaver &f ) { f.Add(2,&pTarget); f.Add(3,&shootingPos); f.Add(4,&unitDir); f.Add(5,&gunDir); return 0; }
		SShotInfo() : shootingPos( VNULL2 ), unitDir( 0 ), gunDir( 0 ) { }
		
		bool NeedAim( CAIUnit *pNewTarget, class CBasicGun *pGun ) const;
		void SetInfo( CAIUnit *pNewTarget, class CBasicGun *pGun );
	};

	ZDATA 
	vector<SShotInfo> shootInfo;

	NTimer::STime lastCheck;
	public: ZEND int operator&( IBinSaver &f ) { f.Add(2,&shootInfo); f.Add(3,&lastCheck); return 0; }
public:
	CFreeFireManager() : lastCheck( 0 ) { }
	CFreeFireManager( class CCommonUnit *pOwner );
	// ���������, ��� base ��� �������� pActiveGun-��
	void Analyze( class CCommonUnit *pUnit, class CBasicGun *pActiveGun );
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // __FREE_FIRE_MANAGER_H__
