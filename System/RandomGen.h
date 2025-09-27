#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IRandomSeed : public CObjectBase
{
	// re-initialize random seed
	virtual void Init() = 0;
	virtual void InitByZeroSeed() = 0;
	// store and restore binary data in the stream form (for non-structure-saver usage)
	virtual void Store( CDataStream *pStream ) = 0;
	virtual void Restore( CDataStream *pStream ) = 0;
	// serialize to XML
	virtual int operator&( interface IXmlSaver &saver ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NRandom
{
	// initialize random generator with random seed
	void SetRandomSeed( IRandomSeed *pSeed );
	// create copy of the current random gen seed and return it
	IRandomSeed *CreateRandomSeedCopy();
	// get random value
	UINT Random();
	// random w/o checks
	__forceinline unsigned int Random( const unsigned int uMax ) { return Random() % uMax; }
	__forceinline int Random( const int nMin, const int nMax ) { return nMin + (int)Random( (unsigned int)(nMax - nMin + 1) ); }
	__forceinline float Random( const float fMin, const float fMax ) { return fMin + float( double(Random()) / double(0xffffffffUL) * double(fMax - fMin) ); }
	// random with checks
	__forceinline unsigned int RandomCheck( const unsigned int uMax ) { return uMax == 0 ? 0 : Random( uMax ); }
	__forceinline int RandomCheck( const int nMin, const int nMax ) { return nMax < nMin ? nMin : Random( nMin, nMax ); }
	__forceinline int RandomCheck( const float fMin, const float fMax ) { return fMax < fMin ? fMin : Random( fMin, fMax ); }

	struct SRandomFunc
	{
		float operator()( float fMin, float fMax ) const { return Random( fMin, fMax ); }
	};
	const SRandomFunc& RndFunc();
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
