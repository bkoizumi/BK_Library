Attribute VB_Name = "TestSpecification"
Public SetRowHeight As Long
Public SetAddRowHeight As Long
Public SetTestCaseFlg As Boolean
Public SetPrintOnePageRow As Long
Public SetFreezePanesCell As String
Public WindowZoomLevel As Long
Public SetTestCount As Long
Public SetActiveCell As String
Public SetActiveSheet As String
Public CheckRecal As Long
Public BeforeCloseFlg As Boolean

Public SetLineColorType As Boolean
Public SetLineColorColumn As String
Public SetLineColorValue As String
Public SetMonoChromePrinting  As Boolean




'***********************************************************************************************************************************************
' * �ݒ�V�[�g�Đݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Sub TestSpecification_Reset()

  On Error Resume Next

  Worksheets("�ݒ�").Active
  
  ' �ݒ�ς̖��O���폜
  Dim nm As Name
  For Each nm In ActiveWorkbook.Names
    nm.Delete
  Next nm

  ActiveWorkbook.Names.Add Name:="�ڋq��", RefersTo:=Range("E3")
  ActiveWorkbook.Names.Add Name:="�쐬��", RefersTo:=Range("E4")
  ActiveWorkbook.Names.Add Name:="�쐬��", RefersTo:=Range("E5")
  ActiveWorkbook.Names.Add Name:="�v���W�F�N�g��", RefersTo:=Range("E6")
  ActiveWorkbook.Names.Add Name:="�V�X�e����", RefersTo:=Range("E7")
  ActiveWorkbook.Names.Add Name:="�\���^�C�g������", RefersTo:=Range("E8")
  ActiveWorkbook.Names.Add Name:="�u���E�U", RefersTo:=Range("G3:G" & Cells(Rows.count, 7).End(xlUp).Row)
  ActiveWorkbook.Names.Add Name:="����", RefersTo:=Range("E13:E" & Cells(Rows.count, 5).End(xlUp).Row)
  ActiveWorkbook.Names.Add Name:="����m�F��", RefersTo:=Range("D13:D" & Cells(Rows.count, 4).End(xlUp).Row)
  
 
  SetLineColorFlg = False
  TestSpecification_SetShortcutKey          '�Ǝ��V���[�g�J�b�g�L�[�ݒ�
'  TestSpecification_SetCellStyles           '�Z���̃X�^�C���ݒ�
  
'  TButton1 = Range("B3").Value
'  ribbonUI.Invalidate
End Sub


'***********************************************************************************************************************************************
' * �V���[�g�J�b�g�L�[�ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetShortcutKey()
  ' [F1]�ɂ��w�w���v�x��ʂ̋N���𖳌��ɂ���B
  Call Application.OnKey("{F1}", "")
  

  If Worksheets("�ݒ�").Range("B16") <> "" Then
    Application.MacroOptions Macro:="FuncAddSheet", ShortcutKey:=Worksheets("�ݒ�").Range("B16")
  End If
  
  If Worksheets("�ݒ�").Range("B17") <> "" Then
    Application.MacroOptions Macro:="FuncSetNumber", ShortcutKey:=Worksheets("�ݒ�").Range("B17")
  End If

  If Worksheets("�ݒ�").Range("B18") <> "" Then
    Application.MacroOptions Macro:="FuncSetPrintArea", ShortcutKey:=Worksheets("�ݒ�").Range("B18")
  End If
  
  If Worksheets("�ݒ�").Range("B19") <> "" Then
    Application.MacroOptions Macro:="FuncSetResult", ShortcutKey:=Worksheets("�ݒ�").Range("B19")
  End If
  
  If Worksheets("�ݒ�").Range("B20") <> "" Then
    Application.MacroOptions Macro:="FuncSetResult", ShortcutKey:=Worksheets("�ݒ�").Range("B20")
  End If

End Function


'***********************************************************************************************************************************************
' * �e�X�g���ʕ񍐏��p���ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Sub TestSpecification_Init()

  Dim TmpTestCaseFlg As String
  
  On Error GoTo ErrHand
  
  ' ���������p�̍���
  SetRowHeight = Worksheets("�ݒ�").Range("B3")
  
  ' ���������p�̍���
  SetAddRowHeight = Worksheets("�ݒ�").Range("B4")
  
  ' �����ԍ���A2�̃Z���l�𗘗p���邩�ǂ���
  TmpTestCaseFlg = Worksheets("�ݒ�").Range("B5")
  If TmpTestCaseFlg = "���p����" Then
    SetTestCaseFlg = True
  Else
    SetTestCaseFlg = False
  End If
  
  ' ������A1�y�[�W�Ɏ��߂�s��
  SetPrintOnePageRow = Worksheets("�ݒ�").Range("B6")
  SetFreezePanesCell = Worksheets("�ݒ�").Range("B7")
  
  ' ��ʂ̃Y�[�����x��
  WindowZoomLevel = Worksheets("�ݒ�").Range("B8")
  
  '�I���s�̐F�t��
  If Range("B1") = "�s�E��Ƃ�" Then
    SetLineColorType = True
  Else
    SetLineColorType = False
  End If
  SetLineColorColumn = Range("B2")
  
  SetLineColorValue = Worksheets("�ݒ�").Range("B9").Interior.color
  
  '���m�N�����
  If Range("B10") = "����" Then
    SetMonoChromePrinting = True
  Else
    SetMonoChromePrinting = False
  End If
  
  
  
  ' �}�N�����s�O�̃A�N�e�B�u�V�[�g�A�Z��
  SetActiveSheet = activeSheet.Name
  
  If Selection.Address = "" Then
    SetActiveCell = "A1"
  Else
    SetActiveCell = Selection.Address
  End If
Exit Sub

ErrHand:
  
  SetActiveCell = "A1"
  Resume Next
  
End Sub

'***********************************************************************************************************************************************
' * �e�X�g���ʕ񍐏��p�V�[�g�ǉ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_AddSheet()

  Dim sheetName As String
  
  ' ���͗p�{�b�N�X�̕\��
  sheetName = InputBox("�@�\���H", "�@�\���i�V�[�g���j����", "")
  
  If sheetName <> "" Then
    Sheets("�R�s�[�p").Copy After:=Worksheets(Worksheets.count)
    ActiveWorkbook.Sheets(Worksheets.count).Tab.ColorIndex = -4142
    ActiveWorkbook.Sheets(Worksheets.count).Name = sheetName
    
    
  End If
  
End Function

