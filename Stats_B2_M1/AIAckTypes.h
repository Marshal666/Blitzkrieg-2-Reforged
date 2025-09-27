#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SAIAcknowledgment
{
	int nAck;
	int	nObjUniqueID; // ��� ������
	int nSet;								// number of acknowledgement set

	SAIAcknowledgment() : nAck( 0 ), nObjUniqueID( -1 ), nSet( 0 ) { }
	SAIAcknowledgment( const int _nAck, const int _nObjUniqueID, const int _nSet )
		: nAck( _nAck ), nObjUniqueID( _nObjUniqueID ), nSet( _nSet ) { }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ��� ������� ������� ��������� ��������� Bored � �����
struct SAIBoredAcknowledgement
{
	int nAck;
	int	nObjUniqueID; // ��� ������
	bool bPresent;			// ����� ���������

	SAIBoredAcknowledgement() : nAck( 0 ), nObjUniqueID( -1 ), bPresent( false ) { }
	SAIBoredAcknowledgement( int _nAck, const int _nObjUniqueID, bool _bPresent )
		: nAck( _nAck ), nObjUniqueID( _nObjUniqueID ), bPresent( _bPresent ) { }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
