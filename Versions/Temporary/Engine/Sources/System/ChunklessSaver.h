#pragma once

interface IPointerSerialization : virtual public CObjectBase
{
	virtual int GetObjectID( CObjectBase *p ) = 0;
	virtual CObjectBase *GetObject( int nID ) = 0;
};

class CMemoryStream;
IBinSaver *CreateChunklessSaver( IPointerSerialization *pPtr, CMemoryStream *pStream, ESaverMode mode );
