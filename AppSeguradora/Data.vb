Imports System.Data.SqlClient
Module Data


    Function getConnection() As SqlConnection
        Dim s As String
        s = "data source= DESKTOP-36N1274;integrated security=true;initial catalog=SeguradoraSaude"

        Dim Connection As SqlConnection = New SqlConnection(s)
        Return Connection
    End Function

End Module
