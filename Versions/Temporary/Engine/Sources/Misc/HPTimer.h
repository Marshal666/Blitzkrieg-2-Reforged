#ifndef __HPTIMER_H_
#define __HPTIMER_H_
////////////////////////////////////////////////////////////////////////////////////////////////////
namespace NHPTimer
{
	typedef int64 STime;
	double GetSeconds( const STime &a );
	// �������� ������� �����
	void GetTime( STime *pTime );
	// �������� �����, ��������� � �������, ����������� � *pTime, ��� ���� � *pTime ����� �������� ������� �����
	double GetTimePassed( STime *pTime );
	// �������� ������� ����������
	double GetClockRate();
	// recalc CPU frequency, call regularly to support SpeedStep processors
	void UpdateHPTimerFrequency();
};
////////////////////////////////////////////////////////////////////////////////////////////////////
#endif
