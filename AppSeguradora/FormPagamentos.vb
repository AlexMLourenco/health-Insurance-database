Imports System.Data.SqlClient

Public Class FormPagamentos

    Dim _con As SqlConnection

    Private Sub refrescar()

        lstList.Items.Clear()

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim Command As SqlCommand = New SqlCommand()
        Command.Connection = Me._con
        Command.CommandText = "SeguradoraSaude.GetPaymentList"
        Command.CommandType = CommandType.StoredProcedure

        Dim reader As SqlDataReader

        reader = Command.ExecuteReader()

        If reader.HasRows Then
            While (reader.HasRows)
                While (reader.Read())
                    lstList.Items.Add(New KeyValue(reader.GetInt32(0), reader.GetInt32(0) & " | " & reader.GetInt32(3) & "€"))
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
            com.CommandText = "SeguradoraSaude.NewPayment"
            com.CommandType = CommandType.StoredProcedure


            com.Parameters.Add(New SqlParameter("@salary", vbNull))
            com.Parameters.Add(New SqlParameter("@refPay", txt_nif.Text))
            com.Parameters.Add(New SqlParameter("@metPay", TextBox1.Text))
            com.Parameters.Add(New SqlParameter("@codPay", txt_morada.Text))
            com.Parameters.Add(New SqlParameter("@amountPay", txt_idade.Text))
            com.Parameters.Add(New SqlParameter("@datePay", txt_sexo.Text))
            com.Parameters.Add(New SqlParameter("@secretaryNIF", txt_nome.Text))
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

    Private Sub eliminar(ByVal RefPagamento As String)
        Me._con = Data.getConnection()
        Me._con.Open()

        Try


            Dim com As SqlCommand = New SqlCommand()
            com.Connection = Me._con
            com.CommandText = "SeguradoraSaude.DeletePayment"
            com.CommandType = CommandType.StoredProcedure

            com.Parameters.Add(New SqlParameter("@PayRef", RefPagamento))

            com.ExecuteNonQuery()

            MsgBox("Apagado com sucesso!")

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Me._con.Close()

    End Sub

    Private Sub carregar(ByVal RefPagamento As Long)

        Me._con = Data.getConnection()
        Me._con.Open()

        Dim com As SqlCommand = New SqlCommand()
        com.Connection = Me._con
        com.CommandText = "SeguradoraSaude.GetPayRef"
        com.CommandType = CommandType.StoredProcedure
        com.Parameters.Add(New SqlParameter("@payRef", RefPagamento))

        Dim reader As SqlDataReader

        reader = com.ExecuteReader()

        If reader.HasRows Then

            reader.Read()
            TextBox1.Text = reader.GetString(0)     'metodo
            txt_morada.Text = reader.GetInt32(1)    'codigo
            txt_idade.Text = reader.GetInt32(2)     'valor
            txt_sexo.Text = reader.GetDateTime(3)   'data
            txt_nome.Text = reader.GetInt32(4)      'nif
            txt_nif.Text = reader.GetInt32(5)       'refPay

        End If

        Me._con.Close()

    End Sub


    Private Sub txt_nif_TextChanged(sender As Object, e As EventArgs) Handles txt_nif.TextChanged
        'refPay
    End Sub

    Private Sub txt_nome_TextChanged(sender As Object, e As EventArgs) Handles txt_nome.TextChanged
        'nifS
    End Sub

    Private Sub txt_morada_TextChanged(sender As Object, e As EventArgs) Handles txt_morada.TextChanged
        'Code
    End Sub

    Private Sub txt_idade_TextChanged(sender As Object, e As EventArgs) Handles txt_idade.TextChanged
        'value
    End Sub

    Private Sub txt_sexo_TextChanged(sender As Object, e As EventArgs) Handles txt_sexo.TextChanged
        'datePay
    End Sub

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles TextBox1.TextChanged
        'method
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

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim nif As String

        nif = InputBox("Introduzir a referencia do pagamento", "Eliminar", 0)
        Me.eliminar(nif)
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Me.Close()
    End Sub
End Class