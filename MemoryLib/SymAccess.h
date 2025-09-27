#pragma once
struct CSymString
{
	enum { N_STRING_CHARS = 1024 };
	char szStr[ N_STRING_CHARS ];
	CSymString() { szStr[0] = 0; }
	CSymString &operator=( const char *psz ) 
	{
		szStr[N_STRING_CHARS-1] = 0; 
		strncpy( szStr, psz, N_STRING_CHARS -1 );
		return *this;
	}
	bool operator ==( const char *psz ) { return strcmp( szStr, psz ) == 0; }
};
////////////////////////////////////////////////////////////////////////////////////////////////////
class CSymEngine
{
	CSymEngine( const CSymEngine &a ) {}
	void operator=( const CSymEngine &a ) {}
	HANDLE hProcess;
public:
	CSymEngine();
	~CSymEngine();
	bool GetSymbol( DWORD dwAddress, CSymString *pszModule, CSymString *pszFile, int *pnLine, CSymString *pszFunc );
	HANDLE GetProcess() const { return hProcess; }
};
CSymEngine &GetSymEngine();
////////////////////////////////////////////////////////////////////////////////////////////////////
struct SCallStackEntry
{
	DWORD dwAddress;
	CSymString szFile, szFunc;
	int nLine;
	SCallStackEntry() : dwAddress(0), nLine(-1) {}
};
int CollectCallStack( EXCEPTION_POINTERS *pExPtrs, SCallStackEntry *pRes, int nMaxEntries );
int CollectCallStack( SCallStackEntry *pRes, int nMaxEntries );