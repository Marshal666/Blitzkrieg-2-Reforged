#if !defined(__COMMON_CONTROLS__PROPERTY_CONTROL_MULTILUNE_STRING_EDITOR__)
#define __COMMON_CONTROLS__PROPERTY_CONTROL_MULTILUNE_STRING_EDITOR__
#pragma once

#include "../MapEditorLib/ScintillaEditor.h"
#include "../MapEditorLib/Interface_CommandHandler.h"
#include "PC_ItemEditor.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CPCMultilineStringEditor : public CScintillaEditorWindow, public CPCItemEditor, public ICommandHandler
{
	OBJECT_NOCOPY_METHODS( CPCMultilineStringEditor );

	string szDefaultValue;
	void SetDefaultValue();

protected:
	afx_msg void OnSetFocus( CWnd* pOldWnd );
	afx_msg void OnKillFocus( CWnd* pNewWnd );
	afx_msg void OnChar( UINT nChar, UINT nRepCnt, UINT nFlags );

public:
	CPCMultilineStringEditor();	
	virtual ~CPCMultilineStringEditor();

	virtual BOOL PreTranslateMessage( MSG* pMsg );

	//CPCItemEditor
	bool CreateEditor( const string &rszName, EPCIEType _nEditorType, const SPropertyDesc* _pPropertyDesc, int _nControlID, const SObjectSet &rObjectSet, CWnd *_pwndTargetWindow );
	bool PlaceEditor( const CTRect<int> &rPlaceRect );
	bool ActivateEditor( CDialog *pwndActiveDialog );
	void EnableEdit( bool bEnable );
	//
	void SetValue( const CVariant &rValue );
	void GetValue( CVariant *pValue );
	//
	void ProcessMessage( UINT nMessage, WPARAM wParam, LPARAM lParam );

	// ICommandHandler
	bool HandleCommand( UINT nCommandID, DWORD dwData );
	bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );

	DECLARE_MESSAGE_MAP()
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__COMMON_CONTROLS__PROPERTY_CONTROL_MULTILUNE_STRING_EDITOR__)
