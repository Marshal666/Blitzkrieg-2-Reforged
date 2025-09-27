#include "StdAfx.h"
#include "GfxBuffers.h"
#include "GfxRender.h"
#include "GScene.h"
#include "GCombiner.h"
#include "RadixSort.h"
#include "GSSETransform.h"
#include "..\Misc\HashFuncs.h"

typedef NGfx::SGeomVecFull SGfxVertex;
typedef NGfx::SGeomVecT2C1 STnLVertex;
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NGScene
{
extern bool bLowRAM;
////////////////////////////////////////////////////////////////////////////////////////////////////
// IPart
////////////////////////////////////////////////////////////////////////////////////////////////////
IPart::IPart( CPtrFuncBase<CObjectInfo> *pData, CPerMaterialCombiner *_pCombiner )
	: pObjInfo(pData), pCombiner( _pCombiner ), fAverageTriArea(0)
{
	if ( IsValid( pCombiner ) )
		pCombiner->AddPart( this );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
IPart::~IPart()
{
	if ( IsValid( pCombiner ) ) 
		pCombiner->RemovePart( this ); 
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void IPart::RefreshObjectInfo() 
{ 
	pObjInfo.Refresh();
	while ( !pObjInfo->GetValue() )
		Sleep(0);
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void IPart::ResetCachedTransform()
{
	xformedPositions.clear();
	gfxData.Clear();
	cacheLighting.Clear();
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void IPart::SetCombiner( CPerMaterialCombiner *_pCombiner )
{
	if ( pCombiner == _pCombiner )
		return;
	if ( IsValid( pCombiner ) )
		pCombiner->RemovePart( this );
	pCombiner = _pCombiner;
	if ( IsValid( pCombiner ) )
		pCombiner->AddPart( this );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void IPart::SetObjectInfoNode( CPtrFuncBase<CObjectInfo> *p )
{
	pObjInfo = p;
	if ( pCombiner )
		pCombiner->MarkWasted( this );
	ResetCachedTransform();
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// CAnimationWatch
////////////////////////////////////////////////////////////////////////////////////////////////////
bool CAnimationWatch::NeedUpdate() 
{
	bool bCombiner = pCombiner.Refresh();
	const vector< CPtr<IPart> > &parts = pCombiner->GetValue();
	if ( bCombiner )
	{
		TWatchSet oldWatch;
		watch.swap( oldWatch );
		indices.resize(0);
		// collect new targets
		for ( int k = 0; k < parts.size(); ++k )
		{
			parts[k]->AddChangeTrackers( this, bAnimationOnly );
			while ( indices.size() < watch.size() )
				indices.push_back( k );
		}
		// sync with previous trackers
		hash_map<void*, int, SDefaultPtrHash> old;
		for ( int k = 0; k < oldWatch.size(); ++k )
			old[ oldWatch[k] ] = k;
		for ( int k = 0; k < watch.size(); ++k )
		{
			hash_map<void*, int, SDefaultPtrHash>::iterator i = old.find( watch[k] );
			if ( i != old.end() )
				watch[k].Sync( oldWatch[ i->second ] );
		}
	}
	bool bRes = false;
	for ( int k = 0; k < watch.size(); ++k )
	{
		if ( watch[k].Refresh() )
		{
			parts[ indices[k] ]->ResetCachedTransform();
			bRes = true;
		}
	}
	return bRes;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// CPerMaterialCombiner
////////////////////////////////////////////////////////////////////////////////////////////////////
CPerMaterialCombiner::CPerMaterialCombiner( int ) : bHasChanged(false)
{
	pAnimation = new CAnimationWatch( this, true );
	pFullChange = new CAnimationWatch( this, false );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
bool CPerMaterialCombiner::NeedUpdate()
{
	return bHasChanged;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CPerMaterialCombiner::Recalc()
{
	bHasChanged = false;
	if ( value.size() < 4 )
		return;
	vector< CPtr<IPart> > res( value );
	vector<int> sorted( res.size() );
	vector<unsigned int> sortValues( res.size() );
	for ( int k = 0; k < res.size(); ++k )
		sortValues[k] = res[k]->GetSortValue();
	::DoRadixSort( (const unsigned int*) &sortValues[0], res.size(), &sorted );
	for ( int k = 0; k < res.size(); ++k )
		value[k] = res[ sorted[k] ];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CPerMaterialCombiner::AddPart( IPart *pPart )
{
	ASSERT( value.size() < PF_MAX_PARTS_PER_COMBINER );
	value.push_back( pPart );
	bHasChanged = true;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CPerMaterialCombiner::RemovePart( IPart *pPart )
{
	vector< CPtr<IPart> >::iterator i = find( value.begin(), value.end(), pPart );
	if ( i == value.end() )
		return;
	value.erase( i );
	bHasChanged = true;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CPerMaterialCombiner::MarkWasted( IPart *pPart )
{
	Updated();
}
////////////////////////////////////////////////////////////////////////////////////////////////////
int CPerMaterialCombiner::operator&( CStructureSaver &f )
{
	f.Add( 1, &value );
	f.Add( 3, &pAnimation );
	f.Add( 4, &pFullChange );
	f.Add( 5, &bHasChanged );
	return 0;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// CMMXAnimationMatrices
////////////////////////////////////////////////////////////////////////////////////////////////////
void CMMXAnimationMatrices::Recalc()
{
	const vector<SHMatrix> &blends = pAnimation->GetValue();
	value.resize( blends.size() );
	for ( int k = 0; k < value.size(); ++k )
		Assign( &value[k], blends[k] );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
CFuncBase<vector<NGfx::SCompactTransformer> >* MakeMMXAnimation( CFuncBase<vector<SHMatrix> > *pAnim )
{
	return new CMMXAnimationMatrices( pAnim );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void TransformVertexT( CVec3 *pRes, const SHMatrix &m, const NGfx::SCompactVector &src )
{
	//CVec3 vRes;
	m.RotateVectorTransposed( pRes, NGfx::GetVector( src ) );
	Normalize( pRes );
/*  //NGfx::SCompactVector *pRes	
	NGfx::SCompactVector test; 
	NGfx::CalcCompactVector( &test, vRes );
	NGfx::SCompactTransformer transformer;
	AssignTransposed( &transformer, m );
	MMXTransformVector( pRes, &transformer, &src );
	ASSERT( fabs( NGfx::GetVector(test) - NGfx::GetVector(*pRes) ) < 0.02f )*/
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void TransformPosition( const vector<CVec3> &srcPos, CVec3 *pRes, const SHMatrix &m )
{
	int nCount = srcPos.size();
	if ( nCount > 3 && bIsSSEPresent )
		SSEBatchTransform( m, &srcPos[0], pRes, nCount );
	else
	{
		for ( int k = 0; k < nCount; ++k )
			m.RotateHVector( pRes++, srcPos[k] );
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static void TransformPosition( const vector<CVec3> &srcPos, CVec3 *pRes, const SRealVertexWeight *pWeight, const vector<SHMatrix> &blends )
{
	int nCount = srcPos.size();
	if ( nCount > 0 && bIsSSEPresent && (((int)(&blends[0]))&0xf) == 0 )
	{
		ASSERT( sizeof(SSSEVertexWeight) == sizeof(SRealVertexWeight) );
		SSESkinning( &srcPos[0], pRes, (SSSEVertexWeight*)pWeight, blends, nCount );
	}
	else
	{
		for ( int k = 0; k < nCount; ++k, ++pWeight )
		{
			if ( pWeight->nWeights[1] == 0 )
			{
				const SHMatrix &blend = blends[ pWeight->cBoneIndices[0] ];
				blend.RotateHVector( pRes++, srcPos[k] );
			}
			else
			{
				CVec3 vPos( VNULL3 ), p;
				for ( int j = 0; pWeight->nWeights[j] && j < 4; ++j )
				{
					const SHMatrix &blend = blends[ pWeight->cBoneIndices[j] ];
					float fW = pWeight->fWeights[j];
					blend.RotateHVector( &p, srcPos[k] );
					vPos.x += fW * p.x;
					vPos.y += fW * p.y;
					vPos.z += fW * p.z;
				}
				*pRes++ = vPos;
			}
		}
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
template <class T>
inline void CalcPerVertexLight( T *pRes, CObjectInfo *p, const vector<CVec3> &srcPos, const SUVInfo *pSrc,
	const vector<NGfx::SCompactVector> &normals, const SPerVertexLightState &ls, SCacheLightingInfo *pCache,
	const SBound &bv )
{
	CalcPerVertexLight( pRes, srcPos, pSrc, p->GetPositionIndices(), normals, p->GetAttribute( GATTR_VERTEX_COLOR ), ls, pCache, bv );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
static vector<NGfx::SCompactVector> xformedNormals;
template<class TParam>
struct STGenericTransformer
{
	enum E { PASS_MMX_BLENDS = 1 };
	typedef TParam TRes;
	const SPerVertexLightState &ls;

	STGenericTransformer( const SPerVertexLightState &_ls ) : ls(_ls) {}
	void CopyTransform( CObjectInfo *pObjInfo, const SUVInfo *pSrc, int nVertices,
		SCacheLightingInfo *pCache, const SBound &bv, 
		TRes *pRes )
	{
		xformedNormals.resize( nVertices );
		for ( int k = 0, nSize = xformedNormals.size(); k < nSize; ++k )
			xformedNormals[k] = pSrc[k].normal;
		CalcPerVertexLight( pRes, pObjInfo, pObjInfo->GetPositions(), pSrc, xformedNormals, ls, pCache, bv );
	}
	void SimpleTransform( CObjectInfo *pObjInfo, const vector<CVec3> &transformed, const SUVInfo *pSrc, int nVertices,
		SCacheLightingInfo *pCache, const SBound &bv, 
		const SFBTransform &trans, TRes *pRes )
	{
		SMMXFixups fixups;
		NGfx::SCompactTransformer transformer;
		CreateFixups( &fixups );
		AssignTransposed( &transformer, trans.backward );

		xformedNormals.resize( nVertices );
		for ( int k = 0, nSize = xformedNormals.size(); k < nSize; ++k )
			MMXTransformVector( &xformedNormals[k], &pSrc[k].normal, &fixups, &transformer );
		_asm emms;

		CalcPerVertexLight( pRes, pObjInfo, transformed, pSrc, xformedNormals, ls, pCache, bv );
	}
	void SingleSkinTransform( CObjectInfo *pObjInfo, const vector<CVec3> &transformed, const SUVInfo *_pSrc, int nVerties,
		SCacheLightingInfo *pCache, const SBound &bv, 
		const SRealVertexWeight *_pWeight, const vector<SHMatrix> &blends, const vector<NGfx::SCompactTransformer> &matrices, TRes *pRes )
	{
		if ( blends.empty() )
		{
			ASSERT(0);
			return CopyTransform( pObjInfo, _pSrc, nVerties, pCache, bv, pRes );
		}

		SMMXFixups fixups;
		CreateFixups( &fixups );
		int k = 0;

		const vector<WORD> &posIndices = pObjInfo->GetPositionIndices();
		ASSERT( nVerties == posIndices.size() );
		xformedNormals.resize( posIndices.size() );
		const SUVInfo *pSrc = _pSrc;
		for ( int k = 0, nSize = xformedNormals.size(); k < nSize; ++k, pSrc++ )
		{
			const SRealVertexWeight *pWeight = _pWeight + posIndices[k];
			if ( pWeight->nWeights[1] == 0 )
			{
				const NGfx::SCompactTransformer &blend = matrices[ pWeight->cBoneIndices[0] ];
				MMXTransformVector( &xformedNormals[k], &pSrc->normal, &fixups, &blend );
			}
			else if ( pWeight->nWeights[2] == 0 )
			{
				const NGfx::SCompactTransformer &blend1 = matrices[ pWeight->cBoneIndices[0] ];
				const NGfx::SCompactTransformer &blend2 = matrices[ pWeight->cBoneIndices[1] ];
				BYTE nW1 = pWeight->nWeights[0], nW2 = pWeight->nWeights[1];
				MMXTransformVector2( &xformedNormals[k], &pSrc->normal, &fixups, &blend1, nW1, &blend2, nW2 );
			}
			else
			{
				const NGfx::SCompactTransformer &blend1 = matrices[ pWeight->cBoneIndices[0] ];
				const NGfx::SCompactTransformer &blend2 = matrices[ pWeight->cBoneIndices[1] ];
				const NGfx::SCompactTransformer &blend3 = matrices[ pWeight->cBoneIndices[2] ];
				BYTE nW1 = pWeight->nWeights[0], nW2 = pWeight->nWeights[1], nW3 = pWeight->nWeights[2];
				MMXTransformVector3( &xformedNormals[k], &pSrc->normal, &fixups, &blend1, nW1, &blend2, nW2, &blend3, nW3 );
			}	
		}
		_asm emms;

		CalcPerVertexLight( pRes, pObjInfo, transformed, _pSrc, xformedNormals, ls, pCache, bv );
	}
};
////////////////////////////////////////////////////////////////////////////////////////////////////
struct SGenericPosTransformer
{
	typedef CVec3 TRes;
	enum E { PASS_MMX_BLENDS = 0 };
	
	void CopyTransform( CObjectInfo *pObjInfo, const SUVInfo *pSrc, int nSize,
		SCacheLightingInfo *pCache, const SBound &bv, 
		TRes *pRes )
	{
		const vector<CVec3> &srcPos = pObjInfo->GetPositions();
		for ( int k = 0; k < srcPos.size(); ++k )
			pRes[k] = srcPos[k];
	}
	void SimpleTransform( CObjectInfo *pObjInfo, const vector<CVec3> &_fake, const SUVInfo *pSrc, int nVertices,
		SCacheLightingInfo *pCache, const SBound &bv, 
		const SFBTransform &trans, TRes *pRes )
	{
		const vector<CVec3> &srcPos = pObjInfo->GetPositions();
		TransformPosition( srcPos, pRes, trans.forward );
	}
	void SingleSkinTransform( CObjectInfo *pObjInfo, const vector<CVec3> &_fake, const SUVInfo *pSrc, int nVertices,
		SCacheLightingInfo *pCache, const SBound &bv, 
		const SRealVertexWeight *pWeight, const vector<SHMatrix> &blends, const vector<NGfx::SCompactTransformer> &matrices, TRes *pRes )
	{
		const vector<CVec3> &srcPos = pObjInfo->GetPositions();
		if ( blends.empty() )
		{
			ASSERT(0);
			return CopyTransform( pObjInfo, pSrc, nVertices, pCache, bv, pRes );
		}
		TransformPosition( srcPos, pRes, pWeight, blends );
	}
};
////////////////////////////////////////////////////////////////////////////////////////////////////
template<class T>
struct SPartTransformer : public T
{
	SPartTransformer() {}
	SPartTransformer( const SPerVertexLightState &_ls ) : T(_ls) {}
	int DoTransform( IPart *p, typename T::TRes *pRes, const vector<CVec3> &transformed )
	{
		CObjectInfo *pObjInfo = p->GetObjectInfo();
		if ( !pObjInfo )
			return 0;
		const vector<SUVInfo> &srcVerts = pObjInfo->GetVertices();
		if ( srcVerts.empty() )
			return 0;
		SBound bv;
		bv.BoxInit( p->vBVMin, p->vBVMax );
		switch ( p->GetTransformType() )
		{
		case TT_NONE:
			CopyTransform( pObjInfo, &srcVerts[0], srcVerts.size(), 
				&p->cacheLighting, bv,
				pRes );
			break;
		case TT_SIMPLE:
			SimpleTransform( pObjInfo, transformed, &srcVerts[0], srcVerts.size(),
				&p->cacheLighting, bv,
				p->GetSimplePos(), pRes );
			break;
		case TT_SINGLE_SKIN:
			if ( T::PASS_MMX_BLENDS )
				SingleSkinTransform( pObjInfo, transformed, &srcVerts[0], srcVerts.size(),
					&p->cacheLighting, bv,
					&(pObjInfo->GetWeights()[0]), p->GetAnimation(), p->GetMMXAnimation(), pRes );
			else
				SingleSkinTransform( pObjInfo, transformed, &srcVerts[0], srcVerts.size(),
					&p->cacheLighting, bv,
					&(pObjInfo->GetWeights()[0]), p->GetAnimation(), *(vector<NGfx::SCompactTransformer>*)0, pRes );
			break;
		default:
			ASSERT(0);
			break;
		}
		return srcVerts.size();
	}
};
////////////////////////////////////////////////////////////////////////////////////////////////////
template<class T>
static void FastGeometryTransfer( T *pDst, const T *pSrc, int nSize )
{
	ASSERT( sizeof(T) == 32 );
	_asm
	{
		mov esi, pSrc
		mov edi, pDst
		mov ecx, nSize
		cmp ecx, 0
		jle fff
		// warm up cache
		mov eax, ecx
warm_up_loop:
		mov edx, [esi+eax - 32]
		sub eax, 32
		jg warm_up_loop
final_ckl:
		movq mm0, [esi]
		movq mm1, [esi+8]
		movq mm2, [esi+16]
		movq mm3, [esi+24]
		add esi, 32
		movq [edi], mm0
		movq [edi+8], mm1
		movq [edi+16], mm2
		movq [edi+24], mm3
		add edi, 32
		sub ecx, 32
		jg final_ckl
fff:
		emms
	}
}
template<class TVertex>
struct STGfxCacheTransformer : public SPartTransformer<STGenericTransformer<TVertex> >
{
	typedef SPartTransformer<STGenericTransformer<TVertex> > TParent;
	NGfx::CBufferLock<TVertex> geom;
	int nVert;

	STGfxCacheTransformer( CObj<NGfx::CGeometry> *pGeom, int nTotal, const SPerVertexLightState &_ls, NGfx::EBufferUsage usage ) 
		: TParent(_ls), geom( pGeom, nTotal, usage ), nVert(0) 
	{
	}
	void Transform( IPart *p, const vector<CVec3> &transformed )
	{
		CObjectInfo *pObjInfo = p->GetObjectInfo();
		if ( !pObjInfo )
			return;
		int nPartVerts = pObjInfo->GetVertices().size();
		if ( nPartVerts == 0 )
		{
			p->gfxData.Clear();
			return;
		}
		if ( bLowRAM )
		{
			int nTransformed = DoTransform( p, &geom[nVert], transformed );
			ASSERT( nTransformed == nPartVerts );
		}
		else
		{
			int nSize = sizeof(TVertex) * nPartVerts;
			if ( p->gfxData.GetSize() != nSize )
			{
				p->gfxData.Resize( nSize );
				int nTransformed = DoTransform( p, (TVertex*)&p->gfxData[0], transformed );
				ASSERT( nTransformed == nPartVerts );
			}
			FastGeometryTransfer( &geom[nVert], (TVertex*)&p->gfxData[0], nSize );
			//memcpy( &geom[nVert], &p->gfxData[0], nSize );
		}
		nVert += nPartVerts;
		ASSERT( nVert <= geom.GetSize() );
	}
};
typedef STGfxCacheTransformer<SGfxVertex> SGfxCacheTransformer;
typedef STGfxCacheTransformer<STnLVertex> STnlCacheTransformer;
////////////////////////////////////////////////////////////////////////////////////////////////////
void TransformPart( IPart *p, vector<CVec3> *pRes, vector<STriangle> *pTris )
{
	p->RefreshObjectInfo();
	CObjectInfo *pObjInfo = p->GetObjectInfo();
	if ( pTris )
		pObjInfo->GetPosTriangles( pTris );
	pRes->resize( pObjInfo->GetPositions().size() );
	if ( pRes->empty() )
		return;
	SPartTransformer<SGenericPosTransformer> trans;
	trans.DoTransform( p, &((*pRes)[0]), *pRes );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// CVBCombiner
////////////////////////////////////////////////////////////////////////////////////////////////////
void CVBCombiner::XFormPosition()
{
	const vector< CPtr<IPart> > &parts = pCombiner->GetValue();
	partBVs.resize( parts.size() );

	SBoundCalcer bcAll;
	for ( int i = 0; i < parts.size(); ++i )
	{
		IPart *pPart = parts[i];
		pPart->RefreshObjectInfo();
		CObjectInfo *pObjInfo = pPart->GetObjectInfo();
		Zero( partBVs[i] ); //SBoundCalcer bc; bc.Add( CVec3(0,0,0) ); bc.Make( &partBVs[i] );
		if ( !pObjInfo )
			continue;
		// xform
		vector<CVec3> *pRes = &pPart->xformedPositions;
		int nSize = pObjInfo->GetPositions().size();
		if ( nSize != pRes->size() )
		{
			pRes->resize( nSize );
			if ( nSize > 0 )
			{
				SPartTransformer<SGenericPosTransformer> trans;
				trans.DoTransform( pPart, &((*pRes)[0]), *pRes );
				// calc bv
				SBoundCalcer bc;
				bc.ptMax = CVec3(0,0,0);
				StartMMXBound( &bc.ptMin, &bc.ptMax );
				for ( int k = 0; k < nSize; ++k )
					AddMMXBoundPoint( &(*pRes)[k] );
				StoreMMXBoundResult( &pPart->vBVMin, &pPart->vBVMax );
				pPart->fAverageTriArea = pObjInfo->GetAverageTriArea();
			}
		}
		if ( nSize > 0 )
		{
			SBoundCalcer bc;
			bc.Add( pPart->vBVMin );
			bc.Add( pPart->vBVMax );
			bc.Make( &partBVs[i] );
			bcAll.Add( bc );
		}
	}
	bcAll.Make( &bound );
	bNeedXForm = false;
	bNeedRecalc = true;
	bDroppedXForm = false;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
template<class TTrans>
void CVBCombiner::SimpleTransform( TTrans *p )
{
	const vector< CPtr<IPart> > &parts = pCombiner->GetValue();
	TTrans &trans = *p;
	for ( int i = 0; i < parts.size(); ++i )
	{
		IPart *p = parts[i];
		trans.Transform( p, p->xformedPositions );
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// possible optimization: amount of animated geometry could be reduced by separating maximal octree node size
// for static & dynamic geometry
void CVBCombiner::DoRecalc()
{
	if ( bNeedXForm || bDroppedXForm )
		XFormPosition();
	bNeedRecalc = false;
	ASSERT( NGfx::N_VEC_FULL_TEX_SIZE == N_VERTEX_TEX_SIZE );
	const vector< CPtr<IPart> > &parts = pCombiner->GetValue();
	partBVs.resize( parts.size() );
	vector< CPtr<IPart> >::const_iterator i = parts.begin();
	int nVerts = 0, nPositions = 0;
	
	for ( ; i != parts.end(); ++i )
	{
		(*i)->RefreshObjectInfo();
		CObjectInfo *pObjInfo = (*i)->GetObjectInfo();
		if ( !pObjInfo )
			continue;
		nPositions += pObjInfo->GetPositions().size();
		nVerts += pObjInfo->GetVertices().size();
	}

	if ( !nVerts )
	{
		pValue = 0;
		bound.BoxInit( CVec3(0,0,0), CVec3(0,0,0) );
		for ( int k = 0; k < partBVs.size(); ++k )
			partBVs[k] = bound.s;
		return;
	}
	NGfx::EBufferUsage bufUsage = NGfx::DYNAMIC;//ct == CT_STATIC ? NGfx::STATIC : NGfx::DYNAMIC;
	if ( NGfx::IsTnLDevice() )
	{
		STnlCacheTransformer trans( &pValue, nVerts, pLightState->GetValue(), bufUsage );
		SimpleTransform( &trans );
	}
	else
	{
		SGfxCacheTransformer trans( &pValue, nVerts, pLightState->GetValue(), bufUsage );
		SimpleTransform( &trans );
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
bool CVBCombiner::NeedUpdate() 
{ 
	bool bLightState = pLightState.Refresh();
	if ( bLightState )
	{
		const vector< CPtr<IPart> > &parts = pCombiner->GetValue();
		for ( int i = 0; i < parts.size(); ++i )
		{
			if ( parts[i] )
				parts[i]->ResetCachedLighting();
		}
	}
	return NeedXForm() | bNeedRecalc | bLightState;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CVBCombiner::Recalc()
{
	DoRecalc();
	if ( bLowRAM )
		FreeMemory();
}
////////////////////////////////////////////////////////////////////////////////////////////////////
void CVBCombiner::FreeMemory()
{
	if ( bDroppedXForm )
		return;
	const vector< CPtr<IPart> > &parts = pCombiner->GetValue();
	for ( int i = 0; i < parts.size(); ++i )
	{
		if ( parts[i] )
			parts[i]->ResetCachedTransform();
	}
	bDroppedXForm = true;				
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// CIBCombiner
////////////////////////////////////////////////////////////////////////////////////////////////////
void CIBCombiner::Recalc()
{
	const vector< CPtr<IPart> > &parts = pCombiner->GetValue();
	//vector< CPtr<IPart> >::const_iterator i;// = parts.begin();
	value.resize( parts.size() );
	int nTotalTris = 0;
	vector<char> bIs2Sided( parts.size(), (char)0 );
	for ( int i = 0; i < parts.size(); ++i )//i = parts.begin(); i != parts.end(); ++i )
	{
		parts[i]->RefreshObjectInfo();
		CObjectInfo *pObjInfo = parts[i]->GetObjectInfo();
		if ( !pObjInfo )
			continue;
		bIs2Sided[i] = parts[i]->Is2Sided();
		if ( bIs2Sided[i] )
			nTotalTris += pObjInfo->GetTrisCount() * 2;
		else
			nTotalTris += pObjInfo->GetTrisCount();
	}

	triBuffer.resize( nTotalTris + 1 );
	STriangle *pFill = &triBuffer[0];
	//
	int nOffset = 0, nLargeOffset = 0;
	for ( int i = 0; i < parts.size(); ++i )
	{
		parts[i]->RefreshObjectInfo();
		CObjectInfo *pObjInfo = parts[i]->GetObjectInfo();
		value[i].pTri = pFill;//&triBuffer[nTriFill];
		if ( !pObjInfo )
		{
			value[i].nTris = 0;
			continue;
		}
		if ( nOffset + pObjInfo->GetVertices().size() > 65535 )
		{
			nLargeOffset += nOffset;
			nOffset = 0;
		}
		vector<STriangle> tris;
		if ( ibt == IBTT_POSITIONS )
			pObjInfo->GetVxPositionTriangles( &tris );
		else if ( ibt == IBTT_VERTICES )
			tris = pObjInfo->GetGeometry();
		else
			ASSERT( 0 );
		bool b2Sided = bIs2Sided[ i ];
		if ( b2Sided )
			value[i].nTris = tris.size() * 2;
		else
			value[i].nTris = tris.size();
		value[i].nOffset = nOffset;
		value[i].nBaseIndex = nLargeOffset;//nOffset;
		unsigned short nUseOffset = nOffset;
		if ( b2Sided )
		{
			for ( vector<STriangle>::iterator k = tris.begin(), kEnd = tris.end(); k != kEnd; ++k )
			{
				STriangle &tDest = *pFill++, &tSrc = *k;
				tDest.i1 = tSrc.i1 + nUseOffset;
				tDest.i2 = tSrc.i3 + nUseOffset;
				tDest.i3 = tSrc.i2 + nUseOffset;
			}
		}
		for ( vector<STriangle>::iterator k = tris.begin(), kEnd = tris.end(); k != kEnd; ++k )
		{
			STriangle &tDest = *pFill++, &tSrc = *k;
			tDest.i1 = tSrc.i1 + nUseOffset;
			tDest.i2 = tSrc.i2 + nUseOffset;
			tDest.i3 = tSrc.i3 + nUseOffset;
		}
		nOffset += pObjInfo->GetVertices().size();
	}
	ASSERT( pFill <= &triBuffer[ triBuffer.size() - 1 ] );
}
////////////////////////////////////////////////////////////////////////////////////////////////////
}
using namespace NGScene;
BASIC_REGISTER_CLASS( IPart )
REGISTER_SAVELOAD_CLASS( 0x02741133, CPerMaterialCombiner )
REGISTER_SAVELOAD_CLASS( 0x02741134, CVBCombiner )
REGISTER_SAVELOAD_CLASS( 0x02741135, CIBCombiner )
REGISTER_SAVELOAD_CLASS( 0x009c2130, CMMXAnimationMatrices )
REGISTER_SAVELOAD_CLASS( 0x2013EC82, CAnimationWatch )
