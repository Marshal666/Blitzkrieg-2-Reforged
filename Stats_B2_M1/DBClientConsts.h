#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// automatically generated file, don't change manually!

#include "acktypes.h"
#include "m1actions.h"
#include "rpgstats.h"
#include "useractions.h"
#include "../system/filepath.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IXmlSaver;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
	struct SVisObj;
	struct SCameraLimits;
	struct SIconsSet;

	struct SWCActionsPriority
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		vector< EUserAction > selfActions;
		vector< EUserAction > friendActions;
		vector< EUserAction > enemyActions;
		vector< EUserAction > neutralActions;

		SWCActionsPriority() :
			__dwCheckSum( 0 )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};

	struct SM1WCActionsPriority
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		vector< EM1Action > selfActions;
		vector< EM1Action > friendActions;
		vector< EM1Action > enemyActions;
		vector< EM1Action > neutralActions;

		SM1WCActionsPriority() :
			__dwCheckSum( 0 )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};

	struct SCursor
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		NFile::CFilePath szFileName;
		EUserAction eAction;
		EM1Action eM1Action;

		SCursor() :
			__dwCheckSum( 0 ),
			eAction( USER_ACTION_UNKNOWN ),
			eM1Action( M1_ACTION_UNKNOWN )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};

	struct SAckParameter
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		EUnitAckType eAckType;
		EAckClass eAckClass;
		NFile::CFilePath szTextStringFileRef;
		int nTimeAfterPrevious;
		EAckPosition ePosition;

		#include "include_AckParameter.h"

		SAckParameter() :
			__dwCheckSum( 0 ),
			eAckType( ACK_NONE ),
			eAckClass( ACKT_POSITIVE ),
			nTimeAfterPrevious( 1000 ),
			ePosition( ACK_POS_UNIT )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};

	struct SAckManagerConsts
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		int nMinAckRadius;
		int nMaxAckRadius;
		int nTimeAckWait;
		int nNumSelectionsBeforeAnnoyed;

		SAckManagerConsts() :
			__dwCheckSum( 0 ),
			nMinAckRadius( 0 ),
			nMaxAckRadius( 0 ),
			nTimeAckWait( 0 ),
			nNumSelectionsBeforeAnnoyed( 0 )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};

	struct SMapCommandAck
	{
	private:
		mutable DWORD __dwCheckSum;
	public:
		CDBPtr< SVisObj > pVisObj;
		float fShowTime;

		SMapCommandAck() :
			__dwCheckSum( 0 ),
			fShowTime( 0.0f )
		{ }
		//
		void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};

	struct SClientGameConsts : public CResource
	{
		OBJECT_BASIC_METHODS( SClientGameConsts )
	public:
		enum { typeID = 0x1007BA80 };
	private:
		mutable DWORD __dwCheckSum;
	public:

		struct SMechUnitIconsSet
		{
		private:
			mutable DWORD __dwCheckSum;
		public:
			EDesignUnitType eType;
			CDBPtr< SIconsSet > pIconsSet;
			float fRaising;
			float fHPBarLen;

			SMechUnitIconsSet() :
				__dwCheckSum( 0 ),
				eType( UNIT_TYPE_UNKNOWN ),
				fRaising( 0.0f ),
				fHPBarLen( 0.0f )
			{ }
			//
			void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
			//
			int operator&( IBinSaver &saver );
			int operator&( IXmlSaver &saver );
			DWORD CalcCheckSum() const;
		};

		struct SSquadIconsSet
		{
		private:
			mutable DWORD __dwCheckSum;
		public:
			EDesignSquadType eType;
			CDBPtr< SIconsSet > pIconsSet;
			float fRaising;
			float fHPBarLen;

			SSquadIconsSet() :
				__dwCheckSum( 0 ),
				eType( SQUAD_TYPE_UNKNOWN ),
				fRaising( 0.0f ),
				fHPBarLen( 0.0f )
			{ }
			//
			void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
			//
			int operator&( IBinSaver &saver );
			int operator&( IXmlSaver &saver );
			DWORD CalcCheckSum() const;
		};

		struct SBuildingIconsSet
		{
		private:
			mutable DWORD __dwCheckSum;
		public:
			EDesignBuildingType eType;
			CDBPtr< SIconsSet > pIconsSet;
			float fRaising;
			float fHPBarLen;

			SBuildingIconsSet() :
				__dwCheckSum( 0 ),
				eType( BUILDING_TYPE_UNKNOWN ),
				fRaising( 0.0f ),
				fHPBarLen( 0.0f )
			{ }
			//
			void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
			//
			int operator&( IBinSaver &saver );
			int operator&( IXmlSaver &saver );
			DWORD CalcCheckSum() const;
		};

		struct SPassengerIconsSet
		{
		private:
			mutable DWORD __dwCheckSum;
		public:
			CDBPtr< SIconsSet > pIconsSet;
			float fHPBarLen;

			SPassengerIconsSet() :
				__dwCheckSum( 0 ),
				fHPBarLen( 0.0f )
			{ }
			//
			void ReportMetaInfo( const string &szAddName, BYTE *pThis ) const;
			//
			int operator&( IBinSaver &saver );
			int operator&( IXmlSaver &saver );
			DWORD CalcCheckSum() const;
		};
		CDBPtr< SCameraLimits > pCamera;
		vector< SCursor > cursors;
		SWCActionsPriority actionsPriority;
		SM1WCActionsPriority m1ActionsPriority;
		vector< SAckParameter > acksParameters;
		SAckManagerConsts ackConsts;
		vector< SMechUnitIconsSet > mechUnitIconsSets;
		vector< SSquadIconsSet > squadIconsSets;
		vector< SBuildingIconsSet > buildingIconsSets;
		SPassengerIconsSet passengerIconsSet;
		SMapCommandAck mapCommandAck;
		SMapCommandAck mapCommandAckDir;
		CDBPtr< SVisObj > pMapPointer;
		NFile::CFilePath szNoises;

		#include "include_ClientGameConsts.h"

		SClientGameConsts() :
			__dwCheckSum( 0 )
		{ }
		//
		int GetTypeID() const { return typeID; }
		//
		void ReportMetaInfo() const;
		//
		int operator&( IBinSaver &saver );
		int operator&( IXmlSaver &saver );
		DWORD CalcCheckSum() const;
	};
}