'***********************************************************************************************************************************************
' * �����ԍ��ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetNumber()

  Dim RowCnt As Long
  Dim endLine As Long
  
  Dim TestCaseNo As Long
  
  Dim ColumLoopArray As Variant
  Dim ColumnLoopName As Variant
  Dim ColumnLoopCount As Long
 
  ' ======================= �����J�n ======================
  Dim result As Boolean
   result = Library_CheckExcludeSheet(activeSheet.Name, 8)
  If result = False Then
    Exit Function
  End If
  

  Application.EnableCancelKey = xlErrorHandler
  On Error GoTo ErrHand
  
  
  ActiveWindow.DisplayGridlines = False
  TestSpecification_Init

  
  endLine = Cells(Rows.count, 5).End(xlUp).Row    ' �A�N�e�B�u�V�[�g�̍ŏI�s�擾
  
  TestCaseNo = 0
  
  ' �v���O���X�o�[�̕\���J�n
  ProgressBar_ProgShowStart

  Columns("D:E").ColumnWidth = 50
  ' �����ԍ����� ====================================================
  For RowCnt = 9 To endLine
    TestCaseNo = TestCaseNo + 1
    
  ' �區�ڂ̃e�X�g�P�[�X ============================================
    If Range("B" & RowCnt).Value <> "" Then
      TestSpecification_SetLineStyle1 (RowCnt)

  ' �����ڂ̃e�X�g�P�[�X ============================================
    ElseIf Range("C" & RowCnt).Value <> "" Then
      TestSpecification_SetLineStyle2 (RowCnt)

  ' �����ڂ̃e�X�g�P�[�X ============================================
    Else
      TestSpecification_SetLineStyle3 (RowCnt)
    End If

    ' �����ԍ��ݒ�
    Range("A" & RowCnt).NumberFormatLocal = "@"
    If SetTestCaseFlg And Range("A2").Value <> "" Then
      Range("A" & RowCnt).Value = Range("A2").Value & "-" & Format(TestCaseNo, "000")
    Else
      Range("A" & RowCnt).Value = Format(TestCaseNo, "000")
    End If

    ' �w�i�F�̃N���A
    Range("A" & RowCnt & ":BD" & RowCnt).Select
      With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With

      With Selection.Font
          .ColorIndex = xlAutomatic
          .TintAndShade = 0
      End With

    ' �v���O���X�o�[�̃J�E���g�ύX�i���݂̃J�E���g�A�S�J�E���g���A���b�Z�[�W�j
    ProgressBar_ProgShowCount "������", RowCnt, endLine, "1/5 �����ԍ��ݒ�F" & Range("A" & RowCnt).Value
    
    ' �����̒���
    TestSpecification_setCellHeight (RowCnt)
  Next
  
  ' �ŏI�s�ݒ�
  TestSpecification_SetEndLineStyle (RowCnt - 1)
  
  '�e�X�g���ʂ̏W�v
  ColumnLoopCount = 0

  
  ' ���ʐݒ�
  ColumLoopArray = Array("G", "Q", "AA", "AK", "AU")
  For Each ColumnLoopName In ColumLoopArray
    ProgressBar_ProgShowCount "������", ColumnLoopCount, UBound(ColumLoopArray), "2/5 ���ʐݒ蒆�E�E�E�E"
    Call TestSpecification_SetResultLineStyle(RowCnt - 1, ColumnLoopName)
    ColumnLoopCount = ColumnLoopCount + 1
  Next
  
  '�m�F���ݒ�
  ColumLoopArray = Array("H", "K", "N", "R", "U", "X", "AB", "AE", "AH", "AL", "AO", "AR", "AV", "AY", "BB")
  ColumnLoopCount = 0
  For Each ColumnLoopName In ColumLoopArray
    ProgressBar_ProgShowCount "������", ColumnLoopCount, UBound(ColumLoopArray), "3/5 �m�F���ݒ蒆�E�E�E�E"
    Call TestSpecification_SetTestDay(RowCnt - 1, ColumnLoopName)
    ColumnLoopCount = ColumnLoopCount + 1
  Next
  
  '�m�F�Ґݒ�
  ColumLoopArray = Array("I", "L", "O", "S", "V", "Y", "AC", "AF", "AI", "AN", "AP", "AS", "AW", "AZ", "BC")
  ColumnLoopCount = 0
  For Each ColumnLoopName In ColumLoopArray
    ProgressBar_ProgShowCount "������", ColumnLoopCount, UBound(ColumLoopArray), "4/5 �m�F�Ґݒ蒆�E�E�E�E"
    Call TestSpecification_SetTestUser(RowCnt - 1, ColumnLoopName)
    ColumnLoopCount = ColumnLoopCount + 1
  Next
  
  '���l�ݒ�
  ColumLoopArray = Array("J", "M", "P", "T", "W", "Z", "AD", "AF", "AJ", "AO", "AQ", "AT", "AX", "BA", "BD")
  ColumnLoopCount = 0
  For Each ColumnLoopName In ColumLoopArray
    ProgressBar_ProgShowCount "������", ColumnLoopCount, UBound(ColumLoopArray), "5/5 ���l�ݒ蒆�E�E�E�E"
    Call TestSpecification_SetTestComment(RowCnt - 1, ColumnLoopName)
    ColumnLoopCount = ColumnLoopCount + 1
  Next

'  TestSpecification_SetPrintArea


  ' �v���O���X�o�[�̕\���I������
  ProgressBar_ProgShowClose
  
  ' �E�B���h�E�g�̌Œ�
  If SetFreezePanesCell <> "" Then
    ActiveWindow.FreezePanes = False
    activeSheet.Outline.ShowLevels RowLevels:=2
    
    
    With ActiveWindow
      .ScrollRow = 1
      .ScrollColumn = 1
    End With
    
    Range("A1").Select
    Range(SetFreezePanesCell).Select
    ActiveWindow.FreezePanes = True
    activeSheet.Outline.ShowLevels RowLevels:=1
  End If
  
  '��ʂ̃Y�[�����x���ݒ�
  ActiveWindow.Zoom = WindowZoomLevel
  
  Erase ColumLoopArray
  
  
  ' ======================= ��ʕ`�ʐ���I�� ======================
  
  Range(SetActiveCell).Activate
    
Exit Function

' ======================= �G���[�������̏��� ======================
ErrHand:
  
'  Erase ColumLoopArray
  Range(SetActiveCell).Select
 
  ' �v���O���X�o�[�̕\���I������
  
  ProgressBar_ProgShowClose

  Call Library_ErrorHandle(Err.Number, Err.Description)
End Function

'***********************************************************************************************************************************************
' * ����͈͐ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Sub TestSpecification_SetPrintArea()

'  On Error GoTo ErrHand
  
  Dim endBookRowLine As Long
  Dim PageCnt As Long
  Dim W_PageNoCol As Long
  Dim RowCnt As Long
  
  TestSpecification_Init

' ======================= ��ʕ`�ʐ���J�n ======================
  endBookRowLine = Cells(Rows.count, 1).End(xlUp).Row
  W_PageNoCol = SetPrintOnePageRow + 4
  PageCnt = 1
  
  ' �v���O���X�o�[�̕\���J�n
  ProgressBar_ProgShowStart
  
' ======================= �����J�n ======================
  '���y�[�W�v���r���[
  ActiveWindow.View = xlPageBreakPreview
  
  '���ׂẲ��y�[�W������
  activeSheet.ResetAllPageBreaks
  
  '����͈͂��N���A����
  activeSheet.PageSetup.PrintArea = ""
  
  '����͈͂̏ڍאݒ�
  With activeSheet.PageSetup
    .RightHeader = Range("A1").Value
    .CenterFooter = "&P / &N"
    .PrintTitleRows = "$5:$8"                 '�s�^�C�g��
    .PrintArea = "$A$5:$P$" & endBookRowLine
    .BlackAndWhite = SetMonoChromePrinting    '������� True:����  False:���Ȃ�
    .Zoom = False
    .FitToPagesWide = 1
    .FitToPagesTall = False
  End With

  
  ActiveWindow.View = xlNormalView
  
