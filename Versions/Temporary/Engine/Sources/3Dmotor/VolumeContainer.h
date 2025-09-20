#ifndef __VolumeContainer_H_
#define __VolumeContainer_H_
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
namespace NCollider
{
////////////////////////////////////////////////////////////////////////////////////////////////////
class CVolumeContainer
{
	struct SLevelContainers
	{
		vector<vector<int> > tris;
	};
	CVec3 ptMin;//, ptMax;  // bounding volume for all triangles
	vector<SLevelContainers> volumeData;
	vector<int> fetchMark;
	float fSize1x, fSize1y, fSize1z;
	int nLastFetch;
	static vector<int> fetchBufferArray;
	vector<int> *pFetched;
	int nFetched;

public:
	struct SIntCoords
	{
		int x,y,z;
	};
	struct SVolumeBounds
	{
		SIntCoords mn, mx;

		int GetSize() const { return Max( mx.x - mn.x, Max( mx.y - mn.y, mx.z - mn.z ) ); }
	};
private:
	void InitFirstPt( SVolumeBounds *pRes, const SHMatrix &pos, const CVec3 &coord );
	void EnlargeVolumeBounds( SVolumeBounds *pRes, const SHMatrix &pos, const CVec3 &coord );
public:
	void Init( const CVec3 &ptMin, const CVec3 &ptMax, float fRegularSize );//, int nDepth = 3 );
	void GetCoords( SIntCoords *pRes, const CVec3 &src );
	void MakeVolume( SVolumeBounds *pRes, const SIntCoords &a, const SIntCoords &b, const SIntCoords &c );
	void MakeVolume( SVolumeBounds *pRes, const SHMatrix &pos, const SBound &bound );
	void MakeVolume( SVolumeBounds *pRes, const SHMatrix &pos, const vector<CVec3> &coords );
	bool IsOut( const SVolumeBounds &t );
	void ClipVolume( SVolumeBounds *pRes );
	void Fetch( const SBound &b );
	void Add( const SVolumeBounds &b, int nData );
	const vector<int>& GetFetchBuffer() const { return *pFetched; }
	int GetFetchedNum() { return nFetched; }
};
////////////////////////////////////////////////////////////////////////////////////////////////////
const float F_NO_COLLISION = -1e20f;
////////////////////////////////////////////////////////////////////////////////////////////////////
struct SSkipColliderAnalyzer
{
	template <class T> 
		bool operator()( float fDist, const CVec3 &ptCollision, const SPlane &plane, const T& ) const { return true; }
	template <class T> 
		bool operator()( const T& ) const { return true; }
};
extern SSkipColliderAnalyzer skipAnalyzer;
}
#endif
