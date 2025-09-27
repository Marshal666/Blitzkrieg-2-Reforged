#if !defined(__FENCE_STATE__)
#define __FENCE_STATE__
#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "..\misc\2darray.h"
#include "..\zlib\zconf.h"
#include "..\stats_b2_m1\iconsset.h"
#include "..\sceneb2\scene.h"
#include "SimpleObjectState.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//				FENCE DESIGN TOOL
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CFenceDesignTool
{
	bool bEnabled;			// ����� � ������
	bool bComplete;			// ������ ������ ������ ������ - ����� �������� �����
	CVec3 vRayOrigin;		// ����� ������ ����� ������
	float fRayDir;			// ����������� �����
	bool bFitToAIGrid;	// ����������� � �����
	int nNumSections;		// ������� ����� ����� ������ 
	float fSectionLen;	// ����� ����� ������

	CVec3 GetFencePlace( const CVec3 &p );	// ���� ����� ���������� � p ����� (���� bFitToAIGrd == false ����� ������ ���������� p)
	void Complete();												// ��������� ������� �����

public:
	bool bRay;					// ������������� ����� ������ ����� ������ ��� ���
	CVec3 vLastPos;

	CFenceDesignTool() : bEnabled( false ) {} 
	//
	void SetUp( bool bFitToAIGrd, const NDb::SFenceRPGStats *pStats );
	void Clear();
	//
	bool ProcessLClickPoint( const CVec3 &p );
	bool ProcessRClickPoint( const CVec3 &p );
	bool ProcessEscape();
	bool ProcessMovePoint( const CVec3 &p );
	//
	bool IsComplete();
	float GetCurSectionLen() { return fSectionLen; }
	///
	struct SFenceSectionInfo
	{
		CVec3 vPosition;
		float fDirection;
	};
	void GetSectionsInfo( vector<SFenceSectionInfo> *pSectionInfo, NDb::SFenceRPGStats::EFencePlacementMode ePlacementMode ); 
	///
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//	FENCE STATE
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CFenceState : public CMapObjectState
{
	friend class CMultiInputState;
	friend class CMapInfoState;
	//
	NMapInfoEditor::CSceneIDList tmpSceneObjectsIDList;
	CFenceDesignTool designTool;
	//
	void InsertFence();
	void ClearData();
	//
	// ��������� ��� ���������� �����
	struct SSelectedFenceInfo
	{ 
		string szRPGStatsTypeName;
		CDBID rpgStatsDBID;
		const NDb::SFenceRPGStats *pFenceRPGStats;
		SSelectedFenceInfo() : pFenceRPGStats( 0 ) {}
	};	
	SSelectedFenceInfo selectedFenceInfo;
	void RefreshSelectedFenceInfo();
	//
	int InsertFenceSection( NMapInfoEditor::SObjectCreateInfo *pSectionCreateInfo, IEditorScene *pEditorScene, IManipulator *pManipulator, CObjectBaseController *pObjectController );
	//
	void ClearScene();
	void FillScene( UINT nFlags, const CVec3 &rTerrainPos );
	//
public:
	CFenceState( CMapObjectMultiState* _pParentState = 0 ) : CMapObjectState( _pParentState )
	{
		NI_ASSERT( pParentState != 0, StrFmt( "CFenceState(): pParentState == 0" ) );
		ClearData();
	}
	//
	bool IsDrawSceneDrawTool() { return true; }
	//
	void InsertObjectEnter();
	void InsertObjectLeave();
	void InsertObjectDraw( class CPaintDC *pPaintDC );
	//
	bool InsertObjectMouseMove( UINT nFlags, const CVec3 &rTerrainPos );
	bool InsertObjectLButtonDown( UINT nFlags, const CVec3 &rTerrainPos );
	bool InsertObjectRButtonUp( UINT nFlags, const CVec3 &rTerrainPos );
	bool InsertObjectKeyDown( UINT nChar, UINT nFlags, const CVec3 &rTerrainPos );
	//
	virtual bool HandleCommand( UINT nCommandID, DWORD dwData );
	virtual bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );
	//
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // #if !defined(__FENCE_STATE__)
