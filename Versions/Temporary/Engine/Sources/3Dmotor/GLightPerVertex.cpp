#include "StdAfx.h"
#include "GLightPerVertex.h"
#include "..\3Dlib\GGeometry.h"
#include "GfxBuffers.h"
//#include "..\Misc\HPTimer.h"
#include <mmintrin.h>
#include "GSSETransform.h"
#include "..\3Dlib\Bound.h"

template<class T>
inline bool operator==( const CArray2D<T> &a, const CArray2D<T> &b )
{
	if ( a.GetSizeX() != b.GetSizeX() || a.GetSizeY() != b.GetSizeY() )
		return false;
	int nTotal = a.GetSizeX() * a.GetSizeY();
	const T *pAData = &a[0][0];
	const T *pBData = &b[0][0];
	for ( int k = 0; k < nTotal; ++k )
	{
		if ( pAData[k] != pBData[k] )
			return false;
	}
	return true;
}

static int nWarFogID;
namespace NGScene
{
////////////////////////////////////////////////////////////////////////////////////////////////////
// SPerVertexLightState
////////////////////////////////////////////////////////////////////////////////////////////////////
SPerVertexLightState::SPerVertexLightState() :
	bWarFogUseOnlyNew(false), nWarFogNewID(0), nWarFogOldID(0)
{
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void ConvertColor( NGfx::SMMXWord *p, const CVec3 &v )
{
	p->nZ = Float2Int( v.z * 0x4000 );
	p->nY = Float2Int( v.y * 0x4000 );
	p->nX = Float2Int( v.x * 0x4000 );
	p->nW = 0;
}
void SPerVertexLightState::SetDirectional(
	const CVec3 &_vAmbient, const CVec3 &_vLightColor, const CVec3 &_vShadeColor, const CVec3 &_vIncidentShadowColor,
	const CVec3 &_vDir, int _nDirectionalID, const CVec3 &_vDymanicLightsModification )
{
	ConvertColor( &ambient, _vAmbient );
	ConvertColor( &lightColor, _vLightColor );
	ConvertColor( &incidentShadowColor, _vIncidentShadowColor );
	ConvertColor( &shadeColor, _vShadeColor );
	ConvertColor( &dirLight, _vDir );
	shift.nX = shift.nY = shift.nZ = (short)0x8000;
	ambient.nX = ( ambient.nX >> 2 ) + 8;
	ambient.nY = ( ambient.nY >> 2 ) + 8;
	ambient.nZ = ( ambient.nZ >> 2 ) + 8;
	nDirectionalID = _nDirectionalID;
	vAmbientColor = _vAmbient;
	vLightColor = _vLightColor;
	vSunDir = _vDir;
	vDymanicLightsModification = _vDymanicLightsModification;
}
static float Lin( float f ) { return f*f*f; }
static float Outp( float f ) { return exp( log(f) / 3 ); }
static CVec3 GetLinearColor( const CVec3 &a ) { return CVec3( Lin(a.x), Lin(a.y), Lin(a.z) ); }
static CVec4 GetLinearColor( const CVec4 &a ) { return CVec4( Lin(a.x), Lin(a.y), Lin(a.z), Lin(a.w) ); }
static CVec3 GetOutputColor( const CVec3 &a ) { return CVec3( Outp(a.x), Outp(a.y), Outp(a.z) ); }
static CVec4 GetOutputColor( const CVec4 &a ) { return CVec4( Outp(a.x), Outp(a.y), Outp(a.z), Outp(a.w) ); }
void SPerVertexLightState::AddPointLight( const CVec3 &_vCenter, float _fRadius, const CVec3 &_vColor )
{
	CVec3 vLightColor( _vColor.x * vDymanicLightsModification.x, _vColor.y * vDymanicLightsModification.y, _vColor.z * vDymanicLightsModification.z );
	dynamicPointLights.push_back( SPointLightInfo( _vCenter, _fRadius, GetLinearColor(vLightColor), 0 ) );
}
void SPerVertexLightState::AddPointLight( const CVec3 &_vCenter, float _fRadius, const CVec3 &_vColor, int nPointID )
{
	CVec3 vLightColor( _vColor.x * vDymanicLightsModification.x, _vColor.y * vDymanicLightsModification.y, _vColor.z * vDymanicLightsModification.z );
	staticPointLights.push_back( SPointLightInfo( _vCenter, _fRadius, GetLinearColor(vLightColor), nPointID ) );
}
static bool CmpPL( const SPerVertexLightState::SPointLightInfo &a, const SPerVertexLightState::SPointLightInfo &b )
{
	return a.nID < b.nID;
}
void SPerVertexLightState::SortPointLights()
{
	sort( staticPointLights.begin(), staticPointLights.end(), CmpPL );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void SPerVertexLightState::SetWarFogBlend( float _fBlend )
{
	fWarFogBlend = _fBlend;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
float SPerVertexLightState::GetWarFogBlend() const 
{ 
	if ( warFogNew.GetSizeX() <= 1 ) 
		return 1; 
	return bWarFogUseOnlyNew ? 1 : fWarFogBlend; 
}
////////////////////////////////////////////////////////////////////////////////////////////////////
bool SPerVertexLightState::SetWarFog( const CArray2D<unsigned char> &_fog, float _fScale )
{
	bool bRes = false;
	if ( warFogNew == _fog )
		bWarFogUseOnlyNew = true;
	else
	{
		bRes = true;
		bWarFogUseOnlyNew = false;
		warFogOld = warFogNew;
		warFogNew = _fog;

		nWarFogOldID = nWarFogNewID;
		nWarFogNewID = ++nWarFogID;
	}
	if ( warFogOld.GetSizeX() != warFogNew.GetSizeX() )
	{
		bRes = true;
		warFogOld = warFogNew;
		nWarFogOldID = nWarFogNewID;
	}
	bRes |= fWarFogScale != _fScale;
	fWarFogScale = _fScale;
	return bRes;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void MultiplyOnColor( vector<DWORD> *pRes, const vector<DWORD> &mult )
{
	if ( mult.empty() )
		return;
	DWORD *pDst = &(*pRes)[0], *pDstEnd = pDst + pRes->size();
	const DWORD *pSrc = &mult[0];
	for ( ; pDst < pDstEnd; ++pDst, ++pSrc )
	{
		DWORD dwB = *pSrc;
		__asm
		{
			mov esi, pDst
			pxor mm7, mm7
			movd mm0, [esi]
			movd mm1, dwB
			punpcklbw mm0, mm7
			punpcklbw mm1, mm7
			pmullw mm0, mm1
			psrlw mm0, 8
			packuswb mm0, mm0
			movd [esi], mm0
		}
	}
	__asm emms
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// calc colors
////////////////////////////////////////////////////////////////////////////////////////////////////
static CVec3 MulPerComp( const CVec3 &a, const CVec3 &b ) { return CVec3( a.x * b.x, a.y * b.y, a.z * b.z ); }
static void CalcDirectionaLighting( 
	const vector<CVec3> &srcPos, const vector<WORD> &posIndices, 
	const vector<NGfx::SCompactVector> &_normals, 
	const SPerVertexLightState &ls, bool bTranslucent, const CVec3 &vTranslucentColor,
	vector<DWORD> *pResColors, vector<DWORD> *pResShadow )
{
	pResColors->resize( posIndices.size() );
	pResShadow->resize( posIndices.size() );
	DWORD dwColor = 0, dwShadowColor = 0, dwPrevNormal = 0;
	const void *pDirData = &ls.ambient;
	const NGfx::SMMXWord *pTranslucentShade = &ls.shadeColor;
	if ( bTranslucent )
	{
		NGfx::SMMXWord transHolder;
		ConvertColor( &transHolder, MulPerComp( ls.vLightColor, vTranslucentColor ) );
		pTranslucentShade = &transHolder;
	}
	for ( int k = 0; k < posIndices.size(); ++k )
	{
		DWORD dwNormal = _normals[k].dw;
		if ( dwNormal != dwPrevNormal )
		{
			__asm
			{
				mov esi, pDirData
				movd mm7, dwNormal
				punpcklbw mm7, mm7
				psubw mm7, [esi+5*8]//shift
				pmaddwd mm7, [esi+4*8]//dirLight
				movq mm6, mm7
				psrlq mm6, 32
				paddd mm7, mm6
				psrad mm7, 15
				punpcklwd mm7, mm7
				punpckldq mm7, mm7
				movq mm6, mm7
				movq mm5, mm7
				psraw mm6, 16
				pand mm7, mm6
				pandn mm6, mm5 // mm6 = f, range [0, 0x4000]
				pcmpeqw mm0, mm0
				pxor mm7, mm0  // mm7 - -f
				movq mm0, [esi]//ambient // vRes
				movq mm1, mm0     // vResShadow
				movq mm2, [esi + 1*8]//lightColor
				movq mm3, [esi + 2*8]//incidentShadowColor
				movq mm4, [esi + 3*8]//shadeColor
				mov esi, pTranslucentShade
				movq mm5, [esi]
				pmulhw mm2, mm6
				pmulhw mm3, mm6
				pmulhw mm5, mm7
				pmulhw mm4, mm7
				paddw mm0, mm2
				paddw mm1, mm3
				paddw mm0, mm5
				paddw mm1, mm4
				psraw mm0, 4
				psraw mm1, 4
				packuswb mm0, mm0
				packuswb mm1, mm1
				movd dwColor, mm0
				movd dwShadowColor, mm1
			}
		}
//		__asm emms
//		CVec3 vNormal = NGfx::GetVector( _normals[k] );
//		CVec3 vRes = ls.vAmbient, vResShadow = ls.vAmbient;
//		float f = vNormal * ls.vDir;
//		if ( f > 0 )
//		{
//			vRes += f * ls.vLightColor;
//			vResShadow += f * ls.vIncidentShadowColor;
//		}
//		else
//		{
//			vRes -= f * ls.vShadeColor;
//			vResShadow -= f * ls.vShadeColor;
//		}
//		DWORD dwShadowColor1 = NGfx::GetDWORDColor( CVec4( vResShadow, 0 ) );
//		DWORD dwColor1 = NGfx::GetDWORDColor( CVec4( vRes, 0 ) );
		(*pResColors)[k] = dwColor;
		(*pResShadow)[k] = dwShadowColor;
		dwPrevNormal = dwNormal;
	}
	__asm emms
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// sample fog of war array with bilinear filteration and store result to pRes
#pragma warning( disable : 4799 )
static void SampleWarFogInt( const vector<int> &intCoords, const CArray2D<unsigned char> &fog, vector<unsigned char> *_pRes, int nVertices )
{
	ASSERT( fog.GetSizeX() == fog.GetSizeY() );
	ASSERT( GetNextPow2( fog.GetSizeX() - 1 ) + 1 == fog.GetSizeX() );
	__m64 zero;
	zero = _m_from_int( 0 );
	unsigned char *pRes = &(*_pRes)[0];
	int nMask = fog.GetSizeX() - 2;
	for ( const int *pTmp = &intCoords[0], *pTmpEnd = pTmp + nVertices * 2; pTmp < pTmpEnd; pTmp += 2, ++pRes )
	{
		int nY = pTmp[1];
		int nYU = ( nY >> 14 ) & nMask;
		int nYfi = nY & 0x3fff;
		__m64 nYf = _m_from_int( ( 0x4000 - nYfi ) | (nYfi << 16) );
		int nX = pTmp[0];
		int nXL = ( nX >> 14 ) & nMask;
		int nXfi = nX & 0x3fff;
		__m64 nXf = _m_from_int( ( 0x4000 - nXfi ) | (nXfi << 16)  );
		const unsigned char *pUp = (&fog[nYU][0]) + nXL;
		const unsigned char *pDown = pUp + nMask + 2;

		__m64 nData = _mm_unpacklo_pi32(
			_m_punpcklbw( _m_from_int( *(unsigned short*)pUp ), zero ),
			_m_punpcklbw( _m_from_int( *(unsigned short*)pDown ), zero )
			);
		nXf = _mm_unpacklo_pi32( nXf, nXf );
		nData = _m_pmaddwd( nData, nXf );
		nData = _m_psradi( nData, 14 );
		nData = _mm_packs_pi32( nData, zero );
		nData = _m_pmaddwd( nData, nYf );
		*pRes = _m_to_int( nData ) >> 14;
	}
}
#pragma warning( default : 4799 )
////////////////////////////////////////////////////////////////////////////////////////////////////
static void SampleWarFog( const vector<CVec3> &srcPos, float fScale, vector<unsigned char> *_pRes1, const CArray2D<unsigned char> &fog1,
	vector<unsigned char> *_pRes2, const CArray2D<unsigned char> &fog2 )
{
	if ( srcPos.empty() ) 
		return;
	int nVertices = srcPos.size();
	if ( _pRes1->size() < nVertices )
		_pRes1->resize( nVertices );
	if ( _pRes2 && _pRes2->size() < nVertices )
		_pRes2->resize( nVertices );

	static vector<int> tmp;
	if ( tmp.size() < nVertices * 2 )
		tmp.resize( nVertices * 2 );

	// calc integer x & y
	{
		float fpScale = fScale * 0x4000;
		const CVec3 *pSrc = &srcPos[0], *pEnd = pSrc + nVertices;
		int *pTmp = &tmp[0];
		__asm
		{
			mov esi, pSrc
			mov edi, pTmp
			mov eax, pEnd
lp:
			fld dword ptr [esi]
			fmul fpScale
			fistp dword ptr[edi]
			fld dword ptr [esi+4]
			fmul fpScale
			fistp dword ptr[edi+4]
			add esi, 12
			add edi, 8
			cmp esi, eax
			jnz lp
		}
	}

	SampleWarFogInt( tmp, fog1, _pRes1, nVertices );
	if ( _pRes2 )
		SampleWarFogInt( tmp, fog2, _pRes2, nVertices );
	_m_empty();
}
////////////////////////////////////////////////////////////////////////////////////////////////////
const float F_PL_RADIUS2 = 64;
const float F_PL_MIN_DISTANCE_NORMALIZED = 0.25f;
const int N_PL_ATTENUATION_SCALE = 8191;
static void CalcPointLightAttenuation( vector<NGfx::SMMXWord> *pRes, const vector<CVec3> &srcPos, const CVec3 &_vCenter, float _fRadius )
{
	int nSize = srcPos.size();
	pRes->resize( nSize );
	float fScale = F_PL_RADIUS2 / sqr( _fRadius );
	for ( int k = 0; k < nSize; ++k )
	{
		CVec3 v = _vCenter - srcPos[k];
		float f = fabs2( v );
		float fCut = Max( 0.0f, sqr(_fRadius) - f ) * ( 1 / sqr(_fRadius ) );
		float fAttenuation = fCut / ( f * fScale + F_PL_MIN_DISTANCE_NORMALIZED ) / sqrt( f );
		NGfx::SMMXWord &n = (*pRes)[k];
		n.nX = Float2Int( v.x * fAttenuation * N_PL_ATTENUATION_SCALE );
		n.nY = Float2Int( v.y * fAttenuation * N_PL_ATTENUATION_SCALE );
		n.nZ = Float2Int( v.z * fAttenuation * N_PL_ATTENUATION_SCALE );
		n.nW = 0;
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void CalcPointLightAttenuationSSE( vector<NGfx::SMMXWord> *pRes, const vector<CVec3> &srcPos, const CVec3 &_vCenter, float _fRadius )
{
	int nSize = srcPos.size();
	pRes->resize( nSize );
	float fAttScale = F_PL_RADIUS2 / sqr( _fRadius );
	__declspec(align(16)) CVec4 vCenter( _vCenter, 0 );
	float fRadius2 = sqr( _fRadius );
	float fCutMult = N_PL_ATTENUATION_SCALE / fRadius2;
	float fAttAdd = F_PL_MIN_DISTANCE_NORMALIZED;
	__asm
	{
		movaps xmm7, vCenter
		shufps xmm7, xmm7, 0xc6
	}
	NGfx::SMMXWord *pDst = &(*pRes)[0];
	const int N_BLOCK = 64;
	for ( int k = 0; k < nSize; k += N_BLOCK )
	{
		const CVec3 *pData = &srcPos[k];
		int nBlock = Min( N_BLOCK, nSize - k );

		// warm up cache
		int nByteSize = sizeof(srcPos[0]) * nBlock - 4;
		__asm
		{
			mov esi, pData
			mov edi, nByteSize
			lp:
			mov eax, [esi + edi]
			sub edi, 32
			jg lp
		}

		for ( const CVec3 *pSrc = pData, *pEnd = pSrc + nBlock; pSrc < pEnd; ++pSrc, ++pDst )
		{
			NGfx::SMMXWord *pMMXRes = pDst;
			__asm
			{
				mov esi, pSrc
				mov edi, pMMXRes
				xorps xmm6, xmm6
				movss xmm2, [esi]
				movss xmm1, [esi+4]
				shufps xmm1, xmm2, 0x40
				movss xmm2, [esi+8]
				movss xmm1, xmm2 // xmm1 = *pSrc (z,y,x) order
				movaps xmm0, xmm7
				subps xmm0, xmm1 // xmm0 = v
				movaps xmm1, xmm0
				mulps xmm1, xmm1
				movaps xmm2, xmm1
				shufps xmm2, xmm2, 0xe1
				addss xmm1, xmm2
				shufps xmm2, xmm2, 0xe2
				addss xmm1, xmm2 // xmm1[0] = f
				movss xmm2, fRadius2
				movss xmm3, xmm1
				mulss xmm3, fAttScale
				subss xmm2, xmm1
				rsqrtss xmm4, xmm1
				mulss xmm2, fCutMult
				addss xmm3, fAttAdd
				maxss xmm2, xmm6 // xmm2[0] = fCut * 8191
				rcpss xmm3, xmm3
				mulss xmm2, xmm4
				mulss xmm2, xmm3
				shufps xmm2, xmm2, 0 // xmm2 = fAttenuation
				mulps xmm0, xmm2
				cvtps2pi mm0, xmm0
				shufps xmm0, xmm0, 0x0e
				cvtps2pi mm1, xmm0
				packssdw mm0, mm1
				movq [edi], mm0
			}
		}
	}
	__asm emms
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void CalcPointLightColors( vector<NGfx::SMMXWord> *pRes, 
	const vector<NGfx::SMMXWord> &attenuation, const SUVInfo *pSrc, const vector<WORD> &posIndices, 
	const vector<NGfx::SCompactVector> &_normals, 
	const CVec3 &_vColor )
{
	NGfx::SMMXWord shift, lightColor, shift1;
	shift.nX = shift.nY = shift.nZ = (short)0x8000;
	shift1.nX = shift1.nZ = 1 << 12; shift1.nY = shift1.nW = 0;
	lightColor.nX = Float2Int( _vColor.x * 32767 );
	lightColor.nY = Float2Int( _vColor.y * 32767 );
	lightColor.nZ = Float2Int( _vColor.z * 32767 );
	__asm
	{
		movq mm7, lightColor
		movq mm5, shift1
	}
	for ( int k = 0; k < posIndices.size(); ++k )
	{
		DWORD dwNormal = _normals[k].dw;
		const NGfx::SMMXWord *pAtt = &attenuation[ posIndices[k] ];
		NGfx::SMMXWord *pResColor = &(*pRes)[k];
		__asm
		{
			mov esi, pResColor
			mov edi, pAtt
			movq mm6, [esi]
			movd mm0, dwNormal
			punpcklbw mm0, mm0
			psubw mm0, shift
			pmaddwd mm0, [edi]
			movq mm1, mm0
			psrlq mm1, 32
			paddd mm0, mm1
			psrad mm0, 15
			packssdw mm0, mm0
			punpcklwd mm0, mm0
			pxor mm2, mm2
			punpckldq mm0, mm0
			movq mm1, mm0
			pcmpgtw mm1, mm2
			pand mm0, mm1
			movq mm1, mm0
			pmulhw mm0, mm7
			pmullw mm1, mm7
			movq mm2, mm1
			movq mm3, mm1
			punpcklwd mm2, mm0
			punpckhwd mm3, mm0
			paddd mm2, mm5
			paddd mm3, mm5
			psrad mm2, 13
			psrad mm3, 13
			packssdw mm2, mm3
			paddsw mm2, mm6
			movq [esi], mm2
		}
		//CVec3 vNormal = NGfx::GetVector( pSrc[k].normal );
		//float f = Max( 0.0f, vNormal * CVec3( pAtt->nX / 8192.0f, pAtt->nY / 8192.0f, pAtt->nZ / 8192.0f ) );
		//CVec3 vTest = f * _vColor;
		//f = f;
	}
	__asm emms
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void CalcPointLightColors( vector<NGfx::SMMXWord> *pRes, 
	const NGfx::SMMXWord &attenuation, const SUVInfo *pSrc, int _nSize, const CVec3 &_vColor )
{
	NGfx::SMMXWord shift, lightColor, shift1;
	shift.nX = shift.nY = shift.nZ = (short)0x8000;
	shift1.nX = shift1.nZ = 1 << 12; shift1.nY = shift1.nW = 0;
	lightColor.nX = Float2Int( _vColor.x * 32767 );
	lightColor.nY = Float2Int( _vColor.y * 32767 );
	lightColor.nZ = Float2Int( _vColor.z * 32767 );
	__asm
	{
		movq mm7, lightColor
		movq mm5, shift1
	}
	DWORD dwPrevNormal = 0;
	__declspec(align(8)) NGfx::SMMXWord prevColor;
	const NGfx::SMMXWord *pAtt = &attenuation;
	for ( int k = 0; k < _nSize; ++k )
	{
		DWORD dwNormal = pSrc[k].normal.dw;
		NGfx::SMMXWord *pResColor = &(*pRes)[k];
		if ( dwNormal != dwPrevNormal )
		{
			__asm
			{
				mov esi, pResColor
				mov edi, pAtt
				movq mm6, [esi]
				movd mm0, dwNormal
				punpcklbw mm0, mm0
				psubw mm0, shift
				pmaddwd mm0, [edi]
				movq mm1, mm0
				psrlq mm1, 32
				paddd mm0, mm1
				psrad mm0, 15
				packssdw mm0, mm0
				punpcklwd mm0, mm0
				pxor mm2, mm2
				punpckldq mm0, mm0
				movq mm1, mm0
				pcmpgtw mm1, mm2
				pand mm0, mm1
				movq mm1, mm0
				pmulhw mm0, mm7
				pmullw mm1, mm7
				movq mm2, mm1
				movq mm3, mm1
				punpcklwd mm2, mm0
				punpckhwd mm3, mm0
				paddd mm2, mm5
				paddd mm3, mm5
				psrad mm2, 13
				psrad mm3, 13
				packssdw mm2, mm3
				movq prevColor, mm2
				paddsw mm2, mm6
				movq [esi], mm2
			}
			dwPrevNormal = dwNormal;
		}
		else
		{
			__asm
			{
				mov esi, pResColor
				movq mm0, [esi]
				paddsw mm0, prevColor
				movq [esi], mm0
			}
		}
	}
	__asm emms
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void AddColors( vector<DWORD> *pRes, const vector<DWORD> &src, const vector<NGfx::SMMXWord> &add )
{
	ASSERT( pRes->size() >= add.size() );
	ASSERT( src.size() >= add.size() );
	int nSize = add.size();
	DWORD *pResPtr = &(*pRes)[0];
	const DWORD *pSrcPtr = &src[0];
	const NGfx::SMMXWord *pAdd = &add[0];
	__asm 
	{
		pxor mm7, mm7
		pcmpeqw mm6, mm6
		psllw mm6, 15
		psrlw mm6, 1
	}
	for ( DWORD *pResEnd = pResPtr + nSize; pResPtr < pResEnd; ++pResPtr, ++pSrcPtr, ++pAdd )
	{
		DWORD dwColor = *pSrcPtr;//(*pRes)[k];
		//NGfx::SMMXWord addColor = add[k];
		//addColor.nX = Clamp( Float2Int( add[k].x * 32767 ), 0, 32767 );
		//addColor.nY = Clamp( Float2Int( add[k].y * 32767 ), 0, 32767 );
		//addColor.nZ = Clamp( Float2Int( add[k].z * 32767 ), 0, 32767 );
		__asm
		{
			mov esi, pAdd
			movd mm0, dwColor
			punpcklbw mm0, mm0
			psrlw mm0, 1
			movq mm1, mm0
			pmulhw mm0, mm0
			psllw mm0, 1
			movq mm2, mm0
			pmulhw mm0, mm1
			pmullw mm2, mm1
			psllw mm0, 1
			paddsw mm0, [esi]//addColor
			psrlw mm0, 1
			// combine low part into lookup index if higher part is zero
			psrlw mm2, 2
			por mm2, mm6
			movq mm3, mm0
			pcmpeqw mm3, mm7
			pand mm2, mm3
			pandn mm3, mm0
			por mm3, mm2
			// calc cubic root from result
			movd ebx, mm3
			psrlq mm3, 32
			mov esi, ebx
			shr ebx, 16
			and esi, 0x7fff
			movzx eax, byte ptr[nCubicRoot + esi]
			and ebx, 0x7fff
			xor ecx, ecx
			mov ch, byte ptr[nCubicRoot + ebx]
			or eax, ecx
			movd ebx, mm3
			and ebx, 0x7fff
			movzx ecx, byte ptr[nCubicRoot + ebx]
			shl ecx, 16
			or eax, ecx
			mov dwColor, eax
			//emms
		}
		//DWORD dwTest = NGfx::GetDWORDColor( GetOutputColor( 
		//	GetLinearColor( NGfx::GetCVec4Color( (*pRes)[k] ) ) + 
		//	CVec4( add[k], 0 )
		//	) );
		*pResPtr = dwColor;
	}
	__asm emms
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void AddPointLight( const SPerVertexLightState::SPointLightInfo &p,  
	const vector<CVec3> &srcPos, const SUVInfo *pSrc, const vector<WORD> &posIndices, 
	const vector<NGfx::SCompactVector> &_normals, 
	vector<NGfx::SMMXWord> *pColors,
	SCacheLightingInfo *pCache, const SBound &bv )
{
	static vector<NGfx::SMMXWord> attenuation;
	if ( pCache->bReplaceWithDirectional )
	{
		float fScale = F_PL_RADIUS2 / sqr( p.fRadius );
		CVec3 vCenter = bv.s.ptCenter;
		NGfx::SMMXWord att;
		CVec3 v = p.vCenter - vCenter;
		float f = fabs2( v );
		// take into account size of object
		float fCorrected = f + sqr( bv.s.fRadius ) * 0.25f;
		float fCut = Max( 0.0f, sqr(p.fRadius) - fCorrected ) * ( 1 / sqr(p.fRadius ) );
		float fAttenuation = fCut / ( fCorrected * fScale + F_PL_MIN_DISTANCE_NORMALIZED ) / sqrt( f );
		att.nX = Float2Int( v.x * fAttenuation * N_PL_ATTENUATION_SCALE );
		att.nY = Float2Int( v.y * fAttenuation * N_PL_ATTENUATION_SCALE );
		att.nZ = Float2Int( v.z * fAttenuation * N_PL_ATTENUATION_SCALE );
		att.nW = 0;
		CalcPointLightColors( pColors, att, pSrc, posIndices.size(), p.vColor );
	}
	else
	{
		if ( bIsSSEPresent )
			CalcPointLightAttenuationSSE( &attenuation, srcPos, p.vCenter, p.fRadius );
		else
			CalcPointLightAttenuation( &attenuation, srcPos, p.vCenter, p.fRadius );
		CalcPointLightColors( pColors, attenuation, pSrc, posIndices, _normals, p.vColor );
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
struct SPVLightCalcer
{
	int nWarFogMask;
	unsigned char cFogHold;
	unsigned char *pWarFogNew, *pWarFogOld;
	vector<DWORD> *pColors, *pShadowColors;
	static vector<DWORD> colorsHold, shadowColorsHold;
	static vector<NGfx::SMMXWord> pointColors;
	static vector<unsigned char> warFogNewHold, warFogOldHold;

	SPVLightCalcer() : pWarFogNew(0), pWarFogOld(0), pColors(0), pShadowColors(0) {}

	void CalcLight(
		const vector<CVec3> &srcPos, const SUVInfo *pSrc, const vector<WORD> &posIndices, 
		const vector<NGfx::SCompactVector> &_normals, const vector<DWORD> &vertexColor,
		const SPerVertexLightState &ls, SCacheLightingInfo *pCache, const SBound &bv )
	{
		//NHPTimer::STime tStart, tFinish;
		//NHPTimer::GetTime( &tStart );
		int nVertices = posIndices.size();

		if ( !pCache->bSkipLighting )
		{
			// determine affecting point lights
			vector<int> pl, plIdx, dynplIdx;
			if ( !pCache->bSkipStaticPointLights )
			{
				for ( int k = 0; k < ls.staticPointLights.size(); ++k )
				{
					const SPerVertexLightState::SPointLightInfo &p = ls.staticPointLights[k];
					if ( !DoesIntersect( SSphere( p.vCenter, p.fRadius ), bv ) )
						continue;
					pl.push_back( p.nID );
					plIdx.push_back( k );
				}
			}

			// decide if cache succeeded
			if ( 
				pCache->nDirectionalLightID == ls.nDirectionalID &&
				pCache->pointLightIDs == pl )
			{
				pColors = &pCache->colors;
				pShadowColors = &pCache->shadowColors;
			}
			else
			{
				if ( pCache->bDoNotCacheLighting )
				{
					pColors = &colorsHold;
					pShadowColors = &shadowColorsHold;
				}
				else
				{
					pColors = &pCache->colors;
					pShadowColors = &pCache->shadowColors;
				}

				// calc directional
				// ~60 clocks / vertex without same normal short cut
				CalcDirectionaLighting( srcPos, posIndices, _normals, ls, pCache->bTranslucent, pCache->vTranslucentColor, pColors, pShadowColors );
				if ( !pCache->bDoNotCacheLighting )
					pCache->nDirectionalLightID = ls.nDirectionalID;

				MultiplyOnColor( pShadowColors, vertexColor );
				MultiplyOnColor( pColors, vertexColor );

				// calc point lights
				if ( !pl.empty() )
				{
					vector<NGfx::SMMXWord> *pPointColors = &pCache->pointLight;
					if ( pl != pCache->pointLightIDs )
					{
						if ( pCache->bDoNotCacheLighting )
							pPointColors = &pointColors;

						pPointColors->resize( 0 );
						NGfx::SMMXWord zero;
						Zero( zero );
						pPointColors->resize( nVertices, zero );
						for ( int k = 0; k < plIdx.size(); ++k )
						{
							const SPerVertexLightState::SPointLightInfo &p = ls.staticPointLights[ plIdx[k] ];
							AddPointLight( p, srcPos, pSrc, posIndices, _normals, pPointColors, pCache, bv );
						}

						if ( !pCache->bDoNotCacheLighting )
							pCache->pointLightIDs = pl;
					}
					else
						ASSERT( !pCache->bDoNotCacheLighting );
					AddColors( pColors, *pColors, *pPointColors );
					AddColors( pShadowColors, *pShadowColors, *pPointColors );
				}
			}
			// calc dynamic point lights
			if ( !ls.dynamicPointLights.empty() )
			{
				pointColors.resize( 0 );
				for ( int k = 0; k < ls.dynamicPointLights.size(); ++k )
				{
					// ~150 clocks / vertex / point light if replace with directional is not used
					const SPerVertexLightState::SPointLightInfo &p = ls.dynamicPointLights[k];
					if ( !DoesIntersect( SSphere( p.vCenter, p.fRadius ), bv ) )
						continue;
					if ( pointColors.empty() )
					{
						NGfx::SMMXWord zero;
						Zero( zero );
						pointColors.resize( nVertices, zero );
					}
					AddPointLight( p, srcPos, pSrc, posIndices, _normals, &pointColors, pCache, bv );
				}
				if ( !pointColors.empty() )
				{
					if ( colorsHold.size() < nVertices )
						colorsHold.resize( nVertices );
					if ( shadowColorsHold.size() < nVertices )
						shadowColorsHold.resize( nVertices );
					AddColors( &colorsHold, *pColors, pointColors );
					AddColors( &shadowColorsHold, *pShadowColors, pointColors );
					pColors = &colorsHold;
					pShadowColors = &shadowColorsHold;
				}
			}
		}

		// fetch warfog
		if ( ls.warFogNew.GetSizeX() > 1 )
		{
			vector<unsigned char> *pNew, *pOld;
			if ( pCache->bDoNotCacheLighting || pCache->bReplaceWithDirectional )
			{
				pNew = &warFogNewHold;
				pOld = &warFogOldHold;
			}
			else
			{
				pNew = &pCache->warFogNew;
				pOld = &pCache->warFogOld;
				if ( ls.nWarFogOldID != pCache->nWarFogOldID && ls.nWarFogOldID == pCache->nWarFogNewID )
				{
					pCache->warFogOld.swap( pCache->warFogNew );
					swap( pCache->nWarFogNewID, pCache->nWarFogOldID );
				}
			}

			if ( pCache->bReplaceWithDirectional )
			{
				vector<CVec3> src(1);
				src[0] = bv.s.ptCenter;
				SampleWarFog( src, ls.fWarFogScale, pNew, ls.warFogNew, pOld, ls.warFogOld  );
				nWarFogMask = 0;
			}
			else
			{
				if ( ls.nWarFogNewID != pCache->nWarFogNewID && ls.nWarFogOldID != pCache->nWarFogOldID )
				{
					SampleWarFog( srcPos, ls.fWarFogScale, pNew, ls.warFogNew, pOld, ls.warFogOld );
					if ( !pCache->bDoNotCacheLighting )
					{
						pCache->nWarFogNewID = ls.nWarFogNewID;
						pCache->nWarFogOldID = ls.nWarFogOldID;
					}
				}
				else
				{
					if ( ls.nWarFogNewID != pCache->nWarFogNewID )
					{
						// ~50 clocks / vertex
						SampleWarFog( srcPos, ls.fWarFogScale, pNew, ls.warFogNew, 0, ls.warFogNew );
						if ( !pCache->bDoNotCacheLighting )
							pCache->nWarFogNewID = ls.nWarFogNewID;
					}
					if ( ls.nWarFogOldID != pCache->nWarFogOldID )
					{
						// ~50 clocks / vertex
						SampleWarFog( srcPos, ls.fWarFogScale, pOld, ls.warFogOld, 0, ls.warFogNew );
						if ( !pCache->bDoNotCacheLighting )
							pCache->nWarFogOldID = ls.nWarFogOldID;
					}
				}
				nWarFogMask = 0xffffffff;
			}
			pWarFogOld = &(*pOld)[0];
			pWarFogNew = &(*pNew)[0];
		}
		else
		{
			cFogHold = 0xff;
			pWarFogOld = &cFogHold;
			pWarFogNew = &cFogHold;
			nWarFogMask = 0;
		}
		//NHPTimer::GetTime( &tFinish );
		//DbgTrc( "%g clocks per vertex, %d vertices", ((double)(tFinish - tStart)) / nVertices, nVertices );
	}
};
////////////////////////////////////////////////////////////////////////////////////////////////////
void SampleWarFog( const vector<CVec3> &vPos, const SPerVertexLightState &ls, vector<float> *pRes )
{
	if ( ls.warFogNew.GetSizeX() <= 1 )
	{
		pRes->resize( 0 );
		return;
	}
	if ( pRes->size() < vPos.size() )
		pRes->resize( vPos.size() );
	vector<unsigned char> newFog, oldFog;
	SampleWarFog( vPos, ls.fWarFogScale, &newFog, ls.warFogNew, &oldFog, ls.warFogOld  );
	float fBlend = ls.GetWarFogBlend();
	float fN = fBlend * ( 1 / 255.0f ), fO = ( 1 - fBlend ) * ( 1 / 255.0f );
	for ( int k = 0; k < vPos.size(); ++k )
	{
		float fRes = newFog[0] * fN + oldFog[0] * fO;
		(*pRes)[k] = fRes;
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
vector<DWORD> SPVLightCalcer::colorsHold, SPVLightCalcer::shadowColorsHold;
vector<NGfx::SMMXWord> SPVLightCalcer::pointColors;
vector<unsigned char> SPVLightCalcer::warFogNewHold, SPVLightCalcer::warFogOldHold;
////////////////////////////////////////////////////////////////////////////////////////////////////
void CalcPerVertexLight( NGfx::SGeomVecFull *pRes, 
	const vector<CVec3> &srcPos, const SUVInfo *pSrc, const vector<WORD> &posIndices, 
	const vector<NGfx::SCompactVector> &_normals, const vector<DWORD> &vertexColor,
	const SPerVertexLightState &ls, SCacheLightingInfo *pCache, const SBound &bv )
{
	if ( posIndices.empty() )
		return;
	SPVLightCalcer l;
	l.CalcLight( srcPos, pSrc, posIndices, _normals, vertexColor, ls, pCache, bv );
	//NHPTimer::STime tStart, tFinish;
	//NHPTimer::GetTime( &tStart );
	if ( pCache->bSkipLighting )
	{
		if ( pCache->bSelfIllum )
		{
			// ~? clocks / vertex
			int k = 0;
			for ( const SUVInfo *pEnd = pSrc + posIndices.size(); pSrc < pEnd; ++pSrc, ++pRes, ++k )
			{
				NGfx::SGeomVecFull &res = *pRes;
				const CVec3 &pos = srcPos[ posIndices[k] ];
				res.pos = pos;
				res.normal = _normals[k];
				res.tex = pSrc->tex;
				res.texLM = pSrc->texLM;
				int nWarFogIndex = posIndices[k] & l.nWarFogMask;
				res.texU.dw = 0x404040 | ( l.pWarFogOld[ nWarFogIndex ] << 24 );
				res.texV.dw = 0x404040 | ( l.pWarFogNew[ nWarFogIndex ] << 24 );
			}
		}
		else
		{
			// ~? clocks / vertex
			int k = 0;
			for ( const SUVInfo *pEnd = pSrc + posIndices.size(); pSrc < pEnd; ++pSrc, ++pRes, ++k )
			{
				NGfx::SGeomVecFull &res = *pRes;
				const CVec3 &pos = srcPos[ posIndices[k] ];
				res.pos = pos;
				res.normal = _normals[k];
				res.tex = pSrc->tex;
				res.texLM = pSrc->texLM;
				int nWarFogIndex = posIndices[k] & l.nWarFogMask;
				res.texU.dw = (pSrc->texU.dw & 0xffffff) | ( l.pWarFogOld[ nWarFogIndex ] << 24 );
				res.texV.dw = (pSrc->texV.dw & 0xffffff) | ( l.pWarFogNew[ nWarFogIndex ] << 24 );
			}
		}
	}
	else
	{
		// ~? clocks / vertex
		int k = 0;
		for ( const SUVInfo *pEnd = pSrc + posIndices.size(); pSrc < pEnd; ++pSrc, ++pRes, ++k )
		{
			NGfx::SGeomVecFull &res = *pRes;
			const CVec3 &pos = srcPos[ posIndices[k] ];
			res.pos = pos;
			res.normal = _normals[k];
			res.tex = pSrc->tex;
			res.texLM = pSrc->texLM;
			int nWarFogIndex = posIndices[k] & l.nWarFogMask;
			res.texU.dw = ((*l.pShadowColors)[k] & 0xffffff) | ( l.pWarFogOld[ nWarFogIndex ] << 24 );
			res.texV.dw = ((*l.pColors)[k] & 0xffffff) | ( l.pWarFogNew[ nWarFogIndex ] << 24 );
		}
	}
	//NHPTimer::GetTime( &tFinish );
	//DbgTrc( "%g clocks per vertex, %d vertices", ((double)(tFinish - tStart)) / nVertices, nVertices );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void ScaleColors( vector<DWORD> *pRes, const DWORD *_pSrc, int nSrcStride, 
	unsigned char *pScale, int nScaleMask, const vector<WORD> &posIndices, const vector<NGfx::SCompactVector> &transp,
	bool bMultiplyOnTransparency )
{
	int nSize = posIndices.size();
	if ( pRes->size() < nSize )
		pRes->resize( nSize );
	DWORD *p = &(*pRes)[0], *pEnd = p + nSize;
	const DWORD *pSrc = _pSrc;
	ASSERT( sizeof(DWORD) == sizeof(transp[0]) );
	const NGfx::SCompactVector *pTransp = &transp[0];
	const WORD *pPosIndices = &posIndices[0];
	NGfx::SMMXWord mTransp;
	mTransp.nX = mTransp.nY = mTransp.nZ = 0; mTransp.nW = 0x1ff;
	__asm movq mm7, mTransp
	if ( bMultiplyOnTransparency )
	{
		mTransp.nX = mTransp.nY = mTransp.nZ = 0; mTransp.nW = 0;
	}
	else
	{
		mTransp.nX = mTransp.nY = mTransp.nZ = 0x7fff; mTransp.nW = 0;
	}
	__asm movq mm6, mTransp
	for ( ; p < pEnd; ++p, pSrc += nSrcStride / 4, ++pPosIndices, ++pTransp )
	{
		int nScaleIndex = (*pPosIndices) & nScaleMask;
		int n = ((int) (pScale[ nScaleIndex ]) ) << 2;
		int nScale = pTransp->w << 7;
		//ASSERT( ((*pSrc) & 0xff000000 ) == 0 );
		__asm
		{
			mov esi, pSrc
			movd mm0, [esi]
			movd mm1, n
			punpcklbw mm0, mm0
			mov esi, p
			psrlw mm0, 1
			punpcklwd mm1, mm1
			punpckldq mm1, mm1
			pmulhw mm0, mm1
			por mm0, mm7
			movd mm2, nScale
			punpcklwd mm2, mm2
			punpckldq mm2, mm2
			por mm2, mm6
			pmulhw mm0, mm2
			packuswb mm0, mm0
			movd [esi], mm0
		}
	}
	__asm emms
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CalcPerVertexLight( NGfx::SGeomVecT2C1 *pRes, 
	const vector<CVec3> &srcPos, const SUVInfo *pSrc, const vector<WORD> &posIndices, 
	const vector<NGfx::SCompactVector> &_normals, const vector<DWORD> &vertexColor,
	const SPerVertexLightState &ls, SCacheLightingInfo *pCache, const SBound &bv )
{
	if ( posIndices.empty() )
		return;
	SPVLightCalcer l;
	l.CalcLight( srcPos, pSrc, posIndices, _normals, vertexColor, ls, pCache, bv );

	if ( pCache->bSkipLighting )
	{
		if ( pCache->bSelfIllum )
		{
			DWORD dwWhite = 0x404040;
			ScaleColors( &l.colorsHold, &dwWhite, 0, l.pWarFogNew, l.nWarFogMask, posIndices, _normals, pCache->bMultiplyOnTransparency );
		}
		else
			ScaleColors( &l.colorsHold, &pSrc->texU.dw, sizeof(*pSrc), l.pWarFogNew, l.nWarFogMask, posIndices, _normals, pCache->bMultiplyOnTransparency );
	}
	else
	{
		ScaleColors( &l.colorsHold, &(*l.pColors)[0], sizeof((*l.pColors)[0]), l.pWarFogNew, l.nWarFogMask, posIndices, _normals, pCache->bMultiplyOnTransparency );
	}
	int k = 0;
	for ( const SUVInfo *pEnd = pSrc + posIndices.size(); pSrc < pEnd; ++pSrc, ++pRes, ++k )
	{
		NGfx::SGeomVecT2C1 &res = *pRes;
		const CVec3 &pos = srcPos[ posIndices[k] ];
		res.pos = pos;
		res.color.dwColor = l.colorsHold[k];//( l.colorsHold[k] & 0xffffff ) | ( _normals[ k ].dw & 0xff000000 );
		res.tex1 = NGfx::GetTexCoords( pSrc->tex );
		res.tex2 = NGfx::GetTexCoords( pSrc->texLM );
	}
}
}
