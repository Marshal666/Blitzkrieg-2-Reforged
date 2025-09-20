#if !defined(__INTERFACE__CHILD_FRAME__)
#define __INTERFACE__CHILD_FRAME__
#pragma once

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// � cpp ����� �������� ������: REGISTER_CHILD_FRAME_IN_...( typeName, className )
interface IChildFrame : public CObjectBase
{
	//
	virtual bool Create() = 0;
	//
	virtual void Destroy() = 0;
	//
	virtual void Enter() = 0;
	//
	virtual void Leave() = 0;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface IChildFrameContainer : public CObjectBase
{
	enum { tidTypeID = 0x1408B400 };
	//
	// ��������� �� ����������� ��������
	virtual bool CanCreate( const string &rszChildFrameTypeName ) = 0;
	// ��������� ��� ������ ���� �������� ������ �������
	virtual bool IsActive( const string &rszChildFrameTypeName ) = 0;
	// ������� �hild frame
	virtual bool Create( const string &rszChildFrameTypeName ) = 0;
	// ������� Child Frame
	virtual void Destroy() = 0;
	//
	virtual void Enter() = 0;
	//
	virtual void Leave() = 0;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__INTERFACE__CHILD_FRAME__)

