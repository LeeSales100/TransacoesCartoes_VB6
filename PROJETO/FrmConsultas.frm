VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form frmConsultas 
   Caption         =   "Consulta de Transações"
   ClientHeight    =   7110
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   12000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7110
   ScaleWidth      =   12000
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdConsultar 
      Caption         =   "Consultar"
      Height          =   495
      Left            =   9720
      TabIndex        =   8
      Top             =   480
      Width           =   1815
   End
   Begin VB.ComboBox cboStatus 
      Height          =   315
      Left            =   5400
      TabIndex        =   5
      Text            =   "Combo1"
      Top             =   840
      Width           =   3735
   End
   Begin VB.TextBox txtValor 
      Height          =   495
      Left            =   2520
      TabIndex        =   4
      Text            =   "Text1"
      Top             =   840
      Width           =   2895
   End
   Begin MSMask.MaskEdBox mskData 
      Height          =   375
      Left            =   4320
      TabIndex        =   3
      Top             =   360
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   661
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtNumeroCartao 
      Height          =   375
      Left            =   2520
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   360
      Width           =   1695
   End
   Begin VB.ComboBox cboFiltros 
      Height          =   315
      Left            =   360
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   480
      Width           =   1815
   End
   Begin MSDataGridLib.DataGrid grdTransacoes 
      Height          =   975
      Left            =   0
      TabIndex        =   0
      Top             =   2040
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   1720
      _Version        =   393216
      HeadLines       =   1
      RowHeight       =   15
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   2
      BeginProperty Column00 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1046
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1046
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
         EndProperty
         BeginProperty Column01 
         EndProperty
      EndProperty
   End
   Begin VB.Label Label1 
      Caption         =   "Entre com o filtro desejado:"
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   0
      Width           =   2175
   End
   Begin VB.Label lblCampoFiltro 
      Caption         =   "Label1"
      Height          =   375
      Left            =   2760
      TabIndex        =   6
      Top             =   0
      Width           =   5415
   End
End
Attribute VB_Name = "frmConsultas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Combo1_Change()

End Sub

Private Sub cmdConsultar_Click()
    Dim rs As ADODB.Recordset
    Dim sql As String
    Dim criterio As String
    Call AbrirConexao
    Select Case cboFiltros.Text
        Case "Número do Cartão"
            criterio = Trim(txtNumeroCartao.Text)
            If criterio = "" Then
                MsgBox "Digite o número do cartão.", vbExclamation
                Exit Sub
            End If
            sql = "SELECT * FROM Transacoes WHERE nr_cartao = '" & criterio & "'"
         

        Case "Data da Transação"
            criterio = Trim(mskData.Text)
            If criterio = "" Or criterio Like "__/__/____" Then
                MsgBox "Informe a data corretamente.", vbExclamation
                Exit Sub
            End If
            sql = "SELECT * FROM Transacoes " & _
                  "WHERE CONVERT(VARCHAR, Dt_Transacao, 103) = '" & criterio & "'"

        Case "Valor da Transação"
            criterio = Trim(txtValor.Text)
            If Not IsNumeric(criterio) Then
                MsgBox "Digite um valor numérico válido.", vbExclamation
                Exit Sub
            End If
            criterio = Replace(criterio, ",", ".")
            sql = "SELECT * FROM Transacoes WHERE Vl_Transacao = " & criterio

        Case "Status da Transação"
            criterio = Trim(cboStatus.Text)
            If criterio = "" Then
                MsgBox "Selecione um status de transação.", vbExclamation
                Exit Sub
            End If
            sql = "SELECT * FROM Transacoes WHERE St_Transacao = '" & criterio & "'"

        Case Else
            MsgBox "Filtro desconhecido.", vbCritical
            Exit Sub
    End Select

    Set rs = New ADODB.Recordset
    rs.CursorLocation = adUseClient
    rs.Open sql, cn, adOpenStatic, adLockReadOnly

    If rs.EOF Then
        MsgBox "Nenhum registro encontrado.", vbInformation
        Exit Sub
    End If
    

    Set grdTransacoes.DataSource = rs
    grdTransacoes.Visible = True
    grdTransacoes.Refresh
    'Call FecharConexao
End Sub
Private Sub Form_Load()
    txtNumeroCartao.MaxLength = 16
    cboFiltros.Clear
    cboFiltros.AddItem "Número do Cartão"
    cboFiltros.AddItem "Data da Transação"
    cboFiltros.AddItem "Valor da Transação"
    cboFiltros.AddItem "Status da Transação"
    cboFiltros.ListIndex = 0 ' Seleciona o primeiro item por padrão

    cboStatus.Clear
    cboStatus.AddItem "APROVADA"
    cboStatus.AddItem "PENDENTE"
    cboStatus.AddItem "CANCELADA"
    cboStatus.ListIndex = 0 ' Seleciona "Aprovada" por padrão


End Sub

Private Sub cboFiltros_Click()
    Call AtualizarCamposDoFiltro
End Sub

Private Sub AtualizarCamposDoFiltro()
    ' Oculta todos os cabompos primeiro
    txtNumeroCartao.Visible = False
    mskData.Visible = False
    txtValor.Visible = False
    cboStatus.Visible = False

    Select Case cboFiltros.Text
        Case "Número do Cartão"
            lblCampoFiltro.Caption = "Digite o número do cartão:"
            txtNumeroCartao.Visible = True
            txtNumeroCartao.Text = ""

        Case "Data da Transação"
            lblCampoFiltro.Caption = "Informe a data (dd/mm/yyyy):"
            mskData.Visible = True
            mskData.Text = "__/__/____"

        Case "Valor da Transação"
            lblCampoFiltro.Caption = "Digite o valor da transação:"
            txtValor.Visible = True
            txtValor.Text = ""

        Case "Status da Transação"
            lblCampoFiltro.Caption = "Selecione o status:"
            cboStatus.Visible = True
            cboStatus.ListIndex = 0
    End Select
End Sub

