#if !defined(__INTERFACE__COMMAND_HANDLER__)
#define __INTERFACE__COMMAND_HANDLER__
#pragma once

#define INVALID_COMMAND_ID (0xFFffFFff)
#define INVALID_COMMAND_HANDLER_ID (0xFFffFFff)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ����������� �� CWnd ������ ������ ��� ��������� �������, ������� �� ���������
interface ICommandHandler
{
	virtual ~ICommandHandler() {}
	//
	// ���������� ������� �� User Interface, ���� ������� false, �� ������� �� ����������
	virtual bool HandleCommand( UINT nCommandID, DWORD dwData ) = 0;
	// ����� �� ������ ������������ �������? ���� ������� false, �� ������� �� ����������
	virtual bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck ) = 0;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ������ ��� ����������� ��������� ����������� ������
// ������ ��� ��������� �������� ����, ���� �� ����� �� ��������� �������� ������ ����
// ���������� �� ���������� �������� (�����������)
interface ICommandHandlerContainer : public CObjectBase
{
	enum { tidTypeID = 0x1408A381 };
	// ��������������� ���������� � MainFrame ( ������� �� ����������������� ���������� )
	virtual void Register( UINT nType, UINT nFirstCommandID, UINT nLastCommandID ) = 0;
	// ������� ����������� ����������� �� Mainframe
	virtual void UnRegister( UINT nType ) = 0;
	// ���������� ���������� ������� �� User Interface
	virtual void Set( UINT nType, ICommandHandler *pCommandHandler ) = 0;
	// ������� ���������� �������, ��� ������� ��� ��������� pCommandHandler �������� owner
	virtual void Remove( UINT nType, ICommandHandler *pCommandHandler ) = 0;
	// ������� ���������� �������
	virtual void Remove( UINT nType ) = 0;
	// �������� ���������� ������� 
	virtual ICommandHandler* Get( UINT nType ) = 0;
	// �������� ������� �� ���������, ���������� ������������������� �����������
	virtual bool HandleCommand( UINT nType, UINT nCommandID, DWORD dwData ) = 0;
	// ��������� ����������� ��������� ������� � ���������� ������������������� �����������
	virtual bool UpdateCommand( UINT nType, UINT nCommandID, bool *pbEnable, bool *pbCheck ) = 0;
	// �������� ������� �� ���������, ���������� �������� �� ����� ������������������
	virtual bool HandleCommand( UINT nCommandID, DWORD dwData ) = 0;
	// ��������� ����������� ��������� �������, ���������� �������� �� ����� ������������������
	virtual bool UpdateCommand( UINT nCommandID, bool *pbEnable, bool *pbCheck ) = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__COMMAND_HANDLER__)

