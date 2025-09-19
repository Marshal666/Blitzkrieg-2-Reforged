#pragma once

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// angle (replacememt for WORD angle), multiplayer sync
struct SAIAngle
{
	union
	{
		WORD wAngle;
		int allign;
	};

	SAIAngle() 
		: allign( 0 )		
	{
	}
	SAIAngle( int _wAngle ) 
		: allign( 0 )
	{
		wAngle = _wAngle;
	}
	operator SAIAngle() const { return wAngle; }
	operator int() const { return wAngle; }
	const SAIAngle & operator=( int _nAngle )
	{
		wAngle = _nAngle;
		return *this;
	}
	int operator&( IBinSaver &saver )
	{
		saver.Add( 1, &allign );
		return 0;
	}
	SAIAngle & operator+=( const SAIAngle &an )
	{
		wAngle += an.wAngle;
		return *this;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool operator>( const SAIAngle &_1, const SAIAngle &_2 );
bool operator>( int _1, const SAIAngle &_2 );
bool operator>( const SAIAngle &_1, int _2 );

bool operator<( const SAIAngle &_1, const SAIAngle &_2 );
bool operator<( int _1, const SAIAngle &_2 );
bool operator<( const SAIAngle &_1, int _2 );

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
