<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormClientes
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
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
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.SeguradoraSaudeDataSet = New App.SeguradoraSaudeDataSet()
        Me.SeguradoraSaudeDataSetBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.lstList = New System.Windows.Forms.ListBox()
        Me.txt_nif = New System.Windows.Forms.TextBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.Button4 = New System.Windows.Forms.Button()
        Me.SeguradoraSaudeDataSetBindingSource1 = New System.Windows.Forms.BindingSource(Me.components)
        Me.ClienteBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.ClienteTableAdapter = New App.SeguradoraSaudeDataSetTableAdapters.ClienteTableAdapter()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.txt_nome = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.txt_morada = New System.Windows.Forms.TextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.txt_idade = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.txt_sexo = New System.Windows.Forms.TextBox()
        Me.Button5 = New System.Windows.Forms.Button()
        CType(Me.SeguradoraSaudeDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.SeguradoraSaudeDataSetBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.SeguradoraSaudeDataSetBindingSource1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ClienteBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'SeguradoraSaudeDataSet
        '
        Me.SeguradoraSaudeDataSet.DataSetName = "SeguradoraSaudeDataSet"
        Me.SeguradoraSaudeDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'SeguradoraSaudeDataSetBindingSource
        '
        Me.SeguradoraSaudeDataSetBindingSource.DataSource = Me.SeguradoraSaudeDataSet
        Me.SeguradoraSaudeDataSetBindingSource.Position = 0
        '
        'lstList
        '
        Me.lstList.FormattingEnabled = True
        Me.lstList.ItemHeight = 16
        Me.lstList.Location = New System.Drawing.Point(16, 15)
        Me.lstList.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.lstList.Name = "lstList"
        Me.lstList.Size = New System.Drawing.Size(441, 452)
        Me.lstList.TabIndex = 0
        '
        'txt_nif
        '
        Me.txt_nif.Location = New System.Drawing.Point(495, 54)
        Me.txt_nif.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.txt_nif.Name = "txt_nif"
        Me.txt_nif.Size = New System.Drawing.Size(173, 22)
        Me.txt_nif.TabIndex = 1
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(491, 487)
        Me.Button1.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(100, 28)
        Me.Button1.TabIndex = 2
        Me.Button1.Text = "Insert"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(612, 487)
        Me.Button2.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(100, 28)
        Me.Button2.TabIndex = 3
        Me.Button2.Text = "Edit"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(733, 487)
        Me.Button3.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(100, 28)
        Me.Button3.TabIndex = 4
        Me.Button3.Text = "Delete"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(951, 487)
        Me.Button4.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(100, 28)
        Me.Button4.TabIndex = 5
        Me.Button4.Text = "Close"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'SeguradoraSaudeDataSetBindingSource1
        '
        Me.SeguradoraSaudeDataSetBindingSource1.DataSource = Me.SeguradoraSaudeDataSet
        Me.SeguradoraSaudeDataSetBindingSource1.Position = 0
        '
        'ClienteBindingSource
        '
        Me.ClienteBindingSource.DataMember = "Cliente"
        Me.ClienteBindingSource.DataSource = Me.SeguradoraSaudeDataSet
        '
        'ClienteTableAdapter
        '
        Me.ClienteTableAdapter.ClearBeforeFill = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(491, 31)
        Me.Label1.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(29, 17)
        Me.Label1.TabIndex = 6
        Me.Label1.Text = "NIF"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(495, 97)
        Me.Label2.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(45, 17)
        Me.Label2.TabIndex = 8
        Me.Label2.Text = "Nome"
        '
        'txt_nome
        '
        Me.txt_nome.Location = New System.Drawing.Point(495, 121)
        Me.txt_nome.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.txt_nome.Name = "txt_nome"
        Me.txt_nome.Size = New System.Drawing.Size(555, 22)
        Me.txt_nome.TabIndex = 7
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(493, 162)
        Me.Label3.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(56, 17)
        Me.Label3.TabIndex = 10
        Me.Label3.Text = "Morada"
        '
        'txt_morada
        '
        Me.txt_morada.Location = New System.Drawing.Point(493, 186)
        Me.txt_morada.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.txt_morada.Name = "txt_morada"
        Me.txt_morada.Size = New System.Drawing.Size(555, 22)
        Me.txt_morada.TabIndex = 9
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(493, 230)
        Me.Label4.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(43, 17)
        Me.Label4.TabIndex = 12
        Me.Label4.Text = "Idade"
        '
        'txt_idade
        '
        Me.txt_idade.Location = New System.Drawing.Point(493, 254)
        Me.txt_idade.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.txt_idade.Name = "txt_idade"
        Me.txt_idade.Size = New System.Drawing.Size(173, 22)
        Me.txt_idade.TabIndex = 11
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(712, 230)
        Me.Label5.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(39, 17)
        Me.Label5.TabIndex = 14
        Me.Label5.Text = "Sexo"
        '
        'txt_sexo
        '
        Me.txt_sexo.Location = New System.Drawing.Point(712, 254)
        Me.txt_sexo.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.txt_sexo.Name = "txt_sexo"
        Me.txt_sexo.Size = New System.Drawing.Size(173, 22)
        Me.txt_sexo.TabIndex = 13
        '
        'Button5
        '
        Me.Button5.Location = New System.Drawing.Point(16, 487)
        Me.Button5.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(100, 28)
        Me.Button5.TabIndex = 15
        Me.Button5.Text = "Refresh"
        Me.Button5.UseVisualStyleBackColor = True
        '
        'FormClientes
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1075, 533)
        Me.Controls.Add(Me.Button5)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.txt_sexo)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.txt_idade)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.txt_morada)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.txt_nome)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Button4)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.txt_nif)
        Me.Controls.Add(Me.lstList)
        Me.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.Name = "FormClientes"
        Me.Text = "FormClientes"
        CType(Me.SeguradoraSaudeDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.SeguradoraSaudeDataSetBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.SeguradoraSaudeDataSetBindingSource1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ClienteBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents SeguradoraSaudeDataSetBindingSource As BindingSource
    Friend WithEvents SeguradoraSaudeDataSet As SeguradoraSaudeDataSet
    Friend WithEvents lstList As ListBox
    Friend WithEvents txt_nif As TextBox
    Friend WithEvents Button1 As Button
    Friend WithEvents Button2 As Button
    Friend WithEvents Button3 As Button
    Friend WithEvents Button4 As Button
    Friend WithEvents SeguradoraSaudeDataSetBindingSource1 As BindingSource
    Friend WithEvents ClienteBindingSource As BindingSource
    Friend WithEvents ClienteTableAdapter As SeguradoraSaudeDataSetTableAdapters.ClienteTableAdapter
    Friend WithEvents Label1 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents txt_nome As TextBox
    Friend WithEvents Label3 As Label
    Friend WithEvents txt_morada As TextBox
    Friend WithEvents Label4 As Label
    Friend WithEvents txt_idade As TextBox
    Friend WithEvents Label5 As Label
    Friend WithEvents txt_sexo As TextBox
    Friend WithEvents Button5 As Button
End Class
