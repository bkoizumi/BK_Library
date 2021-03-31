Attribute VB_Name = "sampleData"

'**************************************************************************************************
' * xxxxxxxxxx
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function �T���v���f�[�^()
  Dim line As Long, endLine As Long, colLine As Long, endColLine As Long
  Dim getLine As Long, count As Long, getMaxCount As Long
  
  Dim newBook As Workbook
'  On Error GoTo catchError
  setName01 = True   '��
  setName02 = True    '��
  setName = True      '����
  setPref = True      '�s���{��
  setMail = True      '���[���A�h���X
  
  
  Call init.setting
  Set newBook = Workbooks.add
  ThisWorkbook.Activate
  sheetTestData.Activate
  
  
  getMaxCount = 100
  If setName01 = True Then
    colLine = 1
    endLine = sheetTestData.Cells(Rows.count, 1).End(xlUp).row
    
    newBook.Sheets("Sheet1").Cells(1, colLine) = "��"
    newBook.Sheets("Sheet1").Cells(1, colLine + 1) = "�Z�C"
    For count = 1 To getMaxCount
      getLine = Library.makeRandomNo(2, endLine)
      
      newBook.Sheets("Sheet1").Cells(count + 1, colLine) = sheetTestData.Range("A" & getLine)
      newBook.Sheets("Sheet1").Cells(count + 1, colLine + 1) = sheetTestData.Range("B" & getLine)
    Next
  End If
  
  If setName02 = True Then
    colLine = newBook.Sheets("Sheet1").Cells(1, Columns.count).End(xlToLeft).Column + 1
    endLine = sheetTestData.Cells(Rows.count, 4).End(xlUp).row
    
    newBook.Sheets("Sheet1").Cells(1, colLine) = "��"
    newBook.Sheets("Sheet1").Cells(1, colLine + 1) = "���C"
    newBook.Sheets("Sheet1").Cells(1, colLine + 2) = "����"
    
    For count = 1 To getMaxCount
      getLine = Library.makeRandomNo(2, endLine)
      
      newBook.Sheets("Sheet1").Cells(count + 1, colLine) = sheetTestData.Range("D" & getLine)
      newBook.Sheets("Sheet1").Cells(count + 1, colLine + 1) = sheetTestData.Range("E" & getLine)
      newBook.Sheets("Sheet1").Cells(count + 1, colLine + 2) = sheetTestData.Range("F" & getLine)
    Next
  End If
  
  If setName = True Then
    colLine = newBook.Sheets("Sheet1").Cells(1, Columns.count).End(xlToLeft).Column + 1
    
    newBook.Sheets("Sheet1").Cells(1, colLine) = "����"
    newBook.Sheets("Sheet1").Cells(1, colLine + 1) = "�Z�C���C"
    For count = 1 To getMaxCount
      newBook.Sheets("Sheet1").Cells(count + 1, colLine) = newBook.Sheets("Sheet1").Range("A" & count + 1) & " " & newBook.Sheets("Sheet1").Range("C" & count + 1)
      newBook.Sheets("Sheet1").Cells(count + 1, colLine + 1) = newBook.Sheets("Sheet1").Range("B" & count + 1) & " " & newBook.Sheets("Sheet1").Range("D" & count + 1)
    Next
  End If
  
  
  If setPref = True Then
    colLine = newBook.Sheets("Sheet1").Cells(1, Columns.count).End(xlToLeft).Column + 1
    endLine = sheetTestData.Cells(Rows.count, 8).End(xlUp).row
    
    newBook.Sheets("Sheet1").Cells(1, colLine) = "�s���{��"
    newBook.Sheets("Sheet1").Cells(1, colLine + 1) = "�s���{���R�[�h"
    For count = 1 To getMaxCount
      getLine = Library.makeRandomNo(2, endLine)
      
      newBook.Sheets("Sheet1").Cells(count + 1, colLine) = sheetTestData.Range("I" & getLine)
      newBook.Sheets("Sheet1").Cells(count + 1, colLine + 1) = sheetTestData.Range("H" & getLine)
    Next
  End If
    
   If setMail = True Then
    colLine = newBook.Sheets("Sheet1").Cells(1, Columns.count).End(xlToLeft).Column + 1
    endLine = sheetTestData.Cells(Rows.count, 11).End(xlUp).row
    
    newBook.Sheets("Sheet1").Cells(1, colLine) = "���[���A�h���X"
    For count = 1 To getMaxCount
      getLine = Library.makeRandomNo(2, endLine)
      
      newBook.Sheets("Sheet1").Cells(count + 1, colLine) = "testMail" & sheetTestData.Range("K" & getLine)
    Next
  End If
  
  
  
  
  
  
  
  

  Exit Function
'�G���[������====================================
catchError:
  Call Library.showNotice(Err.Number, Err.Description, True)
End Function
