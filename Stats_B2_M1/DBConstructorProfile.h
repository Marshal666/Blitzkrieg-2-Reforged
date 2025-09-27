#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// automatically generated file, don't change manually!

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IXmlSaver;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{

	struct SDBGunsProfile
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		bool bAttached;

		SDBGunsProfile() :
			__dwCheckSum( 0 ),
			bAttached( true )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};

	struct SDBPlatformsProfile
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		bool bAttached;
		vector< SDBGunsProfile > guns;

		SDBPlatformsProfile() :
			__dwCheckSum( 0 ),
			bAttached( true )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};

	struct SDBConstructorProfile : public CResource
	{
		OBJECT_BASIC_METHODS( SDBConstructorProfile )
	public:
		enum { typeID = 0x3013ECC0 };
	private:
		mutable DWORD __dwCheckSum;
	public:
		vector< SDBPlatformsProfile > platforms;
		vector< int > slots;

		SDBConstructorProfile() :
			__dwCheckSum( 0 )
		{ }
		//
		int GetTypeID() const { return typeID; }
		//
		void ReportMetaInfo() const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};
}
