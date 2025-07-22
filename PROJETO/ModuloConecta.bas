Attribute VB_Name = "ModuloConecta"
Public cn As ADODB.Connection

Public Sub AbrirConexao()
    Dim sStrCon As String
    sStrCon = "Provider=SQLOLEDB;Data Source=NOTE_LM\SQLEXPRESS;Initial Catalog=CartoesTC;User ID=sa;Password=sapo"
    Set cn = New ADODB.Connection
    cn.Open sStrCon
End Sub

Public Sub FecharConexao()
    If Not cn Is Nothing Then
        If cn.State = adStateOpen Then cn.Close
        Set cn = Nothing
    End If
End Sub

