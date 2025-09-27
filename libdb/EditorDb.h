#pragma once
#include "Db.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
interface IObjMan;
interface IDbObserver;
namespace NTypeDef
{
	struct STypeClass;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//! get object manipulator for given object. NOTE: for editor mode only!
IObjMan *GetManipulator( const CDBID &dbid );
//! create new object for further edit. NOTE: for editor mode only!
IObjMan *CreateNewObject( const string &szClassTypeName );
//! register new object, created with CreateNewObject() function, in database
bool AddNewObject( const string &szFilePath, const CDBID &dbid, IObjMan *pObjMan );
//! remove object from database
bool RemoveObject( const CDBID &dbid );
//! rename object in database
bool RenameObject( const CDBID &dbidOld, const CDBID &dbidNew );
//! mark object as changed to save it
void MarkChanged( const CDBID &dbid );
//! save all objects, marked as changed
void SaveChanges();
//! drop all cached resources
void DropCachedResources();
//! check, have we changed DB objects?
bool HasChangedObjects();
//! retrieve all terminal classes list
bool GetClassesList( vector<NTypeDef::STypeClass*> *pRes );
//! retrieve all objects by type
bool GetObjectsList( vector<CDBID> *pRes, const string &szClassTypeName );

bool RegisterResourceFile( const string &szFileName );
bool IsFileRegistered( const string &szFileName );
//! add database observer
void AddDbObserver( IDbObserver *pObserver );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
