#if !defined(__EFFECT_STATE__)
#define __EFFECT_STATE__
#pragma once

#include "..\MapEditorLib\DefaultInputState.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CEffectEditor;
class CEffectState : public CDefaultInputState
{
	//������ ����������� ��� ������� ����������
	list<int> effectIDList;
	// ������ ������ ���������� 
	CEffectEditor *pEffectEditor;
public:
	CEffectState( CEffectEditor *_pCEffectEditor );
	//IInputState
	void Enter();
	void Leave();
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__EFFECT_STATE__)