' ======================= ��ʕ`�ʐ���I�� ======================
  ' �v���O���X�o�[�̕\���I������
  ProgressBar_ProgShowClose
  Range(SetActiveCell).Select
  ActiveWindow.Zoom = WindowZoomLevel
  
Exit Sub

' ======================= �G���[�������̏��� ======================
ErrHand:

  ActiveWindow.View = xlNormalView
   
  ' �v���O���X�o�[�̕\���I������
  
  ProgressBar_ProgShowClose
  Call Library_ErrorHandle(Err.Number, Err.Description)

End Sub


'***********************************************************************************************************************************************
' * �啪�ނ̌r��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Sub TestSpecification_SetLineStyle1(RowCnt As Long)

'  Range(Cells(RowCnt, 1), Cells(RowCnt, Cells(8, Columns.Count).End(xlToLeft).Column)).Select
  Range(Cells(RowCnt, 1), Cells(RowCnt, 56)).Select
  
  Selection.Borders(xlDiagonalDown).LineStyle = xlNone
  Selection.Borders(xlDiagonalUp).LineStyle = xlNone
  With Selection.Borders(xlEdgeLeft)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeRight)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  
  With Selection.Borders(xlEdgeTop)
      .LineStyle = xlDouble
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThick
  End With
  Selection.Borders(xlEdgeBottom).LineStyle = xlNone
  With Selection.Borders(xlInsideVertical)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
End Sub
'***********************************************************************************************************************************************
' * �����ނ̌r��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Sub TestSpecification_SetLineStyle2(RowCnt As Long)

'  Range(Cells(RowCnt, 1), Cells(RowCnt, Cells(8, Columns.Count).End(xlToLeft).Column)).Select
  Range(Cells(RowCnt, 1), Cells(RowCnt, 56)).Select
  
  
  Selection.Borders(xlDiagonalDown).LineStyle = xlNone
  Selection.Borders(xlDiagonalUp).LineStyle = xlNone
  With Selection.Borders(xlEdgeLeft)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeTop)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeBottom)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeRight)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  With Selection.Borders(xlInsideVertical)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  Selection.Borders(xlInsideHorizontal).LineStyle = xlNone

  If Range("B" & RowCnt).Value = "" Then
    Range("B" & RowCnt).Borders(xlEdgeTop).LineStyle = xlNone
  End If
End Sub

'***********************************************************************************************************************************************
' * �����ނ̌r��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Sub TestSpecification_SetLineStyle3(RowCnt As Long)

'  Range(Cells(RowCnt, 1), Cells(RowCnt, Cells(8, Columns.Count).End(xlToLeft).Column)).Select
  Range(Cells(RowCnt, 1), Cells(RowCnt, 56)).Select

  Selection.Borders(xlDiagonalDown).LineStyle = xlNone
  Selection.Borders(xlDiagonalUp).LineStyle = xlNone
  With Selection.Borders(xlEdgeLeft)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeTop)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlHairline
  End With
  Selection.Borders(xlEdgeBottom).LineStyle = xlNone
  With Selection.Borders(xlEdgeRight)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  With Selection.Borders(xlInsideVertical)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
  
  If Range("B" & RowCnt).Value = "" Then
    Range("B" & RowCnt).Borders(xlEdgeTop).LineStyle = xlNone
  End If
  If Range("C" & RowCnt).Value = "" Then
    Range("C" & RowCnt).Borders(xlEdgeTop).LineStyle = xlNone
  End If
  If Range("D" & RowCnt).Value = "" Then
    Range("D" & RowCnt).Borders(xlEdgeTop).LineStyle = xlNone
  End If
  
End Sub

'***********************************************************************************************************************************************
' * �ŏI�s�̌r��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Sub TestSpecification_SetEndLineStyle(RowCnt As Long)

  Range("A5:BD" & RowCnt).Select

  Selection.Borders(xlDiagonalDown).LineStyle = xlNone
  Selection.Borders(xlDiagonalUp).LineStyle = xlNone
  With Selection.Borders(xlEdgeLeft)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlMedium
  End With
  With Selection.Borders(xlEdgeTop)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlMedium
  End With
  With Selection.Borders(xlEdgeBottom)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlMedium
  End With
  With Selection.Borders(xlEdgeRight)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlMedium
  End With


  Range("A5:BD8").Select
  Range("BD8").Activate
  Selection.Borders(xlDiagonalDown).LineStyle = xlNone
  Selection.Borders(xlDiagonalUp).LineStyle = xlNone
  With Selection.Borders(xlEdgeLeft)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlMedium
  End With
  With Selection.Borders(xlEdgeTop)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlMedium
  End With
  With Selection.Borders(xlEdgeBottom)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeRight)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlMedium
  End With
End Sub


'***********************************************************************************************************************************************
' * ���ʂ̌r��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetResultLineStyle(RowCnt As Long, ColumnLoopName As Variant)

  Range(ColumnLoopName & "9:" & ColumnLoopName & RowCnt).Select
  With Selection
    .HorizontalAlignment = xlCenter
    .VerticalAlignment = xlCenter
    .WrapText = True
    .Orientation = 0
    .AddIndent = False
    .IndentLevel = 0
    .ShrinkToFit = False
    .ReadingOrder = xlContext
'    .MergeCells = False
  End With
  
  ' ���͋K���̐ݒ�
  With Selection.Validation
    .Delete
    .Add Type:=xlValidateList, AlertStyle:=xlValidAlertStop, Operator:= _
    xlBetween, Formula1:="=����"
    .IgnoreBlank = True
    .InCellDropdown = True
    .InputTitle = ""
    .ErrorTitle = ""
    .InputMessage = ""
    .ErrorMessage = ""
    .IMEMode = xlIMEModeOff
    .ShowInput = True
    .ShowError = True
  End With
  
  Selection.Borders(xlDiagonalDown).LineStyle = xlNone
  Selection.Borders(xlDiagonalUp).LineStyle = xlNone
  With Selection.Borders(xlEdgeLeft)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlMedium
  End With
  With Selection.Borders(xlEdgeRight)
      .LineStyle = xlContinuous
      .ThemeColor = 1
      .TintAndShade = -0.499984740745262
      .Weight = xlThin
  End With
  
  Range("F" & RowCnt).Select
  With Selection
    .HorizontalAlignment = xlCenter
    .VerticalAlignment = xlCenter
    .WrapText = True
    .Orientation = 0
    .AddIndent = False
    .IndentLevel = 0
    .ShrinkToFit = False
    .ReadingOrder = xlContext
    .MergeCells = False
    
    .Font.ColorIndex = xlAutomatic
    .Font.TintAndShade = 0
    .Font.Bold = False
  End With

End Function


