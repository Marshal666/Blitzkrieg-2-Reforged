#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CPrimeNumbers : public CObjectBase
{
	OBJECT_NOCOPY_METHODS( CPrimeNumbers );
	vector<int> numbers;
	hash_set<int> isPrime;
public:
	CPrimeNumbers();

	const int GetNNumbers() const { return numbers.size(); }
	const int GetPrime( const int nIndex ) const { return numbers[nIndex]; }
	bool IsPrime( const int nNumber ) { return isPrime.find( nNumber ) != isPrime.end(); }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
