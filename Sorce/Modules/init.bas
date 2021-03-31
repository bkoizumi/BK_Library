Attribute VB_Name = "init"
'���[�N�u�b�N�p�ϐ�------------------------------
Public ThisBook   As Workbook
Public targetBook As Workbook


'���[�N�V�[�g�p�ϐ�------------------------------
Public sheetsetting   As Worksheet
Public sheetNotice    As Worksheet
Public sheetStyle     As Worksheet
Public sheetTestData  As Worksheet
Public sheetRibbon    As Worksheet
Public sheetFavorite  As Worksheet


'�O���[�o���ϐ�----------------------------------
Public Const thisAppName = "BK_Library"
Public Const thisAppVersion = "0.0.4.0"

'���W�X�g���o�^�p�T�u�L�[
Public Const RegistryKey  As String = "BK_Library"
Public RegistrySubKey     As String
'Public RegistryRibbonName As String

'�ݒ�l�ێ�
Public setVal         As Object


'�t�@�C���֘A
Public logFile As String

'�������Ԍv���p
Public StartTime          As Date
Public StopTime           As Date



'���{���֘A--------------------------------------
Public ribbonUI       As Office.IRibbonUI
Public ribbonVal      As Object


'**************************************************************************************************
' * �ݒ����
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function usetting()

  Set ThisBook = Nothing
  
  '���[�N�V�[�g���̐ݒ�
  Set sheetsetting = Nothing
  Set sheetNotice = Nothing
  Set sheetStyle = Nothing
  Set sheetTestData = Nothing
  Set sheetRibbon = Nothing
  Set sheetFavorite = Nothing

  '�ݒ�l�ǂݍ���
  Set setVal = Nothing
  Set ribbonVal = Nothing
End Function


'**************************************************************************************************
' * �ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function setting(Optional reCheckFlg As Boolean)
  
  On Error GoTo catchError
'  ThisWorkbook.Save

  '���W�X�g���֘A�ݒ�------------------------------------------------------------------------------
  RegistrySubKey = "Main"
  
  If ThisBook Is Nothing Or reCheckFlg = True Then
    Call usetting
  Else
    Exit Function
  End If

  '�u�b�N�̐ݒ�
  Set ThisBook = ThisWorkbook
  
  '���[�N�V�[�g���̐ݒ�
  Set sheetsetting = ThisBook.Worksheets("�ݒ�")
  Set sheetNotice = ThisBook.Worksheets("Notice")
  Set sheetStyle = ThisBook.Worksheets("Style")
  Set sheetTestData = ThisBook.Worksheets("testData")
  Set sheetRibbon = ThisBook.Worksheets("Ribbon")
  Set sheetFavorite = ThisBook.Worksheets("Favorite")

  
  
  logFile = ThisWorkbook.Path & "\ExcelMacro.log"
        
  '�ݒ�l�ǂݍ���----------------------------------------------------------------------------------
  Set setVal = Nothing
  Set setVal = CreateObject("Scripting.Dictionary")
  setVal.add "debugMode", "develop"
  
  Set ribbonVal = Nothing
  Set ribbonVal = CreateObject("Scripting.Dictionary")
  For line = 2 To sheetRibbon.Cells(Rows.count, 1).End(xlUp).row
    If sheetRibbon.Range("A" & line) <> "" Then
      ribbonVal.add "Lbl_" & sheetRibbon.Range("A" & line).Text, sheetRibbon.Range("B" & line).Text
      ribbonVal.add "Act_" & sheetRibbon.Range("A" & line).Text, sheetRibbon.Range("C" & line).Text
      ribbonVal.add "Sup_" & sheetRibbon.Range("A" & line).Text, sheetRibbon.Range("D" & line).Text
      ribbonVal.add "Dec_" & sheetRibbon.Range("A" & line).Text, sheetRibbon.Range("E" & line).Text
      ribbonVal.add "Siz_" & sheetRibbon.Range("A" & line).Text, sheetRibbon.Range("F" & line).Text
      ribbonVal.add "Img_" & sheetRibbon.Range("A" & line).Text, sheetRibbon.Range("G" & line).Text
    End If
  Next
  
  
  Exit Function
  
'�G���[������=====================================================================================
catchError:
  
End Function


'**************************************************************************************************
' * ���O��`
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function ���O��`()
  Dim line As Long, endLine As Long, colLine As Long, endColLine As Long
  Dim Name As Object
  
'  On Error GoTo catchError

  '���O�̒�`���폜
  For Each Name In Names
    If Name.Visible = False Then
      Name.Visible = True
    End If
    If Not Name.Name Like "*!Print_Area" And Not Name.Name Like "*!Print_Titles" And _
      Not Name.Name Like "Slc*" And Not Name.Name Like "Pvt*" And Not Name.Name Like "Tbl*" Then
      Name.delete
    End If
  Next
  
  'VBA�p�̐ݒ�
  For line = 3 To sheetsetting.Cells(Rows.count, 1).End(xlUp).row
    If sheetsetting.Range("A" & line) <> "" Then
      sheetsetting.Range("B" & line).Name = sheetsetting.Range("A" & line)
    End If
  Next
  
  'Book�p�̐ݒ�
  sheetsetting.Range("D3:D" & sheetsetting.Cells(Rows.count, 6).End(xlUp).row).Name = sheetsetting.Range("D2")
  

  Exit Function
'�G���[������=====================================================================================
catchError:
  Call Library.showNotice(Err.Number, Err.Description, True)
  
End Function

