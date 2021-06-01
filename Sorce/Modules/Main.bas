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
      ActiveWindow.Zoom = Library.getRegistry("zoomLevel")
      
      '�K�C�h���C���̕\��/��\��
      ActiveWindow.DisplayGridlines = Library.getRegistry("gridLine")
  
      '�w�i�����Ȃ��ɂ���
      If Library.getRegistry("gridLine") = True Then
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
Function �X�^�C���폜(control As IRibbonControl)
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
Function �n�C���C�g(control As IRibbonControl)
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
' * �r���ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function �r��_�폜(control As IRibbonControl)
  With Selection
    .Borders(xlInsideVertical).LineStyle = xlNone
    .Borders(xlInsideHorizontal).LineStyle = xlNone
    .Borders(xlEdgeLeft).LineStyle = xlNone
    .Borders(xlEdgeRight).LineStyle = xlNone
    .Borders(xlEdgeTop).LineStyle = xlNone
    .Borders(xlEdgeBottom).LineStyle = xlNone
    .Borders(xlInsideVertical).LineStyle = xlNone
    .Borders(xlInsideHorizontal).LineStyle = xlNone
  End With
End Function

Function �r��_�\(control As IRibbonControl)
  Call Library.startScript
  Call Library.�r��_�\
  Call Library.endScript
End Function


Function �r��_�j��_����(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  
  With Selection
    .Borders(xlInsideHorizontal).LineStyle = xlNone
    .Borders(xlInsideHorizontal).LineStyle = xlDash
    .Borders(xlInsideHorizontal).Weight = xlHairline
    .Borders(xlInsideHorizontal).Color = RGB(Red, Green, Blue)
    
    End With
End Function


Function �r��_�j��_����(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlInsideVertical).LineStyle = xlNone
    .Borders(xlInsideVertical).LineStyle = xlDash
    .Borders(xlInsideVertical).Weight = xlHairline
    .Borders(xlInsideVertical).Color = RGB(Red, Green, Blue)
  End With
End Function

Function �r��_�j��_���E(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long

  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlEdgeLeft).LineStyle = xlNone
    .Borders(xlEdgeRight).LineStyle = xlNone
    
    .Borders(xlEdgeLeft).LineStyle = xlDash
    .Borders(xlEdgeRight).LineStyle = xlDash
    
    .Borders(xlEdgeLeft).Weight = xlHairline
    .Borders(xlEdgeRight).Weight = xlHairline
    
    .Borders(xlEdgeLeft).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeRight).Color = RGB(Red, Green, Blue)
  End With
End Function


Function �r��_�j��_�㉺(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlEdgeTop).LineStyle = xlNone
    .Borders(xlEdgeBottom).LineStyle = xlNone
    
    .Borders(xlEdgeTop).LineStyle = xlDash
    .Borders(xlEdgeTop).Weight = xlHairline
    
    .Borders(xlEdgeBottom).LineStyle = xlDash
    .Borders(xlEdgeBottom).Weight = xlHairline
    
    .Borders(xlEdgeTop).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeBottom).Color = RGB(Red, Green, Blue)
  End With
End Function


Function �r��_�j��_�͂�(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlEdgeLeft).LineStyle = xlDash
    .Borders(xlEdgeLeft).Weight = xlHairline
    .Borders(xlEdgeRight).LineStyle = xlDash
    .Borders(xlEdgeRight).Weight = xlHairline
    .Borders(xlEdgeTop).LineStyle = xlDash
    .Borders(xlEdgeTop).Weight = xlHairline
    .Borders(xlEdgeBottom).LineStyle = xlDash
    .Borders(xlEdgeBottom).Weight = xlHairline
  
    .Borders(xlEdgeLeft).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeRight).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeTop).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeBottom).Color = RGB(Red, Green, Blue)
  End With
End Function

Function �r��_�j��_�i�q(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlEdgeLeft).LineStyle = xlDash
    .Borders(xlEdgeLeft).Weight = xlHairline
    .Borders(xlEdgeTop).LineStyle = xlDash
    .Borders(xlEdgeTop).Weight = xlHairline
    .Borders(xlEdgeBottom).LineStyle = xlDash
    .Borders(xlEdgeBottom).Weight = xlHairline
    .Borders(xlEdgeRight).LineStyle = xlDash
    .Borders(xlEdgeRight).Weight = xlHairline
    .Borders(xlInsideVertical).LineStyle = xlDash
    .Borders(xlInsideVertical).Weight = xlHairline
    .Borders(xlInsideHorizontal).LineStyle = xlDash
    .Borders(xlInsideHorizontal).Weight = xlHairline
  
    .Borders(xlEdgeLeft).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeRight).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeTop).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeBottom).Color = RGB(Red, Green, Blue)
  End With
End Function


Function �r��_����_�͂�(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  
  With Selection
    .Borders(xlEdgeLeft).LineStyle = xlContinuous
    .Borders(xlEdgeRight).LineStyle = xlContinuous
    .Borders(xlEdgeTop).LineStyle = xlContinuous
    .Borders(xlEdgeBottom).LineStyle = xlContinuous
    
    .Borders(xlEdgeLeft).Weight = xlThin
    .Borders(xlEdgeRight).Weight = xlThin
    .Borders(xlEdgeTop).Weight = xlThin
    .Borders(xlEdgeBottom).Weight = xlThin
    
    .Borders(xlEdgeLeft).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeRight).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeTop).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeBottom).Color = RGB(Red, Green, Blue)
  End With
End Function


Function �r��_��d��_���E(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlEdgeLeft).LineStyle = xlDouble
    .Borders(xlEdgeRight).LineStyle = xlDouble
    
    .Borders(xlEdgeLeft).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeRight).Color = RGB(Red, Green, Blue)
  End With
End Function

Function �r��_��d��_�㉺(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlEdgeTop).LineStyle = xlDouble
    .Borders(xlEdgeBottom).LineStyle = xlDouble
    
    .Borders(xlEdgeTop).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeBottom).Color = RGB(Red, Green, Blue)
  End With
End Function

Function �r��_��d��_�͂�(control As IRibbonControl)
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  
  With Selection
    .Borders(xlEdgeLeft).LineStyle = xlDouble
    .Borders(xlEdgeRight).LineStyle = xlDouble
    .Borders(xlEdgeTop).LineStyle = xlDouble
    .Borders(xlEdgeBottom).LineStyle = xlDouble
    
    .Borders(xlEdgeLeft).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeRight).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeTop).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeBottom).Color = RGB(Red, Green, Blue)
  End With
End Function










