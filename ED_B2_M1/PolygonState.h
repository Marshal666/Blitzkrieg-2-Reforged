#if !defined(__POLYGON_STATE__)
#define __POLYGON_STATE__
#pragma once

#include "Tools_SceneDraw.h"
#include "..\MapEditorLib\MultiInputState.h"
#include "..\MapEditorLib\Interface_CommandHandler.h"
#include "MapInfoStoreInputState.h"
#include "../libdb/Manipulator.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CPolygonSelectState : public CDefaultInputState
{
	friend class CMultiInputState;
	friend class CPolygonState;
	
	class CPolygonState* pParentState;
	
	//������������ � ��������� ������������
	CPolygonSelectState() : pParentState( 0 )
  {
		NI_ASSERT( pParentState != 0, "CPolygonSelectState(): Invalid parameter: pParentState == 0" );
	}
	CPolygonSelectState( CPolygonState* _pParentState ) : pParentState( _pParentState )
	{
		NI_ASSERT( pParentState != 0, "CPolygonSelectState(): Invalid parameter: pParentState == 0" );
	}

	//IInputState interface
	void OnLButtonDown		( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnRButtonDown		( UINT nFlags, const CTPoint<int> &rMousePoint );
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CPolygonEditState : public CDefaultInputState
{
	friend class CMultiInputState;
	friend class CPolygonState;
	
	class CPolygonState* pParentState;
	
	//������������ � ��������� ������������
	CPolygonEditState() : pParentState( 0 )
  {
		NI_ASSERT( pParentState != 0, "CPolygonEditState(): Invalid parameter: pParentState == 0" );
	}
	CPolygonEditState( CPolygonState* _pParentState ) : pParentState( _pParentState )
	{
		NI_ASSERT( pParentState != 0, "CPolygonEditState(): Invalid parameter: pParentState == 0" );
	}

	//IInputState interface
	void OnMouseMove			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonDown		( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonDblClk	( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnKeyDown				( UINT nChar, UINT nRepCnt, UINT nFlags );
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CPolygonAddState : public CDefaultInputState
{
	friend class CMultiInputState;
	friend class CPolygonState;
	
	class CPolygonState* pParentState;
	
	//������������ � ��������� ������������
	CPolygonAddState() : pParentState( 0 )
  {
		NI_ASSERT( pParentState != 0, "CPolygonAddState(): Invalid parameter: pParentState == 0" );
	}
	CPolygonAddState( CPolygonState* _pParentState ) : pParentState( _pParentState )
	{
		NI_ASSERT( pParentState != 0, "CPolygonAddState(): Invalid parameter: pParentState == 0" );
	}

	void InsertPolygon();

	//IInputState interface
	void OnMouseMove			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnLButtonDblClk	( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnRButtonUp			( UINT nFlags, const CTPoint<int> &rMousePoint );
	void OnKeyDown				( UINT nChar, UINT nRepCnt, UINT nFlags );
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CPolygonState : public CMultiInputState, public ICommandHandler
{
	friend class CPolygonStoreInputState;
	friend class CPolygonSelectState;
	friend class CPolygonEditState;
	friend class CPolygonAddState;
	//
	enum EInputStates
	{
		IS_SELECT	= 0,
		IS_EDIT		= 1,
		IS_ADD		= 2,
	};

protected:
	static const float CONTROL_POINT_RADIUS;
	static const int CONTROL_POINT_PARTS;
	static const float CENTER_POINT_RADIUS;
	static const DWORD CONTROL_POINT_COLOR;
	static const DWORD CONTROL_LINE_COLOR;
	//
	typedef vector<UINT> CPolygonIDList;
	typedef vector<CVec3> CControlPointList;

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
	enum EMoveType
	{
		MT_SINGLE = 0,
		MT_MULTI = 1,
		MT_ALL = 2,
	};
	//
protected:
	// ��� ���������� ������ Draw
	// ��� ������ SelectState
	// ��� ������ AddState
	// ��� ������ EditState
	CPolygonIDList pickPolygonIDList;							// ������ ID ���������� ���������
	CControlPointList controlPointList;						// ����������� ����� �������� ��� ����������,
																								// ��������� ��������� ��������� ����������� ����� ��� ��������������
	int nSelectedIndex;														// ������� ���������� ������� (������ ��� ID � ������� ���������� ���������) 
	int nSelectedControlPoint;										// ������� ���������� ����� � ��������
	CMapInfoStoreInputState *pStoreInputState;
	CSceneDrawTool sceneDrawTool;

	// �������� � ���� ������ ��� �������� ������ ������ - �����������
	inline void ValidateSelectedIndex()
	{
		if ( ( nSelectedIndex < 0 ) || ( nSelectedIndex >= pickPolygonIDList.size() ) )
		{
			nSelectedIndex = 0;
		}
	}
	inline int GetSelectedPolygonID()
	{ 
		if ( ( nSelectedIndex < 0 ) || ( nSelectedIndex >= pickPolygonIDList.size() ) )
		{
			return INVALID_NODE_ID;
		}
		else
		{
			return pickPolygonIDList[nSelectedIndex];
		}
	}

	void OnDelete();

	//IInputState interface
	virtual void Enter();
	virtual void Leave();
	virtual void Draw( class CPaintDC *pPaintDC );
	virtual void OnSetFocus( class CWnd* pNewWnd );

	//virtual void OnSetFocus( class CWnd* pNewWnd );
	// CPolygonState
	// ����� �� ��������� ������� ����� ���������� ��� �������� ���� ��������������
	virtual bool SkipEnterAfterInsert() = 0;
	// �������� ����� ���� ��������������
	virtual bool CanEdit() = 0;
	// ����� �� ������� ����� �������
	virtual bool CanInsertPolygon() = 0;
	// ������� ������� ��� �� �������
	virtual bool IsClosedPolygon() = 0;
	// ���������� draw tool ��� �������� � ��� ���� ����-������ � ����� ����������
	virtual bool IsDrawSceneDrawTool() = 0;
	// �������� ������ ��������������
	virtual EMoveType GetMoveType() = 0;
	// �������� ����������� � ������������ ���������� control points
	virtual void GetBounds( int *pnMinCount, int *pnMaxCount ) = 0;
	// �������� ����������� ����� ���������� ��������
	virtual CControlPointList* GetControlPoints( int nPolygonID ) = 0;
	// ���������� ������ ����������� ����� ����� ����������� ��������
	virtual bool PrepareControlPoints( CControlPointList *pControlPointList ) = 0;
	// �� ����� �������� ���������� �������� (����� �� ID)
	virtual void PickPolygon( const CVec3 &rvPos, CPolygonIDList *pPickPolygonIDList ) = 0;
	// �������� ������� (���� �������� ��� ������������ �����)
	virtual void UpdatePolygon( int nPolygonID, EUpdateType eEpdateType ) = 0;
	// �������� ������� (���������� ID ������������ ��������)
	virtual UINT InsertPolygon( const CControlPointList &rControlPointList ) = 0;
	// ������� ������� �� ���������� ID
	virtual void RemovePolygon( int nPolygonID ) = 0;
public:
	//
	//������������ � ��������� ������������
	CPolygonState() : nSelectedIndex( INVALID_NODE_ID ), nSelectedControlPoint( INVALID_NODE_ID )
	{
		pStoreInputState = new CMapInfoStoreInputState();
		NI_ASSERT( pStoreInputState != 0, StrFmt( "CPolygonState(): pStoreInputState == 0" ) );
		
		int nStateIndex = INVALID_INPUT_STATE_INDEX;
		
		CPolygonSelectState *pPolygonSelectState = new CPolygonSelectState( this );
		nStateIndex = AddInputState( pPolygonSelectState );
		NI_ASSERT( nStateIndex == IS_SELECT, StrFmt( "CPolygonState(): Wrong state number: %d (%d)", nStateIndex, IS_SELECT ) );

		CPolygonEditState *pPolygonEditState = new CPolygonEditState( this );
		nStateIndex = AddInputState( pPolygonEditState );
		NI_ASSERT( nStateIndex == IS_EDIT, StrFmt( "CPolygonState(): Wrong state number: %d, (%d)", nStateIndex, IS_EDIT ) );
		
		CPolygonAddState *pPolygonAddState = new CPolygonAddState( this );
		nStateIndex = AddInputState( pPolygonAddState );
		NI_ASSERT( nStateIndex == IS_ADD, StrFmt( "CPolygonState(): Wrong state number: %d, (%d)", nStateIndex, IS_ADD ) );

		SetActiveInputState( IS_SELECT, true, false );
	}
	//
	~CPolygonState()
	{
		if ( pStoreInputState )
		{
			delete pStoreInputState;
		}
		pStoreInputState = 0;
	}

	//ICommandHandler
	virtual bool HandleCommand( UINT nCommandID, DWORD dwData );
	virtual bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__POLYGON_STATE__)

