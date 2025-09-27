#if !defined(__MAPINFO_EDITOR_DATA__OBJECT_INFO__)
#define __MAPINFO_EDITOR_DATA__OBJECT_INFO__
#pragma once

#include "MapInfoEditorData_Consts.h"
#include "..\MapEditorLib\MultiManipulator.h"
#include "..\MapEditorLib\MaskManipulator.h"
#include "..\MapEditorLib\ObjectController.h"
#include "Tools_SceneDraw.h"
#include "EditorScene.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NMapInfoEditor
{
	struct SObjectInfo : public CObjectBase
	{
		struct SMapInfoElement
		{
			string szRPGStatsTypeName;
			CDBID rpgStatsDBID;
			UINT nFrameIndex;																						// Frame index
			UINT nPlayer;																								// Player
			float fHP;																									// Hit points ( 0.0f ... 1.0f )
			//
			CVec3 vPosition;																						// ������������� ������� ������� (� AI ������)
			float fDirection;																						// ������������� ����������� ������� (� ��������)
			//
			CVec3 vAdditionalPosition;																	// �������������� �������� ������� (����������� ��� ������������ �� grid) (� AI ������)
			float fAdditionalDirection;																	// ������������� ����������� ������� ( ����������� ��� ������������ �� 90 �������� ) (� ��������)
			//
			CLinkIDList linkedLinkIDIist;																// ������ ������������� ��������
			UINT nLinkToLinkID;																					// ������ � �������� �����������
			//
			SMapInfoElement()
				:	nFrameIndex( INVALID_NODE_ID ),
					nPlayer( INVALID_NODE_ID ),
					fHP( 1.0f ),
					vPosition( VNULL3 ),
					fDirection( 0.0f ),
					vAdditionalPosition( VNULL3 ),
					fAdditionalDirection( 0.0f ),
					nLinkToLinkID( INVALID_NODE_ID ) {}
			SMapInfoElement( const SMapInfoElement &rMapInfoElement )
				: szRPGStatsTypeName( rMapInfoElement.szRPGStatsTypeName ),
					rpgStatsDBID( rMapInfoElement.rpgStatsDBID ),
					nFrameIndex( rMapInfoElement.nFrameIndex ),
					nPlayer( rMapInfoElement.nPlayer ),
					fHP( rMapInfoElement.fHP ),
					vPosition( rMapInfoElement.vPosition ),
					fDirection( rMapInfoElement.fDirection ),
					vAdditionalPosition( rMapInfoElement.vAdditionalPosition ),
					fAdditionalDirection( rMapInfoElement.fAdditionalDirection ),
					linkedLinkIDIist( rMapInfoElement.linkedLinkIDIist ),
					nLinkToLinkID( rMapInfoElement.nLinkToLinkID ) {}
			SMapInfoElement& operator=( const SMapInfoElement &rMapInfoElement )
			{
				if( &rMapInfoElement != this )
				{
					szRPGStatsTypeName = rMapInfoElement.szRPGStatsTypeName;
					rpgStatsDBID = rMapInfoElement.rpgStatsDBID;
					nFrameIndex = rMapInfoElement.nFrameIndex;
					nPlayer = rMapInfoElement.nPlayer;
					fHP = rMapInfoElement.fHP;
					vPosition = rMapInfoElement.vPosition;
					fDirection = rMapInfoElement.fDirection;
					vAdditionalPosition = rMapInfoElement.vAdditionalPosition;
					fAdditionalDirection = rMapInfoElement.fAdditionalDirection;
					linkedLinkIDIist = rMapInfoElement.linkedLinkIDIist;
					nLinkToLinkID = rMapInfoElement.nLinkToLinkID;
				}
				return *this;
			}	

			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			inline CVec3 GetPosition( const CVec3 &rvPosition ) const { return rvPosition + vPosition + vAdditionalPosition; }
			inline float GetDirection( const float _fDirection ) const { return _fDirection + fDirection + fAdditionalDirection; }
			inline FixInvalidPos( const CTRect<float> &rSize, const CVec3 &rvPosition )
			{
				const CVec3 vPos = GetPosition( rvPosition );
				CVec3 vNewPos = vPos;
				if ( rSize.maxx > 0.0f )
				{
					vNewPos.x = Clamp( vNewPos.x, rSize.minx, rSize.maxx );
				}
				if ( rSize.maxy > 0.0f )
				{
					vNewPos.y = Clamp( vNewPos.y, rSize.miny, rSize.maxy );
				}
				if ( vNewPos != vPos )
				{
					// ���������� �������� � ���������� ��������
					vAdditionalPosition += ( vNewPos - vPos );
				}
			}

			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			void Trace() const
			{
				DebugTrace( "pos: ( %g, %g, %g ), dir: %d, addPos: ( %g, %g, %g ), addDir: %d",
										vPosition.x,
										vPosition.x,
										vPosition.x,
										fDirection,
										vAdditionalPosition.x,
										vAdditionalPosition.x,
										vAdditionalPosition.x,
										fAdditionalDirection );
				//
				DebugTrace( "RPGStatsTypeName: %s, rpgStatsDBID: %s, nFrameIndex: %d, nPlayer: %d",
										szRPGStatsTypeName.c_str(),
										rpgStatsDBID.ToString().c_str(),
										nFrameIndex,
										nPlayer );
				//
				DebugTrace( "linkedLinkIDIist, begin" );
				for ( CLinkIDList::const_iterator itLinkID = linkedLinkIDIist.begin(); itLinkID != linkedLinkIDIist.end(); ++itLinkID )
				{
					DebugTrace( "%d", *itLinkID );
				}
				DebugTrace( "linkedLinkIDIist, end" );
				DebugTrace( "nLinkToLinkID: %d", nLinkToLinkID );
			}
		};

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		struct SSceneElement
		{
			CVec3 vPosition;																						// ������������� ������� ���������� ����� ��������� � ������������� �������� SMapInfoElement (� AI ������)
			float fDirection;																						// ������������� ����������� ���������� ����� � ������������� ��������� SMapInfoElement (� ��������)
			//
			CVec3 vAdditionalPosition;																	// �������������� �������� ������� (������������ SMapInfoElement) (� AI ������)
			float fAdditionalDirection;																	// ������������� ����������� ������� (������������ SMapInfoElement) (� ��������)
			//
			SSceneElement()
				:	vPosition( VNULL3 ),
					fDirection( 0.0f ),
					vAdditionalPosition( VNULL3 ),
					fAdditionalDirection( 0.0f ) {}
			SSceneElement( const SSceneElement &rSceneElement )
				:	vPosition( rSceneElement.vPosition ),
					fDirection( rSceneElement.fDirection ),
					vAdditionalPosition( rSceneElement.vAdditionalPosition ),
					fAdditionalDirection( rSceneElement.fAdditionalDirection ) {}
			SSceneElement& operator=( const SSceneElement &rSceneElement )
			{
				if( &rSceneElement != this )
				{
					vPosition = rSceneElement.vPosition;
					fDirection = rSceneElement.fDirection;
					vAdditionalPosition = rSceneElement.vAdditionalPosition;
					fAdditionalDirection = rSceneElement.fAdditionalDirection;
				}
				return *this;
			}	

			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			inline CVec3 GetPosition( const CVec3 &rvPosition ) const { return rvPosition + vPosition + vAdditionalPosition; }
			inline float GetDirection( const float _fDirection ) const { return _fDirection + fDirection + fAdditionalDirection; }
			void Trace() const
			{
				DebugTrace( "pos: ( %g, %g, %g ), dir: %d, addPos: ( %g, %g, %g ), addDir: %d",
										vPosition.x,
										vPosition.x,
										vPosition.x,
										fDirection,
										vAdditionalPosition.x,
										vAdditionalPosition.x,
										vAdditionalPosition.x,
										fAdditionalDirection );
			}
		};

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		typedef hash_map<UINT, SMapInfoElement> CMapInfoElementMap;		// ������������ LinkID ������� � ��������� ObjectInfoCollector � ������ �� �������
		typedef hash_map<UINT, SSceneElement> CSceneElementMap;				// ������������ SceneID ���������� ����� � ������ �� ���������� �����
		typedef hash_map<UINT, UINT> CSceneIDToLinkIDMap;							// ��������� ��������� ���������� ������������ � �������� �������
		//
		struct SObjectInfoCollector *pObjectInfoCollector;						// ������������ ���������
		UINT nObjectInfoID;																						// ID ������� � ������������ ���������
		CVec3 vPosition;																							// ������� ������� (� AI ������)
		float fDirection;																							// ����������� ������� (� ��������)
		//
		CMapInfoElementMap mapInfoElementMap;													// ����� ��������� �������
		CSceneElementMap sceneElementMap;															// ����� ���������� ������������
		CSceneIDToLinkIDMap sceneIDToLinkIDMap;												// �������� ���������� ������������ � �������� �������
		//
		virtual ~SObjectInfo() {}	
		//
		void MakeAbsolute();
		void MakeRelative();

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		inline UINT GetLinkIDBySceneID( UINT nSceneID )
		{
			if ( nSceneID != INVALID_NODE_ID )
			{
				SObjectInfo::CSceneIDToLinkIDMap::iterator posSceneIDToLinkID = sceneIDToLinkIDMap.find( nSceneID );
				if ( posSceneIDToLinkID != sceneIDToLinkIDMap.end() )
				{
					return posSceneIDToLinkID->second;
				}
			}
			return INVALID_NODE_ID;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		inline SMapInfoElement* GetMapInfoElementByLinkID( UINT nLinkID )
		{
			if ( nLinkID != INVALID_NODE_ID )
			{
				SObjectInfo::CMapInfoElementMap::iterator posMapInfoElement = mapInfoElementMap.find( nLinkID );
				if ( posMapInfoElement != mapInfoElementMap.end() )
				{
					return &( posMapInfoElement->second );
				}
			}
			return 0;
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		inline SMapInfoElement* GetMapInfoElementBySceneID( UINT nSceneID )
		{
			return GetMapInfoElementByLinkID( GetLinkIDBySceneID( nSceneID ) );
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		inline SSceneElement* GetSceneElementBySceneID( UINT nSceneID )
		{
			if ( nSceneID != INVALID_NODE_ID )
			{
				SObjectInfo::CSceneElementMap::iterator posSceneElement = sceneElementMap.find( nSceneID );
				if ( posSceneElement != sceneElementMap.end() )
				{
					return &( posSceneElement->second );
				}
			}
			return 0;
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// ���� ������������ ������ ����� � ��������� ID ���������� true
		virtual bool Pick( UINT nSceneID );
		virtual bool Pick( const CVec3 &rvPos ) { return false; }
		virtual bool Pick( const CSelectionSquare &rSelectionSquare ) { return false; }
		// ������ ������
		virtual bool Draw( CSceneDrawTool *pEditorSceneDrawTool );

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// ��������������� ������
		virtual bool UpdateDBLinkedObjects( CObjectBaseController *pObjectController, IManipulator *pManipulator );
		virtual bool MoveLinkedObjects( const SObjectEditInfo *pObjectEditInfo, const CVec3 &rvNewPosition,
																		bool bUpdateScene, IEditorScene *pEditorScene,
																		bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator  );
		virtual bool RotateLinkedObjects( const SObjectEditInfo *pObjectEditInfo, float fNewDirection,
																			bool bUpdateScene, IEditorScene *pEditorScene,
																			bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		//
		virtual void UpdateSceneElements( bool bModel, bool bPosition, bool bDirection, float fAdditionalDirection );
		//
		virtual void ClearAdditionalPosition( bool bUpdateSceneElements );
		virtual void ClearAdditionalDirection( bool bUpdateSceneElements );
		//
		virtual void FitToGrid( bool bUpdateSceneElements );
		virtual void RotateTo90Degree( bool bUpdateSceneElements );
		virtual void SetCommonHeight( bool bUpdateSceneElements );
		virtual void FixInvalidPos( bool bUpdateSceneElements );

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// ����������� ������
		virtual SObjectInfo* CallDuplicate() const = 0;
		virtual EObjectInfoType GetObjectInfoType() = 0;
		// �����������
		virtual void GetDrawSelectionParameters( DWORD *pdwSceneObject, DWORD *pdwObject, DWORD *pdwObjectLink, DWORD *pdwMainObject )
		{
			if ( pdwSceneObject )
			{
				( *pdwSceneObject ) = DRAW_SELECTION_CIRCLE0 | DRAW_SELECTION_POINT_CIRCLE | DRAW_DIRECTION | DRAW_DIRECTION_POINT;
			}
			if ( pdwObject )
			{
				( *pdwObject ) = 0;
			}
			if ( pdwObjectLink )
			{
				( *pdwObjectLink ) = DRAW_SELECTION_CIRCLE0 | DRAW_DIRECTION;
			}
			if ( pdwMainObject )
			{
				( *pdwMainObject ) = 0;
			}
		}
		virtual bool NeedMakeOrientation() = 0;
		virtual bool KeepZeroHeight() = 0;
		virtual bool KeepCommonHeight() = 0;
		virtual bool NeedProcessEditParameters() = 0;
		// ���������
		// ��������� ������ �� ����
		virtual bool Load( const SObjectLoadInfo* pObjectLoadInfo, IEditorScene *pEditorScene, IManipulator *pManipulator ) = 0;
		// ������� ������
		virtual bool Create( const SObjectCreateInfo* pObjectCreateInfo, IEditorScene *pEditorScene, CObjectBaseController *pObjectController, IManipulator *pManipulator ) = 0;
		// ��������� ���������� MaskManipulator
		virtual void InsertMaskManipulators( CMultiManipulator *pPropertyManipulator, IManipulator *pManipulator );
		virtual void FillMaskManipulator( CMaskManipulator *pMaskManipulator ) = 0;
		virtual void GetMask( string *pszMask ) = 0;
		virtual void CreateSceneObjects( IEditorScene *pEditorScene, IManipulator *pManipulator, bool bUpdateParentStructure );
		virtual void SetSceneObjectOpacity( IEditorScene *pEditorScene, const float fOpacity );
		// ������ ������� ���������� �����������
		// ��������� ������ �������, ������� ����� ��������� ����� ��� ������� ���������
		virtual bool PostLoad( IEditorScene *pEditorScene, IManipulator *pManipulator );
		// �������� ��������� �������
		virtual bool Move( const SObjectEditInfo *pObjectEditInfo, const CVec3 &rvNewPosition,
											 bool bMoveLinkedObjects,
											 bool bUpdateScene, IEditorScene *pEditorScene,
											 bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// �������� ���� �������
		virtual bool Rotate( const SObjectEditInfo *pObjectEditInfo, float fNewDirection,
												 bool bRotateLinkedObjects,
												 bool bUpdateScene, IEditorScene *pEditorScene,
												 bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ��������� ������� � �����
		virtual bool UpdateScene( IEditorScene *pEditorScene );
		// ��������� ������� � ���� ������
		virtual bool UpdateDB( bool bUpdateLinkedObjects, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ������ ��� �������� �� �����  ( call only from Remove )
		virtual void RemoveFromScene( IEditorScene *pEditorScene, bool bUpdateParentStructure );
		// ������ ��� �������� ���������� �� ���� ������  ( call only from Remove )
		virtual bool RemoveFromDB( CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ���������� ������������� �� SObjectInfoCollector::RemoveObjectInfo()
		// �������� UpdateDBLinkedObjects, RemoveLinkTo, RemoveLinks, RemoveFromScene, RemoveFromDB
		virtual void Remove( bool bUpdateScene, IEditorScene *pEditorScene,
												 bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ��������� �� ����������� �������� ����� ��� ����� �������
		virtual bool CheckLinkCapability( UINT nLinkToSceneID ) const;
		// �������� ���� �� ��������� ������
		virtual bool InsertLink( bool bUpdateDB, UINT nLinkToSceneID, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ������� ����� � �������� �� ����� �����, ������� ��������� �� ������, ����� ������ ����� ������ �� ������ ����� �� ���������
		virtual bool RemoveLinks( bool bUpdateLinkedObjects, bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		// ������� ����� � �������, ����� ������ ����� ������ ������ �� ������ �� ���������
		virtual bool RemoveLinkTo( bool bUpdateDB, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		//
		virtual void UpdateByController( UINT nLinkID, UINT nFlags, IEditorScene *pEditorScene, IManipulator *pManipulator );
		//
		virtual void CopySelf();
		virtual void PasteLinkIDList( CLinkIDMap *pNew2OldLinkIDMap, CLinkIDMap *pOld2NewLinkIDMap );
		virtual bool PasteSelf( CLinkIDMap *pNew2OldLinkIDMap, CLinkIDMap *pOld2NewLinkIDMap, IEditorScene *pEditorScene, CObjectBaseController *pObjectController, IManipulator *pManipulator );
		//
		virtual void Trace() const;
	};
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__MAPINFO_EDITOR_DATA__OBJECT_INFO__)
