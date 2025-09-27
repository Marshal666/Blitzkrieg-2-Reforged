#include "stdafx.h"

#include "LogSaver.h"
#include "NetPacket.h"
#include "../Misc/StrProc.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static int N_SAVELOAD_VERSION = 2;
////////////////////////////////////////////////////////////////////////////////////////////////////
// uses the fact that order of chunks during save and during load is the same
// also requires no countchunks() use
class CLogSaver : public IBinSaver
{
	OBJECT_NOCOPY_METHODS( CLogSaver );
	string *pszLog;

	virtual bool StartChunk( const chunk_id idChunk, int nChunkNumber ) { return true; }
	virtual void FinishChunk() { }
	virtual int CountChunks( const chunk_id idChunk ) { return 0; }

	virtual void DataChunk( const chunk_id idChunk, void *pData, int nSize, int nChunkNumber )
	{
		switch ( nSize )
		{
		case 1:
			*pszLog += StrFmt( " %d", (int)(*(reinterpret_cast<BYTE*>(pData))) );
			break;
		case 2:
			*pszLog += StrFmt( " %d", (int)(*(reinterpret_cast<WORD*>(pData))) );
			break;
		case 4:
			*pszLog += StrFmt( " %d", (int)(*(reinterpret_cast<int*>(pData))) );
			break;
		default:
			*pszLog += " long data";
			break;
		}
	}
	virtual void DataChunkString( string &data )
	{
		*pszLog += " \"" + data + "\"";
	}
	virtual void DataChunkString( wstring &data )
	{
		*pszLog += " \"" + NStr::ToMBCS( data ) + "\"";
	}
	// storing/loading pointers to objects
	virtual void StoreObject( CObjectBase *pObject )
	{
		if ( pObject )
		{
			string szObj = typeid( *pObject ).name();
			const string szBegin( szObj.begin(), szObj.begin() + 5 );
			if ( szBegin == "class" )
				szObj.erase( szObj.begin(), szObj.begin() + 7 );

			*pszLog += " ";
			*pszLog += szObj + "(";

			if ( NObjectFactory::GetObjectTypeID( pObject ) != UNKNOWN_PACKET_TYPE_ID )
				pObject->operator&( *this );

			*pszLog += " )";
		}
		else
			*pszLog += " null";
	}

	virtual CObjectBase* LoadObject()
	{
		return 0;
	}
public:
	virtual bool IsReading() { return false; }
	virtual int GetVersion() const { return N_SAVELOAD_VERSION; }
	CLogSaver() : pszLog( 0 ) {}
	CLogSaver( string *_pszLog ) : pszLog( _pszLog ) {}
};
////////////////////////////////////////////////////////////////////////////////////////////////////
IBinSaver* CreateLogSaver( string *pszLog )
{
	return new CLogSaver( pszLog );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
