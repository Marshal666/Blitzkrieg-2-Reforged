#if !defined(__INTERFACE__EXPORTER__)
#define __INTERFACE__EXPORTER__
#pragma once

#include "Interface_Builder.h"
/**
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IReportCollector : public CObjectBase
{
	virtual void AddReport( const string &szObjectType,
													const string &szObjectName, 
		                      const int nObjectID,
													const string &szUserReport ) = 0;
};
/**/
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define DEFAULT_EXPORTER_LABEL __DefaultHierarchicalExporter__
#define DEFAULT_EXPORTER_LABEL_TXT "__DefaultHierarchicalExporter__"

// ��� ������������� �������� ������ StartExport � FinishExpost ������������ � ������������ �������
// ����� Export ��� �������� ������������ ������ ��� ��� ��������
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// � cpp ����� �������� ������: REGISTER_EDITOR_IN_...( typeName, className )

// ��� �������� ����������
// Constructor()
// StartExport 
// Export()
// ...
// Export()
// FinishExport 

// ��� ���������� ����������
// Destructor()

// ��� ������������ ����������� ( �� ��������� � �� ��������� )
// StartExport 
// Export()
// ...
// Export()
// FinishExport 

// ������ ��������
#define FORCE_EXPORT true
#define NOT_FORCE_EXPORT false

// ������ ��������
#define START_EXPORT_TOOLS true
#define FINISH_EXPORT_TOOLS true
#define NOT_START_EXPORT_TOOLS false
#define NOT_FINISH_EXPORT_TOOLS false

// ������ ��������
#define EXPORT_REFERENCES true
#define CHECK_REFERENCES true
#define NOT_EXPORT_REFERENCES false
#define NOT_CHECK_REFERENCES false

enum EXPORT_TYPE
{
	ET_BEFORE_REF	= 0,
	ET_AFTER_REF	= 1,
	ET_NO_REF			= 2,
};

enum EXPORT_RESULT
{
	ER_FAIL					= 0,
	ER_SUCCESS			= 1,
	ER_BREAK				= 2,
	ER_NOT_CHANGED	= 3,
	ER_UNKNOWN			= 4,
};

interface IManipulator;
interface IExporter : public CObjectBase
{
	// bForce - ����������� ������� �������� (��������� ������ ����)
	// rszObjectTypeName ������������ ��� ��������� ����������� ��� ���������� �������� 
	// (�� ������ ��� �� ������ ���������� ���������)
	// ���������� ����� ������������ ������
	// true - ��� ���������
	// false - ��� ���� �������� ����� ���� ������� �� ����������, ����� ���������� �������� 
	// ���������� ER_FAIL, FinishExport �� ����������
	virtual bool StartExport( const string &rszObjectTypeName, bool bForce ) = 0;
	// ���������� ����� ����������� ������
	virtual void FinishExport( const string &rszObjectTypeName, bool bForce ) = 0;
	// ���������� �� ������ ������
	// ER_FAIL - �� ���������� ������� ������ � ������� ����� ������
	// ER_BREAK - ����������� ����������� �������� ��������
	// ER_SUCCES - ��� ��������, ����� ����������
	virtual EXPORT_RESULT ExportObject( IManipulator* pManipulator,
																			const string &rszObjectTypeName,
																			const string &rszObjectName,
																			bool bForce,
																			EXPORT_TYPE exportType ) = 0;
	// ���������� ����� ��������� �����
	// bExport - ���������� ����� �������� �������
	// true - ��� ���������
	// false - ��� ���� �������� ����� ���� ������� �� ����������, ����� ���������� ��������
	// ���������� ER_FAIL, FinishExport �� ����������
	virtual bool StartCheck( const string &rszObjectTypeName, bool bExport ) = 0;
	// ���������� ����� ����������� ������
	virtual void FinishCheck( const string &rszObjectTypeName, bool bExport ) = 0;
	// ���������� �� ������ ������
	// bExport - ���������� ����� �������� �������
	// ER_FAIL - �� ���������� ������� ������ � ������� ����� ������
	// ER_BREAK - ����������� ����������� �������� ��������
	// ER_SUCCES - ��� ��������, ����� ����������
	virtual EXPORT_RESULT CheckObject( IManipulator* pManipulator,
																			const string &rszObjectTypeName,
																			const string &rszObjectName,
																			bool bExport,
																			EXPORT_TYPE exportType ) = 0;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IExportTool : public CObjectBase
{
	// ���������� �� StartDefaultExport
	virtual void StartExportTool() = 0;
	// ���������� �� FinishDefaultExport
	virtual void FinishExportTool() = 0;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IExporterContainer : public CObjectBase
{
	enum { tidTypeID = 0x1408A3C1 };
	//
	// ��������� �� ����������� ��������������� �������
	virtual bool CanExportObject( const string &rszObjectTypeName ) = 0;
	//�������� ���������� ���������
	virtual IExporter* GetExporter( const string &rszObjectTypeName ) = 0;
	//
	// ������ �������� � �������� �����������
	virtual void Create( const string &rszObjectTypeName ) = 0;
	virtual void Destroy( const string &rszObjectTypeName ) = 0;
	//
	// ������ ��������������� ExportTool
	virtual void RegisterExportTool( IExportTool *pExportTool ) = 0;
	virtual void UnRegisterExportTool( IExportTool *pExportTool ) = 0;
	//
	// ������ ��� ������� �� ���������, ��� ����������� ������������� �������
	virtual bool StartExport( const string &rszObjectTypeName, 
														bool bForce, 
														bool bStartTools, 
														bool bExportReferences ) = 0;
	virtual void FinishExport( const string &rszObjectTypeName, 
														bool bForce, 
														bool bFinishTools, 
														bool bExportReferences ) = 0;
	virtual EXPORT_RESULT ExportObject( IManipulator* pManipulator,
																			const string &rszObjectTypeName,
																			const string &rszObjectName,
																			bool bForce,
																			bool bExportReferences ) = 0;
	// ������ ��� �������� �� ���������, ��� ����������� ������������� ��������
	virtual bool StartCheck( const string &rszObjectTypeName, 
													bool bStartTools, 
													bool bCheckReferences ) = 0;
	virtual void FinishCheck( const string &rszObjectTypeName, 
														bool bFinishTools, 
														bool bCheckReferences ) = 0;
	virtual EXPORT_RESULT CheckObject( IManipulator* pManipulator,
																		 const string &rszObjectTypeName,
																		 const string &rszObjectName,
																		 bool bCheckReferences ) = 0;
	//
	// ��������� �� ��������� ����������� ������� ������� ( ��� ������� � �������: szObjectTypeName:szObjectName )
	virtual EXPORT_RESULT GetExportResult( const string &rszObjectRefName ) = 0;
	// ��������� �� ��������� ����������� ������� �������
	virtual EXPORT_RESULT GetExportResult( const string &rszObjectTypeName, const string &rszObjectName ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__EXPORTER__)

