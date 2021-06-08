Attribute VB_Name = "Main"
'ワークブック用変数------------------------------
'ワークシート用変数------------------------------
'グローバル変数----------------------------------


'**************************************************************************************************
' * オプション画面表示
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function オプション画面表示(control As IRibbonControl)
  
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

'エラー発生時=====================================================================================
catchError:
  'Call Library.showNotice(Err.Number, Err.Description, True)
End Function


'**************************************************************************************************
' * 標準画面
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function 標準画面(control As IRibbonControl)
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
      ActiveWindow.Zoom = Library.getRegistry("Main", "zoomLevel")
      
      'ガイドラインの表示/非表示
      ActiveWindow.DisplayGridlines = Library.getRegistry("Main", "gridLine")
  
      '背景白をなしにする
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
' * スタイル削除
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function スタイル削除()
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
    Call Ctl_ProgressBar.showCount("定義済スタイル削除", count, endCount, s.Name)
    Call Library.showDebugForm("定義済スタイル削除：" & s.Name)
    
    Select Case s.Name
      Case "Normal"
      Case Else
        s.delete
    End Select
    count = count + 1
  Next
  
  'スタイル初期化
  endLine = BK_sheetStyle.Cells(Rows.count, 2).End(xlUp).Row
  For line = 2 To endLine
    If BK_sheetStyle.Range("A" & line) <> "無効" Then
      Call Ctl_ProgressBar.showCount("スタイル初期化", line, endLine, BK_sheetStyle.Range("B" & line))
      Call Library.showDebugForm("スタイル初期化：" & BK_sheetStyle.Range("B" & line))
      
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
        
        '配置
        If BK_sheetStyle.Range("F" & line) = "TRUE" Then
          .HorizontalAlignment = BK_sheetStyle.Range("J" & line).HorizontalAlignment
        End If
        
        
        '背景色
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
' * 名前定義削除
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function 名前定義削除(control As IRibbonControl)
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
Function 画像設定(control As IRibbonControl)

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
Function R1C1表記(control As IRibbonControl)

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
' * 設定Import / Export
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function 設定_抽出()
  
  Dim FSO As Object, TempName As String
  Set FSO = CreateObject("Scripting.FileSystemObject")
  
  Call Library.startScript
  Call init.setting
  
  TempName = FSO.GetSpecialFolder(2) & "\BK_Style.xlsx"
  
  BK_sheetStyle.Copy
  ActiveWorkbook.SaveAs fileName:=TempName, FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False
  
  Call Library.endScript
  
  MsgBox ("修正完了後、保存し閉じてください")
End Function

'==================================================================================================
Function 設定_取込()
  
  Dim FSO As Object, TempName As String
  Set FSO = CreateObject("Scripting.FileSystemObject")
  
  Call Library.startScript
  Call init.setting

  TempName = FSO.GetSpecialFolder(2) & "\BK_Style.xlsx"
  
  Set targetBook = Workbooks.Open(TempName)
  targetBook.Sheets("Style").Columns("A:J").Copy ThisWorkbook.Worksheets("Style").Range("A1")
  targetBook.Close
  
  Call FSO.DeleteFile(TempName, True)
  
  Call Main.スタイル削除
  Call Library.endScript
End Function









