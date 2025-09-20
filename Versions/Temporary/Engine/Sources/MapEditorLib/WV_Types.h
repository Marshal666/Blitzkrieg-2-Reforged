#if !defined(__WV_Types__) 
#define __WV_Types__

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "..\System\RandomGen.h"
#include "..\Misc\Win32Random.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//�������� ��� �������� �������� �������� � ������,
//���� ����� ���� ������ ���������������� ������ �������
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NWV
{
	// [0...n-1]
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	struct SAIRandom
	{
		static int GetRandom( int nMax ) //[0...n-1]
		{
			return NRandom::Random( nMax ); //[0...n-1]
		}
	};
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	struct SClientRandom
	{
		static int GetRandom( int nMax ) //[0...n-1]
		{
			return NWin32Random::Random( nMax ); //[0...n-1]
		}
	};
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	template <class TYPE, class TRandom>
	class CWeightVector
	{
		std::vector<TYPE> elements; //�������� (������ ����� ������������� � ����������)
		std::vector<int> weights;		//���� ( ������� ����� �������� - ��� �������� �������� )

	public:
		//
		//������������ � ��������� ������������
		CWeightVector() {}
		//
		CWeightVector( const CWeightVector &rWeightVector ) : elements( rWeightVector.elements ), weights( rWeightVector.weights ) {}
		//
		CWeightVector& operator=( const CWeightVector &rWeightVector )
		{
			if( &rWeightVector != this )
			{
				elements =  rWeightVector.elements;
				weights = rWeightVector.weights;
			}
			return *this;
		}
		
		//
		//������ � ��������� ����� ��������
		const TYPE& operator[]( int nElementIndex ) const
		{ 
			NI_ASSERT_T( ( nElementIndex >=0 ) && ( nElementIndex < elements.size() ),
									NStr::Format("Index (%d) miss in SWeightVector (%d)", nElementIndex, elements.size() ) );
			return elements[nElementIndex];
		}
		//
		TYPE& operator[]( int nElementIndex )
		{ 
			NI_ASSERT_T( ( nElementIndex >=0 ) && ( nElementIndex < elements.size() ),
									NStr::Format("Index (%d) miss in SWeightVector (%d)", nElementIndex, elements.size() ) );
			return elements[nElementIndex];
		}
		
		//
		//������ � ��������� ����� �������
		const TYPE& Get( int nElementIndex ) const
		{
			NI_ASSERT_T( ( nElementIndex >=0 ) && ( nElementIndex < elements.size() ),
									NStr::Format("Index (%d) miss in SWeightVector (%d)", nElementIndex, elements.size() ) );
			return elements[nElementIndex];
		}
		//
		void Set( int nElementIndex, const TYPE &rElement )
		{
			NI_ASSERT_T( ( nElementIndex >=0 ) && ( nElementIndex < elements.size() ),
									NStr::Format("Index (%d) miss in SWeightVector (%d)", nElementIndex, elements.size() ) );
			elements[nElementIndex] = rElement;
		}
		//
		int GetWeight( int nElementIndex ) const
		{
			NI_ASSERT_T( ( nElementIndex >=0 ) && ( nElementIndex < elements.size() ),
									NStr::Format("Index (%d) miss in SWeightVector (%d)", nElementIndex, elements.size() ) );
			return ( nElementIndex > 0 ) ? ( weights[nElementIndex] - weights[nElementIndex - 1] ) : weights[nElementIndex];
		}
		//
		void SetWeight( int nElementIndex, int nWeight )
		{
			int nAdditionalWeight = nWeight - GetWeight( nElementIndex );
			for ( int nInnerIndex = nElementIndex; nInnerIndex < elements.size(); ++nInnerIndex )
			{
				weights[nInnerIndex] += nAdditionalWeight;
			}
		}

		//
		//������ ����������� std::vector �������
		void push_back( const TYPE &rElement, int nWeight )
		{
			elements.push_back( rElement );
			if ( !weights.empty() )
			{
				weights.push_back( weights[weights.size() - 1] + nWeight );
			}
			else
			{
				weights.push_back( nWeight );
			}
		}
		//
		void erase( int nElementIndex )
		{
			int nErasedWeight = GetWeight( nElementIndex );
			for ( int nInnerIndex = nElementIndex + 1; nInnerIndex < weights.size(); ++nInnerIndex )
			{
				weights[nInnerIndex] -= nErasedWeight;
			}
			elements.erase( elements.begin() + nElementIndex );
			weights.erase( weights.begin() + nElementIndex );
		}
		//
		inline int size() const { return elements.size(); }
		inline int weight() const { return !weights.empty() ? weights[weights.size() - 1 ] : 0; }
		//
		inline void clear() { elements.clear(); weights.clear(); }
		//
		inline bool empty() const { return elements.empty(); }

		//
		//�������� ��������� �������
		int GetRandomIndex( bool bBinarySearch = true ) const
		{
			if ( weights.empty() || weights[ weights.size() - 1 ] == 0 )
			{
				return ( -1 );
			}
			
			int nWeight = TRandom::GetRandom( weights[ weights.size() - 1 ] );
			int nMinIndex = 0;
			int nMaxIndex = weights.size() - 1;

			if ( bBinarySearch )
			{
				//�������� �����:
				while ( ( nMaxIndex - nMinIndex ) > 1 )
				{
					int nElementIndex = ( nMinIndex + nMaxIndex ) / 2;
					if ( weights[nElementIndex] > nWeight )
					{
						nMaxIndex = nElementIndex;
					}
					else
					{
						nMinIndex = nElementIndex;
					}
				}
			}
			//������� �����
			while ( nWeight >= weights[nMinIndex] ) ++nMinIndex;
			return nMinIndex;
		}

		//
		const TYPE& GetRandom( bool bBinarySearch = true ) const
		{
			int nElementIndex = GetRandomIndex( bBinarySearch );
			NI_ASSERT( ( nElementIndex >=0 ) && ( nElementIndex < elements.size() ),
								StrFmt( "Index (%d) miss in SWeightVector (%d)", nElementIndex, elements.size() ) );
			return elements[nElementIndex];
		}
	};
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__WV_Types__)
