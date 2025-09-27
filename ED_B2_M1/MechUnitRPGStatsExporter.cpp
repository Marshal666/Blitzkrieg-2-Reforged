/*

	*
	*
	*				��������
	*
	*


	Unit				Locator name							Description										Comments
	----------- ---------------						-----------------------				----------------------
	�����				MainGun										�����													������ � �����������
							MachineGun								�������	
							MachineGun_Turret_Coax		������� ��������� � ������	
							MachineGun_Turret_Back		������� ����� �� �����	
							MachineGun_Turret_Cupola	������� �� ������������ �������	
							MachineGun_Basis					�������� ������� �� �������	
							Smoke											����� ��������								� ��������� ��� �� �����
							FatalitySmoke							����� ���������� ��������	
							Exhaust										����� �������	
							TowingPoint								����� ������ �������	
							HookPoint									����� ������ �����	
							FrontWheel								������ ���� �������� �����	
							BackWheel									������ ���� ������ �����	
							People										����� ������ �����	
							Steam											��� �� ����� ��������	

	�����				MainGun										�����	
							Explosion									����� ��������� - �����	
							Smoke											����� ��������	
							TowingPoint								����� ����������	
							Gunner										����� ������������ �����	
							Ammo											����� ������������ ������ �� ���������	

	�������			MainGun										��������	
							MachineGun								�������	
							Cannon										�����	
							Smoke											����� ��������	
							People										����� ������ �����	

	����������	Explosion									����� ��������� - �����	
							Smoke											����� ��������	
							Exhaust										����� �������	
							TowingPoint								����� ����������	
							People										����� ������ �����	

	����� � ���	MainGun										�����	
							MachineGun								�������	
							MachineGun_Turret_Coax		������� ��������� � ������	
							MachineGun_Turret_Back		������� ����� �� �����	
							MachineGun_Turret_Cupola	������� �� ������������ �������	
							MachineGun_Basis					�������� ������� �� �������	
							Smoke											����� ��������	
							FatalitySmoke							����� ���������� ��������	
							Exhaust										����� �������	
							Explosion									����� ��������� - �����	


	-------------------------------------------------------------------------------------------------------------

	Locator										Field (MechUnitRPGStats)						Type
	-----------------------		------------------------------			----------------------------------
	Ammo											AmmoPoint														Vec2
	BackWheel									BackWheel														Vec2
	Cannon	(��������)				<?>																	string
	Exhaust										exhaustPoints												string[0+]
	Explosion									������ ����� �� ���.								-
	FatalitySmoke							FatalitySmokePoint									string
	FrontWheel								FrontWheel													Vec2
	Gunner										Gunners															Vec2[0+][0+]
	HookPoint									HookPoint														Vec2
	MachineGun								platforms[i].guns[j].ShootPoint			string
	MachineGun_Basis					platforms[i].guns[j].ShootPoint			string
	MachineGun_Turret_Back		platforms[i].guns[j].ShootPoint			string
	MachineGun_Turret_Coax		platforms[i].guns[j].ShootPoint			string
	MachineGun_Turret_Cupol		platforms[i].guns[j].ShootPoint			string
	MainGun										platforms[i].guns[0].ShootPoint			string
	People										PeoplePoints												Vec2[0+]
	Smoke											damagePoints												string[0+]
	TowingPoint								TowPoint														Vec2
	----------------------------------------------------------------------------------------------------------------

	*
	*
	*							����������
	*
	*

	���� � MechUnitRPGStatus					�����																						������ ������� 
	------------------------------		--------------------------------------------		----------------------------
	platforms[i].constraint						constraint for procedural animation							rot Z limit ��� Turret
	platforms[i].constraintVertical		����������� �� ������������ ������� ������			rot X limit ��� GunCarriage
	--------------------------------------------------------------------------------------------------------------

*/
#include "StdAfx.h"
#include "../libdb/ResourceManager.h"
#include "../MapEditorLib/ExporterFactory.h"
#include "../MapEditorLib/ManipulatorManager.h"
#include "AnimationMnemonics.h"
#include "ExporterMethods.h"
#include "MechUnitRPGStatsExporter.h"
#include "../System/FastMath.h"
#include "../ED_Common/TempAttributesTool.h"
//DEBUG{
//DEBUG}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
REGISTER_EXPORTER_IN_DLL( MechUnitRPGStats, CMechUnitRPGStatsExporter )
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const char VISUALOBJECT[]					= "visualObject";
const char ANIMATEMODEL[]					= "AnimableModel";
const char TRANSPORTABLEMODEL[]				= "TransportableModel";
const char SKELETON_FIELD_IN_MODEL[]		= "Skeleton";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CopyVector2D( IManipulator *pSrc, IManipulator *pDst, const string &szSrc, const string &szDst )
{
	CVariant var;
	pSrc->GetValue( szSrc + ".x", &var );
	pDst->SetValue( szDst + ".x", var );
	pSrc->GetValue( szSrc + ".y", &var );
	pDst->SetValue( szDst + ".y", var );
}
void CopyAABB2D( IManipulator *pSrc, IManipulator *pDst, const string &szSrc, const string &szDst )
{
	CopyVector2D( pSrc, pDst, szSrc + ".Center", szDst + ".Center" );
	CopyVector2D( pSrc, pDst, szSrc + ".HalfSize", szDst + ".HalfSize" );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SGunInfo
{
	int nDirection;			// ������� ����� ������������ ��� ����� � �������������� ���������
											// MAYA: rotation ���������������� �������� ������ Z
											// �������� � ���� ����� 0..64�
	
	string szShootPoint;	// ��� ����� ( MAYA: ��� �������� �����, ����������� ���������� � L: LMainGun, LMachineGun01 � �.�. )
	
	string szRecoilPoint;	// ��� ����� �����, ������� ��������� � ������ (���� �� � ���� �����)
												// MAYA: ��� ������������� ���������� �����	(��� �������� ������ MainBarrel??)
	
	float fRecoilLength;	// ���� ����� ������� � RecoilPoint, �� (trans_limit_Y_max - trans_limit_Y_min)
	
	bool bRecoil;					// ���� �� ������ (true ���� fRecoilLength != 0)
	
	string szRotatePoint;	// ����� ������������� �������� (���� �� � ���� �����)
												// MAYA: � ������������  ��������� � ������ GunCarriage??

	
	string szPlatform;		// ���������, � ������� ����������� �����
												// MAYA: ������������ ��������� 
												//		 ��� ��������� ����� ���� ������ 
												//		 Basis, Basis_a, Basis_A, Turret, Turret00, Turret01 � �.�.
	
	
	SGunInfo()
	{
		nDirection = 0;
		fRecoilLength = 0.0f;
		bRecoil = false;
	}

	bool operator<( const SGunInfo &rOther )
	{
		// MainGun ������ ������, MachineGun00 < MachineGun01 � �.�.

		int nMainGunIdx = -1;
		bool bIsMainGun = false;
		int nMachineGunIdx = -1;
		bool bIsMachineGun = false;
		int nCannonIdx = -1;
		bool bIsCannon = false;

		if ( szShootPoint == "LMainGun" )
		{
			bIsMainGun = true;
			nMainGunIdx = 0;
		}
		else
			bIsMainGun = IsNameMatchPattern( &nMainGunIdx, szShootPoint.c_str(), "LMainGun??" );
		bIsCannon = IsNameMatchPattern( &nCannonIdx, szShootPoint.c_str(), "L*Cannon??" );
		bIsMachineGun = IsNameMatchPattern( &nMachineGunIdx, szShootPoint.c_str(), "LMachineGun*" );
		

		int nMainGunIdx2 = -1;
		bool bIsMainGun2 = false;
		int nMachineGunIdx2 = -1;
		bool bIsMachineGun2 = false;
		int nCannonIdx2 = -1;
		bool bIsCannon2 = false;

		if ( rOther.szShootPoint == "LMainGun" )
		{
			bIsMainGun2 = true;
			nMainGunIdx2 = 0;
		}
		else
			bIsMainGun2 = IsNameMatchPattern( &nMainGunIdx2, rOther.szShootPoint.c_str(), "LMainGun??" );
		bIsCannon2 = IsNameMatchPattern( &nCannonIdx2, rOther.szShootPoint.c_str(), "L*Cannon??" );
		bIsMachineGun2 = IsNameMatchPattern( &nMachineGunIdx2, rOther.szShootPoint.c_str(), "LMachineGun*" );
		
		if ( bIsMainGun2 )
		{
			if ( !bIsMainGun )
				return false;
			else
			{
				// ��� �������� �� ����� ���������
				ILogger *pLogger = NLog::GetLogger();
				pLogger->Log( LT_ERROR, "There are two main guns on one platform\n" );
				pLogger->Log( LT_ERROR, StrFmt("\tPlatform: %s\n", szPlatform.c_str()) );
				return (nMainGunIdx < nMainGunIdx2); 
			}
		}

		if ( bIsMachineGun2 )
		{
			if ( bIsMainGun )
				return true;
			else
			{
				if ( bIsCannon )
					return false;
				else
				{
					if ( bIsMachineGun )
					{
						return (nMainGunIdx < nMainGunIdx2);	
					}
					else
					{
						ILogger *pLogger = NLog::GetLogger();
						pLogger->Log( LT_ERROR, StrFmt("Can't classify gun: %s\n", szShootPoint.c_str()) );
						return true;
					}
				}
			}
		}

		if ( bIsCannon2 )
		{
			if ( bIsMainGun || bIsMachineGun )
			{
				return true;
			}
			else
			{
				if ( bIsCannon )
				{
					return (nCannonIdx < nCannonIdx2); 
				}
				else
				{
					ILogger *pLogger = NLog::GetLogger();
					pLogger->Log( LT_ERROR, StrFmt("Can't classify gun: %s\n", rOther.szShootPoint.c_str()) );
					return true;
				}
			}
		}
		return true;
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SPlatformInfo
{
	//
	//		��� ��������� ����� ���� ������ 
	//			Basis, Basis_a, Basis_A, Turret, Turret00, Turret01 � �.�.
	//
	//		Basis ��� Basis_a - ��������� �������� ������
	//		Turret??		  - ������ ��������� (�������������� � Basis)
	//
	string szRotatePoint;	// ��� ��������� ( MAYA: ��� ���������� )

	float constraint[2];	// �������������� ��������� ( MAYA: rot_limit_Z � ���������� ��������� )

	float constraintVertical[2]; // ������������ ��������� 
								 // 0+ ����� ����� � �������� ������ �� ������������ �����������
								 // ��������� GunCarriage??
								 // ������ � ������ �� ���� ����������� rot_limit_X != 0
								 // ������ ���� rot_limit_X � �������� � constraintVertical

	vector<SGunInfo> guns;
	//
	//
	SPlatformInfo()
	{
		constraint[0] = 0;
		constraint[1] = 0;
		constraintVertical[0] = 0;
		constraintVertical[1] = 0;
		szRotatePoint = "<<< ERROR: bad locator >>>";
	}
	//
	bool operator <( const SPlatformInfo &rOther )
	{
		if ( rOther.szRotatePoint == "Basis" )
		{
			if ( szRotatePoint == "Basis" )
				return true;
		}
		else if ( (rOther.szRotatePoint == "Basis_a") || (rOther.szRotatePoint == "Basis_A") )
		{
			if ( szRotatePoint == "Basis" || szRotatePoint == "Basis_a" || szRotatePoint == "Basis_A" )
				return true;
		}
		else
		{
			int nIdx1 = -1;
			bool bRes1 = IsNameMatchPattern( &nIdx1, rOther.szRotatePoint.c_str(), "Turret??" );
			int nIdx0 = -1;
			bool bRes0 = IsNameMatchPattern( &nIdx0, szRotatePoint.c_str(), "Turret??" );
			if ( bRes0 && bRes1 )
			{
				return (nIdx0 < nIdx1); 
			}
		}
		return false;
	}
};
//
typedef vector<SPlatformInfo>::const_iterator CPlatformsInfoConstIter;
typedef vector<SPlatformInfo>::iterator CPlatformsInfoIter;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SConstraintInfo
{
	string szName;

	bool bTransConstrMinEnable[3];
	CVec3 transLimitMin;
	bool bTransConstrMaxEnable[3];
	CVec3 transLimitMax;

	bool bRotConstrMinEnable[3];
	CVec3 rotLimitMin;
	bool bRotConstrMaxEnable[3];
	CVec3 rotLimitMax;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void SetGunnersPoints( IManipulator* pManipulator, const vector<SSkeletonLocatorInfo> &rLocatorsInfo )
{
	// ������������ �������� � ����� � 3-� ��������� ������� ����� (��������+��������+���������������)
	pManipulator->RemoveNode( "Gunners", NODE_REMOVEALL_INDEX );	
	pManipulator->InsertNode( "Gunners" );
	pManipulator->InsertNode( "Gunners" );
	pManipulator->InsertNode( "Gunners" );

	vector<SLocatorQInfo> lc;
	SearchLocators( &lc, rLocatorsInfo, "LGunner??" ); 

	int gunnersNumber[3] = {0,0,0};
	int nIdx = 0;
	for ( CLocatorQInfoConstIter i = lc.begin(); i != lc.end(); ++i, ++nIdx )
	{
		if ( i->nQIdx < 10 ) // ��������
		{	
			pManipulator->InsertNode( "Gunners.[0].gunners" );
			char pszGunnerDBA[64]={0};
			sprintf( pszGunnerDBA, "Gunners.[0].gunners.[%d]", gunnersNumber[0] );
			CManipulatorManager::SetVec2( CVec2( i->inf.vPos.x, i->inf.vPos.y ), pManipulator, pszGunnerDBA );  
			++gunnersNumber[0];
		}
		else if ( i->nQIdx < 20 ) // ��������
		{
			pManipulator->InsertNode( "Gunners.[1].gunners" );
			char pszGunnerDBA[64]={0};
			sprintf( pszGunnerDBA, "Gunners.[1].gunners.[%d]", gunnersNumber[1] );
			CManipulatorManager::SetVec2( CVec2( i->inf.vPos.x, i->inf.vPos.y ), pManipulator, pszGunnerDBA );  
			++gunnersNumber[1];
		}
		else if ( i->nQIdx < 30 ) // ���������������
		{
			pManipulator->InsertNode( "Gunners.[2].gunners" );
			char pszGunnerDBA[64]={0};
			sprintf( pszGunnerDBA, "Gunners.[2].gunners.[%d]", gunnersNumber[2] );
			CManipulatorManager::SetVec2( CVec2( i->inf.vPos.x, i->inf.vPos.y ), pManipulator, pszGunnerDBA );  
			++gunnersNumber[2];
		}
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static string GetParentLocator(	const SSkeletonLocatorInfo &rGunLocator,
								const vector<SSkeletonLocatorInfo> &rLocatorsInfo,
								const char *pszNamePattern )
{
	//
	//	���� ������������ �������, ���������� ������������ ������
	//
	SSkeletonLocatorInfo curLoc = rGunLocator;
	while ( (curLoc.nParentIdx != -1) )
	{
		SSkeletonLocatorInfo parentLocator = rLocatorsInfo[ curLoc.nParentIdx ];
		if ( PatMat( parentLocator.szName.c_str(), pszNamePattern ) )
		{
			return parentLocator.szName;
		}
		else
		{
			curLoc = rLocatorsInfo[curLoc.nParentIdx];
		}
	}
	return "";
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static string GetLocatorPlatform(	const SSkeletonLocatorInfo &rGunLocator,
									const vector<SSkeletonLocatorInfo> &rLocatorsInfo,
									const vector<SPlatformInfo> &rPlatformsInfo )
{
	//
	//	���������� ��� ��������� � ������� �������� �������
	//
	SSkeletonLocatorInfo curLoc = rGunLocator;
	while ( (curLoc.nParentIdx != -1) )
	{
		SSkeletonLocatorInfo parentLocator = rLocatorsInfo[ curLoc.nParentIdx ];
		for ( vector<SPlatformInfo>::const_iterator i = rPlatformsInfo.begin(); i != rPlatformsInfo.end(); ++i )
		{
			if ( parentLocator.szName == i->szRotatePoint )
				return parentLocator.szName;
		}
		curLoc = rLocatorsInfo[curLoc.nParentIdx];
	}
	return "";
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static bool IsPlatformExist( IManipulator* pManipulator, int nPlatformNo )
{
	CVariant v;
	if ( !pManipulator->GetValue( "platforms", &v ) )
		return false;
	int nArraySize = v;
	return (nPlatformNo >= 0) && (nPlatformNo < nArraySize);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static bool IsGunExist( IManipulator* pManipulator, int nPlatformNo, int nGunNo )
{
	char pszDBA[64] = {0};
	 sprintf( pszDBA, "platforms.[%d].guns", nPlatformNo );
	CVariant v;
	if ( !pManipulator->GetValue( pszDBA, &v ) )
		return false;
	int nArraySize = v;
	return (nGunNo >= 0) && (nGunNo < nArraySize);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static bool AddPlatform( IManipulator* pManipulator )
{
	return pManipulator->InsertNode( "platforms" ); 
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static bool AddGun( IManipulator *pManipulator, int nPlatformNo )
{
	char pszDBA[64] = {0};
	sprintf( pszDBA, "platforms.[%d].guns", nPlatformNo );
	return pManipulator->InsertNode( pszDBA ); 
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static bool SetGunShootPoint(	IManipulator* pManipulator, 
								const SSkeletonLocatorInfo *pLocatorInfo, 
								int nPlatformNo, 
								int nGunNo ) 
{
	char pszDBA[64] = {0};
	sprintf( pszDBA, "platforms.[%d].guns.[%d].ShootPoint", nPlatformNo, nGunNo );
	return CManipulatorManager::SetValue( pLocatorInfo->szName, pManipulator, pszDBA, false ); 
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
const SSkeletonLocatorInfo* GetLocator( const char *pszLocatorName, const vector<SSkeletonLocatorInfo> &rLocatorsInfo )
{
	for ( CLocatorInfoConstIter i = rLocatorsInfo.begin(); i != rLocatorsInfo.end(); ++i )
		if ( i->szName == pszLocatorName )
			return i;
	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void GetPlatforms( vector<SPlatformInfo> *pPlatforms, const vector<SSkeletonLocatorInfo> &rLocatorsInfo )
{
	//
	// ������� ������� � ���������: 
	//		Basis ��� Basis_a, Basis?? - ��������� �������� ������
	//
	//		Turret*		  - ������ ��������� (�������������� � Basis)
	//		
	pPlatforms->clear();
	bool bHasBasis = false;
	bool bHasBasisA = false;
	for ( CLocatorInfoConstIter i = rLocatorsInfo.begin(); i != rLocatorsInfo.end(); ++i )
	{
		SPlatformInfo inf;
		inf.szRotatePoint = i->szName;

		if ( i->szName == "Basis" )
		{
			pPlatforms->push_back( inf );
			bHasBasis = true;
		}
		else if ( (i->szName == "Basis_a") || (i->szName == "Basis_A") )
		{
			pPlatforms->push_back( inf );
			bHasBasisA = true;
		}
		else if ( PatMat( i->szName.c_str(), "Turret*" ) )
		{
			pPlatforms->push_back( inf );
		}
	}

	// ���� ���� � Basis � ����� Basis_a, Basis ���������
	if ( bHasBasis && bHasBasisA )
	{
		for ( CPlatformsInfoIter j = pPlatforms->begin(); j != pPlatforms->end(); ++j )
		{
			if ( j->szRotatePoint == "Basis" )
			{
				pPlatforms->erase(j);
				break;
			}
		}
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void GetConstraintInfoFromFile( vector<SConstraintInfo> *pConstraints, IManipulator *pMan )
{
	CPtr<IManipulator> pVisObjMan = CManipulatorManager::CreateManipulatorFromReference( VISUALOBJECT, pMan, 0, 0, 0 );
	granny_file_info *pInfo = NMEGeomAttribs::GetAttribsByVisObj( pVisObjMan );
	if ( !pInfo )
		return;

	granny_skeleton *pSkeleton = pInfo->Skeletons[0];
	for ( int nBoneIndex = 0; nBoneIndex < pSkeleton->BoneCount; ++nBoneIndex )
	{
		granny_bone *pBone = &pSkeleton->Bones[nBoneIndex];
		SConstraintInfo inf;
		inf.szName = pBone->Name;
		//
		struct SGrannyConstr
		{
			granny_real32 minTransXLimit;
			granny_real32 minTransYLimit;
			granny_real32 minTransZLimit;
			granny_real32 maxTransXLimit;
			granny_real32 maxTransYLimit;
			granny_real32 maxTransZLimit;
			granny_real32 minTransXLimitEnable;
			granny_real32 minTransYLimitEnable;
			granny_real32 minTransZLimitEnable;
			granny_real32 maxTransXLimitEnable;
			granny_real32 maxTransYLimitEnable;
			granny_real32 maxTransZLimitEnable;
			granny_real32 minRotXLimit;
			granny_real32 minRotYLimit;
			granny_real32 minRotZLimit;
			granny_real32 maxRotXLimit;
			granny_real32 maxRotYLimit;
			granny_real32 maxRotZLimit;
			granny_real32 minRotXLimitEnable;
			granny_real32 minRotYLimitEnable;
			granny_real32 minRotZLimitEnable;
			granny_real32 maxRotXLimitEnable;
			granny_real32 maxRotYLimitEnable;
			granny_real32 maxRotZLimitEnable;
		} grannyConstr = {0};
		granny_data_type_definition SGrannyConstrTypedef[] =
		{
			{ GrannyReal32Member, "minTransXLimit" },
			{ GrannyReal32Member, "minTransYLimit" },
      { GrannyReal32Member, "minTransZLimit" },
      { GrannyReal32Member, "maxTransXLimit" },
      { GrannyReal32Member, "maxTransYLimit" },
      { GrannyReal32Member, "maxTransZLimit" },
      { GrannyReal32Member, "minTransXLimitEnable" },
      { GrannyReal32Member, "minTransYLimitEnable" },
      { GrannyReal32Member, "minTransZLimitEnable" },
      { GrannyReal32Member, "maxTransXLimitEnable" },
      { GrannyReal32Member, "maxTransYLimitEnable" },
      { GrannyReal32Member, "maxTransZLimitEnable" },
      { GrannyReal32Member, "minRotXLimit" },
      { GrannyReal32Member, "minRotYLimit" },
      { GrannyReal32Member, "minRotZLimit" },
      { GrannyReal32Member, "maxRotXLimit" },
      { GrannyReal32Member, "maxRotYLimit" },
      { GrannyReal32Member, "maxRotZLimit" },
      { GrannyReal32Member, "minRotXLimitEnable" },
      { GrannyReal32Member, "minRotYLimitEnable" },
      { GrannyReal32Member, "minRotZLimitEnable" },
      { GrannyReal32Member, "maxRotXLimitEnable" },
      { GrannyReal32Member, "maxRotYLimitEnable" },
      { GrannyReal32Member, "maxRotZLimitEnable" },
			{ GrannyEndMember }
		};
	  GrannyConvertSingleObject(	pBone->ExtendedData.Type, pBone->ExtendedData.Object,
									SGrannyConstrTypedef, &grannyConstr );
		
		inf.bTransConstrMinEnable[0] = grannyConstr.minTransXLimitEnable;
		inf.bTransConstrMinEnable[1] = grannyConstr.minTransYLimitEnable;
		inf.bTransConstrMinEnable[2] = grannyConstr.minTransZLimitEnable;
		inf.transLimitMin.x = grannyConstr.minTransXLimit;
		inf.transLimitMin.y = grannyConstr.minTransYLimit;
		inf.transLimitMin.z = grannyConstr.minTransZLimit;

		inf.bTransConstrMaxEnable[0] = grannyConstr.maxTransXLimitEnable;
		inf.bTransConstrMaxEnable[1] = grannyConstr.maxTransYLimitEnable;
		inf.bTransConstrMaxEnable[2] = grannyConstr.maxTransZLimitEnable;
		inf.transLimitMax.x = grannyConstr.maxTransXLimit;
		inf.transLimitMax.y = grannyConstr.maxTransYLimit;
		inf.transLimitMax.z = grannyConstr.maxTransZLimit;

		inf.bRotConstrMinEnable[0] = grannyConstr.minRotXLimitEnable;
		inf.bRotConstrMinEnable[1] = grannyConstr.minRotYLimitEnable;
		inf.bRotConstrMinEnable[2] = grannyConstr.minRotZLimitEnable;

		inf.rotLimitMin.x = grannyConstr.minRotXLimit;
		inf.rotLimitMin.y = grannyConstr.minRotYLimit;
		inf.rotLimitMin.z = grannyConstr.minRotZLimit;

		inf.bRotConstrMaxEnable[0] = grannyConstr.maxRotXLimitEnable;
		inf.bRotConstrMaxEnable[1] = grannyConstr.maxRotYLimitEnable;
		inf.bRotConstrMaxEnable[2] = grannyConstr.maxRotZLimitEnable;
		inf.rotLimitMax.x = grannyConstr.maxRotXLimit;
		inf.rotLimitMax.y = grannyConstr.maxRotYLimit;
		inf.rotLimitMax.z = grannyConstr.maxRotZLimit;
		//
		pConstraints->push_back( inf );
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void GetModelConstraints( vector<SConstraintInfo> *pConstraints, IManipulator* pRPGStatsManipulator )
{
	GetConstraintInfoFromFile( pConstraints, pRPGStatsManipulator );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ************************************************************************************************************************ //
// **
// ** animations & AABB processing
// **
// **
// **
// ************************************************************************************************************************ //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static bool IsStringEmpty( const string &szArg )
{
	return szArg.empty() || szArg == " ";
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CMechUnitRPGStatsExporter::ProcessAABB( IManipulator *pItUnit )
{
	// AABB information about this unit (from AI geometry)
	{
		// convert animations from anims array to RPG stats structures
		CPtr<IManipulator> pItVisObj = CManipulatorManager::CreateManipulatorFromReference( "visualObject", pItUnit, 0, 0, 0 );
		if ( pItVisObj == 0 ) 
			return true;
		// find first non-null model
		CPtr<IManipulator> pItModel = CreateModelManipulatorFromVisObj( pItVisObj, 0 );
		if ( pItModel == 0 ) 
			return true;
		//
		CPtr<IManipulator> pGeomMan = CManipulatorManager::CreateManipulatorFromReference( "Geometry", pItModel, 0, 0, 0 );
		CPtr<IManipulator> pAIGeomMan = CManipulatorManager::CreateManipulatorFromReference( "AIGeometry", pGeomMan, 0, 0, 0 );
		// AABB center
		CVec3 vAABBCenter;
		CVec3 vAABBHalfSize;
		if ( CManipulatorManager::GetVec3<CVec3, float>( &vAABBCenter, pAIGeomMan, "AABBCenter" ) == false )
		{
			return true;
		}
		// AABB half size
		if ( CManipulatorManager::GetVec3<CVec3, float>( &vAABBHalfSize, pAIGeomMan, "AABBHalfSize" ) == false )
		{
			return true;
		}
		//
		Vis2AI( &vAABBCenter );
		Vis2AI( &vAABBHalfSize );
		//
		CManipulatorManager::SetVec2( CVec2( vAABBCenter.x, vAABBCenter.y ), pItUnit, "AABBCenter" );
		CManipulatorManager::SetVec2( CVec2( vAABBHalfSize.x, vAABBHalfSize.y ), pItUnit, "AABBHalfSize" );
	}
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool CMechUnitRPGStatsExporter::ProcessMechUnitAnimations( IManipulator *pItUnit )
{
	IResourceManager *pRM = Singleton<IResourceManager>();
	CVariant var;
	pItUnit->RemoveNode( "aabb_as" );
	pItUnit->RemoveNode( "aabb_ds" );
	pItUnit->GetValue( "animdescs", &var );
	int nNumDescs = var;
	for ( int i = 0; i < nNumDescs; ++i )
		pItUnit->RemoveNode( StrFmt( "animdescs.[%d].anims", i ) );
	pItUnit->RemoveNode( "animdescs" );
	for ( int i = 0; i < NDb::__ANIMATION_TYPE_COUNTER; ++i )
		pItUnit->InsertNode( "animdescs" );

	//collect visobjects
	list<string> visObjects;
	pItUnit->GetValue( "visualObject", &var );
	if ( !IsDBIDEmpty(var) )
		visObjects.push_back( var.GetStr() );
	if ( pItUnit->GetValue( "AnimableModel", &var ) )
	{
		if ( !IsDBIDEmpty(var) )
			visObjects.push_back( var.GetStr() );
	}
	if ( pItUnit->GetValue( "TransportableModel", &var ) )
	{
		if ( !IsDBIDEmpty(var) )
			visObjects.push_back( var.GetStr() );
	}
	pItUnit->GetValue( "DamageLevels", &var );
	int nNumDamageLevels = var;
	for ( int i = 0; i < nNumDamageLevels; ++i )
	{
		pItUnit->GetValue( StrFmt( "DamageLevels.[%d].VisObj", i ), &var );
		if ( !IsDBIDEmpty(var) )
			visObjects.push_back( var.GetStr() );
	}

	//collect skeletons
	hash_map<string,bool> skeletons;
	for ( list<string>::const_iterator it = visObjects.begin(); it != visObjects.end(); ++it )
	{
		CPtr<IManipulator> pItVisObj = pRM->CreateObjectManipulator( "VisObj", *it );
		CPtr<IManipulator> pItModel = CreateModelManipulatorFromVisObj( pItVisObj, 0 );
		if ( pItModel == 0 ) 
			continue;
		pItModel->GetValue( "Skeleton", &var );
		if ( !IsDBIDEmpty(var) )	
			skeletons[var.GetStr()] = true;
	}
	if ( skeletons.empty() )
		return false;

	// convert animations from anims array to RPG stats structures
	int nAnimCounter = 0;
	for ( hash_map<string,bool>::const_iterator itSkeleton = skeletons.begin(); itSkeleton != skeletons.end(); ++itSkeleton )
	{
		CPtr<IManipulator> pItSkeleton = pRM->CreateObjectManipulator( "Skeleton", itSkeleton->first );
		// retrieve animation information
		pItSkeleton->GetValue( "Animations", &var );
		int nNumAnimations = var;
		for ( int j = 0; j < nNumAnimations; ++j )
		{
			pItSkeleton->GetValue( StrFmt( "Animations.[%d]", j ), &var );
			if ( !IsDBIDEmpty(var) )
			{
				string szAddr = var.GetStr();
				int nTypeSepPos = szAddr.find( ':' );
				if ( nTypeSepPos != string::npos )
					szAddr = szAddr.substr( nTypeSepPos + 1 );
				CPtr<IManipulator> pAnimMan = pRM->CreateObjectManipulator( "AnimB2", szAddr );
				//get type and create entry
				pAnimMan->GetValue( "Type", &var );
				int nAnimType = typeAnimationMnemonics.GetValue( (string)var.GetStr() );
				string szDescName = StrFmt( "animdescs.[%d].anims", nAnimType );
				pItUnit->InsertNode( szDescName );
				pItUnit->GetValue( szDescName, &var );
				szDescName += StrFmt( ".[%d]", ((int)var) - 1 );
				//create aabb's and write indexes
				pAnimMan->GetValue( "AABBAName", &var );
				string szAABBAName = var.GetStr();
				pAnimMan->GetValue( "AABBDName", &var );
				string szAABBDName = var.GetStr();
				if ( !IsStringEmpty( szAABBAName ) || ! IsStringEmpty( szAABBDName ) )
				{
					pItUnit->InsertNode( "aabb_as" );
					pItUnit->InsertNode( "aabb_ds" );
					CopyAABB2D( pAnimMan, pItUnit, "aabb_a", StrFmt( "aabb_as.[%d]", nAnimCounter ) );
					CopyAABB2D( pAnimMan, pItUnit, "aabb_d", StrFmt( "aabb_ds.[%d]", nAnimCounter ) );
					var = CVariant( nAnimCounter );
					pItUnit->SetValue( szDescName + ".AABB_A", var );
					pItUnit->SetValue( szDescName + ".AABB_D", var );
					++nAnimCounter;
				}
				else
				{
					var = CVariant( -1 );
					pItUnit->SetValue( szDescName + ".AABB_A", var );
					pItUnit->SetValue( szDescName + ".AABB_D", var );
				}
				//read and write other data
				pAnimMan->GetValue( "Length", &var );
				pItUnit->SetValue( szDescName + ".Length", var );
				pAnimMan->GetValue( "Action", &var );
				pItUnit->SetValue( szDescName + ".Action", var );
				var = CVariant( j );
				pItUnit->SetValue( szDescName + ".FrameIndex", var );
			}
		}
	}

	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMechUnitRPGStatsExporter::ProcessAttachedObjects( IManipulator *pUnitManipulator )
{
	CVariant var;
	pUnitManipulator->GetValue( "platforms", &var );
	const int nPlatforms = var;
	for ( int i = 0; i< nPlatforms; ++i )
	{
		CPtr<IManipulator> pAttachedPlatformManipulator = 
			CManipulatorManager::CreateManipulatorFromReference( StrFmt( "platforms.[%d].AttachedPlatformVisObj", i ), pUnitManipulator, 0, 0, 0 );
		if ( pAttachedPlatformManipulator )
			ProcessMechUnitAnimations( pAttachedPlatformManipulator );

		pUnitManipulator->GetValue( StrFmt( "platforms.[%d].guns", i ), &var );
		const int nGuns = var;
		for ( int j = 0; j < nGuns; ++j )
		{
			CPtr<IManipulator> pAttachedGunManipulator = 
				CManipulatorManager::CreateManipulatorFromReference( StrFmt( "platforms.[%d].guns.[%d].AttachedGunVisObj", i, j ), pUnitManipulator, 0, 0, 0 );
			if ( pAttachedGunManipulator )
				ProcessMechUnitAnimations( pAttachedGunManipulator );
		}
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void CopyAnimationsTo( IManipulator *pUnitManipulator, IManipulator *pAttachedManipulator, const string &szVisObj )
{
	CVariant var;
	pUnitManipulator->GetValue( szVisObj, &var );
	const int nVisObjects = var;
	for ( int i = 0; i < nVisObjects; ++i )
	{
		CPtr<IManipulator> pUnitSkeletonManipulator =
			CManipulatorManager::CreateManipulatorFromReference( StrFmt( "Models.[%d].Model.Skeleton", i ), pUnitManipulator, 0, 0, 0 );
		CPtr<IManipulator> pAttachedSkeletonManipulator =
			CManipulatorManager::CreateManipulatorFromReference( StrFmt( "Models.[%d].Model.Skeleton", i ), pAttachedManipulator, 0, 0, 0 );

		if ( pUnitSkeletonManipulator && pAttachedSkeletonManipulator )
		{
			pAttachedSkeletonManipulator->RemoveNode( "Animations" );
			pUnitSkeletonManipulator->GetValue( "Animations", &var );
			const int nAnimations = var;
			for ( int j = 0; j < nAnimations; ++j )
			{
				pAttachedSkeletonManipulator->InsertNode( "Animations" );

				pUnitSkeletonManipulator->GetValue( StrFmt( "Animations[%d]", j ), &var );
				pAttachedSkeletonManipulator->SetValue( StrFmt( "Animations[%d]", j ), var );
			}
		}
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMechUnitRPGStatsExporter::CopyAnimationsToObject( IManipulator *pUnitManipulator, IManipulator *pAttachedManipulator )
{
	CopyAnimationsTo( pUnitManipulator, pAttachedManipulator, "visualObject" );
	CopyAnimationsTo( pUnitManipulator, pAttachedManipulator, "AnimableModel" );
	CopyAnimationsTo( pUnitManipulator, pAttachedManipulator, "TransportableModel" );

	pAttachedManipulator->RemoveNode( "DamageLevels" );

	CVariant var;
	pUnitManipulator->GetValue( "DamageLevels", &var );
	const int nLevels = var;
	for ( int j = 0; j < nLevels; ++j )
	{
		pAttachedManipulator->InsertNode( "DamageLevels" );

		CPtr<IManipulator> pObjDamageLevelManipulator = 
			CManipulatorManager::CreateManipulatorFromReference( StrFmt( "DamageLevels.[%d]", j ), pUnitManipulator, 0, 0, 0 );
		CPtr<IManipulator> pAttachedDamagedLevelManipulator =
			CManipulatorManager::CreateManipulatorFromReference( StrFmt( "DamageLevels.[%d]", j ), pAttachedManipulator, 0, 0, 0 );
		CopyAnimationsTo( pUnitManipulator, pAttachedManipulator, "VisObj" );
	}

}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CMechUnitRPGStatsExporter::CopyAnimationsToAttached( IManipulator *pUnitManipulator )
{
	CVariant var;
	pUnitManipulator->GetValue( "platforms", &var );
	const int nPlatforms = var;
	for ( int i = 0; i< nPlatforms; ++i )
	{
		CPtr<IManipulator> pAttachedPlatformManipulator = 
			CManipulatorManager::CreateManipulatorFromReference( StrFmt( "platforms.[%d].AttachedPlatformVisObj", i ), pUnitManipulator, 0, 0, 0 );
		if ( pAttachedPlatformManipulator )
			CopyAnimationsToObject( pUnitManipulator, pAttachedPlatformManipulator );

		pUnitManipulator->GetValue( StrFmt( "platforms.[%d].guns", i ), &var );
		const int nGuns = var;
		for ( int j = 0; j < nGuns; ++j )
		{
			CPtr<IManipulator> pAttachedGunManipulator = 
				CManipulatorManager::CreateManipulatorFromReference( StrFmt( "platforms.[%d].guns.[%d]", i, j ), pUnitManipulator, 0, 0, 0 );
			if ( pAttachedGunManipulator )
				CopyAnimationsToObject( pUnitManipulator, pAttachedPlatformManipulator );
		}
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void ProcessGun(	SGunInfo *pGunInfo, 
						const SSkeletonLocatorInfo &rGunLocator,
						const vector<SSkeletonLocatorInfo> &rLocatorsInfo,
						const vector<SPlatformInfo> &rPlatformsInfo )
{
	// ��� �����?
	pGunInfo->szShootPoint = rGunLocator.szName;
	
	// ���������?
	pGunInfo->szPlatform = GetLocatorPlatform( rGunLocator, rLocatorsInfo, rPlatformsInfo );
	if ( pGunInfo->szPlatform.empty() )
	{
		ILogger *pLogger = NLog::GetLogger();
		pLogger->Log( LT_ERROR, "Can't find platform for gun\n" );
		pLogger->Log( LT_ERROR, StrFmt("\tGun: %s\n", rGunLocator.szName.c_str()) );
	}
	// ��������� ������� - ����� ����������� � basis, ���� � ������ ���� basis_a

	// ����� ������������� ��������
	pGunInfo->szRotatePoint = GetParentLocator( rGunLocator, rLocatorsInfo, "*GunCarriage*" );

	// ����� �����, ������� ��������� � ������ 
	pGunInfo->szRecoilPoint = GetParentLocator( rGunLocator, rLocatorsInfo, "*MainBarrel*" );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void UpdateGuns( IManipulator *pManipulator, int nPlatformIdx, const vector<SGunInfo> &rGuns )
{
	const string szGunsDba = StrFmt( "platforms.[%d].guns", nPlatformIdx );
	
	CVariant v;
	if ( !pManipulator->GetValue( szGunsDba, &v ) )
		return;

	const int nNumElems = v;
	vector<BYTE> gunProcessed( rGuns.size(), BYTE(0) );
	for ( int i = 0; i < nNumElems; ++i )
	{
		string szLocNameDBA = StrFmt( "platforms.[%d].guns.[%d].ShootPoint", nPlatformIdx, i );
		string szDirectionDBA = StrFmt( "platforms.[%d].guns.[%d].Direction", nPlatformIdx, i );
		string szRecoilPointDBA = StrFmt( "platforms.[%d].guns.[%d].RecoilPoint", nPlatformIdx, i );
		string szRecoilLengthDBA = StrFmt( "platforms.[%d].guns.[%d].RecoilLength", nPlatformIdx, i );
		string szRecoilDBA = StrFmt( "platforms.[%d].guns.[%d].Recoil", nPlatformIdx, i );
		string szRotatePointDBA = StrFmt( "platforms.[%d].guns.[%d].RotatePoint", nPlatformIdx, i );

		CVariant v;
		if ( !pManipulator->GetValue( szLocNameDBA, &v ) )
			continue;

		string szLocatorName = v.GetStr();

		int nIdx = 0;
		for ( vector<SGunInfo>::const_iterator j = rGuns.begin(); j != rGuns.end(); ++j, ++nIdx )
		{
			const SGunInfo *pG = j;

			if ( szLocatorName != j->szShootPoint )
				continue;

			if ( j->szShootPoint == szLocatorName )
			{
				bool bRes;
				CVariant v;
				string szWarnMsg;

				v = pG->nDirection;
				bRes = pManipulator->SetValue( szDirectionDBA, v );
				szWarnMsg = "WARNING: can't write: " + szDirectionDBA;
				NI_ASSERT( bRes, szWarnMsg.c_str() );

				v = pG->szRecoilPoint;
				bRes = pManipulator->SetValue( szRecoilPointDBA, v );
				szWarnMsg = "WARNING: can't write: " + szRecoilPointDBA;
				NI_ASSERT( bRes, szWarnMsg.c_str() );

				v = pG->fRecoilLength;
				bRes = pManipulator->SetValue( szRecoilLengthDBA, v );
				szWarnMsg = "WARNING: can't write: " + szRecoilLengthDBA;
				NI_ASSERT( bRes, szWarnMsg.c_str() );

				v = pG->bRecoil;
				bRes = pManipulator->SetValue( szRecoilDBA, v );
				szWarnMsg = "WARNING: can't write: " + szRecoilDBA;
				NI_ASSERT( bRes, szWarnMsg.c_str() );

				v = pG->szRotatePoint;
				bRes = pManipulator->SetValue( szRotatePointDBA, v );
				szWarnMsg = "WARNING: can't write: " + szRotatePointDBA;
				NI_ASSERT( bRes, szWarnMsg.c_str() );

				gunProcessed[ nIdx ] = true; 
			}
		}
	}

	// �������� ����� �����
	int nIdx = 0;
	int nNewElemIdx = nNumElems;
	for ( vector<SGunInfo>::const_iterator i = rGuns.begin(); i != rGuns.end(); ++i, ++nIdx )
	{
		const SGunInfo *pG = i;

		if ( gunProcessed[nIdx] )
			continue;

		if ( !pManipulator->InsertNode( szGunsDba ) )
			continue;

		string szLocNameDBA = StrFmt( "platforms.[%d].guns.[%d].ShootPoint", nPlatformIdx, nNewElemIdx );
		string szDirectionDBA = StrFmt( "platforms.[%d].guns.[%d].Direction", nPlatformIdx, nNewElemIdx );
		string szRecoilPointDBA = StrFmt( "platforms.[%d].guns.[%d].RecoilPoint", nPlatformIdx, nNewElemIdx );
		string szRecoilLengthDBA = StrFmt( "platforms.[%d].guns.[%d].RecoilLength", nPlatformIdx, nNewElemIdx );
		string szRecoilDBA = StrFmt( "platforms.[%d].guns.[%d].Recoil", nPlatformIdx, nNewElemIdx );
		string szRotatePointDBA = StrFmt( "platforms.[%d].guns.[%d].RotatePoint", nPlatformIdx, nNewElemIdx );

		bool bRes;
		CVariant v;
		string szWarnMsg;

		v = pG->szShootPoint;
		bRes = pManipulator->SetValue( szLocNameDBA, v );
		szWarnMsg = "WARNING: can't write: " + szLocNameDBA;
		NI_ASSERT( bRes, szWarnMsg.c_str() );

		v = pG->nDirection;
		bRes = pManipulator->SetValue( szDirectionDBA, v );
		szWarnMsg = "WARNING: can't write: " + szDirectionDBA;
		NI_ASSERT( bRes, szWarnMsg.c_str() );

		v = pG->szRecoilPoint;
		bRes = pManipulator->SetValue( szRecoilPointDBA, v );
		szWarnMsg = "WARNING: can't write: " + szRecoilPointDBA;
		NI_ASSERT( bRes, szWarnMsg.c_str() );

		v = pG->fRecoilLength;
		bRes = pManipulator->SetValue( szRecoilLengthDBA, v );
		szWarnMsg = "WARNING: can't write: " + szRecoilLengthDBA;
		NI_ASSERT( bRes, szWarnMsg.c_str() );

		v = pG->bRecoil;
		bRes = pManipulator->SetValue( szRecoilDBA, v );
		szWarnMsg = "WARNING: can't write: " + szRecoilDBA;
		NI_ASSERT( bRes, szWarnMsg.c_str() );

		v = pG->szRotatePoint;
		bRes = pManipulator->SetValue( szRotatePointDBA, v );
		szWarnMsg = "WARNING: can't write: " + szRotatePointDBA;
		NI_ASSERT( bRes, szWarnMsg.c_str() );

		++nNewElemIdx;
	}

}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void WritePlatformData( IManipulator *pManipulator, const SPlatformInfo *pP, const int nElementIndex )
{
	bool bRes;
	CVariant v;
	string szDBA; 
	string szWarnMsg;

	v = pP->constraint[0];
	szDBA = StrFmt( "platforms.[%d].constraint.Min", nElementIndex );
	bRes = pManipulator->SetValue( szDBA, v );
	szWarnMsg = "WARNING: can't write: " + szDBA;
	NI_ASSERT( bRes, szWarnMsg.c_str() );

	v = pP->constraint[1];
	szDBA = StrFmt( "platforms.[%d].constraint.Max", nElementIndex );
	bRes = pManipulator->SetValue( szDBA, v );
	szWarnMsg = "WARNING: can't write: " + szDBA;
	NI_ASSERT( bRes, szWarnMsg.c_str() );

	v = pP->constraintVertical[0];
	szDBA = StrFmt( "platforms.[%d].constraintVertical.Min", nElementIndex );
	bRes = pManipulator->SetValue( szDBA, v );
	szWarnMsg = "WARNING: can't write: " + szDBA;
	NI_ASSERT( bRes, szWarnMsg.c_str() );

	v = pP->constraintVertical[1];
	szDBA = StrFmt( "platforms.[%d].constraintVertical.Max", nElementIndex );
	bRes = pManipulator->SetValue( szDBA, v );
	szWarnMsg = "WARNING: can't write: " + szDBA;
	NI_ASSERT( bRes, szWarnMsg.c_str() );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void UpdatePlatforms( IManipulator *pManipulator, const vector<SPlatformInfo> &rPlatforms )
{ 
	// �������� ������������ ���������
	CVariant v;
	if ( !pManipulator->GetValue( "platforms", &v ) )
		return;
	const int nNumElems = v;

	vector<BYTE> platformProcessed( rPlatforms.size(), BYTE(0) );
	for ( int i = 0; i < nNumElems; ++i )
	{
		string szLocNameDBA = StrFmt( "platforms.[%d].RotatePoint", i );
		string szConstraintDBA = StrFmt( "platforms.[%d].constraint", i );
		string szConstraintVerticalDBA = StrFmt( "platforms.[%d].constraintVertical", i );

		CVariant v;
		if ( !pManipulator->GetValue( szLocNameDBA, &v ) )
			continue;

		string szLocatorName = v.GetStr();

		int nIdx = 0;
		for ( vector<SPlatformInfo>::const_iterator j = rPlatforms.begin(); j != rPlatforms.end(); ++j, ++nIdx )
		{
			const SPlatformInfo *pP = j;
			if ( szLocatorName != pP->szRotatePoint )
			{
				// pP ��� ������ ����� ���������
				continue;
			}

			if ( pP->szRotatePoint == szLocatorName )
			{
				WritePlatformData( pManipulator, pP, i );
				UpdateGuns( pManipulator, i, pP->guns );
				platformProcessed[ nIdx ] = true; 
			}
		}
	}

	// �������� ����� ���������
	int nIdx = 0;
	int nNewElemIdx = nNumElems;
	for ( vector<SPlatformInfo>::const_iterator i = rPlatforms.begin(); i != rPlatforms.end(); ++i, ++nIdx )
	{
		const SPlatformInfo *pP = i;

		if ( platformProcessed[nIdx] )
			continue;

		if ( !pManipulator->InsertNode( "platforms" ) )
			continue;

		CVariant v = pP->szRotatePoint;
		string szDBA = StrFmt( "platforms.[%d].RotatePoint", nNewElemIdx );
		bool bRes = pManipulator->SetValue( szDBA, v );
		string szWarnMsg = "WARNING: can't write: " + szDBA;
		NI_ASSERT( bRes, szWarnMsg.c_str() );

		WritePlatformData( pManipulator, pP, nNewElemIdx );
		UpdateGuns( pManipulator, nNewElemIdx, pP->guns );

		++nNewElemIdx;
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void SetupPlatformsAndGuns( IManipulator *pManipulator, const vector<SSkeletonLocatorInfo> &rLocatorsInfo )
{
	// ������� ������ � ���-�� ��������
	vector<SPlatformInfo> platformsInfo;
	GetPlatforms( &platformsInfo, rLocatorsInfo );
	std::sort( platformsInfo.begin(), platformsInfo.end() );

	vector<SGunInfo> gunsInfo;

	// ������� ������ � ������
	for ( CLocatorInfoConstIter i = rLocatorsInfo.begin(); i != rLocatorsInfo.end(); ++i )
	{
		if (	PatMat( i->szName.c_str(), "LMainGun*" ) || 
				PatMat( i->szName.c_str(), "LMachineGun*" ) ||
				PatMat( i->szName.c_str(), "Cannon*" ) ) 
		{
			SGunInfo g;
			ProcessGun( &g, (*i), rLocatorsInfo, platformsInfo );
			gunsInfo.push_back( g );
		}
	}

	// ��������� ����� �� ����������
	for ( vector<SGunInfo>::iterator i = gunsInfo.begin(); i != gunsInfo.end(); ++i )
	{
		for ( vector<SPlatformInfo>::iterator j = platformsInfo.begin(); j != platformsInfo.end(); ++j )
		{
			if ( i->szPlatform == j->szRotatePoint )
			{
				j->guns.push_back( *i );
				break;
			}
		}
	}

	// ���������� ����� 
	for ( vector<SPlatformInfo>::iterator i = platformsInfo.begin(); i != platformsInfo.end(); ++i )
		std::sort( i->guns.begin(), i->guns.end() );


	// �����������
	vector<SConstraintInfo> constraints;
	GetModelConstraints( &constraints, pManipulator ); 

	// ����������� �� �������������� �������� ��������
	for ( vector<SPlatformInfo>::iterator i = platformsInfo.begin(); i != platformsInfo.end(); ++i )
	{
		SPlatformInfo *pP = i;
		for ( vector<SConstraintInfo>::const_iterator j = constraints.begin(); j != constraints.end(); ++j )
		{
			const SConstraintInfo *pC = j;
			if ( pC->szName == pP->szRotatePoint )
			{
				if ( pC->bRotConstrMinEnable[2] && pC->bRotConstrMaxEnable[2] )
				{
					pP->constraint[0] = pC->rotLimitMin[2];
					pP->constraint[1] = pC->rotLimitMax[2];
				}
				break;
			}
		}
	}

	// ����������� �� ������������ ������� ���������
	for ( vector<SPlatformInfo>::iterator i = platformsInfo.begin(); i != platformsInfo.end(); ++i )
	{
		SPlatformInfo *pP = i;
		for ( vector<SGunInfo>::const_iterator j = pP->guns.begin(); j != pP->guns.end(); ++j )
		{
			const SGunInfo *pG = j;
			if ( pG->szRotatePoint.empty() )
			{
				// � ����� ��� GunCarriage
				continue;
			}

			bool bFound = false;
			for ( vector<SConstraintInfo>::const_iterator k = constraints.begin(); k != constraints.end(); ++k )
			{
				const SConstraintInfo *pC = k;
				if ( pC->szName == pG->szRotatePoint )
				{
					// ��� ����� ��������� ��������� �� ������� ������ X
					if ( pC->bRotConstrMinEnable[0] && pC->bRotConstrMaxEnable[0] )
					{
						pP->constraintVertical[0] = pC->rotLimitMin[0];
						pP->constraintVertical[1] = pC->rotLimitMax[0];
						bFound = true;
					}
					break;
				}
			}

			if ( bFound )
				break;
		}
	}

	// ����������� �� �����
	for ( vector<SPlatformInfo>::iterator i = platformsInfo.begin(); i != platformsInfo.end(); ++i )
	{
		SPlatformInfo *pP = i;
		for ( vector<SGunInfo>::iterator j = pP->guns.begin(); j != pP->guns.end(); ++j )
		{
			SGunInfo *pG = j;
			if ( pG->szRecoilPoint.empty() )
				continue;

			for ( vector<SConstraintInfo>::const_iterator k = constraints.begin(); k != constraints.end(); ++k )
			{
				const SConstraintInfo *pC = k;
				if ( pC->szName == pG->szRecoilPoint )
				{
					// ��� ����� ��������� �� �������� ����� Y
					if ( pC->bTransConstrMinEnable[1] && pC->bTransConstrMaxEnable[1] )
					{
						pG->fRecoilLength = pC->transLimitMax[1] - pC->transLimitMin[1];
						pG->bRecoil = ( pG->fRecoilLength ? true : false );
					}
					break;
				}
			}
		}
	}

	// ����������� �����
	for ( vector<SPlatformInfo>::iterator i = platformsInfo.begin(); i != platformsInfo.end(); ++i )
	{
		SPlatformInfo *pP = i;
		for ( vector<SGunInfo>::iterator j = pP->guns.begin(); j != pP->guns.end(); ++j )
		{
			SGunInfo *pG = j;
			for ( CLocatorInfoConstIter k = rLocatorsInfo.begin(); k != rLocatorsInfo.end(); ++k )
			{
				if ( k->szName == pG->szShootPoint )
				{
					SHMatrix mtx = k->mtx;
					CVec3 vec;   
          mtx.RotateVector( &vec, V3_AXIS_Z ); 
					vec.z = 0;
					Normalize( &vec );
					float fDir = NMath::ACos( vec.y ); 
					const float F_EPS_ANGLE = 0.01f;
					if ( fabs(fDir) < F_EPS_ANGLE )
						pG->nDirection = 0xFFFF;
					else
						pG->nDirection = (fDir / FP_2PI)*0xFFFF;
				}
			}
		}
	}

	// �������� � ����
	UpdatePlatforms( pManipulator, platformsInfo );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//										CMechUnitRPGStatsExporter
//
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static int FindLocator( const string &szLocatorName, const vector<SSkeletonLocatorInfo> &rLocatorsInfo )
{
	int i = 0;
	while ( i < rLocatorsInfo.size() && rLocatorsInfo[i].szName != szLocatorName )
		++i;

	return i < rLocatorsInfo.size() ? i : -1;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static void CalculteGunsAndPlatformPositions( IManipulator *pManipulator, const vector<SSkeletonLocatorInfo> &rLocatorsInfo )
{
	CVariant v;
	if ( !pManipulator->GetValue( "platforms", &v ) )
		return;
	const int nPlatforms = v;

	for ( int i = 0; i < nPlatforms; ++i )
	{
		// set platform position
		const string szPlatformName = StrFmt( "platforms.[%d].", i );
		
		string szRotateBone;
		if ( !CManipulatorManager::GetValue( &szRotateBone, pManipulator, szPlatformName + "RotatePoint" ) )
			CManipulatorManager::SetVec3( VNULL3, pManipulator, szPlatformName + "AIRotatePointPos" );
		else 
		{
			const int nLocator = FindLocator( szRotateBone, rLocatorsInfo );
			if ( nLocator != -1 )
				CManipulatorManager::SetVec3( rLocatorsInfo[nLocator].vPos, pManipulator, szPlatformName + "AIRotatePointPos" );
		}

		// set guns positions
		CVariant v;
		if ( pManipulator->GetValue( szPlatformName + "guns", &v ) )
		{
			const int nGuns = v;
			for ( int j = 0; j < nGuns; ++j )
			{
				const string szGunName = szPlatformName + StrFmt( "guns.[%d].", j );
				string szShootBone;

				if ( CManipulatorManager::GetValue( &szShootBone, pManipulator, szGunName + "RotatePoint" ) )
				{
					const int nLocator = FindLocator( szShootBone, rLocatorsInfo );
					if ( nLocator != -1 )
						CManipulatorManager::SetVec3( rLocatorsInfo[nLocator].vPos, pManipulator, szGunName + "AIShootPointPos" );
				}
			}
		}
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EXPORT_RESULT CMechUnitRPGStatsExporter::ExportObject( IManipulator* pManipulator,
																											 const string &rszObjectTypeName,
																											 const string &rszObjectName,
																											 bool bForce,
																											 EXPORT_TYPE exportType )
{
	CHPObjectRPGStatsExporter::ExportObject( pManipulator, rszObjectTypeName, rszObjectName, bForce, exportType );
	//
	if ( exportType == ET_BEFORE_REF )
		return ER_SUCCESS;

	ProcessMechUnitAnimations( pManipulator );

	ProcessAABB( pManipulator );
	//
	vector<SSkeletonLocatorInfo> visualObjectLocators;
	vector<SSkeletonLocatorInfo> animateModelLocators;
	vector<SSkeletonLocatorInfo> transportableModelLocators;
	vector<SSkeletonLocatorInfo> allModelsLocators;
	//
	GetModelLocators( &visualObjectLocators, pManipulator, VISUALOBJECT );
	GetModelLocators( &animateModelLocators, pManipulator, ANIMATEMODEL );
	GetModelLocators( &transportableModelLocators, pManipulator, TRANSPORTABLEMODEL );

	allModelsLocators.insert( allModelsLocators.end(), visualObjectLocators.begin(), visualObjectLocators.end() );
	allModelsLocators.insert( allModelsLocators.end(), animateModelLocators.begin(), animateModelLocators.end() );
	allModelsLocators.insert(	allModelsLocators.end(), transportableModelLocators.begin(), transportableModelLocators.end() );

	// ������ ������ ��� ������ ��� ������
	SetPointValueForVec2Field( pManipulator, "LBackWheel", "BackWheel", visualObjectLocators );
	// �������� ������� ��� ������ ��� ������
	SetPointValueForVec2Field( pManipulator, "LFrontWheel", "FrontWheel", visualObjectLocators );

	// ����� ���������� � ������� �����
	SetPointValueForVec2Field( pManipulator, "LHookPoint", "HookPoint", visualObjectLocators );
	// ����� ���������� � ������� ������� ��� ����� ��������� ����� ��� ���������������
	SetPointValueForVec2Field( pManipulator, "LTowingPoint", "TowPoint", visualObjectLocators );

	// ����� ������ ��������� ��� ��������� �������
	SetPointValueForStringField( pManipulator, "LFatalitySmoke", "FatalitySmokePoint", allModelsLocators );
	SetPointsValuesForStringArray( pManipulator, "LSmoke??", "damagePoints", visualObjectLocators );

	// ��������� �����
	SetPointsValuesForStringArray( pManipulator, "LExhaust??", "exhaustPoints", allModelsLocators );

	// ����� ������ ����� � ������
	SetPointsValuesForVec2Array( pManipulator, "LPeople??", "PeoplePoints", allModelsLocators );

	// ���� ��� �������� � ������
	SetPointValueForVec2Field( pManipulator, "LAmmo", "AmmoPoint", visualObjectLocators );
	// ��������
	SetGunnersPoints( pManipulator, allModelsLocators );

	// ����� - �������� - ��������� - ����������
	SetupPlatformsAndGuns( pManipulator, visualObjectLocators );

	CalculteGunsAndPlatformPositions( pManipulator, visualObjectLocators );
	ProcessAttachedObjects( pManipulator );
	//
	return ER_SUCCESS;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ************************************************************************************************************************ //
// **
// ** check RPG stats
// **
// **
// **
// ************************************************************************************************************************ //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EXPORT_RESULT CMechUnitRPGStatsExporter::CheckObject( IManipulator* pManipulator,
																											const string &rszObjectTypeName,
																											const string &rszObjectName,
																											bool bExport,
																											EXPORT_TYPE exportType )
{
	if ( exportType == ET_AFTER_REF )
		return ER_SUCCESS;
	//
	ILogger *pLogger = NLog::GetLogger();
	// check for diving bomber
	{
		string szRPGType;
		CManipulatorManager::GetValue( &szRPGType, pManipulator, "DBtype" );
		if ( szRPGType == "DB_RPG_TYPE_AVIA_ATTACK" ) 
		{
			float fDivingAngle = 0;
			CManipulatorManager::GetValue( &fDivingAngle, pManipulator, "DivingAngle" );
			if ( fDivingAngle == 0 ) 
			{
				pLogger->Log( LT_ERROR, "Invalid diving angle for ground attack plane\n" );
				pLogger->Log( LT_ERROR, StrFmt("\tMechUnit: %s\n", rszObjectName.c_str()) );
				pLogger->Log( LT_ERROR, StrFmt("\tDiving angle: %g\n", fDivingAngle) );
			}
		}
	}
	//
	return ER_SUCCESS;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
