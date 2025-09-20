#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	struct SDBConstructorProfile;
	struct SHPObjectRPGStats;
}

struct SConstructorProfile;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CConstructorInfo : public CObjectBase
{
	OBJECT_NOCOPY_METHODS( CConstructorInfo );
public:
	struct SUnitPlatform
	{
		ZDATA 
			int nPlatformIndex;
			vector<int> gunIndexes;

			SUnitPlatform() : nPlatformIndex( -1 ) { }
		ZEND int operator&( IBinSaver &f ) { f.Add(2,&nPlatformIndex); f.Add(3,&gunIndexes); return 0; }
	};
private:
	ZDATA
		hash_map<int, vector<SUnitPlatform> > units;
		hash_map<int, vector<int> > slots;
		hash_map<int, CPtr<CObjectBase> > playerUnits;
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&units); f.Add(3,&slots); f.Add(4,&playerUnits); return 0; }
public:
	enum { tidTypeID = 0x3013EC01 };

	bool GetUnitPlatforms( const int nUniqueID, const vector<SUnitPlatform> **pPlatforms );
	void ApplyProfile( const int nUniqueID, const NDb::SDBConstructorProfile *pProfile );
	void ClearProfile( const int nUniqueID );

	void SetPlayerUnit( const int nUniqueID, CObjectBase *pPlayerUnit );
	CObjectBase* GetPlayerUnit( const int nUniqueID );
	
	int GetSlotsSize( const int nUniqueID ) const;
	int GetSlotObject( const int nUniqueID, const int nSlot ) const;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CConstructorInfo* CreateConstructorInfo();
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
