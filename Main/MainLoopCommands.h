#pragma once
#include "MainLoop.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
IInterfaceCommand *CreateICExitGame();
IInterfaceCommand *CreateICLoad( const string &szName );
IInterfaceCommand *CreateICSave( const string &szName );
IInterfaceCommand *CreateICCloseInterface();

IBinSaver *CreateSaveLoadSaver( CDataStream *pStream, ESaverMode mode );
IBinSaver *CreateSaveSaverWithCheckers( CDataStream *pStream, vector< CPtr<IDebugSaveCheckObj> > &checkers );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CICLoadBase : public IInterfaceCommand
{
	wstring szTitleName;
	string szFileName;
public:
	enum EStage
	{
		STG_START,
		STG_SERIALIZE_DONE,
		STG_AFTER_LOAD_DONE,
	};
	
	CICLoadBase();
	CICLoadBase( const string &szFileName );
	
	void Configure( const char *pszConfig );
	void Exec();
	
	virtual void OnProgress( EStage eStage ) {}

	int operator&( IBinSaver &saver ) { NI_ASSERT( 0, "Wrong call" ); return 0; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CICSaveBase : public IInterfaceCommand
{
	ZDATA
	wstring szTitleName;
	string szFileName;
public:
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&szTitleName); f.Add(3,&szFileName); return 0; }
protected:
	const string &GetFileName() const { return szFileName; }
	const string GetPathName();
public:
	enum EStage
	{
		STG_START,
		STG_AFTER_SAVE_DONE,
	};

	CICSaveBase();
	CICSaveBase( const string &szFileName );
	
	void Configure( const char *pszConfig );
	void Exec();

	virtual void OnProgress( EStage eStage ) {}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
