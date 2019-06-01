Imports System.Data.SqlClient

Public Class FormMedicos

    Dim _con As SqlConnection

    Private Sub refrescar()

        lstList.Items.Clear()

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim Command As SqlCommand = New SqlCommand()
        Command.Connection = Me._con
        Command.CommandText = "SeguradoraSaude.GetDoctorList"
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
            com.CommandText = "SeguradoraSaude.NewDoctor"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@doctorNIF", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@name", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@address", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@yearsOld", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@sex", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@salary", TextBox1.Text))
            com.Parameters.Add(New SqlParameter("@specialization", TextBox2.Text))
            com.Parameters.Add(New SqlParameter("@clinicNumber", TextBox3.Text))
            com.Parameters.Add(New SqlParameter("@clinicName", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@clinicLocalization", txt_sexo.Text))

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
        com.CommandText = "SeguradoraSaude.GetDoctorNIF"
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@doctorNIF", nif))

        Dim reader As SqlDataReader

        reader = com.ExecuteReader()

        If reader.HasRows Then

            reader.Read()
            txt_nome.Text = reader.GetString(0)
            txt_nif.Text = reader.GetInt32(1)
            txt_morada.Text = reader.GetString(2)
            txt_idade.Text = reader.GetInt32(3)
            txt_sexo.Text = reader.GetString(4)
            TextBox1.Text = reader.GetInt32(5)
            TextBox2.Text = reader.GetString(6)
            TextBox3.Text = reader.GetInt32(7)

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
            com.Parameters.Add(New SqlParameter("@salary", TextBox1.Text))
            com.Parameters.Add(New SqlParameter("@specialization", TextBox2.Text))
            com.Parameters.Add(New SqlParameter("@clinicNumber", TextBox3.Text))

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



    Private Sub txt_nif_TextChanged(sender As Object, e As EventArgs) Handles txt_nif.TextChanged

    End Sub

    Private Sub txt_nome_TextChanged(sender As Object, e As EventArgs) Handles txt_nome.TextChanged

    End Sub

    Private Sub txt_morada_TextChanged(sender As Object, e As EventArgs) Handles txt_morada.TextChanged

    End Sub

    Private Sub txt_idade_TextChanged(sender As Object, e As EventArgs) Handles txt_idade.TextChanged

    End Sub

    Private Sub txt_sexo_TextChanged(sender As Object, e As EventArgs) Handles txt_sexo.TextChanged

    End Sub

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles TextBox1.TextChanged
        'ordenado

    End Sub

    Private Sub TextBox2_TextChanged(sender As Object, e As EventArgs) Handles TextBox2.TextChanged
        'especializacao
    End Sub

    Private Sub TextBox3_TextChanged(sender As Object, e As EventArgs) Handles TextBox3.TextChanged
        'numClinica
    End Sub

    Private Sub TextBox4_TextChanged(sender As Object, e As EventArgs) Handles TextBox4.TextChanged
        'nomeClinica
    End Sub

    Private Sub TextBox5_TextChanged(sender As Object, e As EventArgs) Handles TextBox5.TextChanged
        'localizaçãoClinica
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

        nif = InputBox("Introduzir o NIF", "Eliminar", 0)
        Me.eliminar(nif)
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Me.Close()
    End Sub
End Class