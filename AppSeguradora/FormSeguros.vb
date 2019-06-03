Imports System.Data.SqlClient

Public Class FormSeguros

    Dim _con As SqlConnection

    Private Sub refrescar()

        lstList.Items.Clear()

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim Command As SqlCommand = New SqlCommand()
        Command.Connection = Me._con
        Command.CommandText = "SeguradoraSaude.GetInsurenceList"
        Command.CommandType = CommandType.StoredProcedure

        Dim reader As SqlDataReader

        reader = Command.ExecuteReader()

        If reader.HasRows Then
            While (reader.HasRows)
                While (reader.Read())
                    lstList.Items.Add(New KeyValue(reader.GetInt32(5), reader.GetString(6) & " | " & reader.GetInt32(5) & " | " & reader.GetDateTime(3)))
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
            com.CommandText = "SeguradoraSaude.NewInsurance"
            com.CommandType = CommandType.StoredProcedure


            com.Parameters.Add(New SqlParameter("@clientNIF", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@name", vbNull))
            com.Parameters.Add(New SqlParameter("@address", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOld", vbNull))
            com.Parameters.Add(New SqlParameter("@sex", vbNull))
            com.Parameters.Add(New SqlParameter("@idInsurance", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@type", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@fee", txt_morada.Text))   'cota
            com.Parameters.Add(New SqlParameter("@lack", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@insurenceDate", TextBox1.Text))

            com.ExecuteNonQuery()

            MsgBox("Inserido com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub eliminar(ByVal ID As String)
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.DeleteInsurence"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@InsID", ID))

            com.ExecuteNonQuery()

            MsgBox("Apagado com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub carregar(ByVal ID As Long)

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim com As SqlCommand = New SqlCommand()
        com.Connection = Me._con
        com.CommandText = "SeguradoraSaude.GetInsurenceID"
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@insurenceID", ID))

        Dim reader As SqlDataReader

        reader = com.ExecuteReader()

        If reader.HasRows Then

            reader.Read()
            txt_nome.Text = reader.GetString(0)     'tipo
            txt_morada.Text = reader.GetInt32(1)    'cota
            txt_sexo.Text = reader.GetString(2)     'carencia
            TextBox1.Text = reader.GetDateTime(3)   'data
            txt_idade.Text = reader.GetInt32(4)     'nif
            txt_nif.Text = reader.GetInt32(5)       'ID

        End If

        Me._con.Close()

    End Sub

    Private Sub atualizar()
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.UpdateInsurence"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@id", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@type", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@amount", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@lack", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@dateInsurence", TextBox1.Text))
            com.Parameters.Add(New SqlParameter("@clientNIF", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@name", vbNull))
            com.Parameters.Add(New SqlParameter("@address", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOld", vbNull))
            com.Parameters.Add(New SqlParameter("@sex", vbNull))

            Dim res As Integer

            res = com.ExecuteNonQuery()

            If (res = -1) Then
                MsgBox("Seguro não Existe")
            Else
                MsgBox("Atualizada com sucesso")
            End If

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()
    End Sub

    Private Sub txt_nif_TextChanged(sender As Object, e As EventArgs) Handles txt_nif.TextChanged
        'id
    End Sub

    Private Sub txt_nome_TextChanged(sender As Object, e As EventArgs) Handles txt_nome.TextChanged
        'tipo
    End Sub

    Private Sub txt_morada_TextChanged(sender As Object, e As EventArgs) Handles txt_morada.TextChanged
        'cota
    End Sub

    Private Sub txt_idade_TextChanged(sender As Object, e As EventArgs) Handles txt_idade.TextChanged
        'nifClient
    End Sub

    Private Sub txt_sexo_TextChanged(sender As Object, e As EventArgs) Handles txt_sexo.TextChanged
        'carencia
    End Sub

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles TextBox1.TextChanged
        'dataS
    End Sub

    Private Sub lstList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lstList.SelectedIndexChanged
        Dim _item As KeyValue
        _item = lstList.SelectedItem
        carregar(_item.key)
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

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim nif As String

        nif = InputBox("Introduzir o ID do Seguro", "Eliminar", 0)
        Me.eliminar(nif)
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Me.Close()
    End Sub
End Class