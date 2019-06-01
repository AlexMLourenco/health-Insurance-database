<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class FormPrincipal
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub


    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.MenuStrip = New System.Windows.Forms.MenuStrip()
        Me.FileMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.ExitToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.HelpMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator8 = New System.Windows.Forms.ToolStripSeparator()
        Me.ClientesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.MédicosToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SecretáriasToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ClinicasHospitalaresToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ConsultasToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FichasToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FichasDoençasToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SegurosToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.StatusStrip = New System.Windows.Forms.StatusStrip()
        Me.ToolStripStatusLabel = New System.Windows.Forms.ToolStripStatusLabel()
        Me.ToolTip = New System.Windows.Forms.ToolTip(Me.components)
        Me.MenuStrip.SuspendLayout()
        Me.StatusStrip.SuspendLayout()
        Me.SuspendLayout()
        '
        'MenuStrip
        '
        Me.MenuStrip.ImageScalingSize = New System.Drawing.Size(20, 20)
        Me.MenuStrip.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.FileMenu, Me.HelpMenu})
        Me.MenuStrip.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip.Name = "MenuStrip"
        Me.MenuStrip.Padding = New System.Windows.Forms.Padding(8, 2, 0, 2)
        Me.MenuStrip.Size = New System.Drawing.Size(1292, 28)
        Me.MenuStrip.TabIndex = 5
        Me.MenuStrip.Text = "MenuStrip"
        '
        'FileMenu
        '
        Me.FileMenu.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ExitToolStripMenuItem})
        Me.FileMenu.ImageTransparentColor = System.Drawing.SystemColors.ActiveBorder
        Me.FileMenu.Name = "FileMenu"
        Me.FileMenu.Size = New System.Drawing.Size(44, 24)
        Me.FileMenu.Text = "&File"
        '
        'ExitToolStripMenuItem
        '
        Me.ExitToolStripMenuItem.Name = "ExitToolStripMenuItem"
        Me.ExitToolStripMenuItem.Size = New System.Drawing.Size(108, 26)
        Me.ExitToolStripMenuItem.Text = "E&xit"
        '
        'HelpMenu
        '
        Me.HelpMenu.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripSeparator8, Me.ClientesToolStripMenuItem, Me.MédicosToolStripMenuItem, Me.SecretáriasToolStripMenuItem, Me.ClinicasHospitalaresToolStripMenuItem, Me.ConsultasToolStripMenuItem, Me.FichasToolStripMenuItem, Me.FichasDoençasToolStripMenuItem, Me.SegurosToolStripMenuItem, Me.ToolStripMenuItem1})
        Me.HelpMenu.Name = "HelpMenu"
        Me.HelpMenu.Size = New System.Drawing.Size(70, 24)
        Me.HelpMenu.Text = "&Tabelas"
        '
        'ToolStripSeparator8
        '
        Me.ToolStripSeparator8.Name = "ToolStripSeparator8"
        Me.ToolStripSeparator8.Size = New System.Drawing.Size(218, 6)
        '
        'ClientesToolStripMenuItem
        '
        Me.ClientesToolStripMenuItem.Name = "ClientesToolStripMenuItem"
        Me.ClientesToolStripMenuItem.Size = New System.Drawing.Size(221, 26)
        Me.ClientesToolStripMenuItem.Text = "Clientes"
        '
        'MédicosToolStripMenuItem
        '
        Me.MédicosToolStripMenuItem.Name = "MédicosToolStripMenuItem"
        Me.MédicosToolStripMenuItem.Size = New System.Drawing.Size(221, 26)
        Me.MédicosToolStripMenuItem.Text = "Médicos"
        '
        'SecretáriasToolStripMenuItem
        '
        Me.SecretáriasToolStripMenuItem.Name = "SecretáriasToolStripMenuItem"
        Me.SecretáriasToolStripMenuItem.Size = New System.Drawing.Size(221, 26)
        Me.SecretáriasToolStripMenuItem.Text = "Secretárias"
        '
        'ClinicasHospitalaresToolStripMenuItem
        '
        Me.ClinicasHospitalaresToolStripMenuItem.Name = "ClinicasHospitalaresToolStripMenuItem"
        Me.ClinicasHospitalaresToolStripMenuItem.Size = New System.Drawing.Size(221, 26)
        Me.ClinicasHospitalaresToolStripMenuItem.Text = "Clinicas Hospitalares"
        '
        'ConsultasToolStripMenuItem
        '
        Me.ConsultasToolStripMenuItem.Name = "ConsultasToolStripMenuItem"
        Me.ConsultasToolStripMenuItem.Size = New System.Drawing.Size(221, 26)
        Me.ConsultasToolStripMenuItem.Text = "Consultas"
        '
        'FichasToolStripMenuItem
        '
        Me.FichasToolStripMenuItem.Name = "FichasToolStripMenuItem"
        Me.FichasToolStripMenuItem.Size = New System.Drawing.Size(221, 26)
        Me.FichasToolStripMenuItem.Text = "Fichas"
        '
        'FichasDoençasToolStripMenuItem
        '
        Me.FichasDoençasToolStripMenuItem.Name = "FichasDoençasToolStripMenuItem"
        Me.FichasDoençasToolStripMenuItem.Size = New System.Drawing.Size(221, 26)
        Me.FichasDoençasToolStripMenuItem.Text = "Fichas Doenças"
        '
        'SegurosToolStripMenuItem
        '
        Me.SegurosToolStripMenuItem.Name = "SegurosToolStripMenuItem"
        Me.SegurosToolStripMenuItem.Size = New System.Drawing.Size(221, 26)
        Me.SegurosToolStripMenuItem.Text = "Seguros"
        '
        'ToolStripMenuItem1
        '
        Me.ToolStripMenuItem1.Name = "ToolStripMenuItem1"
        Me.ToolStripMenuItem1.Size = New System.Drawing.Size(221, 26)
        Me.ToolStripMenuItem1.Text = "Pagamentos"
        '
        'StatusStrip
        '
        Me.StatusStrip.ImageScalingSize = New System.Drawing.Size(20, 20)
        Me.StatusStrip.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripStatusLabel})
        Me.StatusStrip.Location = New System.Drawing.Point(0, 654)
        Me.StatusStrip.Name = "StatusStrip"
        Me.StatusStrip.Padding = New System.Windows.Forms.Padding(1, 0, 19, 0)
        Me.StatusStrip.Size = New System.Drawing.Size(1292, 25)
        Me.StatusStrip.TabIndex = 7
        Me.StatusStrip.Text = "StatusStrip"
        '
        'ToolStripStatusLabel
        '
        Me.ToolStripStatusLabel.Name = "ToolStripStatusLabel"
        Me.ToolStripStatusLabel.Size = New System.Drawing.Size(49, 20)
        Me.ToolStripStatusLabel.Text = "Status"
        '
        'FormPrincipal
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1292, 679)
        Me.Controls.Add(Me.MenuStrip)
        Me.Controls.Add(Me.StatusStrip)
        Me.IsMdiContainer = True
        Me.MainMenuStrip = Me.MenuStrip
        Me.Margin = New System.Windows.Forms.Padding(4)
        Me.Name = "FormPrincipal"
        Me.Text = "MDIParent1"
        Me.MenuStrip.ResumeLayout(False)
        Me.MenuStrip.PerformLayout()
        Me.StatusStrip.ResumeLayout(False)
        Me.StatusStrip.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents HelpMenu As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripSeparator8 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents ToolTip As System.Windows.Forms.ToolTip
    Friend WithEvents ToolStripStatusLabel As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents StatusStrip As System.Windows.Forms.StatusStrip
    Friend WithEvents ExitToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents FileMenu As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents MenuStrip As System.Windows.Forms.MenuStrip
    Friend WithEvents ClientesToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents MédicosToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents SecretáriasToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItem1 As ToolStripMenuItem
    Friend WithEvents ClinicasHospitalaresToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents ConsultasToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents FichasToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents FichasDoençasToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents SegurosToolStripMenuItem As ToolStripMenuItem
End Class
