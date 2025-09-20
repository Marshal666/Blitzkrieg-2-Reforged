#pragma once

#include "../MapEditorLib/DefaultInputState.h"
#include "../MapEditorLib/Interface_CommandHandler.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SCameraPos
{
	CVec3 vAnchor;
	float fYaw;
	float fPitch;
	float fDistance;
	bool bUseAnchorOnly;
	//
	SCameraPos()
		: vAnchor( VNULL3 ), 
			fYaw( 45.0f ), 
			fPitch( 45.0f ), 
			fDistance( 170.0f ), 
			bUseAnchorOnly( true )
	{
	}
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//		CAMERA POSITION STATE
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CMapInfoEditor;
class CSceneDrawTool;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CCameraPositionState : public CDefaultInputState, public ICommandHandler
{
	CMapInfoEditor *pMapInfoEditor;
	//
	int nCurrentPlayer;
	bool bMove;
	//
	void RefreshWindow( bool bGetFromDB );
	int GetPlayersCountFromDB();
	void SavePosition();
	bool IsGoodCamPos( const SCameraPos &rCamPos );
	SCameraPos GetDefaultCamPos();
	void GetDBInfo();
	//
	vector<SCameraPos> cameraPositions;
	CSceneDrawTool sceneDrawTool;

public:

	//	CDefaultInputState
	void Enter();
	void Leave();
	void Draw( CPaintDC *pPaintDC );
	void PostDraw( CPaintDC *pPaintDC );
	void DrawLabel( CPaintDC *pPaintDC, const string &szLabel, const CVec2 &pos );
	
	void OnLButtonDown( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnMouseMove( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonUp( UINT nFlags, const CTPoint<int> &rMousePoint );

	//	ICommandHandler
	bool HandleCommand( UINT nCommandID, DWORD dwData );
	bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );

	//	CCameraPositionState 
	CCameraPositionState( CMapInfoEditor* _pMapInfoEditor = 0 );
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
