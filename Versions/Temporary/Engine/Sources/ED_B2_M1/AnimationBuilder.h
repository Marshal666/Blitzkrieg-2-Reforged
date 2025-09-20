#if !defined(__ANIMATION_BUILDER__)
#define __ANIMATION_BUILDER__
#pragma once

#include "..\mapeditorlib\interface_commandhandler.h"
#include "..\MapEditorLib\BuildDataBuilder.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SGrannyBoneAttributes; 
class CAnimationBuilder : public CDefaultBuilderBase, public IBuildDataCallback, public ICommandHandler
{
	OBJECT_NOCOPY_METHODS( CAnimationBuilder );

	CAnimationBuilder();
	~CAnimationBuilder();

	bool UpdateAminations( const string &rszAnimationFolder );
protected:
	// ICommandHandler
	bool HandleCommand( UINT nCommandID, DWORD dwData );
	bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );
	// IBuildDataCallback
	bool IsValidBuildData( IManipulator *pBuildDataManipulator, string *pszDescription, IView *pBuildDataView );
	bool IsUniqueObjectName( const string &szObjectType, const string &szObjectName );

	// methods
	DWORD GetWeaponBits( const SGrannyBoneAttributes & gba ) const;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__ANIMATION_BUILDER__)
