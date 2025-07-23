VERSION 5.00
Begin VB.MDIForm mdiPrincipal 
   BackColor       =   &H8000000C&
   Caption         =   "Transações de Cartões"
   ClientHeight    =   3135
   ClientLeft      =   165
   ClientTop       =   810
   ClientWidth     =   10275
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   Begin VB.Menu mnuTransações 
      Caption         =   "Transações"
      Begin VB.Menu mnuManutencao 
         Caption         =   "Manutenção"
      End
      Begin VB.Menu mnuConsulta 
         Caption         =   "Consulta"
      End
   End
   Begin VB.Menu MnuExport 
      Caption         =   " Exportar Tansações Excel"
      NegotiatePosition=   2  'Middle
   End
End
Attribute VB_Name = "mdiPrincipal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public sServidor As String
Public sBancoDados As String
Public sUsuario As String
Public sSenhaBD As String
Public sStrCon As String
Public cn As ADODB.Connection
Private Sub MDIForm_Load()
    Dim sStrCon As String
    sStrCon = "Provider=SQLOLEDB;Data Source=NOTE_LM\SQLEXPRESS;Initial Catalog=CartoesTC;User ID=sa;Password=sapo"
    Set cn = New ADODB.Connection
    cn.Open sStrCon
End Sub

Private Sub Transações_Click()
End Sub
Private Sub mnuConsulta_Click()
   frmConsultas.Show
End Sub

Private Sub MnuLog_Click()

End Sub

Private Sub MnuExport_Click()
  
    ' --- DECLARAÇÕES ---
    Dim cn As ADODB.Connection
    Dim rs As ADODB.Recordset
    Dim cmd As ADODB.Command
    Dim xlApp As Object
    Dim xlWB As Object
    Dim xlWS As Object

    ' --- CALCULA PERÍODO DO ÚLTIMO MÊS ---
    Dim dataInicial As Date
    Dim dataFinal As Date
    'Dim statusTransacao As String

    dataInicial = DateSerial(Year(Date), Month(Date) - 1, 1)
    dataFinal = DateSerial(Year(Date), Month(Date), 0)
    'statusTransacao = "Aprovada" ' ou qualquer outro status desejado

    ' --- ABRE CONEXÃO COM SQL SERVER ---
    Set cn = New ADODB.Connection
    cn.Open "Provider=SQLOLEDB;Data Source=NOTE_LM\SQLEXPRESS;Initial Catalog=CartoesTC;User ID=sa;Password=sapo"

    ' --- PREPARA COMANDO COM PARÂMETROS ---
    Set cmd = New ADODB.Command
    Set cmd.ActiveConnection = cn
    cmd.CommandText = "sp_Todas_Transacoes"
    cmd.CommandType = adCmdStoredProc

    cmd.Parameters.Append cmd.CreateParameter("@Dt_Inicial", adDate, adParamInput, , dataInicial)
    cmd.Parameters.Append cmd.CreateParameter("@Dt_Final", adDate, adParamInput, , dataFinal)
    'cmd.Parameters.Append cmd.CreateParameter("@St_Transacao", adVarChar, adParamInput, 20, statusTransacao)

    ' --- EXECUTA E ABRE RECORDSET ---
    Set rs = New ADODB.Recordset
    rs.Open cmd, , adOpenForwardOnly, adLockReadOnly

    If rs.EOF Then
        MsgBox "Nenhum dado encontrado para o último mês.", vbExclamation
        rs.Close: cn.Close
        Exit Sub
    End If

    ' --- CRIA OBJETO EXCEL ---
    Set xlApp = CreateObject("Excel.Application")
    Set xlWB = xlApp.Workbooks.Add
    Set xlWS = xlWB.Sheets(1)

    ' --- CABEÇALHOS PERSONALIZADOS ---
    xlWS.Cells(1, 1).Value = "Cartão"
    xlWS.Cells(1, 2).Value = "Valor"
    xlWS.Cells(1, 3).Value = "Data"
    xlWS.Cells(1, 4).Value = "Descrição"
    xlWS.Cells(1, 5).Value = "Status"
    
    xlWS.Range("A1:E1").Font.Bold = True

   'AJUSTA AS COLUNAS
   
   xlWS.Columns("A").ColumnWidth = 16
   xlWS.Columns("B").ColumnWidth = 25
   xlWS.Columns("C").ColumnWidth = 15
   xlWS.Columns("D").ColumnWidth = 50
   xlWS.Columns("E").ColumnWidth = 10

     
   ' --- CENTRALIZA OS TÍTULOS DAS COLUNAS ---
   xlWS.Range("A1:E1").HorizontalAlignment = -4108 ' xlCenter



    ' --- COPIA RECORDSET PARA LINHA 2 ---
    xlWS.Range("A2").CopyFromRecordset rs

    ' --- SALVA ARQUIVO COM DATA NO NOME ---
    Dim caminho As String
    caminho = "C:\Projeto_Transacoes_Cartoes_Clientes\ExcelGerado\Export_" & Format(dataInicial, "yyyy_mm") & ".xlsx"
    xlWB.SaveAs caminho

    ' --- FINALIZA ---
    xlWB.Close
    xlApp.Quit
    rs.Close
    cn.Close

    ' --- LIMPA OBJETOS ---
    Set rs = Nothing
    Set cmd = Nothing
    Set cn = Nothing
    Set xlWS = Nothing
    Set xlWB = Nothing
    Set xlApp = Nothing

    MsgBox "Exportação do último mês concluída com sucesso!", vbInformation

End Sub

Private Sub mnuManutencao_Click()
   frmTransacoes.Show
End Sub
