// automatically generated file, don't change manually!

#include "stdafx.h"
#include "../libdb/ReportMetaInfo.h"
#include "../libdb/Checksum.h"
#include "../System/XmlSaver.h"
#include "dbminimap.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EMinimapLayerType eValue )
{
	switch ( eValue )
	{
	case NDb::LAYER_UNKNOWN:
		return "LAYER_UNKNOWN";
	case NDb::LAYER_BRIDGE:
		return "LAYER_BRIDGE";
	case NDb::LAYER_BUILDING:
		return "LAYER_BUILDING";
	case NDb::LAYER_RIVER:
		return "LAYER_RIVER";
	case NDb::LAYER_RAILOAD:
		return "LAYER_RAILOAD";
	case NDb::LAYER_ROAD:
		return "LAYER_ROAD";
	case NDb::LAYER_FLORA:
		return "LAYER_FLORA";
	case NDb::LAYER_GRAG:
		return "LAYER_GRAG";
	case NDb::LAYER_SWAMP:
		return "LAYER_SWAMP";
	case NDb::LAYER_LAKE:
		return "LAYER_LAKE";
	case NDb::LAYER_OCEAN:
		return "LAYER_OCEAN";
	case NDb::LAYER_TERRAIN:
		return "LAYER_TERRAIN";
	default:
		return "LAYER_UNKNOWN";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EMinimapLayerType NDb::StringToEnum_NDb_EMinimapLayerType( const string &szValue )
{
	if ( szValue == "LAYER_UNKNOWN" )
		return NDb::LAYER_UNKNOWN;
	if ( szValue == "LAYER_BRIDGE" )
		return NDb::LAYER_BRIDGE;
	if ( szValue == "LAYER_BUILDING" )
		return NDb::LAYER_BUILDING;
	if ( szValue == "LAYER_RIVER" )
		return NDb::LAYER_RIVER;
	if ( szValue == "LAYER_RAILOAD" )
		return NDb::LAYER_RAILOAD;
	if ( szValue == "LAYER_ROAD" )
		return NDb::LAYER_ROAD;
	if ( szValue == "LAYER_FLORA" )
		return NDb::LAYER_FLORA;
	if ( szValue == "LAYER_GRAG" )
		return NDb::LAYER_GRAG;
	if ( szValue == "LAYER_SWAMP" )
		return NDb::LAYER_SWAMP;
	if ( szValue == "LAYER_LAKE" )
		return NDb::LAYER_LAKE;
	if ( szValue == "LAYER_OCEAN" )
		return NDb::LAYER_OCEAN;
	if ( szValue == "LAYER_TERRAIN" )
		return NDb::LAYER_TERRAIN;
	return NDb::LAYER_UNKNOWN;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string EnumToString( NDb::EImageScaleMethod eValue )
{
	switch ( eValue )
	{
	case NDb::IMAGE_SCALE_METHOD_DEFAULT:
		return "IMAGE_SCALE_METHOD_DEFAULT";
	case NDb::IMAGE_SCALE_METHOD_FILTER:
		return "IMAGE_SCALE_METHOD_FILTER";
	case NDb::IMAGE_SCALE_METHOD_BOX:
		return "IMAGE_SCALE_METHOD_BOX";
	case NDb::IMAGE_SCALE_METHOD_TRIANGLE:
		return "IMAGE_SCALE_METHOD_TRIANGLE";
	case NDb::IMAGE_SCALE_METHOD_BELL:
		return "IMAGE_SCALE_METHOD_BELL";
	case NDb::IMAGE_SCALE_METHOD_BSPLINE:
		return "IMAGE_SCALE_METHOD_BSPLINE";
	case NDb::IMAGE_SCALE_METHOD_LANCZOS3:
		return "IMAGE_SCALE_METHOD_LANCZOS3";
	case NDb::IMAGE_SCALE_METHOD_MITCHELL:
		return "IMAGE_SCALE_METHOD_MITCHELL";
	default:
		return "IMAGE_SCALE_METHOD_DEFAULT";
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::EImageScaleMethod NDb::StringToEnum_NDb_EImageScaleMethod( const string &szValue )
{
	if ( szValue == "IMAGE_SCALE_METHOD_DEFAULT" )
		return NDb::IMAGE_SCALE_METHOD_DEFAULT;
	if ( szValue == "IMAGE_SCALE_METHOD_FILTER" )
		return NDb::IMAGE_SCALE_METHOD_FILTER;
	if ( szValue == "IMAGE_SCALE_METHOD_BOX" )
		return NDb::IMAGE_SCALE_METHOD_BOX;
	if ( szValue == "IMAGE_SCALE_METHOD_TRIANGLE" )
		return NDb::IMAGE_SCALE_METHOD_TRIANGLE;
	if ( szValue == "IMAGE_SCALE_METHOD_BELL" )
		return NDb::IMAGE_SCALE_METHOD_BELL;
	if ( szValue == "IMAGE_SCALE_METHOD_BSPLINE" )
		return NDb::IMAGE_SCALE_METHOD_BSPLINE;
	if ( szValue == "IMAGE_SCALE_METHOD_LANCZOS3" )
		return NDb::IMAGE_SCALE_METHOD_LANCZOS3;
	if ( szValue == "IMAGE_SCALE_METHOD_MITCHELL" )
		return NDb::IMAGE_SCALE_METHOD_MITCHELL;
	return NDb::IMAGE_SCALE_METHOD_DEFAULT;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SShadowPoint::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "x", (BYTE*)&nx - pThis, sizeof(nx), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "y", (BYTE*)&ny - pThis, sizeof(ny), NTypeDef::TYPE_TYPE_INT );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SShadowPoint::operator&( IXmlSaver &saver )
{
	saver.Add( "x", &nx );
	saver.Add( "y", &ny );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SShadowPoint::operator&( IBinSaver &saver )
{
	saver.Add( 2, &nx );
	saver.Add( 3, &ny );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SShadowPoint::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << nx << ny;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SEmbossPoint::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "x", (BYTE*)&nx - pThis, sizeof(nx), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "y", (BYTE*)&ny - pThis, sizeof(ny), NTypeDef::TYPE_TYPE_INT );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SEmbossPoint::operator&( IXmlSaver &saver )
{
	saver.Add( "x", &nx );
	saver.Add( "y", &ny );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SEmbossPoint::operator&( IBinSaver &saver )
{
	saver.Add( 2, &nx );
	saver.Add( 3, &ny );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SEmbossPoint::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << nx << ny;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SMinimapLayer::ReportMetaInfo( const string &szAddName, BYTE *pThis ) const
{
	NMetaInfo::ReportMetaInfo( szAddName + "Type", (BYTE*)&eType - pThis, sizeof(eType), NTypeDef::TYPE_TYPE_ENUM );
	NMetaInfo::ReportMetaInfo( szAddName + "EmbossFilterSize", (BYTE*)&nEmbossFilterSize - pThis, sizeof(nEmbossFilterSize), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "ScaleNoise", (BYTE*)&bScaleNoise - pThis, sizeof(bScaleNoise), NTypeDef::TYPE_TYPE_BOOL );
	NMetaInfo::ReportMetaInfo( szAddName + "Color", (BYTE*)&nColor - pThis, sizeof(nColor), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "BorderColor", (BYTE*)&nBorderColor - pThis, sizeof(nBorderColor), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( szAddName + "BorderWidth", (BYTE*)&nBorderWidth - pThis, sizeof(nBorderWidth), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportStructMetaInfo( szAddName + "ShadowPoint", &shadowPoint, pThis ); 
	NMetaInfo::ReportStructMetaInfo( szAddName + "EmbossPoint", &embossPoint, pThis ); 
	NMetaInfo::ReportMetaInfo( szAddName + "NoiseImage", (BYTE*)&szNoiseImage - pThis, sizeof(szNoiseImage), NTypeDef::TYPE_TYPE_STRING );
	NMetaInfo::ReportMetaInfo( szAddName + "ScaleMethod", (BYTE*)&eScaleMethod - pThis, sizeof(eScaleMethod), NTypeDef::TYPE_TYPE_ENUM );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMinimapLayer::operator&( IXmlSaver &saver )
{
	saver.Add( "Type", &eType );
	saver.Add( "EmbossFilterSize", &nEmbossFilterSize );
	saver.Add( "ScaleNoise", &bScaleNoise );
	saver.Add( "Color", &nColor );
	saver.Add( "BorderColor", &nBorderColor );
	saver.Add( "BorderWidth", &nBorderWidth );
	saver.Add( "ShadowPoint", &shadowPoint );
	saver.Add( "EmbossPoint", &embossPoint );
	saver.Add( "NoiseImage", &szNoiseImage );
	saver.Add( "ScaleMethod", &eScaleMethod );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMinimapLayer::operator&( IBinSaver &saver )
{
	saver.Add( 2, &eType );
	saver.Add( 3, &nEmbossFilterSize );
	saver.Add( 4, &bScaleNoise );
	saver.Add( 5, &nColor );
	saver.Add( 6, &nBorderColor );
	saver.Add( 7, &nBorderWidth );
	saver.Add( 8, &shadowPoint );
	saver.Add( 9, &embossPoint );
	saver.Add( 10, &szNoiseImage );
	saver.Add( 11, &eScaleMethod );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DWORD SMinimapLayer::CalcCheckSum() const
{
	if ( __dwCheckSum != 0 )
		return __dwCheckSum;
	__dwCheckSum = 1;

	CCheckSum checkSum;
	checkSum << eType << nEmbossFilterSize << bScaleNoise << nColor << nBorderColor << nBorderWidth << shadowPoint << embossPoint << eScaleMethod;
	__dwCheckSum = checkSum.GetCheckSum();
	if ( __dwCheckSum == 0 )
		__dwCheckSum = 1;

	return __dwCheckSum;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SMinimap::ReportMetaInfo() const
{
	NMetaInfo::StartMetaInfoReport( "Minimap", typeID, sizeof(*this) );

	BYTE *pThis = (BYTE*)this;
	NMetaInfo::ReportMetaInfo( "WoodRadius", (BYTE*)&nWoodRadius - pThis, sizeof(nWoodRadius), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "TerrainShadeRatio", (BYTE*)&nTerrainShadeRatio - pThis, sizeof(nTerrainShadeRatio), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportMetaInfo( "ShowAllBuildingsPassability", (BYTE*)&bShowAllBuildingsPassability - pThis, sizeof(bShowAllBuildingsPassability), NTypeDef::TYPE_TYPE_BOOL );
	NMetaInfo::ReportMetaInfo( "ShowTerrainShades", (BYTE*)&bShowTerrainShades - pThis, sizeof(bShowTerrainShades), NTypeDef::TYPE_TYPE_BOOL );
	NMetaInfo::ReportMetaInfo( "MinAlpha", (BYTE*)&nMinAlpha - pThis, sizeof(nMinAlpha), NTypeDef::TYPE_TYPE_INT );
	NMetaInfo::ReportStructArrayMetaInfo( "Layers", &layers, pThis );
	NMetaInfo::FinishMetaInfoReport();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMinimap::operator&( IXmlSaver &saver )
{
	NMetaInfo::STerminalClassReporter reporter( this, saver );
	saver.Add( "WoodRadius", &nWoodRadius );
	saver.Add( "TerrainShadeRatio", &nTerrainShadeRatio );
	saver.Add( "ShowAllBuildingsPassability", &bShowAllBuildingsPassability );
	saver.Add( "ShowTerrainShades", &bShowTerrainShades );
	saver.Add( "MinAlpha", &nMinAlpha );
	saver.Add( "Layers", &layers );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int SMinimap::operator&( IBinSaver &saver )
{
	saver.Add( 2, &nWoodRadius );
	saver.Add( 3, &nTerrainShadeRatio );
	saver.Add( 4, &bShowAllBuildingsPassability );
	saver.Add( 5, &bShowTerrainShades );
	saver.Add( 6, &nMinAlpha );
	saver.Add( 7, &layers );

	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
using namespace NDb;
REGISTER_DATABASE_CLASS( 0x1414DB40, SMinimap ) 
