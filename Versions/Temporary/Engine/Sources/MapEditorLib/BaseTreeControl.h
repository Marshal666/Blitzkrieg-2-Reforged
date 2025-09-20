#if !defined(__COMMON_CONTROLS__BASE_TREE_CONTROL__)
#define __COMMON_CONTROLS__BASE_TREE_CONTROL__
#pragma once

#include "ControlConfig.h"
#include "ControlData.h"
#include "ControlSelection.h"
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// funtionality															struct	algorithm
// item data expansion / storage						*
// sort by any column												*
// fast search															*
// simpe selection / expanded selection			*
// multi tree binding												*
// clipboard																*
// copy / cut / paste												*
// undo / redo															*
// drag & drop support											*
// save / load expanded / collapsed states	
// save / load columns count / width
// save / load selected / focused elements
//
struct SHTREEITEMHash
{
	int operator()( const HTREEITEM hTreeItem ) const { return int( hTreeItem ); }
};
//
struct SData
{
	int nColor;
	int bReadOnly;
};
//
class CControlConfig : public IControlConfig<string>
{
	void SetAttribute( const string &rID, int nAttribute, bool bSet ) {}
	bool GetAttribute( const string &rID, int nAttribute ) {}
	void ClearAll( int nAttribute ) {}
	const CIDSet& GetAll( int nAttribute ) {}
	//
	void SetWidth( int nWidth, int nColumnIndex ) {}
	int GetWidth( int nColumnIndex ) {}
};
//
typedef CControlData<HTREEITEM, string, SData, SHTREEITEMHash> CStringControlData;
typedef CControlSelection<string, SData> CStringControlSelection;
//
class CBaseTreeControl
{
	CStringControlData controlData;
	CStringControlSelection controlSelection;
	CControlConfig controlConfig;
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__COMMON_CONTROLS__BASE_TREE_CONTROL__)