'***********************************************************************************************************************************************
' * �m�F���̌r��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetTestDay(RowCnt As Long, ColumnLoopName As Variant)
  
  Range(ColumnLoopName & "9:" & ColumnLoopName & RowCnt).Select
  Selection.NumberFormatLocal = "yyyy/mm/dd"
  With Selection
      .HorizontalAlignment = xlCenter
      .VerticalAlignment = xlCenter
      .WrapText = False
      .Orientation = 0
      .AddIndent = False
      .IndentLevel = 0
      .ShrinkToFit = False
      .ReadingOrder = xlContext
      .MergeCells = False
      .ColumnWidth = 12
  End With

  With Selection.Validation
      .Delete
      .Add Type:=xlValidateInputOnly, AlertStyle:=xlValidAlertStop, Operator _
      :=xlBetween
      .IgnoreBlank = True
      .InCellDropdown = True
      .InputTitle = ""
      .ErrorTitle = ""
      .InputMessage = ""
      .ErrorMessage = ""
      .IMEMode = xlIMEModeOff
      .ShowInput = True
      .ShowError = True
  End With
End Function


'***********************************************************************************************************************************************
' * �m�F�҂̓��͋K��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetTestUser(RowCnt As Long, ColumnLoopName As Variant)
  
  Range(ColumnLoopName & "9:" & ColumnLoopName & RowCnt).Select
  With Selection
    .HorizontalAlignment = xlCenter
    .VerticalAlignment = xlCenter
    .WrapText = True
    .Orientation = 0
    .AddIndent = False
    .IndentLevel = 0
    .ShrinkToFit = False
    .ReadingOrder = xlContext
    .MergeCells = False
  End With
  
  With Selection.Validation
      .Delete
      .Add Type:=xlValidateInputOnly, AlertStyle:=xlValidAlertStop, Operator:=xlBetween
      .IgnoreBlank = True
      .InCellDropdown = True
      .InputTitle = ""
      .ErrorTitle = ""
      .InputMessage = ""
      .ErrorMessage = ""
      .IMEMode = xlIMEModeOn
      .ShowInput = True
      .ShowError = True
  End With
  
End Function


'***********************************************************************************************************************************************
' * ���l�̓��͋K��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetTestComment(RowCnt As Long, ColumnLoopName As Variant)

  Range(ColumnLoopName & "9:" & ColumnLoopName & RowCnt).Select
  With Selection.Validation
      .Delete
      .Add Type:=xlValidateInputOnly, AlertStyle:=xlValidAlertStop, Operator _
      :=xlBetween
      .IgnoreBlank = True
      .InCellDropdown = True
      .InputTitle = ""
      .ErrorTitle = ""
      .InputMessage = ""
      .ErrorMessage = ""
      .IMEMode = xlIMEModeOn
      .ShowInput = True
      .ShowError = True
  End With
  
  Selection.NumberFormatLocal = "G/�W��"
  With Selection
    .HorizontalAlignment = xlLeft
    .VerticalAlignment = xlCenter
    .WrapText = True
    .Orientation = 0
    .AddIndent = False
    .IndentLevel = 0
    .ShrinkToFit = False
    .ReadingOrder = xlContext
    .MergeCells = False
  End With
  
  With Selection.Font
    .Name = "���C���I"
    .Size = 8
  End With
End Function


'***********************************************************************************************************************************************
' * �s�̍����̒��߂ƃe�X�g���ʏW�v
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetResult()

  Dim RowCnt As Long
  Dim endLine As Long
  
  Dim TestCaseNo As Long
 
  ' ======================= �����J�n ======================
  Dim result As Boolean
   result = Library_CheckExcludeSheet(activeSheet.Name, 9)
  If result = False Then
    Exit Function
  End If
  
'  On Error GoTo ErrHand
  
  TestSpecification_Init
  Range("A1") = activeSheet.Name
  
  endLine = Cells(Rows.count, 5).End(xlUp).Row    ' �A�N�e�B�u�V�[�g�̍ŏI�s�擾
  
  TestCaseNo = 0
  
  ' �v���O���X�o�[�̕\���J�n
  ProgressBar_ProgShowStart
  Columns("D:E").ColumnWidth = 50
  
  ' �����ԍ����� ====================================================
  For RowCnt = 9 To endLine
    TestCaseNo = TestCaseNo + 1
    
  ' �區�ڂ̃e�X�g�P�[�X ============================================
    If Range("B" & RowCnt).Value <> "" Then
      TestSpecification_SetLineStyle1 (RowCnt)

  ' �����ڂ̃e�X�g�P�[�X ============================================
    ElseIf Range("C" & RowCnt).Value <> "" Then
      TestSpecification_SetLineStyle2 (RowCnt)

  ' �����ڂ̃e�X�g�P�[�X ============================================
    Else
      TestSpecification_SetLineStyle3 (RowCnt)
    End If

    ' �����ԍ��ݒ�
    Range("A" & RowCnt).NumberFormatLocal = "@"
    If SetTestCaseFlg And Range("A2").Value <> "" Then
      Range("A" & RowCnt).Value = Range("A2").Value & "-" & Format(TestCaseNo, "000")
    Else
      Range("A" & RowCnt).Value = Format(TestCaseNo, "000")
    End If

    ' �w�i�F�̃N���A
    Range("A" & RowCnt & ":BD" & RowCnt).Select
      With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With

      With Selection.Font
          .ColorIndex = xlAutomatic
          .TintAndShade = 0
      End With

    ' �v���O���X�o�[�̃J�E���g�ύX�i���݂̃J�E���g�A�S�J�E���g���A���b�Z�[�W�j
    ProgressBar_ProgShowCount "������", RowCnt, endLine, "�����ԍ��F" & Range("A" & RowCnt).Value
    
    
    ' �����̒���
    Call TestSpecification_setCellHeight(RowCnt)

      
    '�e�X�g���ʂ̐F�t�� ========================================================================================================
    Range("F" & RowCnt).Value = ""
    Range("F" & RowCnt).Value = TestSpecification_SetResultFlg(RowCnt)

  Next
  
  ' �ŏI�s�ݒ�
  TestSpecification_SetEndLineStyle (RowCnt - 1)
  
  '�e�X�g���ʂ̏W�v
  Range("F1").NumberFormatLocal = "@"
  Range("F2").NumberFormatLocal = "@"
  Range("F3").NumberFormatLocal = "@"
  Range("F4").NumberFormatLocal = "@"
  
  Range("F1").Value = endLine - 8
  Range("F2").Value = WorksheetFunction.CountIf(Range("F9:F" & endLine), "NG") & "/" & _
                      WorksheetFunction.CountIf(Range("F9:F" & endLine), "OK.")
  
  Range("F3").Value = WorksheetFunction.CountIf(Range("F9:F" & endLine), "OK") + _
                      WorksheetFunction.CountIf(Range("F9:F" & endLine), "OK.")
                      
  Range("F4").Value = WorksheetFunction.CountIf(Range("F9:F" & endLine), "") & "/" & _
                                  WorksheetFunction.CountIf(Range("F9:F" & endLine), "�ΏۊO") + _
                                  WorksheetFunction.CountIf(Range("F9:F" & endLine), "�������")

  
  
  Dim ColumLoopArray As Variant
  Dim ColumnLoopName As Variant
  ColumLoopArray = Array("G", "Q", "AA", "AK", "AU")
  For Each ColumnLoopName In ColumLoopArray
    If Range(ColumnLoopName & "9").Value = "" And ColumnLoopName <> "G" Then
      Exit For
    End If
    
    Range(ColumnLoopName & "1").NumberFormatLocal = "@"
    Range(ColumnLoopName & "2").NumberFormatLocal = "@"
    Range(ColumnLoopName & "3").NumberFormatLocal = "@"
    Range(ColumnLoopName & "4").NumberFormatLocal = "@"
    
    Range(ColumnLoopName & "1").Value = endLine - 8
    Range(ColumnLoopName & "2").Value = WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "NG") + _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "NG[�v���I]") + _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "NG[�d��]") + _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "NG[����]") + _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "NG[����I]") + _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "NG[�y��]") + _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "�C��OK") + _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "�m�FOK")
    
    Range(ColumnLoopName & "3").Value = WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "OK") & "/ " & _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "�C��OK") & "/ " & _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "�m�FOK")
                        
    Range(ColumnLoopName & "4").Value = WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "") & "/" & _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "�ΏۊO") + _
                                    WorksheetFunction.CountIf(Range(ColumnLoopName & "9:" & ColumnLoopName & endLine), "�������")

  Next

  If endLine <= 8 Then
    Range("F1").Value = 0
    Range("F2").Value = 0
    Range("F3").Value = 0
    Range("F4").Value = "0/0"
    For Each ColumnLoopName In ColumLoopArray
      Range(ColumnLoopName & "1").Value = 0
      Range(ColumnLoopName & "2").Value = 0
      Range(ColumnLoopName & "3").Value = "0/0/0"
      Range(ColumnLoopName & "4").Value = "0/0"
    Next
