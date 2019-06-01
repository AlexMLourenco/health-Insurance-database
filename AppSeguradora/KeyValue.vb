Public Class KeyValue

    Private _key As Long
    Private _value As String

    Public Sub New(key As Long, value As String)
        _key = key
        _value = value
    End Sub

    Property key() As Long
        Get
            Return _key
        End Get
        Set(ByVal v As Long)
            _key = v
        End Set
    End Property
    Property value() As Long
        Get
            Return _value
        End Get
        Set(ByVal v As Long)
            _value = v
        End Set
    End Property


    Public Overrides Function ToString() As String
        Return _value
    End Function
End Class
