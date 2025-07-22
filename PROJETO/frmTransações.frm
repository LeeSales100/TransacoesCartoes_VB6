VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form frmTransacoes 
   Caption         =   "Manuten��o de Transa��es"
   ClientHeight    =   6705
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   17430
   LinkTopic       =   "Form1"
   ScaleHeight     =   6705
   ScaleWidth      =   17430
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox cboStatus 
      Height          =   315
      Left            =   2760
      TabIndex        =   12
      Top             =   3480
      Width           =   2415
   End
   Begin MSMask.MaskEdBox mskData 
      Height          =   495
      Left            =   2760
      TabIndex        =   11
      Top             =   1800
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   873
      _Version        =   393216
      MaxLength       =   16
      Mask            =   "##/##/#### ##:##"
      PromptChar      =   "_"
   End
   Begin VB.CommandButton cmdExcluir 
      Caption         =   "Exclusao"
      Height          =   1095
      Left            =   8400
      TabIndex        =   10
      Top             =   4920
      Width           =   1935
   End
   Begin VB.CommandButton cmdAlterar 
      Caption         =   "Altera��o"
      Height          =   1095
      Left            =   6120
      TabIndex        =   9
      Top             =   4920
      Width           =   1935
   End
   Begin VB.CommandButton cmdIncluir 
      Caption         =   "Inclus�o"
      Height          =   1095
      Left            =   3600
      TabIndex        =   8
      Top             =   4920
      Width           =   1935
   End
   Begin VB.TextBox txtDescricao 
      Height          =   495
      Left            =   2760
      TabIndex        =   2
      Top             =   2520
      Width           =   13215
   End
   Begin VB.TextBox txtValor 
      Height          =   495
      Left            =   2760
      TabIndex        =   1
      Top             =   1200
      Width           =   1815
   End
   Begin VB.TextBox txtNumeroCartao 
      Height          =   495
      Left            =   2760
      TabIndex        =   0
      Top             =   480
      Width           =   1815
   End
   Begin VB.Label lblId_Trans 
      Caption         =   "ID_TRANSA��O"
      Height          =   495
      Left            =   8040
      TabIndex        =   13
      Top             =   480
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label Label5 
      Caption         =   "Status da Transa��o"
      Height          =   375
      Left            =   600
      TabIndex        =   7
      Top             =   3480
      Width           =   1815
   End
   Begin VB.Label Label4 
      Caption         =   "Descri��o"
      Height          =   255
      Left            =   720
      TabIndex        =   6
      Top             =   2760
      Width           =   1815
   End
   Begin VB.Label Label3 
      Caption         =   "Data da Transa��o"
      Height          =   255
      Left            =   720
      TabIndex        =   5
      Top             =   2040
      Width           =   1815
   End
   Begin VB.Label Label2 
      Caption         =   "Valor"
      Height          =   255
      Left            =   720
      TabIndex        =   4
      Top             =   1320
      Width           =   1815
   End
   Begin VB.Label Label1 
      Caption         =   "N�mero do Cart�o:"
      Height          =   255
      Left            =   720
      TabIndex        =   3
      Top             =   600
      Width           =   1815
   End
End
Attribute VB_Name = "frmTransacoes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Text1_Change()

End Sub

Private Sub Text3_Change()

End Sub

Private Sub Command1_Click()

End Sub

Private Sub cmdInclusao_Click()
Dim sql As String
Dim sDataSQL As String
MsgBox "Valor digitado: " & mskData.Text

If Not IsDate(mskData.Text) Then
   MsgBox "ERRO: N�o � uma data!"
   Exit Sub
End If

sDataSQL = Format$(CDate(mskData.Text), "yyyy-mm-dd hh:nn:ss")

Call AbrirConexao

sql = "INSERT INTO Transacoes " & _
      "(nr_cartao, Vl_Transacao, Dt_Transacao, Descricao, St_Transacao) " & _
      "VALUES (" & _
      "'" & txtNumeroCartao.Text & "', " & _
      Replace(txtValor.Text, ",", ".") & ", " & _
      "CONVERT(datetime, '" & sDataSQL & "', 120), " & _
      "'" & txtDescricao.Text & "', " & _
      "'" & cboStatus.Text & "'" & _
      ")"
                cn.Execute (sql)
                MsgBox UCase("Dados Cadastrados com Sucesso")
                
      Call FecharConexao
                
                
