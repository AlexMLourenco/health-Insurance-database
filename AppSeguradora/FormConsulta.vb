Imports System.Data.SqlClient

Public Class FormConsulta

    Dim _con As SqlConnection

    Private Sub refrescar()

        lstList.Items.Clear()

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim Command As SqlCommand = New SqlCommand()
        Command.Connection = Me._con
        Command.CommandText = "SeguradoraSaude.GetAppointmentList"
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
            com.CommandText = "SeguradoraSaude.NewAppointment"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@doctorNIF", TextBox6.Text))
            com.Parameters.Add(New SqlParameter("@clientNIF", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@salary", vbNull))
            com.Parameters.Add(New SqlParameter("@specialization", vbNull))
            com.Parameters.Add(New SqlParameter("@clinicNumber", vbNull))
            com.Parameters.Add(New SqlParameter("@clinicName", TextBox1.Text))
            com.Parameters.Add(New SqlParameter("@clinicLocalization", vbNull))
            com.Parameters.Add(New SqlParameter("@nameClient", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@nameDoctor", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@addressClient", vbNull))
            com.Parameters.Add(New SqlParameter("@addressDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOldClient", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOldDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@sexClient", vbNull))
            com.Parameters.Add(New SqlParameter("@sexDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@dateAppoint", txt_idade))
            com.Parameters.Add(New SqlParameter("@hourAppoint", txt_sexo))

            com.ExecuteNonQuery()

            MsgBox("Inserido com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub eliminar(ByVal NumConsulta As String)
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.DeleteAppointment"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@numAppoint", NumConsulta))

            com.ExecuteNonQuery()

            MsgBox("Apagado com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub carregar(ByVal NumConsulta As Long)

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim com As SqlCommand = New SqlCommand()
        com.Connection = Me._con
        com.CommandText = "SeguradoraSaude.GetAppointNum"
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@appointNum", NumConsulta))

        Dim reader As SqlDataReader

        reader = com.ExecuteReader()

        If reader.HasRows Then
            'continuar aqui
            reader.Read()
            txt_nif.Text = reader.GetInt32(0)
            txt_nome.Text = reader.GetString(1)
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
        'clientNIF
    End Sub

    Private Sub TextBox6_TextChanged(sender As Object, e As EventArgs) Handles TextBox6.TextChanged
        'doctorNIF
    End Sub

    Private Sub txt_nome_TextChanged(sender As Object, e As EventArgs) Handles txt_nome.TextChanged
        'nameclient
    End Sub

    Private Sub txt_morada_TextChanged(sender As Object, e As EventArgs) Handles txt_morada.TextChanged
        'doctorName
    End Sub

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles TextBox1.TextChanged
        'clinicName
    End Sub

    Private Sub txt_idade_TextChanged(sender As Object, e As EventArgs) Handles txt_idade.TextChanged
        'date
    End Sub

    Private Sub txt_sexo_TextChanged(sender As Object, e As EventArgs) Handles txt_sexo.TextChanged
        'hour
    End Sub
End Class