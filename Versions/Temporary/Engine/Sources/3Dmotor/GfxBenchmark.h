#pragma once

namespace NGfx
{
struct SPerformanceInfo
{
	float fPSRate, fFillRate, fTriangleRate, fCPUclock; // in millions
};
void PerformBenchmark();
const SPerformanceInfo &GetPerformanceInfo();
}
