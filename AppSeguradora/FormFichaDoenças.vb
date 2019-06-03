Imports System.Data.SqlClient

Public Class FormFichaDoenças

    Dim _con As SqlConnection

    Private Sub refrescar()

        lstList.Items.Clear()

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim Command As SqlCommand = New SqlCommand()
        Command.Connection = Me._con
        Command.CommandText = "SeguradoraSaude.GetDiseasesList"
        Command.CommandType = CommandType.StoredProcedure

        Dim reader As SqlDataReader

        reader = Command.ExecuteReader()

        If reader.HasRows Then
            While (reader.HasRows)
                While (reader.Read())
                    lstList.Items.Add(New KeyValue(reader.GetInt32(0), reader.GetString(6) & " | " & reader.GetInt32(0)))
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
            com.CommandText = "SeguradoraSaude.NewDiseasesFile"
            com.CommandType = CommandType.StoredProcedure


            com.Parameters.Add(New SqlParameter("@clientNIF", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@name", vbNull))
            com.Parameters.Add(New SqlParameter("@address", vbNull))
            com.Parameters.Add(New SqlParameter("@yearsOld", vbNull))
            com.Parameters.Add(New SqlParameter("@sex", vbNull))
            com.Parameters.Add(New SqlParameter("@idDiseaseFile", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@type", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@state", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@dateD", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@numFile", TextBox1.Text))
            com.Parameters.Add(New SqlParameter("@rD", vbNull))
            com.Parameters.Add(New SqlParameter("@cI", vbNull))
            com.Parameters.Add(New SqlParameter("@numAppoint", vbNull))
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
            com.Parameters.Add(New SqlParameter("@refPay", vbNull))
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

    Private Sub eliminar(ByVal ID As String)
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.DeleteDisease"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@idD", ID))

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
        com.CommandText = "SeguradoraSaude.GetDiseaseID"
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@diseaseID", ID))

        Dim reader As SqlDataReader

        reader = com.ExecuteReader()

        If reader.HasRows Then

            reader.Read()
            txt_idade.Text = reader.GetInt32(0)     'nifCliente
            txt_morada.Text = reader.GetString(1)   'tipo
            txt_nome.Text = reader.GetBoolean(2)    'estado
            txt_sexo.Text = reader.GetDateTime(3)   'dataD
            TextBox1.Text = reader.GetInt32(4)      'numF
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
            com.CommandText = "SeguradoraSaude.UpdateDiseaseInfo"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@idFile", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@clientNIF", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@type", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@state", txt_nome.Text))
            com.Parameters.Add(New SqlParameter("@dateD", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@fileNum", TextBox1.Text))

            Dim res As Integer

            res = com.ExecuteNonQuery()

            If (res = -1) Then
                MsgBox("Ficha de Doenças não Existe")
            Else
                MsgBox("Atualizada/Adicionada com sucesso")
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
        'estado
    End Sub

    Private Sub txt_morada_TextChanged(sender As Object, e As EventArgs) Handles txt_morada.TextChanged
        'tipo
    End Sub

    Private Sub txt_idade_TextChanged(sender As Object, e As EventArgs) Handles txt_idade.TextChanged
        'nif
    End Sub

    Private Sub txt_sexo_TextChanged(sender As Object, e As EventArgs) Handles txt_sexo.TextChanged
        'dataD
    End Sub

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles TextBox1.TextChanged
        'numFicha
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

        nif = InputBox("Introduzir o ID da Ficha de Doenças", "Eliminar", 0)
        Me.eliminar(nif)
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Me.Close()
    End Sub

End Class