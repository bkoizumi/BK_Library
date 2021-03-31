Attribute VB_Name = "Main"
'ワークブック用変数------------------------------
'ワークシート用変数------------------------------
'グローバル変数----------------------------------


'**************************************************************************************************
' * オプション画面表示
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function オプション画面表示()
  
'  On Error GoTo catchError
  
  With Frm_Option
    .StartUpPosition = 0
    .Top = Application.Top + (ActiveWindow.Width / 4)
    .Left = Application.Left + (ActiveWindow.Height / 2)
    .Show
  End With

  Exit Function

'エラー発生時=====================================================================================
catchError:
  'Call Library.showNotice(Err.Number, Err.Description, True)
End Function


'**************************************************************************************************
' * 標準画面
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function 標準画面()
  Dim objSheet As Object
  Dim sheetName As String, SetActiveSheet As String
  
  
  'On Error Resume Next
  
  Call Library.startScript
  Call Ctl_ProgressBar.showStart
  
  SetActiveSheet = ActiveWorkbook.ActiveSheet.Name
  SelectAddress = Selection.Address
  
  For Each objSheet In ActiveWorkbook.Sheets
    sheetName = objSheet.Name
    Call Ctl_ProgressBar.showCount("標準画面設定", 1, 100, sheetName)
    If Worksheets(sheetName).Visible = True Then
      Worksheets(sheetName).Select
      
      '標準画面に設定
      ActiveWindow.View = xlNormalView
      
      '表示倍率の指定
      ActiveWindow.Zoom = Library.getRegistry("zoomLevel")
      
      'ガイドラインの表示/非表示
      ActiveWindow.DisplayGridlines = Library.getRegistry("gridLine")
  
      '背景白をなしにする
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
' * スタイル削除
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function スタイル削除()
  Dim s
  Dim count As Long, endCount As Long
  Dim line As Long, endLine As Long
  
  On Error Resume Next
  
  Call Library.startScript
  Call init.setting
  
  count = 1
  Call Ctl_ProgressBar.showStart
  endCount = ActiveWorkbook.Styles.count
  
  For Each s In ActiveWorkbook.Styles
    Call Ctl_ProgressBar.showCount("定義済スタイル削除", count, endCount, s.Name)
    
    Select Case s.Name
      Case "Normal"
      Case Else
        s.delete
    End Select
    count = count + 1
  Next
  
  'スタイル初期化
  endLine = sheetStyle.Cells(Rows.count, 2).End(xlUp).row
  For line = 2 To endLine
    If sheetStyle.Range("A" & line) <> "無効" Then
      Call Ctl_ProgressBar.showCount("スタイル初期化", line, endLine, sheetStyle.Range("B" & line))
      
      If sheetStyle.Range("B" & line) <> "Normal" Then
        ActiveWorkbook.Styles.add Name:=sheetStyle.Range("B" & line).Value
      End If
      
      With ActiveWorkbook.Styles(sheetStyle.Range("B" & line).Value)
        
        If sheetStyle.Range("C" & line) <> "" Then
          .NumberFormatLocal = sheetStyle.Range("C" & line)
        End If
        .IncludeNumber = sheetStyle.Range("D" & line)
        .IncludeFont = sheetStyle.Range("E" & line)
        .IncludeAlignment = sheetStyle.Range("F" & line)
        .IncludeBorder = sheetStyle.Range("G" & line)
        .IncludePatterns = sheetStyle.Range("H" & line)
        .IncludeProtection = sheetStyle.Range("I" & line)
        
        If sheetStyle.Range("E" & line) = "TRUE" Then
          .Font.Name = sheetStyle.Range("J" & line).Font.Name
          .Font.Size = sheetStyle.Range("J" & line).Font.Size
          .Font.Color = sheetStyle.Range("J" & line).Font.Color
          .Font.Bold = sheetStyle.Range("J" & line).Font.Bold
        End If
        
        '背景色
        If sheetStyle.Range("H" & line) = "TRUE" Then
          .Interior.Color = sheetStyle.Range("J" & line).Interior.Color
        End If
        
        
      End With
    End If
  Next
  
  Call Ctl_ProgressBar.showEnd
  Call Library.endScript

