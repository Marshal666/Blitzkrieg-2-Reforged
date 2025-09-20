#if !defined(__EDITOR_TEST_STATE__)
#define __EDITOR_TEST_STATE__
#pragma once

#include "..\MapEditorLib\DefaultInputState.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CEditorTestEditor;
class CEditorTestState : public CDefaultInputState
{
	// ������ ������ ���������� 
	CEditorTestEditor *pEditorTestEditor;
public:
	CEditorTestState( CEditorTestEditor *_pCEditorTestEditor );
	//IInputState
	void Enter();
	void Leave();
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__EDITOR_TEST_STATE__)

