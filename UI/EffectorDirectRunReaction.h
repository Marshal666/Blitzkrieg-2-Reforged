#pragma ONCE

/////////////////////////////////////////////////////////////////////////////
// run message reaction
class CEffectorDirectRunReaction : public IUIEffector
{
	OBJECT_BASIC_METHODS(CEffectorDirectRunReaction)
	ZDATA
	CDBPtr< NDb::SUIDesc > pReactionBackward;
	CDBPtr< NDb::SUIDesc > pReactionForward;
	bool bFinished;
	bool bForward;
	string szAnimatedWindow;
	ZEND int operator&( IBinSaver &f ) { f.Add(2,&pReactionBackward); f.Add(3,&pReactionForward); f.Add(4,&bFinished); f.Add(5,&bForward); f.Add(6,&szAnimatedWindow); return 0; }
public:
	CEffectorDirectRunReaction() {  }
	virtual bool IsFinished() const;
	virtual void Configure( const NDb::SUIStateBase *_pCmd, interface IScreen *pScreen, SWindowContext *pContext, const string &szAnimatedWindow );
	virtual const int Segment( const int timeDiff, interface IScreen *pScreen, const bool bFastForward );
	virtual void Visit( interface IUIVisitor *pVisitor ) { }
	virtual void Reverse();
};
/////////////////////////////////////////////////////////////////////////////
