virtual const char* GetName() const { return "AIExpLevel"; }
virtual const char* GetParentName() const { return szTypeName.c_str(); }

enum EUnitRPGType eType;

// ������������� �� ������������ ������ � AI
void ToAIUnits( bool bInEditor ) {}

virtual void PostLoad( bool bInEditor )
{
	//eType = NDb::ReMapRPGType( eDBType );
}