End Sub
Private Sub cmdAlterar_Click()
    Dim sql As String
    Dim sDataSQL As String
    
    Call AbrirConexao

    ' Sanitiza m�scara
    mskData.Text = Replace(mskData.Text, "_", "")
    
    MsgBox "Data convertida: " & Format$(CDate(mskData.Text), "yyyy-mm-dd hh:nn:ss")
    ' Valida��o adicional
    If Trim(mskData.Text) = "" Then
        MsgBox "Data n�o pode estar vazia.", vbExclamation
        Exit Sub
    End If
    
    If Not IsDate(mskData.Text) Then
        MsgBox "Data inv�lida! Use o formato dd/mm/yyyy hh:nn:ss", vbExclamation
        Exit Sub
    End If

    ' Tentativa de convers�o segura
    On Error GoTo TrataErroData
    
    sDataSQL = Format$(CDate(mskData.Text), "yyyy-mm-dd") & "T" & Format$(CDate(sDataLimpa), "HH:mm:ss")
    
    On Error GoTo 0 ' limpa o tratamento de erro

    ' Verifica visualmente o valor antes de enviar ao SQL
    Debug.Print "Data convertida para SQL: " & sDataSQL

    ' Monta o UPDATE
    sql = "UPDATE Transacoes SET " & _
          "nr_cartao = '" & txtNumeroCartao.Text & "', " & _
          "Vl_Transacao = " & Replace(txtValor.Text, ",", ".") & ", " & _
          "Dt_Transacao = '" & sDataSQL & "', " & _
          "Descricao = '" & txtDescricao.Text & "', " & _
          "St_Transacao = '" & cboStatus.Text & "' " & _
          "WHERE Id_Trans = " & lblId_Trans.Caption

    cn.Execute sql

    MsgBox "Transa��o alterada com sucesso!", vbInformation
    Call LimpaCampos
    Call FecharConexao
    
    ' Volta para modo inclus�o
    cmdIncluir.Enabled = True
    cmdAlterar.Enabled = False
    cmdExcluir.Enabled = False
    lblId_Trans.Caption = ""

    Exit Sub

TrataErroData:
    MsgBox "Falha ao converter a data. Verifique o valor digitado e o formato!", vbCritical
    Exit Sub
End Sub

Private Sub cmdExcluir_Click()
   Dim resposta As Integer
   Dim sql As String
   
   Call AbrirConexao
   
   ' Confirma exclus�o com o usu�rio
   resposta = MsgBox("Tem certeza que deseja excluir esta transa��o?", vbYesNo + vbQuestion, "Confirma��o")
   
   If resposta = vbNo Then Exit Sub
   
   ' Verifica se temos o ID v�lido
   If Trim(lblId_Trans.Caption) = "" Then
       MsgBox "Nenhuma transa��o selecionada!", vbExclamation
       Exit Sub
   End If
   
   ' Executa o DELETE com base na chave prim�ria
   sql = "DELETE FROM Transacoes WHERE Id_Trans = " & lblId_Trans.Caption
   cn.Execute sql
   
   MsgBox "Transa��o exclu�da com sucesso!", vbInformation
   
   ' Limpa o formul�rio e volta ao modo inclus�o
   txtNumeroCartao.Text = ""
   txtValor.Text = ""
   txtDescricao.Text = ""
   cboStatus.ListIndex = 0
   mskData.Text = "__/__/____ __:__"
   lblId_Trans.Caption = ""
   
   cmdIncluir.Enabled = True
   cmdAlterar.Enabled = False
   cmdExcluir.Enabled = False
   
   Call FecharConexao
   Call LimpaCampos
End Sub

Private Sub cmdIncluir_Click()
    Dim sql As String
    Dim sDataSQL As String
    
    Call AbrirConexao
    ' Verifica se campos obrigat�rios est�o preenchidos
    If Trim(txtNumeroCartao.Text) = "" Then
        MsgBox "Informe o n�mero do cart�o.", vbExclamation
        Exit Sub
    End If
    
    If Trim(txtValor.Text) = "" Then
        MsgBox "Informe o valor da transa��o.", vbExclamation
        Exit Sub
    End If

    If Not IsDate(mskData.Text) Then
        MsgBox "Data inv�lida. Verifique o campo Data.", vbExclamation
        Exit Sub
    End If

    If cboStatus.ListIndex = -1 Then
        MsgBox "Selecione o status da transa��o.", vbExclamation
        Exit Sub
    End If

    ' Converte a data para formato SQL Server
    sDataSQL = Format$(CDate(mskData.Text), "yyyy-mm-dd hh:nn:ss")
    sDataSQL = Format$(CDate(mskData.Text), "yyyy-mm-dd") & "T" & Format$(CDate(sDataLimpa), "HH:mm:ss")
  
   '  sDataSQL = Format$(CDate(mskData.Text), "yyyy-MM-dd HH:mm")


    
    ' Monta SQL de inser��o
    sql = "INSERT INTO Transacoes " & _
          "(nr_cartao, Vl_Transacao, Dt_Transacao, Descricao, St_Transacao) " & _
          "VALUES (" & _
          "'" & txtNumeroCartao.Text & "', " & _
          Replace(txtValor.Text, ",", ".") & ", " & _
          "'" & sDataSQL & "', " & _
          "'" & txtDescricao.Text & "', " & _
          "'" & cboStatus.Text & "'" & _
          ")"

    ' Executa o comando
    cn.Execute sql

    MsgBox "Transa��o cadastrada com sucesso!", vbInformation