End If


  ' �v���O���X�o�[�̕\���I������
  ProgressBar_ProgShowClose
  
  '��ʂ̃Y�[�����x���ݒ�
  Range("A1").Select
  ActiveWindow.Zoom = WindowZoomLevel
  Erase ColumLoopArray
  
  ' ======================= ��ʕ`�ʐ���I�� ======================
  
  Range(SetActiveCell).Activate
    
Exit Function

' ======================= �G���[�������̏��� ======================
ErrHand:
  
  Erase ColumLoopArray
  
  Range(SetActiveCell).Select
  
  ' �v���O���X�o�[�̕\���I������
  ProgressBar_ProgShowClose

  Call Library_ErrorHandle(Err.Number, Err.Description)
End Function


'***********************************************************************************************************************************************
' * �������ʔ���
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetResultFlg(RowCnt As Long)

  Dim CheckFlg As String
  Dim ResultValue As String

  CheckFlg = False

  If Range("AU" & RowCnt).Value <> "" Then
    ResultValue = Range("AU" & RowCnt).Value
  ElseIf Range("AK" & RowCnt).Value <> "" Then
    ResultValue = Range("AK" & RowCnt).Value
  ElseIf Range("AA" & RowCnt).Value <> "" Then
    ResultValue = Range("AA" & RowCnt).Value
  ElseIf Range("Q" & RowCnt).Value <> "" Then
    ResultValue = Range("Q" & RowCnt).Value
  ElseIf Range("G" & RowCnt).Value <> "" Then
    ResultValue = Range("G" & RowCnt).Value
  End If
  
  Range("F" & RowCnt & ":F" & RowCnt).Select
  
  Select Case ResultValue
    Case "�ΏۊO", "�������"
      Range("A" & RowCnt & ",D" & RowCnt & ":BD" & RowCnt).Select
      
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E13").Interior.color  'RGB(255, 204, 204)
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E13").Font.color
        .TintAndShade = 0
      End With
      CheckFlg = "�ΏۊO"
        
    Case "NG[�v���I]"
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E15").Interior.color   'RGB(255, 0, 0)
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E15").Font.color
        .TintAndShade = 0
      End With
      CheckFlg = "NG"
        
    Case "NG[�d��]"
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E16").Interior.color  'RGB(255, 51, 51)
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E16").Font.color
        .TintAndShade = 0
      End With
      CheckFlg = "NG"
        
    Case "NG"
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E17").Interior.color  'RGB(255, 102, 102)
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E17").Font.color
        .TintAndShade = 0
      End With
      CheckFlg = "NG"
        
    Case "NG[����I]"
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E18").Interior.color  'RGB(255, 153, 153)
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E18").Font.color
        .TintAndShade = 0
      End With
     CheckFlg = "NG"

    Case "NG[�y��]"
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E19").Interior.color  'RGB(255, 204, 204)
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E19").Font.color
        .TintAndShade = 0
      End With
      CheckFlg = "NG"
    

    Case "OK"
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E14").Interior.color
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E14").Font.color
        .TintAndShade = 0
      End With
      CheckFlg = "OK"
    
    Case "�C��OK"
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E20").Interior.color
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E20").Font.color
        .TintAndShade = 0
      End With
      CheckFlg = "OK."
    
    Case "�m�FOK"
      With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .color = Worksheets("�ݒ�").Range("E21").Interior.color
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      With Selection.Font
        .color = Worksheets("�ݒ�").Range("E21").Font.color
        .TintAndShade = 0
      End With
      CheckFlg = "OK."
    
    Case ""
      With Range("F" & RowCnt).Font
        .ColorIndex = xlAutomatic
        .TintAndShade = 0
        .Bold = False
      End With
      With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      CheckFlg = ""
      
      
    Case Else
      With Range("F" & RowCnt).Font
        .ColorIndex = xlAutomatic
        .TintAndShade = 0
        .Bold = False
      End With
      With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
      End With
      CheckFlg = "OK"
  End Select
  TestSpecification_SetResultFlg = CheckFlg
End Function


'***********************************************************************************************************************************************
' * �o�O�Ȑ�����
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_MakeGompertzCurve()

  Dim endLine As Long
  Dim sheetName As Object
  Dim result As Boolean
  Dim GrafCount As Long

  Dim SheetCount As Long
  Dim SheetCountOK As Long
  Dim SheetCountNG As Long
  Dim SheetCountNotTest As Long
  Dim SheetCountNotTestStr As String

  Dim AllCount As Long
  Dim AllCountOK As Long
  Dim AllCountNG As Long
  Dim AllCountNotTest As Long
  
  Dim TesterLineCount As Long
  
  Dim ColumLoopCount As Long
  Dim ColumnLoopName As String
      
  ' ======================= �����J�n ======================
