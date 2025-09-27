using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

class CForm : System.Windows.Forms.Form
{
	private System.Windows.Forms.TextBox textBoxFileName;
	private System.Windows.Forms.TextBox refsTextBox;
	private System.Windows.Forms.Button buttonOpenFileDialog;

	private string szFileDialogDir;
	private string szWatchDir;
	private string szDumpDir;
	private System.Windows.Forms.Button buttonDump;
	private CRefsAnswerer refsAnswerer;

	public CForm( string _szWatchDir, CRefsAnswerer _refsAnswerer )
	{
		refsAnswerer = _refsAnswerer;
		szFileDialogDir = _szWatchDir.Replace( "/", @"\" );
		szWatchDir = (string)(szFileDialogDir.Clone());
		szDumpDir = (string)(szFileDialogDir.Clone());

		InitializeComponent();
	}

	#region Windows Form Designer generated code
	private void InitializeComponent()
	{
		System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(CForm));
		this.textBoxFileName = new System.Windows.Forms.TextBox();
		this.buttonOpenFileDialog = new System.Windows.Forms.Button();
		this.refsTextBox = new System.Windows.Forms.TextBox();
		this.buttonDump = new System.Windows.Forms.Button();
		this.SuspendLayout();
		// 
		// textBoxFileName
		// 
		this.textBoxFileName.BackColor = System.Drawing.SystemColors.Window;
		this.textBoxFileName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
		this.textBoxFileName.Location = new System.Drawing.Point(16, 16);
		this.textBoxFileName.Name = "textBoxFileName";
		this.textBoxFileName.Size = new System.Drawing.Size(316, 20);
		this.textBoxFileName.TabIndex = 0;
		this.textBoxFileName.Text = "";
		this.textBoxFileName.KeyUp += new System.Windows.Forms.KeyEventHandler(this.OnTextBoxFileNameKeyUp);
		// 
		// buttonOpenFileDialog
		// 
		this.buttonOpenFileDialog.FlatStyle = System.Windows.Forms.FlatStyle.System;
		this.buttonOpenFileDialog.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((System.Byte)(204)));
		this.buttonOpenFileDialog.ForeColor = System.Drawing.SystemColors.InfoText;
		this.buttonOpenFileDialog.Location = new System.Drawing.Point(332, 16);
		this.buttonOpenFileDialog.Name = "buttonOpenFileDialog";
		this.buttonOpenFileDialog.Size = new System.Drawing.Size(20, 20);
		this.buttonOpenFileDialog.TabIndex = 1;
		this.buttonOpenFileDialog.Text = "...";
		this.buttonOpenFileDialog.Click += new System.EventHandler(this.onButtonOpenFileDialogClick);
		// 
		// refsTextBox
		// 
		this.refsTextBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
		this.refsTextBox.Location = new System.Drawing.Point(16, 48);
		this.refsTextBox.Multiline = true;
		this.refsTextBox.Name = "refsTextBox";
		this.refsTextBox.ReadOnly = true;
		this.refsTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
		this.refsTextBox.Size = new System.Drawing.Size(552, 328);
		this.refsTextBox.TabIndex = 2;
		this.refsTextBox.Text = "";
		// 
		// buttonDump
		// 
		this.buttonDump.Location = new System.Drawing.Point(512, 16);
		this.buttonDump.Name = "buttonDump";
		this.buttonDump.Size = new System.Drawing.Size(56, 20);
		this.buttonDump.TabIndex = 3;
		this.buttonDump.Text = "Dump";
		this.buttonDump.Click += new System.EventHandler(this.buttonDump_Click);
		// 
		// CForm
		// 
		this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
		this.ClientSize = new System.Drawing.Size(578, 384);
		this.Controls.Add(this.buttonDump);
		this.Controls.Add(this.refsTextBox);
		this.Controls.Add(this.textBoxFileName);
		this.Controls.Add(this.buttonOpenFileDialog);
		this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
		this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
		this.MaximizeBox = false;
		this.Name = "CForm";
		this.ResumeLayout(false);

	}
	#endregion

	private bool CheckEnteredFileName( string szRawFileName, out string szFileName )
	{
		szFileName = szRawFileName.Replace( "/", @"\" );
		szFileName = szFileName.ToLower();

		int nWatchDirIndex = szFileName.IndexOf( szWatchDir + @"\");
		if ( nWatchDirIndex != -1 )
			szFileName = szFileName.Replace( szWatchDir + @"\", null );

		return true;
	}

	private void BuildFileDialogDir( string szFileName )
	{
		szFileDialogDir = szWatchDir + @"\" + szFileName;
		szFileDialogDir = szFileDialogDir.Replace( "/", @"\" );

		int nIndex = szFileDialogDir.LastIndexOf( @"\" );
		szFileDialogDir = szFileDialogDir.Remove( nIndex, szFileDialogDir.Length - nIndex );
	}

	private void onButtonOpenFileDialogClick(object sender, System.EventArgs e)
	{
		OpenFileDialog openFileDialog = new OpenFileDialog();
		openFileDialog.InitialDirectory = szFileDialogDir + @"\";
		openFileDialog.Filter = "xdb files (*.xdb)|*.xdb";
		openFileDialog.FilterIndex = 0;
		openFileDialog.RestoreDirectory = true;
		openFileDialog.Multiselect = false;
		if ( openFileDialog.ShowDialog() == DialogResult.OK )
		{
			string szFileName;
			if ( CheckEnteredFileName( openFileDialog.FileName, out szFileName ) )
			{
				BuildFileDialogDir( szFileName );
				textBoxFileName.Text = szFileName;
				ShowFileRefs( szFileName );
			}
		}
	}

	private void OnTextBoxFileNameKeyUp(object sender, System.Windows.Forms.KeyEventArgs e)
	{
		if ( e.KeyValue == 13 )
		{
			string szFileName;
			if ( CheckEnteredFileName( textBoxFileName.Text, out szFileName ) )
			{
				BuildFileDialogDir( szFileName );				
				textBoxFileName.Text = szFileName;
				ShowFileRefs( szFileName );
			}
		}
	}

	private void ShowFileRefs( string szFileName )
	{
		string[] refs = null;
		if ( !refsAnswerer.GetRefsTo( szFileName, out refs ) )
			refsTextBox.Text = "can't display refs now";
		else
		{
			refsTextBox.Text = null;
			if ( refs == null || refs.Length == 0 )
				refsTextBox.Text = "no referencing files";
			else
			{
				System.Array.Sort( refs );
				foreach (string szFile in refs )
				{
					refsTextBox.AppendText( szFile );
					refsTextBox.AppendText( Environment.NewLine );
				}
			}
		}
	}

	private void buttonDump_Click(object sender, System.EventArgs e)
	{
		SaveFileDialog saveFileDialog = new SaveFileDialog();
		saveFileDialog.InitialDirectory = szDumpDir + @"\";
		saveFileDialog.Filter = "All files (*.*)|*.*";
		saveFileDialog.FilterIndex = 0;
		saveFileDialog.RestoreDirectory = true;

		if ( saveFileDialog.ShowDialog() == DialogResult.OK )
		{
			string szFileName = saveFileDialog.FileName;

			int nSlashIndex = szFileName.LastIndexOf( @"\" );
			szDumpDir = szFileName.Remove( nSlashIndex, szFileName.Length - nSlashIndex );

			if ( refsAnswerer.DumpAllRefs( szFileName ) )
				refsTextBox.Text = "dump ok";
			else
				refsTextBox.Text = "can't make dump now";
		}
	}
}