Dim sConcat As String

sConcat = "Inclus�o de Transa��o as " & Now & " - " & _
          txtNumeroCartao.Text & " - " & _
          txtValor.Text & " - " & _
          txtDescricao.Text & " - " & _
          mskData.Text & " - " & _
          txtDescricao.Text & " - " & _
          cboStatus.Text

          GravaLog (sConcat)


    
    Call LimpaCampos
    ' Limpa campos
    'txtNumeroCartao.Text = ""
    'txtValor.Text = ""
    'mskData.Text = Format$(Now, "dd/mm/yyyy hh:nn:ss")
    'txtDescricao.Text = ""
    'cboStatus.ListIndex = -1

    ' Volta para modo inclus�o
    cmdIncluir.Enabled = True
    cmdAlterar.Enabled = False
    cmdExcluir.Enabled = False
    Call FecharConexao
    
    
End Sub

Public Sub GravaLog(ByVal sTexto As String)
   Dim sql As String
   sql = "INSERT INTO Log (Mensagem) Values (" & "'" & sTexto & "')"
   cn.Execute RTrim(sql)
End Sub
Private Sub Form_Load()
   mskData.Text = Format$(Now, "dd/mm/yyyy HH:mm")
   txtNumeroCartao.MaxLength = 16
   txtValor = 15
   txtDescricao.MaxLength = 255
                  
     With cboStatus
         .Clear
         .AddItem "APROVADA"
         .AddItem "PENDENTE"
         .AddItem "CANCELADA"
         .ListIndex = 0 ' Deixa "Aprovada" selecionada por padr�o
     End With
     
     ' Modo padr�o: Inclus�o
     cmdIncluir.Enabled = True
     cmdAlterar.Enabled = False
     cmdExcluir.Enabled = False
End Sub
Private Sub Label1_Click()
N
End Sub

Private Sub txtNumeroCartao_LostFocus()
    Dim rs As New ADODB.Recordset
    Dim sql As String
    
    Call AbrirConexao


    If Trim(txtNumeroCartao.Text) = "" Then Exit Sub ' evita busca vazia

    sql = "SELECT * FROM Transacoes WHERE nr_cartao = '" & txtNumeroCartao.Text & "'"
    rs.Open sql, cn, adOpenStatic, adLockReadOnly

    If Not rs.EOF Then
        ' Transa��o EXISTE ? Modo Altera��o/Exclus�o

        ' Preenche os campos do formul�rio
        txtValor.Text = rs!Vl_Transacao
        mskData.Text = Format$(rs!Dt_Transacao, "dd/mm/yyyy hh:nn")
        txtDescricao.Text = rs!Descricao
        cboStatus.Text = rs!St_Transacao

        ' Guarda o ID para uso posterior
        lblId_Trans.Caption = rs!Id_Trans  ' ou use uma vari�vel como idTransAtual

        ' Habilita os bot�es corretos
        cmdIncluir.Enabled = False
        cmdAlterar.Enabled = True
        cmdExcluir.Enabled = True

        ' Se status for 'Aprovada', bloqueia altera��o/exclus�o
        If cboStatus.Text = "Aprovada" Then
            cmdAlterar.Enabled = False
            cmdExcluir.Enabled = False
            MsgBox "Transa��o aprovada n�o pode ser alterada ou exclu�da!", vbInformation
        End If
    Else
        ' Transa��o N�O EXISTE ? Modo Inclus�o

        ' Limpa os campos para nova inser��o
        txtValor.Text = ""
        txtDescricao.Text = ""
        cboStatus.ListIndex = 0
        mskData.Text = Format$(Now, "dd/mm/yyyy hh:nn")

        ' Bot�es configurados para modo inclus�o
        cmdIncluir.Enabled = True
        cmdAlterar.Enabled = False
        cmdExcluir.Enabled = False

        lblId_Trans.Caption = "" ' zera o ID guardado
    End If

    rs.Close
    Set rs = Nothing
    Call FecharConexao

End Sub

Private Sub LimpaCampos()
   txtNumeroCartao = ""
   txtValor = ""
   txtDescricao = ""
   mskData.Text = Format$(Now, "dd/mm/yyyy HH:mm")
   cboStatus.ListIndex = 0
        
End Sub

Private Sub txtValor_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        Case 8    ' Backspace (permite apagar)
        Case 48 To 57    ' N�meros de 0 a 9
        Case 44 ', 46      ' V�rgula (,) ou Ponto (.) � depende do regional settings
        Case Else
            KeyAscii = 0 ' Bloqueia qualquer outro caractere
    End Select
End Sub


