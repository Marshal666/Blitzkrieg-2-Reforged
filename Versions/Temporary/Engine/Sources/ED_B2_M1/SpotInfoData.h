#if !defined(__SPOT_INFO_DATA__)
#define __SPOT_INFO_DATA__
#pragma once

#include "MapInfoEditorData.h"
#include "..\Misc\Planegeometry.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NMapInfoEditor
{
	//  Spot Square
	//
	//  v3                            v2
	//  |-----------------------------|
	//  |                             |
	//  |                             |
	//  |                             |
	//  |                             |
	//  |                             |
	//  |                             |
	//  |              *              |
	//  |              vPosition      |
	//  |                             |
	//  |                             |
	//  |                             |
	//  |                             |
	//  |                  vDirection |
	//  |---------------------------->|
	//  v0                            v1
	//
	typedef vector<CVec2> CSpotSquare;
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	struct SSpotLoadInfo : public SObjectLoadInfo
	{
		CSpotSquare spotSquare;
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	struct SSpotCreateInfo : public SObjectCreateInfo
	{
		CSpotSquare spotSquare;
	};

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	struct SSpotInfo : public SObjectInfo
	{
		OBJECT_BASIC_METHODS( SSpotInfo );

	public:
		string szRPGStatsTypeName;
		CDBID rpgStatsDBID;
		UINT nLinkID;
		CSpotSquare spotSquare;
		CVec3 vAdditionalPosition;
		//
		void MakeAbsoluteSpotSquare()
		{
			NI_ASSERT( ( spotSquare.size() == 4 ), "MakeAbsoluteSpotSquare(), spotSquare.size() != 4" );
			const CVec2 vMassCenter = CVec2( vPosition.x + vAdditionalPosition.x, vPosition.y + vAdditionalPosition.y );
			for ( CSpotSquare::iterator itSpotPoint = spotSquare.begin(); itSpotPoint != spotSquare.end(); ++itSpotPoint )
			{
				( *itSpotPoint ) += vMassCenter;
			}
		}
		//
		void MakeRelativeSpotSquare( bool bDirection )
		{
			NI_ASSERT( ( spotSquare.size() == 4 ), "MakeAbsoluteSpotSquare(), spotSquare.size() != 4" );
			CVec2 vMassCenter = VNULL2;
			GetPolygonMassCenter( spotSquare, &vMassCenter );
			for ( CSpotSquare::iterator itSpotPoint = spotSquare.begin(); itSpotPoint != spotSquare.end(); ++itSpotPoint )
			{
				( *itSpotPoint ) -= vMassCenter;
			}
			vPosition = CVec3( vMassCenter.x - vAdditionalPosition.x, vMassCenter.y - vAdditionalPosition.y, 0.0f );
			if ( bDirection )
			{ 
				fDirection = GetPolarAngle( spotSquare[1] - spotSquare[0] );
			}
		}
		void ClearAdditionalPosition( bool bUpdateSceneElements ) { vAdditionalPosition = VNULL3; }
		//
		// ���� ������������ ������ ���������� true
		bool Pick( const CVec3 &rvPos );
		bool Pick( const CSelectionSquare &rSelectionSquare );
		// ������ ������
		bool Draw( CSceneDrawTool *pSceneDrawTool );
		//
		// ��������������� ������
		void UpdateSceneElements( bool bModel, bool bPosition, bool bDirection, float fAdditionalDirection ) {}
		//
		void FitToGrid( bool bUpdateSceneElements ) {}
		void RotateTo90Degree( bool bUpdateSceneElements ) {}
		void SetCommonHeight( bool bUpdateSceneElements ) {}
		void FixInvalidPos( bool bUpdateSceneElements );

		// ����������� ������
		// �����������
		void GetDrawSelectionParameters( DWORD *pdwSceneObject, DWORD *pdwObject, DWORD *pdwObjectLink, DWORD *pdwMainObject ) {}
		bool NeedMakeOrientation() { return false; }
		bool KeepZeroHeight() { return false; }
		bool KeepCommonHeight() { return false; }
		bool NeedProcessEditParameters() { return true; }
		// ���������
		SObjectInfo* CallDuplicate() const { return Duplicate(); }
		EObjectInfoType GetObjectInfoType()  { return OIT_SPOT; }
		// ��������� ������ �� ����
		bool Load( const SObjectLoadInfo* pObjectLoadInfo, IEditorScene *pEditorScene, IManipulator *pManipulator );
		// ������� ������
		bool Create( const SObjectCreateInfo* pObjectCreateInfo, IEditorScene *pEditorScene, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ��������� ���������� MaskManipulator
		void InsertMaskManipulators( class CMultiManipulator *pPropertyManipulator, IManipulator *pManipulator ) {}
		void FillMaskManipulator( class CMaskManipulator *pMaskManipulator ) {}
		void GetMask( string *pszMask ) {}
		//
		// ������ ������� ���������� �����������
		// ��������� ������ �������, ������� ����� ��������� ����� ��� ������� ���������
		bool PostLoad( IEditorScene *pEditorScene, IManipulator *pManipulator ) { return true; }
		// �������� ��������� �������
		bool Move( const SObjectEditInfo *pObjectEditInfo, const CVec3 &rvNewPosition,
							 bool bMoveLinkedObjects,
							 bool bUpdateScene, IEditorScene *pEditorScene,
							 bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// �������� ���� �������
		bool Rotate( const SObjectEditInfo *pObjectEditInfo, float fNewDirection,
								 bool bRotateLinkedObjects,
								 bool bUpdateScene, IEditorScene *pEditorScene,
								 bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ��������� ������� � �����
		bool UpdateScene( IEditorScene *pEditorScene );
		// ��������� ������� � ���� ������
		bool UpdateDB( bool bUpdateLinkedObjects, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		bool RemoveFromDB( CObjectBaseController *pObjectController, IManipulator *pManipulator ) { return true; }
		void Remove( bool bUpdateScene, IEditorScene *pEditorScene,
								 bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ��������� �� ����������� �������� ����� ��� ����� �������
		bool CheckLinkCapability( UINT nSceneObjectIDLinkTo ) { return false; }
		// �������� ���� �� ��������� ������
		bool InsertLink( bool bUpdateDB, UINT nSceneObjectIDLinkTo, CObjectBaseController *pObjectController, IManipulator *pManipulator ) { return true; }
		// ������� ����� � �������� �� ����� �����, ������� ��������� �� ������, ����� ������ ����� ������ �� ������ ����� �� ���������
		bool RemoveLinks( bool bUpdateLinkedObjects, bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator ) { return true; }
		// ������� ����� � �������, ����� ������ ����� ������ ������ �� ������ �� ���������
		bool RemoveLinkTo( bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator ) { return true; }
		//
		void UpdateByController( UINT nSpotID, UINT nFlags, IEditorScene *pEditorScene, IManipulator *pManipulator );
		//
		void CreateSceneObjects( IEditorScene *pEditorScene, IManipulator *pManipulator, bool bUpdateParentStructure );
		void RemoveFromScene( IEditorScene *pEditorScene, bool bUpdateParentStructure );
		void SetSceneObjectOpacity( IEditorScene *pEditorScene, const float fOpacity ) {}

		void CopySelf();
		void PasteLinkIDList( CLinkIDMap *pNew2OldLinkIDMap, CLinkIDMap *pOld2NewLinkIDMap );
		bool PasteSelf( CLinkIDMap *pNew2OldLinkIDMap, CLinkIDMap *pOld2NewLinkIDMap, IEditorScene *pEditorScene, CObjectBaseController *pObjectController, IManipulator *pManipulator );
	};
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__SPOT_INFO_DATA__)
