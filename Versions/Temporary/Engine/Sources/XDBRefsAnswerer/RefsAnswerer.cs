using System;
using System.Reflection;

[assembly:AssemblyKeyFile("../../refsAnswerer.snk")]
[assembly:AssemblyVersion("1.0.0.0")]

public abstract class CRefsAnswerer
{
	public abstract bool GetRefsTo( string szFileName, out string[] refFiles );
	public abstract bool DumpAllRefs( string szFileName );
};

public interface CPause
{
	bool CanSetPause();
	void Pause( bool bPause );
}

public class CRemoteRefsAnswerer : System.MarshalByRefObject
{
	public static CRefsAnswerer refsAnswerer;
	public static CPause pause;

	public bool GetRefsTo( string szFileName, out string[] refFiles )
	{
		return refsAnswerer.GetRefsTo( szFileName, out refFiles );
	}

	public bool DumpAllRefs( string szFileName )
	{
		return refsAnswerer.DumpAllRefs( szFileName );
	}

	public bool CanSetPause()
	{
		return pause.CanSetPause();
	}

	public void Pause( bool bPause )
	{
		pause.Pause( bPause );
	}
};
