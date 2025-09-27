#ifndef __ROTATING_FIREPLACES_OBJECT_H__
#define __ROTATING_FIREPLACES_OBJECT_H__

#pragma ONCE
class CSoldier;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CRotatingFireplacesObject
{
	struct SUnitInfo
	{
		ZDATA
		CPtr<CSoldier> pSoldier;
		int nLastFireplace;
		NTimer::STime lastFireplaceChange;
		public: ZEND int operator&( IBinSaver &f ) { f.Add(2,&pSoldier); f.Add(3,&nLastFireplace); f.Add(4,&lastFireplaceChange); return 0; }
		SUnitInfo() : pSoldier( 0 ), nLastFireplace( 0 ), lastFireplaceChange( 0 ) { }
	};

	ZDATA
	list<SUnitInfo> units;
	public: ZEND int operator&( IBinSaver &f ) { f.Add(2,&units); return 0; }
	//
	bool IsBetterToGoToFireplace( class CSoldier *pSoldier, const int nFireplace ) const;
public:
	CRotatingFireplacesObject() { }

	// ���������� ����� ����, ��� ����� ��������� �������� � ������
	// nFireplace - ����� fireplace � ��� ������, ���� ������ ����������� � fireplace
	void AddUnit( class CSoldier *pSoldier, const int nFireplace );
	void DeleteUnit( class CSoldier *pSoldier );

	virtual void Segment();

	// ����� �� ������ ���� � ����� �������
	virtual bool CanRotateSoldier( class CSoldier *pSoldier ) const = 0;
	// ��������� ������� � place ������ �������� ���
	virtual void ExchangeUnitToFireplace( class CSoldier *pSoldier, int nFirePlace ) = 0;
	// ���������� fireplaces
	virtual const int GetNFirePlaces() const = 0;
	// ������, ������� � fireplace, ���� fireplace ����, �� ���������� 0
	virtual class CSoldier* GetSoldierInFireplace( const int nFireplace) const = 0;
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // __ROTATING_FIREPLACES_OBJECT_H__
