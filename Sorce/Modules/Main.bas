Attribute VB_Name = "Main"
'���[�N�u�b�N�p�ϐ�------------------------------
'���[�N�V�[�g�p�ϐ�------------------------------
'�O���[�o���ϐ�----------------------------------


'**************************************************************************************************
' * �I�v�V������ʕ\��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function �I�v�V������ʕ\��(control As IRibbonControl)
  
'  On Error GoTo catchError
  
  topPosition = Library.getRegistry("UserForm", "OptionTop")
  leftPosition = Library.getRegistry("UserForm", "OptionLeft")
  With Frm_Option
    .StartUpPosition = 0
    If topPosition = "" Then
      .Top = 10
      .Left = 120
    Else
      .Top = topPosition
      .Left = leftPosition
    End If
    .Show
  End With

  Exit Function

'�G���[������=====================================================================================
catchError:
  'Call Library.showNotice(Err.Number, Err.Description, True)
End Function


'**************************************************************************************************
' * �W�����
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function �W�����(control As IRibbonControl)
  Dim objSheet As Object
  Dim sheetName As String, SetActiveSheet As String
  
  
  'On Error Resume Next
  
  Call Library.startScript
  Call Ctl_ProgressBar.showStart
  
  SetActiveSheet = ActiveWorkbook.ActiveSheet.Name
  SelectAddress = Selection.Address
  
  For Each objSheet In ActiveWorkbook.Sheets
    sheetName = objSheet.Name
    Call Ctl_ProgressBar.showCount("�W����ʐݒ�", 1, 100, sheetName)
    If Worksheets(sheetName).Visible = True Then
      Worksheets(sheetName).Select
      
      '�W����ʂɐݒ�
      ActiveWindow.View = xlNormalView
      
      '�\���{���̎w��
      ActiveWindow.Zoom = Library.getRegistry("Main", "zoomLevel")
      
      '�K�C�h���C���̕\��/��\��
      ActiveWindow.DisplayGridlines = Library.getRegistry("Main", "gridLine")
  
      '�w�i�����Ȃ��ɂ���
      If Library.getRegistry("Main", "gridLine") = True Then
        With Application.FindFormat.Interior
          .PatternColorIndex = xlAutomatic
          .ThemeColor = xlThemeColorDark1
          .TintAndShade = 0
          .PatternTintAndShade = 0
        End With
        With Application.ReplaceFormat.Interior
          .Pattern = xlNone
          .TintAndShade = 0
          .PatternTintAndShade = 0
        End With
        Cells.Replace What:="", Replacement:="", LookAt:=xlPart, SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=True, ReplaceFormat:=True
      End If
      Application.GoTo Reference:=Range("A1"), Scroll:=True
    End If
  Next
  
  Worksheets(SetActiveSheet).Select
  Range(SelectAddress).Select
  Call Ctl_ProgressBar.showEnd
  Call Library.endScript
  
End Function


'**************************************************************************************************
' * �X�^�C���폜
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function �X�^�C���폜()
  Dim s
  Dim count As Long, endCount As Long
  Dim line As Long, endLine As Long
  
'  On Error Resume Next
  
  Call Library.startScript
  Call init.setting
  
  count = 1
  Call Ctl_ProgressBar.showStart
  endCount = ActiveWorkbook.Styles.count
  
  For Each s In ActiveWorkbook.Styles
    Call Ctl_ProgressBar.showCount("��`�σX�^�C���폜", count, endCount, s.Name)
    Call Library.showDebugForm("��`�σX�^�C���폜�F" & s.Name)
    
    Select Case s.Name
      Case "Normal"
      Case Else
        s.delete
    End Select
    count = count + 1
  Next
  
  '�X�^�C��������
  endLine = BK_sheetStyle.Cells(Rows.count, 2).End(xlUp).Row
  For line = 2 To endLine
    If BK_sheetStyle.Range("A" & line) <> "����" Then
      Call Ctl_ProgressBar.showCount("�X�^�C��������", line, endLine, BK_sheetStyle.Range("B" & line))
      Call Library.showDebugForm("�X�^�C���������F" & BK_sheetStyle.Range("B" & line))
      
      If BK_sheetStyle.Range("B" & line) <> "Normal" Then
        ActiveWorkbook.Styles.add Name:=BK_sheetStyle.Range("B" & line).Value
      End If
      
      With ActiveWorkbook.Styles(BK_sheetStyle.Range("B" & line).Value)
        
        If BK_sheetStyle.Range("C" & line) <> "" Then
          .NumberFormatLocal = BK_sheetStyle.Range("C" & line)
        End If
        .IncludeNumber = BK_sheetStyle.Range("D" & line)
        .IncludeFont = BK_sheetStyle.Range("E" & line)
        .IncludeAlignment = BK_sheetStyle.Range("F" & line)
        .IncludeBorder = BK_sheetStyle.Range("G" & line)
        .IncludePatterns = BK_sheetStyle.Range("H" & line)
        .IncludeProtection = BK_sheetStyle.Range("I" & line)
        
        If BK_sheetStyle.Range("E" & line) = "TRUE" Then
          .Font.Name = BK_sheetStyle.Range("J" & line).Font.Name
          .Font.Size = BK_sheetStyle.Range("J" & line).Font.Size
          .Font.Color = BK_sheetStyle.Range("J" & line).Font.Color
          .Font.Bold = BK_sheetStyle.Range("J" & line).Font.Bold
        End If
        
        '�z�u
        If BK_sheetStyle.Range("F" & line) = "TRUE" Then
          .HorizontalAlignment = BK_sheetStyle.Range("J" & line).HorizontalAlignment
        End If
        
        
        '�w�i�F
        If BK_sheetStyle.Range("H" & line) = "TRUE" Then
          .Interior.Color = BK_sheetStyle.Range("J" & line).Interior.Color
        End If
        
        
      End With
    End If
  Next
  
  Call Ctl_ProgressBar.showEnd
  Call Library.endScript