'  On Error GoTo ErrHand
  GrafCount = 0
  
  TestSpecification_Init
  
  Worksheets("��������").Select
  Worksheets("��������").Range("A1").Select
  TesterLineCount = 33
  
  
  If Not BeforeCloseFlg Then
    CheckRecal = MsgBox("�Čv�Z���s���܂����H", vbYesNo + vbQuestion, "�m�F")
  Else
    CheckRecal = vbYes
  End If
  
  For Each sheetName In ActiveWorkbook.Sheets
    
    ' ���ʌv�Z�̍Ď��s
    result = Library_CheckExcludeSheet(sheetName.Name, 9)
    
    If result = True Then
      Worksheets(sheetName.Name).Activate
      Range("A1") = activeSheet.Name
      
      ' ======================= �e�X�^�[��񒊏o ======================
      Worksheets("��������").Activate
      With Worksheets("��������").Range("H" & TesterLineCount)
        .Value = sheetName.Name
        .Select
        .Hyperlinks.Add Anchor:=Selection, Address:="", SubAddress:=sheetName.Name & "!" & "A9"
        .Font.color = RGB(0, 0, 0)
        .Font.Underline = False
        .Font.Size = 10
        .Font.Name = "Meiryo UI"
      End With


      Worksheets(sheetName.Name).Activate
      For ColumLoopCount = 13 To Worksheets("��������").Cells(32, Columns.count).End(xlToLeft).Column Step 1
        ColumnLoopName = Library_getColumnName(ColumLoopCount)
        If Worksheets("��������").Range(ColumnLoopName & "32").Value <> "" Then
          Worksheets("��������").Range(ColumnLoopName & TesterLineCount).Value = _
              WorksheetFunction.CountIf(Range("I:I"), Worksheets("��������").Range(ColumnLoopName & "32").Value)
        End If
      Next
      
      ' ======================= �o�O�Ȑ���񒊏o ======================
      If CheckRecal = vbYes Then
        TestSpecification_SetResult
      End If
      SheetCount = Range("F1").Value
      tmp = Split(Range("F2").Value, "/")
      SheetCountNG = val(tmp(0)) + val(tmp(1))
      SheetCountNGOK = val(tmp(1))

      SheetCountOK = Range("F3").Value
      SheetCountNotTestStr = Range("F4").Value
      tmp = Split(SheetCountNotTestStr, "/")
      SheetCountNotTest = val(tmp(0))
      SheetCountNotTestCase = val(tmp(1))
    
      AllCount = AllCount + SheetCount
      AllCountOK = AllCountOK + SheetCountOK
      AllCountNG = AllCountNG + SheetCountNG
      AllCountNotTest = AllCountNotTest + SheetCountNotTest
      AllCountNotTestCase = AllCountNotTestCase + SheetCountNotTestCase
        
    
      '�e�X�g�P�[�X����
      Worksheets("��������").Range("I" & TesterLineCount).Value = SheetCountOK
      Worksheets("��������").Range("J" & TesterLineCount).Value = SheetCountNG
      Worksheets("��������").Range("K" & TesterLineCount).Value = SheetCountNotTest
      Worksheets("��������").Range("L" & TesterLineCount).Value = SheetCount
      
'      If SheetCount = (SheetCountOK + SheetCountNotTest) Then
'        Worksheets("��������").Activate
'        Range("H" & TesterLineCount & ":" & ColumnLoopName & TesterLineCount).Select
'        With Selection.Interior
'          .Color = RGB(222, 222, 222)
'        End With
'      End If
      
      '����NG���v�Z
'      Public SheetNGCountRuikei As Object
'      Dim TestCount As Long
'      Dim ColumLoopArray As Variant
'      Dim ColumnLoopName As Variant
'
'      ColumLoopArray = Array("H", "R", "", "", "")
'      Set SheetNGCountRuikei = CreateObject("Scripting.Dictionary")
'      Endline = Cells(Rows.Count, 1).End(xlUp).Row
'      TestCount = Worksheets("��������").Range("B31").Value
  
      TesterLineCount = TesterLineCount + 1
    End If
  Next
  
  Worksheets("��������").Select
    
  '�I���Z���̍s�w�i�ݒ�
  Call Library_SetLineColor("H33:" & ColumnLoopName & TesterLineCount, True, SetLineColorValue)
  
  '���v�Z�o
  Range("H" & TesterLineCount) = "���v"
  For ColumLoopCount = 9 To Worksheets("��������").Cells(32, Columns.count).End(xlToLeft).Column Step 1
    ColumnLoopName = Library_getColumnName(ColumLoopCount)
    If ColumnLoopName <> "L" Then
      Range(ColumnLoopName & TesterLineCount) = "=SUM(" & ColumnLoopName & "33:" & ColumnLoopName & TesterLineCount - 1 & ")"
    End If
  Next
  
  '�r��
  Range("H32" & ":" & ColumnLoopName & TesterLineCount).Select
  Selection.Borders(xlDiagonalDown).LineStyle = xlNone
  Selection.Borders(xlDiagonalUp).LineStyle = xlNone
  With Selection.Borders(xlEdgeLeft)
      .LineStyle = xlContinuous
      .ColorIndex = 0
      .TintAndShade = 0
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeTop)
      .LineStyle = xlContinuous
      .ColorIndex = 0
      .TintAndShade = 0
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeBottom)
      .LineStyle = xlContinuous
      .ColorIndex = 0
      .TintAndShade = 0
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeRight)
      .LineStyle = xlContinuous
      .ColorIndex = 0
      .TintAndShade = 0
      .Weight = xlThin
  End With
  With Selection.Borders(xlInsideVertical)
      .LineStyle = xlContinuous
      .ColorIndex = 0
      .TintAndShade = 0
      .Weight = xlThin
  End With
  With Selection.Borders(xlInsideHorizontal)
      .LineStyle = xlContinuous
      .ColorIndex = 0
      .TintAndShade = 0
      .Weight = xlHairline
  End With
  
  ' ���v�s�̌r��
  Range("H" & TesterLineCount & ":" & ColumnLoopName & TesterLineCount).Select

  With Selection.Borders(xlEdgeTop)
    .LineStyle = xlDouble
    .ColorIndex = xlAutomatic
    .TintAndShade = 0
    .Weight = xlThick
  End With

  endLine = Cells(Rows.count, 1).End(xlUp).Row
  If Range("A" & endLine).Value = "���{��" Then
    endLine = endLine + 1
  End If
  
  'OK��1���Ȃ���΍ŏI�s���㏑��
  If (AllCountOK < 0 And AllCountNG < 0) Then
    endLine = endLine
  ElseIf Format(Range("A" & endLine).Value, "yyyy/mm/dd") <> Format(Date, "yyyy/mm/dd") Then
    endLine = endLine + 1
  
  End If
  
  Range("A" & endLine).Value = Format(Date, "yyyy/mm/dd")
  Range("A" & endLine).NumberFormatLocal = "mm/dd"
  Range("B" & endLine).Value = AllCount
  Range("C" & endLine).Value = AllCountOK
  Range("D" & endLine).Value = AllCountNG
  Range("E" & endLine).Value = AllCountNotTest
  Range("F" & endLine).Value = AllCountNotTestCase
  

  Range("A" & endLine & ":" & "F" & endLine).Select
  Selection.Borders(xlDiagonalDown).LineStyle = xlNone
  Selection.Borders(xlDiagonalUp).LineStyle = xlNone
  With Selection.Borders(xlEdgeLeft)
      .LineStyle = xlContinuous
      .ColorIndex = xlAutomatic
      .TintAndShade = 0
      .Weight = xlThin
  End With
  With Selection.Borders(xlEdgeTop)
      .LineStyle = xlContinuous
      .ColorIndex = xlAutomatic
      .TintAndShade = 0
      .Weight = xlHairline
  End With
  With Selection.Borders(xlEdgeBottom)
      .LineStyle = xlContinuous
      .ColorIndex = xlAutomatic
      .TintAndShade = 0
      .Weight = xlHairline
  End With
  With Selection.Borders(xlEdgeRight)
      .LineStyle = xlContinuous
      .ColorIndex = xlAutomatic
      .TintAndShade = 0
      .Weight = xlThin
  End With
  With Selection.Borders(xlInsideVertical)
      .LineStyle = xlContinuous
      .ColorIndex = xlAutomatic
      .TintAndShade = 0
      .Weight = xlThin
  End With
  Selection.Borders(xlInsideHorizontal).LineStyle = xlNone



  '-----------------------------------------------------------------------------------------
  ' �A�N�e�B�u�V�[�g��Ɋ����̃O���t������΍폜
  If activeSheet.ChartObjects.count > 0 Then
    For i = 1 To activeSheet.ChartObjects.count
      ' �O���t������v���邩
      If activeSheet.ChartObjects(i).Name = "GompertzCurve" Then
        activeSheet.ChartObjects(i).Delete
        Exit For
      End If
    Next i
  End If
  
  Set chartObj = activeSheet.ChartObjects.Add(20, 20, 1000, 500)
  chartObj.Name = "GompertzCurve"
    With chartObj.Chart
      .ChartType = xlXYScatterSmoothNoMarkers
