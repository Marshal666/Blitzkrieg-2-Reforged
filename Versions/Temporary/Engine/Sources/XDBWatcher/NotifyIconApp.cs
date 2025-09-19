using System;
using System.Drawing;
using System.Windows.Forms;

class CNotifyIconAppContext : ApplicationContext, CPause
{
	private System.ComponentModel.IContainer components;
	private NotifyIcon notifyIcon;
	private MenuItem exitContextMenuItem;
	private MenuItem refsInfoContextMenuItem;
	private MenuItem statsContextMenuItem;
	private MenuItem pauseContextMenumItem;
	private ContextMenu	contextMenu;
	private Form mainForm = null;
	private string szWatchDir;
	private CXDB xDB;
	private CDBFixer dbFixer;
	bool bOnPause;
	bool bLoading;
	private Timer timer;

	private void InitializeContext()
	{
		components = new System.ComponentModel.Container();
		notifyIcon = new NotifyIcon(components);
		contextMenu = new ContextMenu();
		refsInfoContextMenuItem = new MenuItem();		
		exitContextMenuItem = new MenuItem();
		statsContextMenuItem = new MenuItem();
		pauseContextMenumItem = new MenuItem();

		notifyIcon.ContextMenu = contextMenu;
		System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
		System.IO.Stream appPause = assembly.GetManifestResourceStream( "XDBWatcher.app_loading.ico" );
		notifyIcon.Icon = new System.Drawing.Icon( appPause );
		bLoading = true;

		notifyIcon.Text = "XDBWatcher";
		notifyIcon.Visible = true;

		contextMenu.MenuItems.AddRange(new MenuItem[]{ pauseContextMenumItem, refsInfoContextMenuItem, statsContextMenuItem, exitContextMenuItem });

		exitContextMenuItem.Index = 3;
		exitContextMenuItem.Text = "&Exit";
		exitContextMenuItem.Click += new System.EventHandler(contextMenuExitItem_Click);

		statsContextMenuItem.Index = 2;
		statsContextMenuItem.Text = "&Statistics";
		statsContextMenuItem.Click += new System.EventHandler(contextMenustatisticsItem_Click);

		refsInfoContextMenuItem.Index = 1;
		refsInfoContextMenuItem.Text = "&References";
		refsInfoContextMenuItem.Click += new System.EventHandler(refsInfoContextMenuItem_Click);

		pauseContextMenumItem.Index = 0;
		pauseContextMenumItem.Text = "&Pause";
		pauseContextMenumItem.Click += new System.EventHandler(pauseContextMenumItem_Click);

		timer = new Timer();
		timer.Interval = 5000;
		timer.Tick += new EventHandler( On_Timer );
		timer.Start();
	}

	private void contextMenuExitItem_Click( object sender, EventArgs e )
	{
		ExitThread();
	}
	private void mainForm_Closed( object sender, EventArgs e )
	{
		mainForm = null;
	}
	private void mainForm_Resized( object sender, EventArgs e )
	{
		if ( mainForm != null )
		{
			mainForm.Close();
			mainForm = null;
		}
	}
	private void refsInfoContextMenuItem_Click(object sender, EventArgs e)
	{
		if ( mainForm == null )
		{
			mainForm = new CForm( szWatchDir, xDB );
			mainForm.Show();

			mainForm.Closed += new EventHandler( mainForm_Closed );		
			mainForm.Resize += new EventHandler( mainForm_Resized );
		}
		else
			mainForm.Activate();
	}

	public bool CanSetPause()
	{
		return dbFixer.CanSetPause();
	}
	public void Pause( bool bPause )
	{
		if ( bPause == bOnPause )
			return;

		if ( bPause && !CanSetPause() )
			return;
		
		bOnPause = bPause;
		
		if ( bPause == true )
		{
			pauseContextMenumItem.Text = "Un&pause";

			System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
			System.IO.Stream appPause = assembly.GetManifestResourceStream( "XDBWatcher.app_pause.ico" );
			notifyIcon.Icon = new System.Drawing.Icon( appPause );
		}
		else
		{
			pauseContextMenumItem.Text = "&Pause";
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(CForm));
			notifyIcon.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
		}

		dbFixer.Pause( bPause );
	}

	private void pauseContextMenumItem_Click( object sender, EventArgs e )
	{
		Pause( !bOnPause );
	}

	private void contextMenustatisticsItem_Click( object sender, EventArgs e )
	{
		string stats = xDB.GetStats();
		MessageBox.Show( stats );
	}

	private void On_Timer(object sender, EventArgs myEventArgs)
	{
		if ( bLoading && !dbFixer.IsLoading() )
		{
			bLoading = false;
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(CForm));
			notifyIcon.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
		}
		
		notifyIcon.Text = "XDBWatcher\n";
		if ( bOnPause )
			notifyIcon.Text += "Paused\n";
		else if ( bLoading )
			notifyIcon.Text += "Loading...\n";

		notifyIcon.Text += xDB.GetStats();
	}


	protected override void Dispose( bool disposing )
	{
		if( disposing )
		{
			if (components != null) 
			{
				components.Dispose();
			}
		}		
	}		

	protected override void ExitThreadCore()
	{
		base.ExitThreadCore();
	}


	public CNotifyIconAppContext( string _szWatchDir, CXDB _xDB, CDBFixer _dbFixer )
	{
		szWatchDir = _szWatchDir;
		xDB = _xDB;
		dbFixer = _dbFixer;
		bOnPause = false;
		InitializeContext();
	}
}
