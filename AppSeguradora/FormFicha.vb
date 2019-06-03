Imports System.Data.SqlClient

Public Class FormFicha

    Dim _con As SqlConnection

    Private Sub refrescar()

        lstList.Items.Clear()

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim Command As SqlCommand = New SqlCommand()
        Command.Connection = Me._con
        Command.CommandText = "SeguradoraSaude.GetFileList"
        Command.CommandType = CommandType.StoredProcedure

        Dim reader As SqlDataReader

        reader = Command.ExecuteReader()

        If reader.HasRows Then
            While (reader.HasRows)
                While (reader.Read())
                    lstList.Items.Add(New KeyValue(reader.GetInt32(0), reader.GetInt32(0) & " | " & reader.GetString(1) & " | " & reader.GetString(2)))
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
            com.CommandText = "SeguradoraSaude.NewFile"
            com.CommandType = CommandType.StoredProcedure


            com.Parameters.Add(New SqlParameter("@Rd", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@Ci", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@appointmentNumber", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@clientNIF", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@refPay", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@name", vbNull))
            com.Parameters.Add(New SqlParameter("@address", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOld", vbNull))
            com.Parameters.Add(New SqlParameter("@sex", vbNull))
            com.Parameters.Add(New SqlParameter("@dateAppoint", vbNull))
            com.Parameters.Add(New SqlParameter("@hourAppoint", vbNull))
            com.Parameters.Add(New SqlParameter("@doctorNIF", vbNull))
            com.Parameters.Add(New SqlParameter("@nameDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@addressDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOldDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@sexDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@doctorNum", vbNull))
            com.Parameters.Add(New SqlParameter("@salary", vbNull))
            com.Parameters.Add(New SqlParameter("@specialization", vbNull))
            com.Parameters.Add(New SqlParameter("@clinicNum", vbNull))
            com.Parameters.Add(New SqlParameter("@clinicName", vbNull))
            com.Parameters.Add(New SqlParameter("@clinicLocalization", vbNull))
            com.Parameters.Add(New SqlParameter("@metPay", vbNull))
            com.Parameters.Add(New SqlParameter("@codPay", vbNull))
            com.Parameters.Add(New SqlParameter("@amountPay", vbNull))
            com.Parameters.Add(New SqlParameter("@datePay", vbNull))
            com.Parameters.Add(New SqlParameter("@secretaryNIF", vbNull))
            com.Parameters.Add(New SqlParameter("@nameSecretary", vbNull))
            com.Parameters.Add(New SqlParameter("@addressSecretary", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOldSecretary", vbNull))
            com.Parameters.Add(New SqlParameter("@sexSecretary", vbNull))
            com.ExecuteNonQuery()

            MsgBox("Inserido com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub eliminar(ByVal NumFicha As String)
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.DeleteFile"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@numFile", NumFicha))

            com.ExecuteNonQuery()

            MsgBox("Apagado com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub carregar(ByVal NumFicha As Long)

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim com As SqlCommand = New SqlCommand()
        com.Connection = Me._con
        com.CommandText = "SeguradoraSaude.GetFileNum"
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@fileNum", NumFicha))

        Dim reader As SqlDataReader

        reader = com.ExecuteReader()

        If reader.HasRows Then

            reader.Read()
            txt_nif.Text = reader.GetString(0)      'rd
            txt_nome.Text = reader.GetString(1)     'ci
            txt_morada.Text = reader.GetInt32(2)    'NumConsulta
            txt_idade.Text = reader.GetInt32(3)     'nifCliente
            txt_sexo.Text = reader.GetInt32(4)      'refPay


        End If

        Me._con.Close()
    End Sub

    Private Sub atualizar()
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.UpdateFile"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@nameClinic", vbNull))
            com.Parameters.Add(New SqlParameter("@numClinic", vbNull))
            com.Parameters.Add(New SqlParameter("@localization", vbNull))
            com.Parameters.Add(New SqlParameter("@doctorNIF", vbNull))
            com.Parameters.Add(New SqlParameter("@nameDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@addressDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOldDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@sexDoctor", vbNull))
            com.Parameters.Add(New SqlParameter("@clientNIF", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@clientNumber", vbNull))
            com.Parameters.Add(New SqlParameter("@nameClient", vbNull))
            com.Parameters.Add(New SqlParameter("@addressClient", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOldClient", vbNull))
            com.Parameters.Add(New SqlParameter("@sexClient", vbNull))
            com.Parameters.Add(New SqlParameter("@salary", vbNull))
            com.Parameters.Add(New SqlParameter("@specialization", vbNull))
            com.Parameters.Add(New SqlParameter("@numAppointment", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@dateAppoint", vbNull))
            com.Parameters.Add(New SqlParameter("@hourAppoint", vbNull))
            com.Parameters.Add(New SqlParameter("@rD", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@cI", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@refPay", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@metPay", vbNull))
            com.Parameters.Add(New SqlParameter("@codPay", vbNull))
            com.Parameters.Add(New SqlParameter("@amountPay", vbNull))
            com.Parameters.Add(New SqlParameter("@datePay", vbNull))
            com.Parameters.Add(New SqlParameter("@numFile", vbNull))
            com.Parameters.Add(New SqlParameter("@secretaryNIF", vbNull))
            com.Parameters.Add(New SqlParameter("@secretaryNum", vbNull))
            com.Parameters.Add(New SqlParameter("@nameSecretary", vbNull))
            com.Parameters.Add(New SqlParameter("@addressSecretary", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOldSecretary", vbNull))
            com.Parameters.Add(New SqlParameter("@sexSecretary", vbNull))

            Dim res As Integer

            res = com.ExecuteNonQuery()

            If (res = -1) Then
                MsgBox("Ficha não Existe")
            Else
                MsgBox("Atualizada/Adicionada com sucesso")
            End If

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()
    End Sub


    Private Sub txt_nif_TextChanged(sender As Object, e As EventArgs) Handles txt_nif.TextChanged
        'relatorio/diagnostico
    End Sub

    Private Sub txt_nome_TextChanged(sender As Object, e As EventArgs) Handles txt_nome.TextChanged
        'consulta/internamento
    End Sub

    Private Sub txt_morada_TextChanged(sender As Object, e As EventArgs) Handles txt_morada.TextChanged
        'numeroConsulta
    End Sub

    Private Sub txt_idade_TextChanged(sender As Object, e As EventArgs) Handles txt_idade.TextChanged
        'nifCliente
    End Sub

    Private Sub txt_sexo_TextChanged(sender As Object, e As EventArgs) Handles txt_sexo.TextChanged
        'refPagamento
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

        nif = InputBox("Introduzir o Numero da Ficha", "Eliminar", 0)
        Me.eliminar(nif)
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Me.Close()
    End Sub
End Class