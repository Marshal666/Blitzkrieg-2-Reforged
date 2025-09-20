#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// automatically generated file, don't change manually!

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IXmlSaver;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	struct STerrainSpotDesc;
	struct SMaterial;

	struct STerrainSpotDesc : public CResource
	{
		OBJECT_BASIC_METHODS( STerrainSpotDesc )
	public:
		enum { typeID = 0x100AC382 };
		CDBPtr< SMaterial > pMaterial;
		float fUsedTexSizeX;
		float fUsedTexSizeY;
		float fScaleCoeff;

		STerrainSpotDesc() :
			fUsedTexSizeX( 1 ),
			fUsedTexSizeY( 1 ),
			fScaleCoeff( 1 )
		{ }
		//
		int GetTypeID() const { return typeID; }
		//
		void ReportMetaInfo() const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const { return 0; }
	};

	struct STerrainSpotInstance
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		CDBPtr< STerrainSpotDesc > pDescriptor;
		int nSpotID;
		vector< CVec2 > points;

		STerrainSpotInstance() :
			__dwCheckSum( 0 ),
			nSpotID( 0 )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};
}
