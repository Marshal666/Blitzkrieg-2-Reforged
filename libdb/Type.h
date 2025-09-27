#pragma once
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NDb
{
namespace NTypeDef
{
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum ETypeType
{
	TYPE_TYPE_UNKNOWN,
	TYPE_TYPE_INT,
	TYPE_TYPE_FLOAT,
	TYPE_TYPE_BOOL,
	TYPE_TYPE_GUID,
	TYPE_TYPE_STRING,
	TYPE_TYPE_WSTRING,
	TYPE_TYPE_BINARY,
	TYPE_TYPE_ENUM,
	TYPE_TYPE_REF,
	TYPE_TYPE_ARRAY,
	TYPE_TYPE_STRUCT,
	TYPE_TYPE_CLASS,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
enum EEditorType
{
	EDITOR_TYPE_UNKNOWN,
	EDITOR_TYPE_INT_INPUT,
	EDITOR_TYPE_INT_SLIDER,
	EDITOR_TYPE_INT_COMBO,
	EDITOR_TYPE_INT_COLOR,
	EDITOR_TYPE_INT_COLOR_WITH_ALPHA,
	EDITOR_TYPE_FLOAT_INPUT,
	EDITOR_TYPE_FLOAT_SLIDER,
	EDITOR_TYPE_FLOAT_COMBO,
	EDITOR_TYPE_BOOL_COMBO,
	EDITOR_TYPE_BOOL_CHECKBOX,
	EDITOR_TYPE_BOOL_SWITCHER,
	EDITOR_TYPE_GUID,
	EDITOR_TYPE_STRING_REF,
	EDITOR_TYPE_STRING_MULTI_REF,
	EDITOR_TYPE_STRING_INPUT,
	EDITOR_TYPE_STRING_BIG_INPUT,
	EDITOR_TYPE_STRING_COMBO,
	EDITOR_TYPE_STRING_COMBO_REF,
	EDITOR_TYPE_STRING_COMBO_MULTI_REF,
	EDITOR_TYPE_STRING_FILE_REF,
	EDITOR_TYPE_STRING_DIR_REF,
	EDITOR_TYPE_BIT_FIELD,
	EDITOR_TYPE_STRING_NEW_REF,
	EDITOR_TYPE_STRING_NEW_MULTI_REF,
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
};
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
NDb::NTypeDef::ETypeType StringToEnum_NDb_NTypeDef_ETypeType( const string &szName );
const char *EnumToString_NDb_NTypeDef_ETypeType( NDb::NTypeDef::ETypeType eType );
template<>
struct SKnownEnum<NDb::NTypeDef::ETypeType>
{
	enum { isKnown = 1 };
	static NDb::NTypeDef::ETypeType ToEnum( const string &szName ) { return StringToEnum_NDb_NTypeDef_ETypeType( szName ); }
	static const char *ToString( NDb::NTypeDef::ETypeType eType ) { return EnumToString_NDb_NTypeDef_ETypeType( eType ); }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