End Function


'**************************************************************************************************
' * ���O��`�폜
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function ���O��`�폜(control As IRibbonControl)
  Dim wb As Workbook, tmp As String
  
  Call Library.startScript
  
  For Each wb In Workbooks
    Workbooks(wb.Name).Activate
    Call Library.delVisibleNames
  Next wb
  
  Call Library.endScript

End Function


'**************************************************************************************************
' * �摜�ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function �摜�ݒ�(control As IRibbonControl)

  With ActiveWorkbook.ActiveSheet
    Dim AllShapes As Shapes
    Dim CurShape As Shape
    Set AllShapes = .Shapes
    
    For Each CurShape In AllShapes
      CurShape.Placement = xlMove
    Next
  End With
  
End Function


'**************************************************************************************************
' * R1C1�\�L
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function R1C1�\�L(control As IRibbonControl)

  On Error Resume Next
  
  If Application.ReferenceStyle = xlA1 Then
    Application.ReferenceStyle = xlR1C1
  Else
    Application.ReferenceStyle = xlA1
  End If
  
End Function


'**************************************************************************************************
' * �n�C���C�g
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function �n�C���C�g()
  Dim highLightFlg As String
  Dim highLightArea As String

  Call Library.startScript
  highLightFlg = Library.getRegistry(ActiveWorkbook.Name, "HighLightFlg")
  
  If highLightFlg = "" Then
    Call Library.setLineColor(Selection.Address, True, Library.getRegistry("HighLightColor"))
    
    Call Library.setRegistry(ActiveWorkbook.Name, True, "HighLightFlg")
    Call Library.setRegistry(ActiveWorkbook.Name & "_HighLightSheet", ActiveSheet.Name, "HighLightFlg")
    Call Library.setRegistry(ActiveWorkbook.Name & "_HighLightArea", Selection.Address, "HighLightFlg")
    
  Else
    highLightArea = Library.getRegistry(ActiveWorkbook.Name & "_HighLightArea")
    
    If highLightArea = "" Then
      highLightArea = Selection.Address
    End If
    Call Library.unsetLineColor(highLightArea)
    
    Call Library.delRegistry(ActiveWorkbook.Name, "HighLightFlg")
    Call Library.delRegistry(ActiveWorkbook.Name & "_HighLightSheet")
    Call Library.delRegistry(ActiveWorkbook.Name & "_HighLightArea")
  End If
  
  Call Library.endScript(True)
End Function



'**************************************************************************************************
' * �ݒ�Import / Export
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function �ݒ�_���o()
  
  Dim FSO As Object, TempName As String
  Set FSO = CreateObject("Scripting.FileSystemObject")
  
  Call Library.startScript
  Call init.setting
  
  TempName = FSO.GetSpecialFolder(2) & "\BK_Style.xlsx"
  
  BK_sheetStyle.Copy
  ActiveWorkbook.SaveAs fileName:=TempName, FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False
  
  Call Library.endScript
  
  MsgBox ("�C��������A�ۑ������Ă�������")
End Function

'==================================================================================================
Function �ݒ�_�捞()
  
  Dim FSO As Object, TempName As String
  Set FSO = CreateObject("Scripting.FileSystemObject")
  
  Call Library.startScript
  Call init.setting

  TempName = FSO.GetSpecialFolder(2) & "\BK_Style.xlsx"
  
  Set targetBook = Workbooks.Open(TempName)
  targetBook.Sheets("Style").Columns("A:J").Copy ThisWorkbook.Worksheets("Style").Range("A1")
  targetBook.Close
  
  Call FSO.DeleteFile(TempName, True)
  
  Call Main.�X�^�C���폜
  Call Library.endScript
End Function









