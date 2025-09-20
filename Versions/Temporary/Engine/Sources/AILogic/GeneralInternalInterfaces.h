#ifndef __GENERAL_INTERNAL_INTERFACES__
#define __GENERAL_INTERNAL_INTERFACES__

class CFormation;
class CAIUnit;
class CCommonUnit;
typedef list< CPtr<CFormation> > Infantry;
typedef list< CPtr<CAIUnit> > MechUnits;
typedef list<CPtr<CCommonUnit> > CommonUnits;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum ETaskName
{
	ETN_DEFEND_PATCH,
	ETN_HOLD_REINFORCEMENT,
	ENT_DEFEND_ESTORAGE,
	ETN_INTENDANT,
	ETN_RESUPPLYCELL,
	ETN_SWARM_TO_POINT,
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// for defining type of force type
enum EForceType
{
	FT_NONE,
	FT_AIR_GUNPLANE,
	FT_AIR_SCOUT,
	FT_AIR_BOMBER,
	FT_AIR_FIGHTER,


	FT_INFANTRY_IN_TRENCHES,
	FT_FREE_INFANTRY,

	FT_MOBILE_TANKS,											// ��������� ������������
	FT_SWARMING_TANKS,										// tanks that is ascribed to attack group
	FT_STATIONARY_MECH_UNITS,							// ����� �� �������
	FT_RECAPTURE_STORAGE,

	FT_TRUCK_REPAIR_BUILDING,							//truck that is able to repair buildings
	FT_TRUCK_RESUPPLY,
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ����� ���� ��������� �������� ������
interface IEnemyEnumerator
{
	// ���������, ����� �� ��� ���������� ������
	virtual bool EnumEnemy( class CAIUnit *pEnemy ) = 0;
	virtual bool EnumResistances( const struct SResistance &resistance ) { return false; }
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ����� ���� - ������
interface IEnemyContainer
{
	virtual void GiveEnemies( IEnemyEnumerator *pEnumerator ) = 0;
	virtual void GiveResistances( IEnemyEnumerator *pEnmumerator ) { }
	virtual void AddResistance( const CVec2 &vCenter, const float fRadius ) = 0;
	virtual void RemoveResistance( const CVec2 &vCenter ) = 0;
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ****
// common interface for validating and sorting workers
// ****
interface IWorkerEnumerator
{
	// return FALSE if enumerator already has enough workers
	virtual bool EnumWorker( class CCommonUnit *pUnit, const enum EForceType eType ) = 0;
	
	// return the avalability of worker for the specific work ( should be fast )
	virtual bool EvaluateWorker( CCommonUnit * pUnit, const enum EForceType eType ) const = 0;

	// if enumerator needs only best units of this kind
	virtual int NeedNBest( const enum EForceType eType ) const { return 0; }
	
	// return presize avalability of worker for enumerator
	virtual float EvaluateWorkerRating( CCommonUnit * pUnit, const enum EForceType eType ) const { return 1.0f; }
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ****
// common interface for workers container
// ****
interface ICommander : public CAIObjectBase
{
	// ������� ��������� ������, ������� ��������� ������ �������
	virtual float GetMeanSeverity() const = 0;
	// ������ ���������� �� �������� ������, ������� � ������ �������� �� ����������
	virtual void EnumWorkers( const EForceType eType, IWorkerEnumerator *pEnumerator ) = 0;
	// �������� ��������� �����
	virtual void Give( CCommonUnit *pWorker ) = 0;
	virtual void Segment() = 0;

	// ���� ������� ���������� ��� ������� or ask for resupply(repair,heal)(�������� ������������)
	virtual int /*request ID*/RequestForSupport( const CVec2 &vSupportCenter, enum EForceType eType ) { return 0; }
	virtual void CancelRequest( int nRequestID, enum EForceType eType ) {  }
};

// ****
// common interface for task
// ****
interface IGeneralTask : public CAIObjectBase
{
	// ��� ����������� ����� �����
	virtual ETaskName GetName() const = 0;
	// ����� ���� ��� ��������� ����������, �� ���, ����� ��������� ���� ����������
	// �� ��������� ��������
	virtual void AskForWorker( ICommander *pManager, const float fMaxSeverity, const bool bInit = false ) = 0;
	// ����� ���� ��� ������� ����������, �� ���, ����� �������� �� ����� 
	// ������ ��������
	virtual void ReleaseWorker( ICommander *pManager, const float fMinSeverity ) = 0;
	// �� ����� ��������� ����� �����������
	//������������� ����������� - ��� ���������, ������������� - ��������� ������
	virtual float GetSeverity() const = 0;

	// ������ ���������
	virtual bool IsFinished() const = 0;

	// ������������� ��������� ������, ������� ���� ����������
	virtual void CancelTask( ICommander *pManager ) = 0;
	
	virtual void Segment() = 0;
	virtual int GetWorkerCount() { return 0; }
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IGeneralDelayedTask : public CAIObjectBase
{
	virtual bool IsTimeToRun() const = 0;
	virtual void Run() = 0;
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // __GENERAL_INTERNAL_INTERFACES__
