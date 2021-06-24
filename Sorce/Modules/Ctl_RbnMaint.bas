Attribute VB_Name = "Ctl_RbnMaint"
'**************************************************************************************************
' * Copy
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function �V�[�g�ǉ�()
  Call init.setting
  ThisWorkbook.Worksheets.add.Name = "HighLight"
  ThisWorkbook.Save
End Function


'==================================================================================================
Function �V�[�g�폜()
  Call init.setting
  Application.DisplayAlerts = False
  
  ThisWorkbook.Sheets("Ribbon").delete
  
  Application.DisplayAlerts = True
  ThisWorkbook.Save
End Function


'==================================================================================================
Function SheetImport(control As IRibbonControl)
  Call init.setting
  Set targetBook = Workbooks("�����e�i���X�p.xlsx")
  
'  ThisWorkbook.Sheets("Ribbon").Columns("A:G").Value = targetBook.Sheets("Ribbon").Columns("A:G").Value
'  ThisWorkbook.Sheets("Notice").Columns("A:B").Value = targetBook.Sheets("Notice").Columns("A:B").Value
'  ThisWorkbook.Worksheets("Style").Columns("A:J").Value = targetBook.Sheets("Style").Columns("A:J").Value
'

  targetBook.Sheets("�ݒ�").Columns("A:H").Copy ThisWorkbook.Worksheets("�ݒ�").Range("A1")
'  targetBook.Sheets("Ribbon").Columns("A:G").Copy ThisWorkbook.Worksheets("Ribbon").Range("A1")
  targetBook.Sheets("Notice").Columns("A:B").Copy ThisWorkbook.Worksheets("Notice").Range("A1")
  targetBook.Sheets("Style").Columns("A:J").Copy ThisWorkbook.Worksheets("Style").Range("A1")
  targetBook.Sheets("testData").Columns("A:P").Copy ThisWorkbook.Worksheets("testData").Range("A1")
  targetBook.Sheets("Favorite").Columns("A:A").Copy ThisWorkbook.Worksheets("Favorite").Range("A1")
  
  
  Application.DisplayAlerts = False
  ThisWorkbook.Sheets("Stamp").delete
  ThisWorkbook.Worksheets.add.Name = "Stamp"
  targetBook.Sheets("Stamp").Columns("A:AP").Copy ThisWorkbook.Worksheets("Stamp").Range("A1")
  Application.DisplayAlerts = True
  
  ThisWorkbook.Save
  
  'Call Library.showDebugForm(ThisWorkbook.Worksheets("Ribbon").Range("C39"))
  

End Function


'==================================================================================================
Function SheetExport(control As IRibbonControl)

  Call init.setting
  Set targetBook = Workbooks("�����e�i���X�p.xlsx")
  
  ThisWorkbook.Sheets("�ݒ�").Columns("A:H").Copy targetBook.Worksheets("�ݒ�").Range("A1")
'  ThisWorkbook.Sheets("Ribbon").Columns("A:G").Copy targetBook.Worksheets("Ribbon").Range("A1")
  ThisWorkbook.Sheets("Notice").Columns("A:B").Copy targetBook.Worksheets("Notice").Range("A1")
  ThisWorkbook.Sheets("Style").Columns("A:J").Copy targetBook.Worksheets("Style").Range("A1")
  ThisWorkbook.Sheets("testData").Columns("A:P").Copy targetBook.Worksheets("testData").Range("A1")
  ThisWorkbook.Worksheets("Favorite").Columns("A:C").Copy targetBook.Sheets("Favorite").Range("A1")
  
  
  Application.DisplayAlerts = False
  targetBook.Sheets("Stamp").delete
  targetBook.Worksheets.add.Name = "Stamp"
  
  ThisWorkbook.Worksheets("Stamp").Columns("A:AP").Copy targetBook.Sheets("Stamp").Range("A1")
  Application.DisplayAlerts = True
  
  
  
  
  
  
  
'  Call Library.showDebugForm(ThisWorkbook.Worksheets("Ribbon").Range("A2"))
  

End Function


