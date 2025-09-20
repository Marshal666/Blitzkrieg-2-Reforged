// WindowEditLine.h: interface for the CWindowEditLine class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_WINDOWEDITLINE_H__7531A3C4_0749_49AD_8A73_4500671399F2__INCLUDED_)
#define AFX_WINDOWEDITLINE_H__7531A3C4_0749_49AD_8A73_4500671399F2__INCLUDED_

#pragma ONCE

#include "Window.h"
#include "UIComponents.h"

interface IML;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// for edit text. keep focus if being clicked upon
class CWindowEditLine : public CWindow, public IEditLine
{
	OBJECT_BASIC_METHODS(CWindowEditLine)

	CUIMORegConttainer impotantMsgs;

	CObj<IML> pGfxText;								// text to display
	list<CTRect<float> > rectsList;
	//pGfxText->Render( &rectsList, CTPoint<float>( 0, 0 ), CTRect<float>( 0, 0, 0, 0 ) );

	int timeSegment;							// for counting segment times

	int nCursorPos;									//������� ������� � ������� ������������� ������
	bool bShowCursor;								//��� ������� �������
	int nBeginSel;								//������ ���������
	int nEndSel;									//����� ���������
	int m_nBeginDragSel;						//������ ��������� ������
	int nBeginText;		//� ���� ������� ���������� ����������� ������ szFullText

	//��� ���������� ������ ����� � ������
	//� pGFXText ����� ��������� ���� ����� ������������ ������, � � ���� ���������� ��������� �����
	wstring wszFullText;
	bool bRegistered;												// message sink registered
	bool bMouseButton1Down;

	CDBPtr<NDb::SWindowEditLineShared> pShared;
	CPtr<NDb::SWindowEditLine> pInstance;

	CPtr<IFocusNotify> pFocusNotify;

	//selection under mouse position
	int GetSelection( const int nX );
	// deletes text under selection
	bool DeleteSelection();
	// determines weather the sybmbol is valid according to allowable set
	bool IsValidSymbol( const wchar_t chr ) const;
	void NotifyTextChanged();
	void EnsureCursorVisible();
	bool CheckTextInsideEditLine();

	void FillWindowRectEditLine( CTRect<float> *pRect );

	void CreateText();
	void InitLocal();
	void CopySelectionToClipboard();

	// CRAP - should be removed
	void UpdateFocus();

	// return false if char isn't fit into edit line space and is not added by this reason
	bool AddChar( const wchar_t chr );
	int GetTextWidth( const int nFirstChars );
	void SetTextToGfx( const wstring &szText );
	//bool ProcessEvent( const struct SGameMessage &msg );
protected:
	NDb::SWindow* GetInstance() { return pInstance; }

public:
	CWindowEditLine();

	int operator&( IBinSaver &saver );

	//{ CWindow
	void SetFocus( const bool bFocus );
	//}
	void SetFocusNotify( IFocusNotify *_pNotify ) { pFocusNotify = _pNotify; }
	
	void Init();
	void InitByDesc( const struct NDb::SUIDesc *pDesc );
	void AfterLoad();

	// IWindow
	void Visit( interface IUIVisitor *pVisitor );
	void Segment( const int timeDiff );

	bool OnMouseMove( const CVec2 &_vPos, const int nButton );
	bool OnButtonDown( const CVec2 &_vPos, const int nButton );
	bool OnButtonUp( const CVec2 &_vPos, const int nButton );

	void Reposition( const CTRect<float> &rcParent );

	// IEditLine
	void SetCursor( const int nPos );
	void SetSelection( const int nBegin, const int nEnd );
	void SetText( const wchar_t *pszText );
	const wchar_t * GetText() const { return wszFullText.c_str(); }
	

	void RegisterObservers();

	bool ProcessEvent( const struct SGameMessage &msg );
	
	//begin message sinks
	bool OnReturn();
	void OnTab( const struct SGameMessage &msg );
	void OnBack( const struct SGameMessage &msg );
	void OnDelete( const struct SGameMessage &msg );
	void OnLeft( const struct SGameMessage &msg );
	void OnCtrlLeft( const struct SGameMessage &msg );
	void OnRight( const struct SGameMessage &msg );
	void OnCtrlRight( const struct SGameMessage &msg );
	void OnHome( const struct SGameMessage &msg );
	void OnEnd( const struct SGameMessage &msg );
	bool OnEscape();
	bool OnChar( const SGameMessage &msg );
	bool OnKey( const SGameMessage &msg );

	void OnPaste( const struct SGameMessage &msg );
	void OnCopy( const struct SGameMessage &msg );
	void OnCut( const struct SGameMessage &msg );
	void OnSelectAll( const struct SGameMessage &msg );
	//end message sinks
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif // !defined(AFX_WINDOWEDITLINE_H__7531A3C4_0749_49AD_8A73_4500671399F2__INCLUDED_)
