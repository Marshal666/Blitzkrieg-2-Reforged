#if !defined(__VSO_STATE__)
#define __VSO_STATE__
#pragma once

#include "..\misc\2darray.h"
#include "..\zlib\zconf.h"
#include "..\stats_b2_m1\iconsset.h"
#include "../libdb/manipulator.h"
#include "VSOManager.h"
#include "..\MapEditorLib\Interface_CommandHandler.h"
#include "..\MapEditorLib\MultiInputState.h"
#include "MapInfoStoreInputState.h"
#include "..\B2_M1_Terrain\DBVSO.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NExtraDraw
{
	enum
	{
		EDM_SAMPS		= 0x0000000F,
		EDM_RIDGES	= 0x000000F0,
		EDM_VERTS		= 0x00000F00,
		EDM_HEIGHTS	= 0x0000F000,
		EDM_LOWS		= 0x000F0000,
		EDM_UPS			= 0x00F00000,
		EDM_ALL			= EDM_SAMPS | EDM_RIDGES | EDM_VERTS | EDM_HEIGHTS | EDM_LOWS | EDM_UPS,
	};
	const DWORD EC_SAMPS		= 0xFFFF0000; // RED
	const DWORD EC_RIDGES		= 0xFF00FF00; // GREEN
	const DWORD EC_VERTS		= 0xFF0000FF; // BLUE
	const DWORD EC_HEIGHTS	= 0xFFFFFF00; // YELLOW
	const DWORD EC_LOWS			= 0xFF00FFFF; // CYAN
	const DWORD EC_UPS			= 0xFFFF00FF; // MAGENTA

	void DrawExtraLines( CSceneDrawTool *pSceneDrawTool, UINT uMode );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CVSOSelectState : public CDefaultInputState
{
	friend class CMultiInputState;
	friend class CVSOState;
	
	class CVSOState* pParentState;
	
	//������������ � ��������� ������������
	CVSOSelectState() : pParentState( 0 )
  {
		NI_ASSERT( pParentState != 0, "CVSOSelectState(): Invalid parameter: pParentState == 0" );
	}
	CVSOSelectState( CVSOState* _pParentState ) : pParentState( _pParentState )
	{
		NI_ASSERT( pParentState != 0, "CVSOSelectState(): Invalid parameter: pParentState == 0" );
	}

	//IInputState interface
	void OnLButtonDown		( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnRButtonDown		( UINT nFlags, const CTPoint<int> &rMousePoint );
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CVSOEditState : public CDefaultInputState
{
	friend class CMultiInputState;
	friend class CVSOState;
	
	class CVSOState* pParentState;
	
	//������������ � ��������� ������������
	CVSOEditState() : pParentState( 0 )
  {
		NI_ASSERT( pParentState != 0, "CVSOEditState(): Invalid parameter: pParentState == 0" );
	}
	CVSOEditState( CVSOState* _pParentState ) : pParentState( _pParentState )
	{
		NI_ASSERT( pParentState != 0, "CVSOEditState(): Invalid parameter: pParentState == 0" );
	}

	//IInputState interface
	void OnMouseMove			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonDown		( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonDblClk	( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnRButtonDown		( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnRButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnKeyDown				( UINT nChar, UINT nRepCnt, UINT nFlags );
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CVSOAddState : public CDefaultInputState
{
	friend class CMultiInputState;
	friend class CVSOState;
	
	class CVSOState* pParentState;
	
	//������������ � ��������� ������������
	CVSOAddState() : pParentState( 0 )
  {
		NI_ASSERT( pParentState != 0, "CVSOAddState(): Invalid parameter: pParentState == 0" );
	}
	CVSOAddState( CVSOState* _pParentState ) : pParentState( _pParentState )
	{
		NI_ASSERT( pParentState != 0, "CVSOAddState(): Invalid parameter: pParentState == 0" );
	}

	bool InsertVSO();

	//IInputState interface
	void OnSetFocus				( class CWnd* pNewWnd );
	void OnKillFocus			( class CWnd* pOldWnd );

	void OnMouseMove			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonDblClk	( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnRButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnKeyDown				( UINT nChar, UINT nRepCnt, UINT nFlags );
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CVSOState : public CMultiInputState, public ICommandHandler
{
private:
	friend class CVSOStoreInputState;
	friend class CVSOSelectState;
	friend class CVSOEditState;
	friend class CVSOAddState;
	friend class CVSOMultiState;
	//
	enum EInputStates
	{
		IS_SELECT	= 0,
		IS_EDIT		= 1,
		IS_ADD		= 2,
	};

protected:
	//
	typedef vector<int> CVSOIDList;

public:
	enum EUpdateType
	{
		UT_START								= 0,
		UT_START_MOVE						= 1,
		UT_CONTINUE_MOVE				= 2,
		UT_FINISH_MOVE					= 3,
		UT_CHANGE_POINT_NUMBER	= 4,
		UT_FINISH								= 5,
		UT_CANCEL								= 6,
	};
	//

private:
	// ����� ���������� ����������
	class CVSOMultiState* pParentState;
	CMapInfoStoreInputState *pStoreInputState;
	CSceneDrawTool sceneDrawTool;

	CVSOIDList pickVSOIDList;
	int nSelectedIndex;
	//
	NDb::SVSOInstance startVSOInstance;
	CVSOManager::SVSOSelection currentSelection;
	CTRect<float> mapRect;
	CVSOManager::SBackupKeyPoints backupKeyPoints;
	//
	CVSOManager::CVSOSelectionParamList leftButtonVSOSelectionParamList;
	CVSOManager::CVSOSelectionParamList rightButtonVSOSelectionParamList;
	
	void ClearPickVSOIDList()
	{
		pickVSOIDList.clear();
		nSelectedIndex = INVALID_NODE_ID;
	}

	void ClearStartVSOPointList()
	{
		startVSOInstance.controlPoints.clear();
		startVSOInstance.points.clear();
	}

protected:
	// �������� � ���� ������ ��� �������� ������ ������ - �����������
	inline void ValidateSelectedIndex()
	{
		if ( pickVSOIDList.empty() )
		{
			nSelectedIndex = INVALID_NODE_ID;
		}
		else if ( ( nSelectedIndex < 0 ) || ( nSelectedIndex >= pickVSOIDList.size() ) )
		{
			nSelectedIndex = 0;
		}
	}
	inline int GetSelectedVSOID()
	{ 
		if ( ( nSelectedIndex < 0 ) || ( nSelectedIndex >= pickVSOIDList.size() ) )
		{
			return INVALID_NODE_ID;
		}
		else
		{
			return pickVSOIDList[nSelectedIndex];
		}
	}
	inline class CVSOMultiState* GetParentState() { return pParentState; }

	void ClearSelection();

	//IInputState interface
	virtual void Enter();
	virtual void Leave();
	virtual void Draw( class CPaintDC *pPaintDC );
	
	virtual void OnSetFocus( class CWnd* pNewWnd );

	// CVSOState
	// ��� ���������� ������ VSO ���������� ������������ ��� ��������
	virtual void UpdateVisualVSO( NDb::SVSOInstance *pVSO, bool bBothEdges );
	// �������� ����� ���� ��������������
	virtual bool CanEdit() = 0;
	// ���������� draw tool ��� �������� � ��� ���� ����-������ � ����� ����������
	virtual bool IsDrawSceneDrawTool() = 0;
	// ��������� ������ ��������������
	// ���������� ����������� ������������� ��������� �����
	virtual bool CanEditPoints( CVSOManager::SVSOSelection::ESelectionType eSelectionType ) = 0;
	// ���� VSO ������ �������� � 0
	virtual bool EdgesMustBeZero() = 0;
	// ���� VSO ������ ���� �� ��������� �����
	virtual bool IsEdgesMustBeOut() = 0;
	// VSOPoints ��������� ������� (�� ���������� � �������)
	virtual bool IsClose() = 0;
	// VSOPoints ������� ������ �� ��������� ����������� �����
	virtual bool IsComplete() = 0;
	// VSO �� ������������ � ������� VSO
	virtual bool NoIntersection() = 0;
	// VSO �� ������������ ��� � �����
	virtual bool NoSelfIntersection() = 0;
	// �������� ����������� � ������������ ���������� control points
	virtual void GetControlPointBounds( int *pnMinCount, int *pnMaxCount ) = 0;
	// ��� �������������
	virtual float GetDefaultStep() = 0;
	// ������ �������
	virtual float GetDefaultWidth() = 0;
	// ������ � �����
	virtual float GetDefaultHeight() = 0;
	// ������������ � �����
	virtual float GetDefaultOpacity() = 0;
	// ��� �������������
	virtual float GetDefaultStepOut() = 0;
	// �� ����� �������� ������������� ID VSO
	virtual void PickVSO( const CVec3 &rvPos, CVSOIDList *pPickVSOIDList ) = 0;
	// ����� �� ������� ����� ��������� VSO
	virtual bool CanInsertVSO() = 0;
	// ����� �� �������� ��������� VSO
	virtual bool CanUpdateVSO( int nVSOID ) = 0;
	// ����� �� ������� ��������� VSO
	virtual bool CanRemoveVSO( int nVSOID ) = 0;
	// �������� ������ � VSO
	virtual NDb::SVSOInstance* GetVSO( int nVSOID, int *pnVSOIndex ) = 0;
	// �������� �������������� ������ ( ��� ���� �������� )
	virtual void UpdateVSO( int nVSOID, EUpdateType eEpdateType, CVSOManager::SVSOSelection::ESelectionType eSelectionType, UINT nFlags ) = 0;
	// ����������� ������ ��� �������
	virtual void PrepareInsertVSO() = 0;
	// �������� VSO	( ���������� nVSOID ������������ VSO
	virtual int InsertVSO( const vector<CVec3> &rControlPointList ) = 0;
	// ������� VSO
	virtual void RemoveVSO( int nVSOID ) = 0;

public:
	//
	//������������ � ��������� ������������
	CVSOState( class CVSOMultiState *_pParentState = 0 ) : pParentState( _pParentState ), nSelectedIndex( INVALID_NODE_ID ), mapRect( 0.0f, 0.0f, 0.0f, 0.0f )
	{
		pStoreInputState = new CMapInfoStoreInputState();
		NI_ASSERT( pStoreInputState != 0, StrFmt( "CVSOState(): pStoreInputState == 0" ) );
		
		int nStateIndex = INVALID_INPUT_STATE_INDEX;
		
		CVSOSelectState *pVSOSelectState = new CVSOSelectState( this );
		nStateIndex = AddInputState( pVSOSelectState );
		NI_ASSERT( nStateIndex == IS_SELECT, StrFmt( "CVSOState(): Wrong state number: %d (%d)", nStateIndex, IS_SELECT ) );

		CVSOEditState *pVSOEditState = new CVSOEditState( this );
		nStateIndex = AddInputState( pVSOEditState );
		NI_ASSERT( nStateIndex == IS_EDIT, StrFmt( "CVSOState(): Wrong state number: %d, (%d)", nStateIndex, IS_EDIT ) );
		
		CVSOAddState *pVSOAddState = new CVSOAddState( this );
		nStateIndex = AddInputState( pVSOAddState );
		NI_ASSERT( nStateIndex == IS_ADD, StrFmt( "CVSOState(): Wrong state number: %d, (%d)", nStateIndex, IS_ADD ) );

		SetActiveInputState( IS_SELECT, true, false );
	}
	//
	~CVSOState()
	{
		if ( pStoreInputState )
		{
			delete pStoreInputState;
		}
		pStoreInputState = 0;
	}

	void SwitchToAddState();
	void RemoveSelectedVSO();
	//
	virtual class CMapInfoEditor* GetMapInfoEditor();
	
	bool PickOtherVSO( UINT nFlags, const CTPoint<int> &rMousePoint, const CVec3 &rvPos );
	void EmulateSelectLButtonDown( UINT nFlags, const CTPoint<int> &rMousePoint, const CVec3 &rvPos );
	// ICommandHandler
	virtual bool HandleCommand( UINT nCommandID, DWORD dwData );
	virtual bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__VSO_STATE__)
