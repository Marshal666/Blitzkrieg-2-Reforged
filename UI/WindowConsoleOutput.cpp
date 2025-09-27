#include "StdAfx.h"
#include ".\windowconsoleoutput.h"


#include "UIVisitor.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "UIML.h"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
static const int CONSOLE_HEIGHT = 240;			//������ ������� � ��������
static const int TEXT_VERTICAL_SIZE = 20;		//������ ������ �� ���������
static const int MINUS_PAGE_SIZE = 5;				//����������� ��������� ������� ��� PgUp PgDown,
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
REGISTER_SAVELOAD_CLASS(0x11095B00, CWindowConsoleOutput )
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CWindowConsoleOutput::SColorString::operator&( IBinSaver &saver )
{
	saver.Add( 1, &szString );
	saver.Add( 2, &dwColor );
	saver.Add( 3, &pGfxText );
	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CWindowConsoleOutput::SColorString::SColorString( const wchar_t *pszStr, DWORD col, const int nWidth ) 
: szString( pszStr ), dwColor( col ) 
{  
	const wstring szText = NStr::ToUnicode( StrFmt( "<color=%.8X>", col ) ) + pszStr;
	pGfxText = CreateML();
	CUIFactory::RegisterMLHandlers( pGfxText );
	pGfxText->SetText( szText, 0 );
	pGfxText->Generate( VirtualToScreenX( nWidth ) );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CWindowConsoleOutput::operator&( IBinSaver &saver )
{
	saver.Add( 1, static_cast<CWindow*>( this ) );
	saver.Add( 2, &pShared );
	saver.Add( 3, &pInstance );
	saver.Add( 4, &pUpperSign );
	saver.Add( 5, &vectorOfStrings );
	saver.Add( 6, &nBeginString );	
	return 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CWindowConsoleOutput::AddString( const wstring &szString, const DWORD color )
{
	int nSizeX;
	GetPlacement( 0, 0, &nSizeX, 0 );
	vectorOfStrings.push_back( SColorString(szString.c_str(), color, nSizeX) );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CWindowConsoleOutput::Scroll( const int bUp )
{
	if ( bUp )
	{
		if ( nBeginString + CONSOLE_HEIGHT / TEXT_VERTICAL_SIZE < vectorOfStrings.size() )
			nBeginString += CONSOLE_HEIGHT / TEXT_VERTICAL_SIZE - MINUS_PAGE_SIZE;
	}
	else
	{
		if ( nBeginString - CONSOLE_HEIGHT / TEXT_VERTICAL_SIZE > 0 )
			nBeginString -= CONSOLE_HEIGHT / TEXT_VERTICAL_SIZE - MINUS_PAGE_SIZE;
		else
			nBeginString = 0;
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CWindowConsoleOutput::Init()
{
	CWindow::Init();
	IScreen *pScreen = GetScreen();
	if ( pScreen )
		GetScreen()->RegisterToSegment( this, true );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CWindowConsoleOutput::Segment( const int timeDiff )
{
	CWindow::Segment( timeDiff );
	int nSizeY;
	GetPlacement( 0, 0, 0, &nSizeY );
	const int nSize = nSizeY / TEXT_VERTICAL_SIZE - 1;
	const int nExtra = vectorOfStrings.size() - nSize;
	if ( nExtra > 0 )
	{
		for ( int i = 0; i < nSize; ++i )
			vectorOfStrings[i] = vectorOfStrings[vectorOfStrings.size() - nSize + i];
		vectorOfStrings.resize( nSize );
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CWindowConsoleOutput::InitByDesc( const struct NDb::SUIDesc *_pDesc )
{
	const NDb::SWindowConsoleOutput *pDesc( checked_cast<const NDb::SWindowConsoleOutput*>( _pDesc ) );
	pInstance = pDesc->Duplicate();
	CWindow::InitByDesc( _pDesc );

	pShared = checked_cast_ptr<const NDb::SWindowConsoleOutputShared *>( pDesc->pShared );
	pUpperSign = CreateML();
	CUIFactory::RegisterMLHandlers( pUpperSign );
	pUpperSign->SetText( L"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^", 0 );
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CWindowConsoleOutput::ToBegin()
{
	nBeginString = 0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CWindowConsoleOutput::ToEnd()
{
	if ( vectorOfStrings.size() > CONSOLE_HEIGHT / TEXT_VERTICAL_SIZE )
		nBeginString = vectorOfStrings.size() - CONSOLE_HEIGHT / TEXT_VERTICAL_SIZE + MINUS_PAGE_SIZE;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CWindowConsoleOutput::Visit( interface IUIVisitor *pVisitor )
{
	CWindow::Visit( pVisitor );

	if ( IsVisible() )
	{
		CTRect<float> wndRect;
		FillWindowRect( &wndRect );

		int nCurrentY = wndRect.y2 - wndRect.y1;
		if ( nBeginString != 0 )
		{
			nCurrentY -= TEXT_VERTICAL_SIZE;
			CTPoint<float> vPosition( 0, nCurrentY );
			CTRect<float> tmp;
			VirtualToScreen( wndRect, &tmp );
			VirtualToScreen( vPosition, &vPosition );
			pVisitor->VisitUIText( pUpperSign, vPosition, tmp );
		}
		else
			nCurrentY -= TEXT_VERTICAL_SIZE;

		// ��������� ������� 
		int nSize = vectorOfStrings.size();
		for ( int i = nBeginString; i < nSize; ++i )
		{
			CTPoint<float> vPosition( 0, nCurrentY );
			VirtualToScreen( vPosition, &vPosition );

			CTRect<float> tmp;
			VirtualToScreen( wndRect, &tmp );
			pVisitor->VisitUIText( vectorOfStrings[nSize - i - 1].pGfxText, tmp.GetLeftTop() + vPosition, tmp );
			nCurrentY -= TEXT_VERTICAL_SIZE;
			if ( nCurrentY < 0 )
				break;
		}
	}
}
