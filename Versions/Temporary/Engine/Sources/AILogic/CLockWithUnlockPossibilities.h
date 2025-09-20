#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//� �������� ���� ���� ���������� ��������� ������������
// � ��������� ���. 
// ����� ����� ���� ����������� ������������ ��������� ��������� ������������
class CAIUnit;
class CLockWithUnlockPossibilities
{
	
	void Unlock();
	void Lock();

	ZDATA
	vector<BYTE> formerTilesType;
	list<SVector> pathTiles;

	bool bLocked;
	BYTE bAIClass; //
protected:
	SRect bigRect; // ���� ���� Rect ����� ������� ������.
	public: ZEND int operator&( IBinSaver &f ) { f.Add(2,&formerTilesType); f.Add(3,&pathTiles); f.Add(4,&bLocked); f.Add(5,&bAIClass); f.Add(6,&bigRect); return 0; }
protected:
	bool TryLockAlongTheWay( const bool bLock, const BYTE _bAIClass ) ;

public:
	CLockWithUnlockPossibilities()
		: bLocked(false){}

	bool LockRect( const SRect &rect, const BYTE _bAIClass )
	{
		if ( bLocked )	
		{
			TryLockAlongTheWay(false, bAIClass );
		}
		bigRect = rect;
		bLocked = TryLockAlongTheWay( true, _bAIClass );
		return bLocked ;
	}
	void UnlockIfLocked()
	{
		if ( bLocked )
		{
			bLocked = false;
			TryLockAlongTheWay(false, bAIClass);
		}
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