End Function


'**************************************************************************************************
' * 名前定義削除
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function 名前定義削除()
  Dim wb As Workbook, tmp As String
  
  Call Library.startScript
  
  For Each wb In Workbooks
    Workbooks(wb.Name).Activate
    Call Library.delVisibleNames
  Next wb
  
  Call Library.endScript

End Function


'**************************************************************************************************
' * 画像設定
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function 画像設定()

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
' * R1C1表記
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function R1C1表記()

  On Error Resume Next
  
  If Application.ReferenceStyle = xlA1 Then
    Application.ReferenceStyle = xlR1C1
  Else
    Application.ReferenceStyle = xlA1
  End If
  
End Function


'**************************************************************************************************
' * ハイライト
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function ハイライト()
  Dim highLightFlg As Boolean
  Dim highLightArea As String

  Call Library.startScript
  highLightFlg = Library.getRegistry("HighLightFlg")
  
  If highLightFlg = False Then
    Call Library.setLineColor(Selection.Address, True, Library.getRegistry("HighLightColor"))
    
    Call Library.setRegistry("HighLightFlg", True)
    
    Call Library.setRegistry("HighLightBook", ActiveWorkbook.Name)
    Call Library.setRegistry("HighLightSheet", ActiveSheet.Name)
    Call Library.setRegistry("HighLightArea", Selection.Address)
    
  Else
    highLightArea = Library.getRegistry("HighLightArea")
    Call Library.unsetLineColor(highLightArea)
    
    Call Library.setRegistry("HighLightFlg", False)
    Call Library.setRegistry("HighLightBook", "")
    Call Library.setRegistry("HighLightSheet", "")
    Call Library.setRegistry("HighLightArea", "")
  End If
  
  Call Library.endScript(True)
End Function



'**************************************************************************************************
' * 罫線設定
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function 罫線_削除()
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

Function 罫線_表()
  Call Library.罫線_表
  
End Function


Function 罫線_破線_水平()
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  
  With Selection
    .Borders(xlInsideHorizontal).LineStyle = xlNone
    .Borders(xlInsideHorizontal).LineStyle = xlDash
    .Borders(xlInsideHorizontal).Weight = xlHairline
    .Borders(xlInsideHorizontal).Color = RGB(Red, Green, Blue)
    
    End With
End Function


Function 罫線_破線_垂直()
  Dim Red As Long, Green As Long, Blue As Long
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlInsideVertical).LineStyle = xlNone
    .Borders(xlInsideVertical).LineStyle = xlDash
    .Borders(xlInsideVertical).Weight = xlHairline
    .Borders(xlInsideVertical).Color = RGB(Red, Green, Blue)
  End With
End Function

Function 罫線_破線_左右()
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


Function 罫線_破線_上下()
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


Function 罫線_破線_囲み()
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

Function 罫線_破線_格子()
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


Function 罫線_実線_囲み()
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


Function 罫線_二重線_左右()
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlEdgeLeft).LineStyle = xlDouble
    .Borders(xlEdgeRight).LineStyle = xlDouble
    
    .Borders(xlEdgeLeft).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeRight).Color = RGB(Red, Green, Blue)
  End With
End Function

Function 罫線_二重線_上下()
  Dim Red As Long, Green As Long, Blue As Long
  
  Call Library.getRGB(Library.getRegistry("LineColor"), Red, Green, Blue)
  With Selection
    .Borders(xlEdgeTop).LineStyle = xlDouble
    .Borders(xlEdgeBottom).LineStyle = xlDouble
    
    .Borders(xlEdgeTop).Color = RGB(Red, Green, Blue)
    .Borders(xlEdgeBottom).Color = RGB(Red, Green, Blue)
  End With
End Function

Function 罫線_二重線_囲み()
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










