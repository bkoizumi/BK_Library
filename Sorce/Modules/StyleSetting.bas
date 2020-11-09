Attribute VB_Name = "StyleSetting"
Function StyleSetting_Sheet()

  Dim line As Integer
 
  Columns("A:A").ColumnWidth = 1
  Columns("B:B").ColumnWidth = 5
  Columns("C:C").ColumnWidth = 15
  Columns("D:D").ColumnWidth = 25
  Columns("E:E").ColumnWidth = 25
  Columns("F:F").ColumnWidth = 10
  Columns("G:G").ColumnWidth = 13.29
  Columns("H:H").ColumnWidth = 11.13
  Columns("J:J").ColumnWidth = 2.25
  Columns("K:K").ColumnWidth = 2.25
  Columns("L:L").ColumnWidth = 2.25
  Columns("M:M").ColumnWidth = 2.25
  Columns("N:N").ColumnWidth = 2.25
  Columns("O:O").ColumnWidth = 11.38
  Columns("P:U").ColumnWidth = 12.75

  For line = 9 To 108
    Range("C" & line).Value = StyleSetting_han2zen(Range("C" & line).Value)
    Range("Q" & line).Value = StyleSetting_han2zen(Range("Q" & line).Value)
    
    Range("O" & line).Value = Replace(Range("O" & line).Value, "NOT NULL", "1")
    
    If Range("G" & line).Value = "numeric" Then
      If InStr(Range("H" & line).Value, ",") = 0 Then
        Range("H" & line).Select
        Selection.Style = "����"
      End If
    End If
    
    
  Next line

End Function


Function StyleSetting_Cell()


  Selection.RowHeight = Selection.RowHeight + 20





End Function



Sub ����͈͐ݒ�()

  On Error GoTo ErrHand
  
  Dim endLine As Integer
  Dim PageCnt As Integer
  Dim OnePageRow As Integer
  Dim RowCnt As Integer
  Dim ThisActiveSheetName As String
  Dim WindowZoomLevel As Integer
  
  WindowZoomLevel = ActiveWindow.Zoom
  
  ThisActiveSheetName = activeSheet.Name
  
  endLine = activeSheet.Cells(Rows.count, 2).End(xlUp).Row
  OnePageRow = 30
  PageCnt = 1
  
  ' ======================= �����J�n ======================
  '���y�[�W�v���r���[
  ActiveWindow.View = xlPageBreakPreview
  
  '���ׂẲ��y�[�W������
  activeSheet.ResetAllPageBreaks
  
  '����͈͂��N���A����
  activeSheet.PageSetup.PrintArea = ""
  
  '����͈͂̏ڍאݒ�
  With activeSheet.PageSetup
    .RightFooter = "&""Arial,�W��""&8Sharp Business Solutions Corporation"
    .CenterFooter = "&P / &N"
'    .PrintTitleRows = "$2:$8"                 '�s�^�C�g��
    .PrintArea = "$B$2:$U$" & endLine
    .BlackAndWhite = False                    '������� True:����  False:���Ȃ�
    .Zoom = False                             '�g��E�k�������w�肵�Ȃ�
    .FitToPagesTall = False                   '�c�����͎w�肵�Ȃ�
    .FitToPagesWide = 1                       '������1�y�[�W�ň��
    
    .TopMargin = Application.CentimetersToPoints(1.5)       '��]��
    .BottomMargin = Application.CentimetersToPoints(1.5)    '���]��
    .LeftMargin = Application.CentimetersToPoints(1)        '���]��
    .RightMargin = Application.CentimetersToPoints(1)       '�E�]��
    .HeaderMargin = Application.CentimetersToPoints(0.8)    '�w�b�_�[�]��
    .FooterMargin = Application.CentimetersToPoints(0.7)    '�t�b�^�[�]��
  End With

  '�W����ʂɖ߂�
'  ActiveWindow.View = xlNormalView
  ActiveWindow.Zoom = 80
  Range("A1").Select
Exit Sub

ErrHand:
  ActiveWindow.View = xlNormalView
  ActiveWindow.Zoom = WindowZoomLevel
End Sub


Function StyleSetting_han2zen(Text As String)


  Dim c As Range
  Dim i As Integer
  Dim rData As Variant, ansData As Variant

  ansData = ""
  
  For i = 1 To Len(Text)
    rData = StrConv(Text, vbWide)
    If Mid(rData, i, 1) Like "[�`-��]" Or Mid(rData, i, 1) Like "[�O-�X]" Or Mid(rData, i, 1) Like "�|" Then
      ansData = ansData & StrConv(Mid(rData, i, 1), vbNarrow)
    Else
     ansData = ansData & Mid(rData, i, 1)
    End If
    
    
    ansData = Replace(ansData, "�i", "(")
    ansData = Replace(ansData, "�j", ")")
    ansData = Replace(ansData, ":", "�F")
    ansData = Replace(ansData, "::", "�F")
    ansData = Replace(ansData, "()", "")
    'ansData = Replace(ansData, "�@", "�A")

  Next i
 
  StyleSetting_han2zen = ansData

End Function
