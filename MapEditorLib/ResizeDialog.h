#if !defined(__COMMON_CONTROLS__RESIZE_DIALOG__)
#define __COMMON_CONTROLS__RESIZE_DIALOG__
#pragma once

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define DECLARE_RESIZE_DLG_WND_COMMON_METHODS( className )														\
protected:																																						\
	void	GetXMLFilePath( string *pszXMLFilePath ) { (*pszXMLFilePath) = #className; }	\
	int GetMinimumXDimension() { return 100; }																					\
	int GetMinimumYDimension() { return 130; }																					\
	bool IsDrawGripper() { return false; }																							\
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CResizeDialog : public CDialog
{
	struct SControlStyle
	{
		CTRect<int> position;
		DWORD dwStyle;
		float fHorCenterAnchorRatio;
		float fVerCenterAnchorRatio;
		float fHorResizeRatio;
		float fVerResizeRatio;
	};

	struct SOptions
	{
		CTRect<int> rect;
		vector<int> nParameters;
		vector<string> szParameters;
		vector<float> fParameters;

		SOptions() : rect( 0, 0, 0, 0 ) {}
		virtual int operator&( IBinSaver &bs );
		virtual int operator&( IXmlSaver &xs );
	};

	hash_map<UINT, SControlStyle> resizeDialogControlStyles;
	CTPoint<int> resizeDialogOriginalSize;
	string szToolTipText;

	public:
	SOptions resizeDialogOptions;
	//ANCHORE_LEFT				resize - ������������ ������ ���� ( ����������� ����� - 0.0f )
	//ANCHORE_RIGHT				resize - ������������ ������� ���� ( ����������� ����� - 1.0f )
	//ANCHORE_HOR_CENTER	resize - ������������ ����������� ����� ( ����������� ����� - fHorCenterAnchorRatio)
	//RESIZE_HOR					������������� ������ ������ �� fHorResizeRatio
	enum
	{
		ANCHORE_LEFT							= 0x001,
		ANCHORE_TOP								= 0x002,
		ANCHORE_RIGHT							= 0x004,
		ANCHORE_BOTTOM						= 0x008,
		RESIZE_HOR								= 0x010,
		RESIZE_VER								= 0x020,
		ANCHORE_HOR_CENTER				= 0x040,
		ANCHORE_VER_CENTER				= 0x080,

		ANCHORE_LEFT_TOP					= ANCHORE_LEFT | ANCHORE_TOP,
		ANCHORE_RIGHT_TOP					= ANCHORE_RIGHT | ANCHORE_TOP,
		ANCHORE_LEFT_BOTTOM				= ANCHORE_LEFT | ANCHORE_BOTTOM,
		ANCHORE_RIGHT_BOTTOM			= ANCHORE_RIGHT | ANCHORE_BOTTOM,
		RESIZE_HOR_VER						= RESIZE_HOR | RESIZE_VER,
		ANCHORE_HOR_VER_CENTER		= ANCHORE_HOR_CENTER | ANCHORE_VER_CENTER,

		DEFAULT_STYLE							= ANCHORE_LEFT_TOP,
	};

	CResizeDialog( UINT nIDTemplate, CWnd* pParent = 0 );
	
	void SetControlStyle( UINT nControlID, DWORD dwStyle = DEFAULT_STYLE, float fHorCenterAnchorRatio = 0.5f, float fVerCenterAnchorRatio = 0.5f, float fHorResizeRatio = 1.0f, float fVerResizeRatio = 1.0f ); //Add and style control to inner structure
	void LoadResizeDialogOptions();
	void SaveResizeDialogOptions();
	
	void UpdateControlPositions();

protected:
	//����������� ������� ���������� ����� �������
	virtual int GetMinimumXDimension() { return 0; }
	virtual int GetMinimumYDimension() { return 0; }

	//������ ����������
	virtual bool SerializeToRegistry() { return false; }
	
	//���� XML ������������ �������� IDataStorage
	virtual void GetXMLFilePath( string *pszXMLFilePath ) {}
	
	//���� REGISTRY ������������ HKEY_CURRENT_USER
	virtual void GetRegistryKey( string *pszRegistryKey ) {}

	//�������� ��� �� �������� �������
	virtual bool IsToolTipsEnable() { return false; }
	virtual bool IsDrawGripper() { return false; }
	virtual bool IsRestoreSize() { return true; }

	virtual HINSTANCE GetResourceHandle() { return 0; }
	virtual bool GetToolTipText( string *pszToolTipText, const UINT nControlID ) { return false; }
	
	virtual void DoDataExchange( CDataExchange* pDX );
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnSize( UINT nType, int cx, int cy );
	afx_msg void OnSizing( UINT fwSide, LPRECT pRect );
	afx_msg void OnPaint();
	afx_msg BOOL OnNeedToolTipText( UINT id, NMHDR *pTTTStruct, LRESULT *pResult );
	afx_msg BOOL OnEraseBkgnd( CDC* pDC );

	DECLARE_MESSAGE_MAP()
};
#define RESIZE_DIALOG_OPTIONS_FILE_NAME "Editor\\ResizeDialogStyles\\"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif // !defined(__COMMON_CONTROLS__RESIZE_DIALOG__)
