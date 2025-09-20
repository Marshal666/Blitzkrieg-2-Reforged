#if !defined(__TERRAIN_EDITOR__)
#define __TERRAIN_EDITOR__
#pragma once

#include "..\MapEditorLib\EditorBase.h"
#include "..\MapEditorLib\Interface_CommandHandler.h"
#include "..\MapEditorLib\DefaultView.h"
#include "TerrainState.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CTerrainEditor : public CEditorBase, public CDefaultView, public ICommandHandler
{
	friend class CTerrainState;
	OBJECT_NOCOPY_METHODS( CTerrainEditor );
	//������ ����������� ��� ������� ����������
	// ������ ������ ���������� 
	CTerrainState *pTerrainState;
	//
	CTerrainEditor();
	//
public:
	//IEditor
	void GetTemporaryLabel( string *pszTemporaryLabel ) { pszTemporaryLabel->clear(); }
	IView* GetView() { return this; }
	IInputState* GetInputState() { return pTerrainState; }
	void GetChildFrameType( string *pszChildFrameTypeName ) { ( *pszChildFrameTypeName ) = "__CHILD_FRAME_DX_SCENE_LABEL__"; }
	void CreateControls() {}
	void PostCreateControls() {}
	void PreDestroyControls() {}
	void DestroyControls() { Destroy(); }
	void Create();
	void Destroy();

	//CDefaultView
	void Undo( IController* pController ) {}
	void Redo( IController* pController ) {}
	
	//ICommandHandler
	bool HandleCommand( UINT nCommandID, DWORD dwData ) { return false; }
	bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck ) { return false; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__TERRAIN_EDITOR__)
