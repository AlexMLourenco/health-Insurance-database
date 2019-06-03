Imports System.Data.SqlClient

Public Class FormClinicaHospitalar

    Dim _con As SqlConnection

    Private Sub refrescar()

        lstList.Items.Clear()

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim Command As SqlCommand = New SqlCommand()
        Command.Connection = Me._con
        Command.CommandText = "SeguradoraSaude.GetClinicList"
        Command.CommandType = CommandType.StoredProcedure

        Dim reader As SqlDataReader

        reader = Command.ExecuteReader()

        If reader.HasRows Then
            While (reader.HasRows)
                While (reader.Read())
                    lstList.Items.Add(New KeyValue(reader.GetInt32(1), reader.GetString(0) & " | Number: " & reader.GetInt32(1)))
                End While
                reader.NextResult()
            End While
        End If

        Me._con.Close()
    End Sub

    Private Sub inserir()
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.NewClinic"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@clinicName", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@localization", txt_nome.Text))

            com.ExecuteNonQuery()

            MsgBox("Inserido com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub eliminar(ByVal NumClinica As String)
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.DeleteClinic"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@ClinicNum", NumClinica))

            com.ExecuteNonQuery()

            MsgBox("Apagado com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub carregar(ByVal NumClinica As Long)

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim com As SqlCommand = New SqlCommand()
        com.Connection = Me._con
        com.CommandText = "SeguradoraSaude.GetClinicNum"
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@clinicNum", NumClinica))

        Dim reader As SqlDataReader

        reader = com.ExecuteReader()

        If reader.HasRows Then

            reader.Read()
            txt_nif.Text = reader.GetString(0)
            txt_nome.Text = reader.GetString(1)

        End If

        Me._con.Close()
    End Sub

    Private Sub atualizar()
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.UpdateClinic"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@numClinic", TextBox1.Text))
            com.Parameters.Add(New SqlParameter("@nameClinic", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@localization", txt_nome.Text))

            Dim res As Integer

            res = com.ExecuteNonQuery()

            If (res = -1) Then
                MsgBox("Não foi possível atualizar a clinica")
            Else
                MsgBox("Clinica Atualizada/Adicionada")
            End If

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()
    End Sub

    Private Sub txt_nif_TextChanged(sender As Object, e As EventArgs) Handles txt_nif.TextChanged
        'nomeClinica
    End Sub

    Private Sub txt_nome_TextChanged(sender As Object, e As EventArgs) Handles txt_nome.TextChanged
        'localizacao
    End Sub

    Private Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click
        Me.refrescar()
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Me.inserir()
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Me.atualizar()
    End Sub

    Private Sub LstList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lstList.SelectedIndexChanged
        Dim _item As KeyValue
        _item = lstList.SelectedItem
        carregar(_item.key)
    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim nif As String

        nif = InputBox("Introduzir o numero da clínica", "Eliminar", 0)
        Me.eliminar(nif)
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Me.Close()
    End Sub

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles TextBox1.TextChanged
        'numeroClinica
    End Sub
End Class