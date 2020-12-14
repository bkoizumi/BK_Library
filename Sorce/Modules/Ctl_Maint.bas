Attribute VB_Name = "Ctl_Maint"
'**************************************************************************************************
' * Copy
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Sub データコピー()
  
  Call init.setting
  
  Set targetBook = Workbooks("メンテナンス用.xlsx")
  
'  ThisWorkbook.Sheets("Ribbon").Columns("A:G").Value = targetBook.Sheets("Ribbon").Columns("A:G").Value
'  ThisWorkbook.Sheets("Notice").Columns("A:B").Value = targetBook.Sheets("Notice").Columns("A:B").Value
'  ThisWorkbook.Worksheets("Style").Columns("A:J").Value = targetBook.Sheets("Style").Columns("A:J").Value
'

  targetBook.Sheets("設定").Columns("A:H").Copy ThisWorkbook.Worksheets("設定").Range("A1")
  targetBook.Sheets("Ribbon").Columns("A:G").Copy ThisWorkbook.Worksheets("Ribbon").Range("A1")
  targetBook.Sheets("Notice").Columns("A:B").Copy ThisWorkbook.Worksheets("Notice").Range("A1")
  targetBook.Sheets("Style").Columns("A:J").Copy ThisWorkbook.Worksheets("Style").Range("A1")
  targetBook.Sheets("testData").Columns("A:P").Copy ThisWorkbook.Worksheets("testData").Range("A1")

  
  If MsgBox("インポート", vbYesNo + vbExclamation) = vbYes Then
    targetBook.Sheets("Favorite").Columns("A:A").Copy ThisWorkbook.Worksheets("Favorite").Range("A1")
  Else
    ThisWorkbook.Worksheets("Favorite").Columns("A:C").Copy targetBook.Sheets("Favorite").Range("A1")
  End If
  
  ThisWorkbook.Save
  
  Call Library.showDebugForm(ThisWorkbook.Worksheets("Ribbon").Range("A2"))
'  Call Library.showNotice(200, "データコピー")
  

End Sub


Sub シート追加()
  Call init.setting


  ThisWorkbook.Worksheets.add.Name = "Favorite"
  

  
  ThisWorkbook.Save
End Sub
