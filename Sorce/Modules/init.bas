Attribute VB_Name = "init"
'���[�N�u�b�N�p�ϐ�------------------------------
Public ThisBook As Workbook
Public targetBook As Workbook


'���[�N�V�[�g�p�ϐ�------------------------------
Public sheetNotice As Worksheet
Public sheetStyle As Worksheet
Public sheetStyle2 As Worksheet
Public sheetRibbon As Worksheet


'�O���[�o���ϐ�----------------------------------
Public Const thisAppName = "BK_Library"
Public Const thisAppVersion = "0.0.4.0"

'���W�X�g���o�^�p�T�u�L�[
Public Const RegistryKey As String = "B.Koizumi"
Public Const RegistrySubKey As String = "BK_Library"

Public setVal As Collection

'�t�@�C���֘A
Public logFile As String


'**************************************************************************************************
' * �ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function setting(Optional reCheckFlg As Boolean)
  
'  On Error GoTo catchError
  ThisWorkbook.Save

  If ThisBook Is Nothing Or reCheckFlg = True Then
  Else
    Exit Function
  End If

  '�u�b�N�̐ݒ�
  Set ThisBook = ThisWorkbook
  
  '���[�N�V�[�g���̐ݒ�
  Set sheetNotice = ThisBook.Worksheets("Notice")
  Set sheetStyle = ThisBook.Worksheets("Style")
  Set sheetStyle2 = ThisBook.Worksheets("Style2")
  Set sheetRibbon = ThisBook.Worksheets("Ribbon")

  Set setVal = New Collection
  With setVal
    .Add Item:="develop", Key:="debugMode"
  End With
  
  logFile = ThisWorkbook.Path & "\ExcelMacro.log"
  
  
  Exit Function
  
'�G���[������=====================================================================================
catchError:
  
End Function