'      .Axes(xlValue).MajorUnit = 10

      .Axes(xlValue).HasMajorGridlines = True
      .Axes(xlValue).MajorGridlines.Border.LineStyle = xlContinuous
      .Axes(xlValue).MajorGridlines.Border.color = RGB(144, 136, 136)
      
      .Axes(xlValue).HasMinorGridlines = True
      .Axes(xlValue).MinorGridlines.Border.LineStyle = xlDot
      .Axes(xlValue).MinorGridlines.Border.Weight = xlHairline
      .Axes(xlValue).MinorGridlines.Border.color = RGB(222, 222, 222)
      
      .Axes(xlCategory).HasMajorGridlines = True
      .Axes(xlCategory).MajorGridlines.Border.LineStyle = xlContinuous
      .Axes(xlCategory).MinorGridlines.Border.color = RGB(144, 136, 136)

      .Axes(xlCategory).HasMinorGridlines = True
      .Axes(xlCategory).MinorGridlines.Border.LineStyle = xlDot
      .Axes(xlCategory).MinorGridlines.Border.Weight = xlHairline
      .Axes(xlCategory).MinorGridlines.Border.color = RGB(222, 222, 222)
      
      .Axes(xlCategory).MinimumScale = Range("A33").Value
      .Axes(xlCategory).MaximumScale = Range("A" & endLine).Value + 8
      
      .Axes(xlValue).MinimumScale = 0
      .Axes(xlValue).MaximumScale = WorksheetFunction.Round(Range("B" & endLine).Value + 10, -1)
      

'      GrafCount = GrafCount + 1
'      .SeriesCollection.NewSeries
'      .SeriesCollection(GrafCount).Name = "=""OK��(����)"""
'      .SeriesCollection(GrafCount).XValues = "='��������'!$A$33:$A$" & endLine
'      .SeriesCollection(GrafCount).Values = "='��������'!$C$33:$C$" & endLine
'      .SeriesCollection(GrafCount).ChartType = xlXYScatterSmoothNoMarkers
'      .SeriesCollection(GrafCount).Border.Weight = xlThin
'      .SeriesCollection(GrafCount).Border.Color = RGB(0, 0, 255)
'
'       GrafCount = GrafCount + 1
'      .SeriesCollection.NewSeries
'      .SeriesCollection(GrafCount).Name = "=""OK��"""
'      .SeriesCollection(GrafCount).XValues = "='��������'!$A$33:$A$" & endLine
'      .SeriesCollection(GrafCount).Values = "='��������'!$C$33:$C$" & endLine
'      .SeriesCollection(GrafCount).ChartType = xlXYScatterLinesNoMarkers
'      .SeriesCollection(GrafCount).Border.LineStyle = xlDot
'      .SeriesCollection(GrafCount).Border.Weight = xlThin
'      .SeriesCollection(GrafCount).Border.Color = RGB(0, 0, 150)

      GrafCount = GrafCount + 1
      .SeriesCollection.NewSeries
      .SeriesCollection(GrafCount).Name = "=""NG��"""
      .SeriesCollection(GrafCount).XValues = "='��������'!$A$33:$A$" & endLine
      .SeriesCollection(GrafCount).Values = "='��������'!$D$33:$D$" & endLine
      .SeriesCollection(GrafCount).ChartType = xlXYScatterSmoothNoMarkers
      .SeriesCollection(GrafCount).Border.Weight = xlThin
      .SeriesCollection(GrafCount).Border.color = RGB(255, 0, 0)
      
      GrafCount = GrafCount + 1
      .SeriesCollection.NewSeries
      .SeriesCollection(GrafCount).Name = "=""NG��(����)"""
      .SeriesCollection(GrafCount).XValues = "='��������'!$A$33:$A$" & endLine
      .SeriesCollection(GrafCount).Values = "='��������'!$D$33:$D$" & endLine
      .SeriesCollection(GrafCount).ChartType = xlXYScatterLinesNoMarkers
      .SeriesCollection(GrafCount).Border.LineStyle = xlDot
      .SeriesCollection(GrafCount).Border.Weight = xlThin
      .SeriesCollection(GrafCount).Border.color = RGB(150, 0, 0)

      GrafCount = GrafCount + 1
      .SeriesCollection.NewSeries
      .SeriesCollection(GrafCount).Name = "=""�����{"""
      .SeriesCollection(GrafCount).XValues = "='��������'!$A$33:$A$" & endLine
      .SeriesCollection(GrafCount).Values = "='��������'!$E$33:$E$" & endLine
      .SeriesCollection(GrafCount).ChartType = xlXYScatterSmoothNoMarkers
      .SeriesCollection(GrafCount).Border.Weight = xlThin
      .SeriesCollection(GrafCount).Border.color = RGB(192, 192, 131)

      GrafCount = GrafCount + 1
      .SeriesCollection.NewSeries
      .SeriesCollection(GrafCount).Name = "=""�����{(����)"""
      .SeriesCollection(GrafCount).XValues = "='��������'!$A$33:$A$" & endLine
      .SeriesCollection(GrafCount).Values = "='��������'!$E$33:$E$" & endLine
      .SeriesCollection(GrafCount).ChartType = xlXYScatterLinesNoMarkers
      .SeriesCollection(GrafCount).Border.LineStyle = xlDot
      .SeriesCollection(GrafCount).Border.Weight = xlThin
      .SeriesCollection(GrafCount).Border.color = RGB(0, 0, 150)

  End With

  Worksheets(SetActiveSheet).Select
  Range(SetActiveCell).Select
  If Not BeforeCloseFlg Then
    Worksheets("��������").Select
  End If

  
  
  Range("H32").Select
Exit Function

ErrHand:
  
  ' �v���O���X�o�[�̕\���I������
  
  ProgressBar_ProgShowClose
  
  If Not BeforeCloseFlg Then
    Worksheets("��������").Select
  End If
  
  Call Library_ErrorHandle(Err.Number, Err.Description)

End Function

