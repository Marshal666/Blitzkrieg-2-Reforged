#if !defined(__COMMON_CONTROLS__PROPERTY_CONTROL_BASE_DIALOG__)
#define __COMMON_CONTROLS__PROPERTY_CONTROL_BASE_DIALOG__
#pragma once

interface IView;
#include "..\MapEditorLib\Interface_CommandHandler.h"
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CPCBaseDialog : public ICommandHandler
{
	// ICommandHandler
	virtual bool HandleCommand( UINT nCommandID, DWORD dwData );
	virtual bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck );
	
	// �������� ��������� �� ������
	virtual IView* GetView() = 0;
	// �������� ��������� �� ���������� ������
	virtual ICommandHandler* GetCommandHandler() = 0;
	// ��������� ������
	virtual void CreateTree() = 0;
	// �������� ��� �������� � ������ ��� ��� ����������
	// �� ������������ ��� ����������, ������������ ������ � MaskManipulator
	virtual void UpdateValues() = 0;
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__COMMON_CONTROLS__PROPERTY_CONTROL_BASE_DIALOG__)
