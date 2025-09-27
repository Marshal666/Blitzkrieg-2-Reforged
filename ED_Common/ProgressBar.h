#if !defined(__PROGRESS_BAR_INTERFACE__)
#define __PROGRESS_BAR_INTERFACE__
#pragma once

namespace NProgressBar
{
	// should called ONCE:
	void CreateProgressBar();		// on app startup
	void DestroyProgressBar();	// on app shutdown

	void Start( int nRange, const string & szCaption ); // show window, reset progress bar
	void Finish();							// hide window
	void StepIt();							// step the progress
	void SetCaption( const string & szCaption );
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__PROGRESS_BAR_INTERFACE__)