'***********************************************************************************************************************************************
' * �S�V�[�g�ݒ�Z����I����Ԃɂ���
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_SetCellActive(targetCell As String)

  Dim sheetName As Object
  Dim result As Boolean

  
  ' ======================= �����J�n ======================
  
  TestSpecification_Init
  
  For Each sheetName In ActiveWorkbook.Sheets

    Worksheets(sheetName.Name).Select
  
    ' �e�X�g�P�[�X�p�̃V�[�g���ǂ����`�F�b�N
    result = Library_CheckExcludeSheet(sheetName.Name, 9)
    If result = True Then
      Application.Goto Reference:=Range(targetCell), Scroll:=True
    End If
  Next
  
  Worksheets(SetActiveSheet).Select
  

End Function

'***********************************************************************************************************************************************
' * �Z���̃X�^�C���ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Sub TestSpecification_SetCellStyles()

  Dim n()
  Dim CheckFlg As Boolean
  Dim ColumLoopArray As Variant
  Dim ColumnLoopName As Variant
  
  On Error GoTo ErrHand
  CheckFlg = False
  
  
  ColumLoopArray = Array("�ʉ�", "�p�[�Z���g", """����", "���V�X�e���A��", "����")
  
  j = ActiveWorkbook.Styles.count
  ReDim n(j)
  For i = 1 To j
    n(i) = ActiveWorkbook.Styles(i).Name
  Next
  For i = 1 To j
    For Each ColumnLoopName In ColumLoopArray
      If n(i) <> ColumnLoopName Then
        ActiveWorkbook.Styles(n(i)).Delete
      Else
        CheckFlg = True
    End If
  Next

  If CheckFlg = False Then
    ActiveWorkbook.Styles.Add Name:="����"
    ActiveWorkbook.Styles.Add Name:="���V�X�e���A��"
    ActiveWorkbook.Styles.Add Name:="����"
  End If

  With ActiveWorkbook.Styles("Normal")
    .IncludeNumber = False
    .IncludeFont = True
    .IncludeAlignment = False
    .IncludeBorder = False
    .IncludePatterns = False
    .IncludeProtection = False
        
    .Font.Name = "Meiryo UI"
    .Font.Size = 9
    .Font.Bold = False
    .Font.Italic = False
    .Font.Underline = xlUnderlineStyleNone
    .Font.Strikethrough = False
    .Font.color = RGB(0, 0, 0)
    .Font.TintAndShade = 0
    .Font.ThemeFont = xlThemeFontNone
  End With
  
  
    With ActiveWorkbook.Styles("����")
      .IncludeNumber = False
      .IncludeFont = True
      .IncludeAlignment = False
      .IncludeBorder = False
      .IncludePatterns = False
      .IncludeProtection = False
      
      .Font.Name = "Meiryo UI"
      .Font.Size = 9
      .Font.Bold = False
      .Font.Italic = False
      .Font.Underline = xlUnderlineStyleNone
      .Font.Strikethrough = False
      .Font.color = RGB(0, 0, 255)
      .Font.TintAndShade = 0
      .Font.ThemeFont = xlThemeFontNone
    End With

  
    With ActiveWorkbook.Styles("���V�X�e���A��")
      .IncludeNumber = False
      .IncludeFont = True
      .IncludeAlignment = False
      .IncludeBorder = False
      .IncludePatterns = True
      .IncludeProtection = False
      
      .Interior.color = RGB(252, 204, 204)
      .Interior.Pattern = xlSolid
      
      .Font.Name = "Meiryo UI"
      .Font.Size = 9
      .Font.Bold = False
      .Font.Italic = False
      .Font.Underline = xlUnderlineStyleNone
      .Font.Strikethrough = False
      .Font.color = RGB(0, 0, 0)
      .Font.TintAndShade = 0
      .Font.ThemeFont = xlThemeFontNone
    End With

    With ActiveWorkbook.Styles("����")
      .IncludeNumber = False
      .IncludeFont = True
      .IncludeAlignment = False
      .IncludeBorder = False
      .IncludePatterns = True
      .IncludeProtection = False
      .Font.Name = "Meiryo UI"
      .Font.Size = 9
      .Font.Bold = True
      .Font.Italic = False
      .Font.Underline = xlUnderlineStyleNone
      .Font.Strikethrough = False
      .Font.ThemeColor = 1
      .Font.TintAndShade = 0
      .Font.ThemeFont = xlThemeFontNone
      .Interior.Pattern = xlSolid
      .Interior.PatternColorIndex = 0
      .Interior.color = 255
      .Interior.TintAndShade = 0
      .Interior.PatternTintAndShade = 0
    End With
  Exit Sub
  
ErrHand:
  Resume Next
End Sub


'***********************************************************************************************************************************************
' * �X�e�[�^�X�o�[�Ƀe�X�g���ʂ�\������
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_DisplayStatusBar()

  Dim MsgString As String
  Dim result As Boolean
  
  Dim SheetCount As Long
  Dim SheetCountOK As Long
  Dim SheetCountNG As Long
  Dim SheetCountNotTest As Long
  Dim SheetCountNotTestStr As String
  
  Application.StatusBar = False
  
  result = Library_CheckExcludeSheet(activeSheet.Name, 8)
  
  
  If result = False Then
    Exit Function
  End If
   Exit Function
  
  SheetCount = Range("F1").Value
  tmp = Split(Range("F2").Value, "/")
  SheetCountNG = val(tmp(0))

  SheetCountOK = Range("F3").Value
  SheetCountNotTestStr = Range("F4").Value
  
  If SheetCount < 0 Then
    Exit Function
  End If
  
  tmp = Split(SheetCountNotTestStr, "/")
  SheetCountNotTest = val(tmp(0))
  
  MsgString = "�S����:" & SheetCount
  MsgString = MsgString & "�@NG����:" & SheetCountNG
  MsgString = MsgString & "�@OK����:" & SheetCountOK
  MsgString = MsgString & "�@�����{:" & SheetCountNotTest

  If SheetCountOK > 0 And SheetCountNotTest > 0 Then
    Application.StatusBar = MsgString
  ElseIf SheetCountNotTest = 0 Then
    Application.StatusBar = "�e�X�g����"
  End If
End Function


'***********************************************************************************************************************************************
' * �����̒���
' *
' * @param  Long  RowCnt     �F��ԍ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'***********************************************************************************************************************************************
Function TestSpecification_setCellHeight(RowCnt As Long)
    '
  Rows(RowCnt & ":" & RowCnt).EntireRow.AutoFit
  If Rows(RowCnt & ":" & RowCnt).Height < SetRowHeight Then
    Rows(RowCnt & ":" & RowCnt).RowHeight = SetRowHeight + SetAddRowHeight
  Else
    Rows(RowCnt & ":" & RowCnt).RowHeight = Rows(RowCnt & ":" & RowCnt).Height + SetAddRowHeight
  End If
  If Len(Range("D" & RowCnt).Value) = 58 Or Len(Range("E" & RowCnt).Value) = 58 Then
    Rows(RowCnt & ":" & RowCnt).RowHeight = Rows(RowCnt & ":" & RowCnt).Height + SetRowHeight + SetAddRowHeight
  End If
End Function

