Imports System.Windows.Forms

Public Class FormPrincipal
    Private m_ChildFormNumber As Integer

    Private Sub ExitToolsStripMenuItem_Click(ByVal sender As Object, ByVal e As EventArgs) Handles ExitToolStripMenuItem.Click
        Me.Close()
    End Sub

    Private Sub PessoasToolStripMenuItem_Click(sender As Object, e As EventArgs)


    End Sub

    Private Sub FormPrincipal_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.Text = "Gestor de Saúde"

    End Sub

    Private Sub MédicosToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles MédicosToolStripMenuItem.Click
        Dim ChildForm As New FormMedicos

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub

    Private Sub ClientesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ClientesToolStripMenuItem.Click
        Dim ChildForm As New FormClientes

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub

    Private Sub ToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItem1.Click
        Dim ChildForm As New FormPagamentos

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub

    Private Sub ClinicasHospitalaresToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ClinicasHospitalaresToolStripMenuItem.Click
        Dim ChildForm As New FormClinicaHospitalar

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub

    Private Sub ConsultasToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ConsultasToolStripMenuItem.Click
        Dim ChildForm As New FormConsulta

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub

    Private Sub FichasToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles FichasToolStripMenuItem.Click
        Dim ChildForm As New FormFicha

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub

    Private Sub FichasDoençasToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles FichasDoençasToolStripMenuItem.Click
        Dim ChildForm As New FormFichaDoenças

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub

    Private Sub SegurosToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles SegurosToolStripMenuItem.Click
        Dim ChildForm As New FormSeguros

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub

    Private Sub SecretáriasToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles SecretáriasToolStripMenuItem.Click
        Dim ChildForm As New FormSecretarias

        ' Make it a child of this MDI form before showing it.
        ChildForm.MdiParent = Me

        m_ChildFormNumber += 1
        ChildForm.Text = "Window " & m_ChildFormNumber

        ChildForm.Show()
    End Sub
End Class
