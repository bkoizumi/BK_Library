VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} MakeDMLForm 
   Caption         =   "�I�����Ă�������"
   ClientHeight    =   1365
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   6465
   OleObjectBlob   =   "MakeDMLForm.frx":0000
   StartUpPosition =   3  'Windows �̊���l
End
Attribute VB_Name = "MakeDMLForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub MakeDeleteDML_Click()
  Dim TabelName As String
  Dim SheetName As String
  
  Sheets("Delete��").Copy After:=Worksheets(Worksheets.count)
  ActiveWorkbook.Sheets(Worksheets.count).Tab.ColorIndex = -4142
  
  '  ���͗p�{�b�N�X�̕\��
  TabelName = InputBox("�e�[�u�����̂́H", "�e�[�u�����̓���", "�V�KTBL")
  
  ActiveWorkbook.Sheets(Worksheets.count).Name = "Delete_" & TabelName
  Range("B1").Value = TabelName
  Range("A1").Value = "DELETE"
  Range("A2").Value = ""

  Unload MakeDMLForm

End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer)
    If CloseMode = vbFormControlMenu Then
        Cancel = True
    End If
End Sub

Private Sub MakeInsertDML_Click()

  Dim TabelName As String
  Dim SheetName As String
  
  Sheets("Insert��").Copy After:=Worksheets(Worksheets.count)
  ActiveWorkbook.Sheets(Worksheets.count).Tab.ColorIndex = -4142
  
  '  ���͗p�{�b�N�X�̕\��
  TabelName = InputBox("�e�[�u�����̂́H", "�e�[�u�����̓���", "�V�KTBL")
  
  ActiveWorkbook.Sheets(Worksheets.count).Name = "Insert_" & TabelName
  Range("B1").Value = TabelName
  Range("A1").Value = "INSERT"
  Range("A2").Value = "-- TRUNCATE TABLE " & TabelName & ";"

  Unload MakeDMLForm

End Sub

Private Sub MakeUpdateDML_Click()

  Dim TabelName As String
  Dim SheetName As String
  
  Sheets("Update��").Copy After:=Worksheets(Worksheets.count)
  ActiveWorkbook.Sheets(Worksheets.count).Tab.ColorIndex = -4142
  
  '  ���͗p�{�b�N�X�̕\��
  TabelName = InputBox("�e�[�u�����̂́H", "�e�[�u�����̓���", "�V�KTBL")
  
  ActiveWorkbook.Sheets(Worksheets.count).Name = "Update_" & TabelName
  Range("B1").Value = TabelName
  Range("A1").Value = "UPDATE"

  Unload MakeDMLForm
End Sub

