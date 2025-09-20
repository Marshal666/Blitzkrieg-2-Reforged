#include "StdAfx.h"

#include "ImageProcessor.h"

#include "ImageBMP.h"
#include "ImageTGA.h"
#include "ImageDDS.h"

namespace NImage
{
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ************************************************************************************************************************ //
// **
// ** image save/load
// **
// **
// **
// ************************************************************************************************************************ //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool LoadAnyImage( CArray2D<DWORD> *pRes, CDataStream *pStream )
{
	NI_ASSERT( pStream != 0, "Can't load to NULL stream" );
	//
	if ( NImage::RecognizeFormatDDS(pStream) )
		return NImage::LoadImageDDS( pRes, pStream );
	if ( NImage::RecognizeFormatBMP(pStream) )
		return NImage::LoadImageBMP( pRes, pStream );
	else if ( NImage::RecognizeFormatTGA(pStream) )
		return NImage::LoadImageTGA( pRes, pStream );
	return false;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ************************************************************************************************************************ //
// **
// ** subimage copying
// **
// **
// **
// ************************************************************************************************************************ //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool Copy( const CArray2D<DWORD> &src, const CTRect<long> *pSrcRect, CArray2D<DWORD> &dst, const CTPoint<long> &dstPos )
{
	const CTRect<long> rcRect = (pSrcRect == 0) ? CTRect<long>( 0, 0, src.GetSizeX(), src.GetSizeY() ) : *pSrcRect;
	//
	if ( (dstPos.x + rcRect.Width() > dst.GetSizeX()) || (dstPos.y + rcRect.Height() > dst.GetSizeY()) )
	{
		NI_ASSERT( (dstPos.x + rcRect.Width() > dst.GetSizeX()) || (dstPos.y + rcRect.Height() > dst.GetSizeY()), "Wrong image size" );
		return false;
	}
	//
	for ( int j = 0; j < rcRect.Height(); ++j )
		memcpy( &(dst[dstPos.y + j][dstPos.x]), &(src[rcRect.top + j][rcRect.left]), rcRect.Width() * sizeof(DWORD) );
	//
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CopyAB( const CArray2D<DWORD> &src, const CTRect<long> *pSrcRect, CArray2D<DWORD> &dst, const CTPoint<long> &dstPos )
{
	const CTRect<long> rcRect = (pSrcRect == 0) ? CTRect<long>( 0, 0, src.GetSizeX(), src.GetSizeY() ) : *pSrcRect;
	//
	if ( (dstPos.x + rcRect.Width() > dst.GetSizeX()) || (dstPos.y + rcRect.Height() > dst.GetSizeY()) )
	{
		NI_ASSERT( (dstPos.x + rcRect.Width() > dst.GetSizeX()) || (dstPos.y + rcRect.Height() > dst.GetSizeY()), "Wrong image size" );
		return false;
	}
	//
	for ( int j = 0; j < rcRect.Height(); ++j )
	{
		const DWORD *pSrcColors = &( src[rcRect.top + j][rcRect.left] );
		DWORD *pDstColors = &( dst[dstPos.y + j][dstPos.x] );
		for ( int i = 0; i < rcRect.Width(); ++i )
		{
			const DWORD srcA = ( pSrcColors[i] >> 24 ) & 0x000000ff;
			const DWORD srcR = ( pSrcColors[i] >> 16 ) & 0x000000ff;
			const DWORD srcG = ( pSrcColors[i] >>  8 ) & 0x000000ff;
			const DWORD srcB = ( pSrcColors[i]       ) & 0x000000ff;
			const DWORD dstA = ( pDstColors[i] >> 24 ) & 0x000000ff;
			const DWORD dstR = ( pDstColors[i] >> 16 ) & 0x000000ff;
			const DWORD dstG = ( pDstColors[i] >>  8 ) & 0x000000ff;
			const DWORD dstB = ( pDstColors[i]       ) & 0x000000ff;
			pDstColors[i] = ( Max(srcA, dstA) << 24 ) |
											( ((srcR*srcA + dstR*(255 - srcA)) / 255) << 16 ) |
											( ((srcR*srcA + dstR*(255 - srcA)) / 255) << 16 ) |
											( ((srcG*srcA + dstG*(255 - srcA)) / 255) <<  8 ) |
											( ((srcB*srcA + dstB*(255 - srcA)) / 255) );
		}
	}
	//
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
