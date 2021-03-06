Attribute VB_Name = "Ctl_String"
'**************************************************************************************************
' * 文字列操作
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function Trim01()
  ActiveCell = Trim(ActiveCell.Text)
  
  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:

End Function

'==================================================================================================
Function 中黒点付与()
  Dim line As Long, endLine As Long
  Dim slctCells As Range
  
  
  '処理開始--------------------------------------
  'On Error GoTo catchError
  FuncName = "Ctl_String.中黒点付与"

  Call Library.startScript
  Call init.setting
  Call Ctl_ProgressBar.showStart
  '----------------------------------------------
  For Each slctCells In Selection
    slctCells.Value = "・" & slctCells.Value
  Next

  '処理終了--------------------------------------
  Call Ctl_ProgressBar.showEnd
  Call Library.endScript
  '----------------------------------------------

  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:
  Call Library.showNotice(400, FuncName, True)
End Function


'==================================================================================================
Function 連番付与()
  Dim line As Long, endLine As Long
  Dim slctCells As Range
  
  
  '処理開始--------------------------------------
  'On Error GoTo catchError
  FuncName = "Ctl_String.連番付与"

  Call Library.startScript
  Call init.setting
  Call Ctl_ProgressBar.showStart
  '----------------------------------------------
  line = 1
  For Each slctCells In Selection
    slctCells.Value = line & "．" & slctCells.Value
    line = line + 1
  Next

  '処理終了--------------------------------------
  Call Ctl_ProgressBar.showEnd
  Call Library.endScript
  '----------------------------------------------

  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:
  Call Library.showNotice(400, FuncName, True)
End Function

