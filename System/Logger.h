#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NLog
{
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface ILogDumper : public CObjectBase
{
	virtual void Dump( const wstring &wszString ) = 0;
};
ILogDumper *CreateFileDumper( const string &szFullFileName );
ILogDumper *CreateDebugDumper();
ILogDumper *CreateAssertDumper();
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CLogger
{
	const string szLoggerName;
	typedef vector<CObj<ILogDumper> > CDumpersList;
	CDumpersList dumpers;
	wstring wszLogBuffer;
	CLogger *pParent;
	//
	CLogger *GetParent() const { return pParent; }
	const string &GetLoggerLocalName() const { return szLoggerName; }
	string GetLoggerFullName() const;
public:
	CLogger( const string &_szLoggerName, CLogger *_pParent ): szLoggerName( _szLoggerName ), pParent( _pParent ) {}
	~CLogger() { Dump(); }
	//
	CLogger &operator<<( const int nVal );
	CLogger &operator<<( const long lVal );
	CLogger &operator<<( const double fVal );
	CLogger &operator<<( const bool bVal );
	CLogger &operator<<( const char cVal );
	CLogger &operator<<( const wchar_t wcVal );
	CLogger &operator<<( const char *pszText );
	CLogger &operator<<( const string &szText );
	CLogger &operator<<( const wchar_t *pwszText );
	CLogger &operator<<( const wstring &wszText );
	//
	CLogger &operator<< ( CLogger &(*Func)( CLogger &logStream ) ) { return Func( *this ); }
	CLogger &Dump();
	bool Dump( const string &szChildLoggerFullName, const wstring &wszString );
	//
	void AddDumper( ILogDumper *pDumper ) { dumpers.push_back( pDumper ); }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NLog::CLogger &endl( NLog::CLogger &logStream ) { return logStream << L"\n"; }
NLog::CLogger &dump( NLog::CLogger &logStream ) { return logStream.Dump(); }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ���������� ���������. ������������ ��� �������� ������� ���������� (��������������).
EXTERNVAR NLog::CLogger logDebug;
// ���������� ���������. ������������ ��� ������� ���������� (��������������).
EXTERNVAR NLog::CLogger logInfo;
// �������������� ��������� � ��������� �������� � ���� (���������������� ����������, ���������� ������� � �.�.)
EXTERNVAR NLog::CLogger logNotice;
// �������������� � ������������� ������������ (�� ��������������) �������� (object outside map)
EXTERNVAR NLog::CLogger logWarning;
// �������� ������ - ������� �� ����� ���� ��������� ���������, �� �� �������� (can't load sound file "attack.wav")
EXTERNVAR NLog::CLogger logError;
// ����������� ������ - �����-�� ���������� ����� ������ ����������� (Can't detect sound card. All Sounds will be disabled)
EXTERNVAR NLog::CLogger logCritical;
// �������� ��������������� ������ - ��������� �� ����� ������ ������������ ��������� (Allocation failed. Not enough memory)
EXTERNVAR NLog::CLogger logAlert;
// �� ����� - unhandled exception - ������������ �� ����������� unhandled exception
EXTERNVAR NLog::CLogger logEmergency;
