#ifndef __REGISTER_EDITORS_H__
#define __REGISTER_EDITORS_H__
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ����������� "������", �������������� � �����������
class CRegisterEditorsSemiAutoMagic : public CObjectBase
{
	OBJECT_NOCOPY_METHODS( CRegisterEditorsSemiAutoMagic );

	struct SUIEditor
	{
		string szInstance;

		SUIEditor() {}
		SUIEditor( const string &_szInstance ) : 
			szInstance( _szInstance ) {}
			
		int operator&( IXmlSaver &xs );
	};
	
	vector<SUIEditor> uiEditors;
private:
	const char* GetXMLPath() const;
	const char* GetLabel() const;
public:
	CRegisterEditorsSemiAutoMagic();
	~CRegisterEditorsSemiAutoMagic();
	
	void Load();
	void Save();
	
	int operator&( IXmlSaver &xs );
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern CRegisterEditorsSemiAutoMagic g_RegisterEditorsSemiAutoMagic;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif //__REGISTER_EDITORS_H__
