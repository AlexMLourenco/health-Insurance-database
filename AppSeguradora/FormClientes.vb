Imports System.Data.SqlClient

Public Class FormClientes

    Dim _con As SqlConnection

    Private Sub refrescar()

        lstList.Items.Clear()

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim Command As SqlCommand = New SqlCommand()
        Command.Connection = Me._con
        Command.CommandText = "SeguradoraSaude.GetClientList"
        Command.CommandType = CommandType.StoredProcedure

        Dim reader As SqlDataReader

        reader = Command.ExecuteReader()

        If reader.HasRows Then
            While (reader.HasRows)
                While (reader.Read())
                    lstList.Items.Add(New KeyValue(reader.GetInt32(1), reader.GetString(0)))
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
            com.CommandText = "SeguradoraSaude.NewClient"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@clientNIF", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@name", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@address", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@yearsOld", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@sex", txt_sexo.Text))

            com.ExecuteNonQuery()

            MsgBox("Inserido com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub eliminar(ByVal nif As String)
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.DeleteUser"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@userNIF", nif))

            com.ExecuteNonQuery()

            MsgBox("Apagado com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub carregar(ByVal nif As Long)

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim com As SqlCommand = New SqlCommand()
        com.Connection = Me._con
        com.CommandText = "SeguradoraSaude.GetClientNIF"
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@clientNIF", nif))

        Dim reader As SqlDataReader

        reader = com.ExecuteReader()

        If reader.HasRows Then

            reader.Read()
            txt_nome.Text = reader.GetString(0)
            txt_nif.Text = reader.GetInt32(1)
            txt_morada.Text = reader.GetString(2)
            txt_idade.Text = reader.GetInt32(3)
            txt_sexo.Text = reader.GetString(4)

        End If

        Me._con.Close()
    End Sub

    Private Sub atualizar()
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.UpdateUserInfo"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@userNIF", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@name", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@address", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@yearsOld", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@sex", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@salary", vbNull))
            com.Parameters.Add(New SqlParameter("@specialization", vbNull))
            com.Parameters.Add(New SqlParameter("@clinicNumber", vbNull))

            Dim res As Integer

            res = com.ExecuteNonQuery()

            If (res = -1) Then
                MsgBox("Pessoa não Existe")
            Else
                MsgBox("Atualizado com sucesso")
            End If

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()
    End Sub

    Private Sub FormClientes_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        refrescar()


    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Me.inserir()
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Me.Close()
    End Sub

    Private Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click
        Me.refrescar()
    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim nif As String

        nif = InputBox("Introduzir o NIF", "Eliminar", 0)
        Me.eliminar(nif)
    End Sub

    Private Sub LstList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lstList.SelectedIndexChanged
        Dim _item As KeyValue
        _item = lstList.SelectedItem
        carregar(_item.key)
    End Sub

    Private Sub Txt_nif_TextChanged(sender As Object, e As EventArgs) Handles txt_nif.TextChanged

    End Sub

    Private Sub Label1_Click(sender As Object, e As EventArgs) Handles Label1.Click

    End Sub

    Private Sub Txt_nome_TextChanged(sender As Object, e As EventArgs) Handles txt_nome.TextChanged

    End Sub

    Private Sub Label2_Click(sender As Object, e As EventArgs) Handles Label2.Click

    End Sub

    Private Sub Label3_Click(sender As Object, e As EventArgs) Handles Label3.Click

    End Sub

    Private Sub Txt_morada_TextChanged(sender As Object, e As EventArgs) Handles txt_morada.TextChanged

    End Sub

    Private Sub Label4_Click(sender As Object, e As EventArgs) Handles Label4.Click

    End Sub

    Private Sub Txt_idade_TextChanged(sender As Object, e As EventArgs) Handles txt_idade.TextChanged

    End Sub

    Private Sub Txt_sexo_TextChanged(sender As Object, e As EventArgs) Handles txt_sexo.TextChanged

    End Sub

    Private Sub Label5_Click(sender As Object, e As EventArgs) Handles Label5.Click

    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Me.atualizar()

    End Sub
End Class