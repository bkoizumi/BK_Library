Attribute VB_Name = "Ctl_Ribbon"
#If VBA7 And Win64 Then
  Private Declare PtrSafe Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" (pDest As Any, pSrc As Any, ByVal cbLen As LongPtr)
#Else
  Private Declare Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" (pDest As Any, pSrc As Any, ByVal cbLen As Long)
#End If


'**************************************************************************************************
' * ���{�����j���[�����ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
'�ǂݍ��ݎ�����
Function onLoad(ribbon As IRibbonUI)
  Call init.setting
  
  Set ribbonUI = ribbon
  
'  Call Library.showDebugForm("ribbonUI" & "," & CStr(ObjPtr(ribbonUI)))
  Call Library.setRegistry("ribbonUI", CStr(ObjPtr(ribbonUI)))
  
  ribbonUI.ActivateTab ("BK_Library")
  ribbonUI.Invalidate
  
End Function


'==================================================================================================
'�X�V
Function Refresh()
  Call init.setting
  
  #If VBA7 And Win64 Then
    Set ribbonUI = GetRibbon(CLngPtr(Library.getRegistry("ribbonUI")))
  #Else
    Set ribbonUI = GetRibbon(CLng(Library.getRegistry("ribbonUI")))
  #End If
  
  ribbonUI.ActivateTab ("BK_Library")
  ribbonUI.Invalidate
End Function
  
  
'==================================================================================================
'�V�[�g�ꗗ���j���[
Function getSheetsList(control As IRibbonControl, ByRef returnedVal)
  Dim DOMDoc As Object, Menu As Object, Button As Object, subMenu As Object
  Dim sheetName As Worksheet
  
  Call init.setting
   
  If ribbonUI Is Nothing Then
    #If VBA7 And Win64 Then
      Set ribbonUI = GetRibbon(CLngPtr(Library.getRegistry("ribbonUI")))
    #Else
      Set ribbonUI = GetRibbon(CLng(Library.getRegistry("ribbonUI")))
    #End If
  End If
  
  Set DOMDoc = CreateObject("Msxml2.DOMDocument")
  Set Menu = DOMDoc.createElement("menu")

  Menu.SetAttribute "xmlns", "http://schemas.microsoft.com/office/2009/07/customui"
  Menu.SetAttribute "itemSize", "normal"

  For Each sheetName In ActiveWorkbook.Sheets
    Set Button = DOMDoc.createElement("button")
    With Button
      sheetNameID = sheetName.Name
      .SetAttribute "id", encode(sheetName.Name)
      .SetAttribute "label", sheetName.Name
    
    If Sheets(sheetName.Name).Visible = True Then
      .SetAttribute "imageMso", "HeaderFooterSheetNameInsert"
    ElseIf Sheets(sheetName.Name).Visible <> True Then
      .SetAttribute "imageMso", "SheetProtect"
    
    End If
    If ActiveWorkbook.activeSheet.Name = sheetName.Name Then
      .SetAttribute "imageMso", "ExcelSpreadsheetInsert"
    End If
      .SetAttribute "onAction", "selectActiveSheet"
    End With
    Menu.AppendChild Button
    Set Button = Nothing
  Next

  DOMDoc.AppendChild Menu
  
  'Call Library.showDebugForm(DOMDoc.XML)
  
  returnedVal = DOMDoc.XML
  Set Menu = Nothing
  Set DOMDoc = Nothing
  
End Function

'--------------------------------------------------------------------------------------------------
Function dMenuRefresh(control As IRibbonControl)
  
  If ribbonUI Is Nothing Then
    #If VBA7 And Win64 Then
      Set ribbonUI = GetRibbon(CLngPtr(Library.getRegistry("ribbonUI")))
    #Else
      Set ribbonUI = GetRibbon(CLng(Library.getRegistry("ribbonUI")))
    #End If
  End If
  ribbonUI.Invalidate
End Function


'--------------------------------------------------------------------------------------------------
Function selectActiveSheet(control As IRibbonControl)
  Dim sheetNameID As String
  
  Call Library.startScript
  sheetNameID = decode(control.ID)
  
  If Sheets(sheetNameID).Visible <> True Then
    Sheets(sheetNameID).Visible = True
  End If
  Sheets(sheetNameID).Select
  Application.GoTo Reference:=Range("A1"), Scroll:=True
  
  Call dynamicMenu
  Call Library.endScript
End Function

'--------------------------------------------------------------------------------------------------
Function encode(strVal As String)

  strVal = Replace(strVal, "(", "bk-1-lib")
  strVal = Replace(strVal, ")", "bk-2-lib")
  strVal = Replace(strVal, " ", "bk-3-lib")
  strVal = Replace(strVal, "�@", "bk-4-lib")
  strVal = Replace(strVal, "�y", "bk-5-lib")
  strVal = Replace(strVal, "�z", "bk-6-lib")
  
  strVal = "bk-0-lib" & strVal
  encode = strVal
End Function

'--------------------------------------------------------------------------------------------------
Function decode(strVal As String)

  strVal = Replace(strVal, "bk-0-lib", "")
  strVal = Replace(strVal, "bk-1-lib", "(")
  strVal = Replace(strVal, "bk-2-lib", ")")
  strVal = Replace(strVal, "bk-3-lib", " ")
  strVal = Replace(strVal, "bk-4-lib", "�@")
  strVal = Replace(strVal, "bk-5-lib", "�y")
  strVal = Replace(strVal, "bk-6-lib", "�z")
  
  decode = strVal
End Function


'--------------------------------------------------------------------------------------------------
#If VBA7 And Win64 Then
Private Function GetRibbon(ByVal lRibbonPointer As LongPtr) As Object
  Dim p As LongPtr
#Else
Private Function GetRibbon(ByVal lRibbonPointer As Long) As Object
  Dim p As Long
#End If
  Dim ribbonObj As Object
  
  MoveMemory ribbonObj, lRibbonPointer, LenB(lRibbonPointer)
  Set GetRibbon = ribbonObj
  p = 0: MoveMemory ribbonObj, p, LenB(p) '��n��
End Function





' ���C�ɓ��胁�j���[�쐬---------------------------------------------------------------------------
Function FavoriteMenu(control As IRibbonControl, ByRef returnedVal)
  Dim DOMDoc As Object, Menu As Object, Button As Object, subMenu As Object
  Dim regLists As Variant, i As Long
  Dim line As Long, endLine As Long
  Dim objFSO As New FileSystemObject
   
  Call init.setting
   
  If ribbonUI Is Nothing Then
    #If VBA7 And Win64 Then
      Set ribbonUI = GetRibbon(CLngPtr(Library.getRegistry("ribbonUI")))
    #Else
      Set ribbonUI = GetRibbon(CLng(Library.getRegistry("ribbonUI")))
    #End If
  End If
  
  Set DOMDoc = CreateObject("Msxml2.DOMDocument")
  Set Menu = DOMDoc.createElement("menu") ' menu�̍쐬

  Menu.SetAttribute "xmlns", "http://schemas.microsoft.com/office/2009/07/customui"
  Menu.SetAttribute "itemSize", "normal"

  endLine = sheetFavorite.Cells(Rows.count, 1).End(xlUp).Row
  For line = 2 To endLine
    Set Button = DOMDoc.createElement("button")
    With Button
      .SetAttribute "id", "Favorite_" & line
      .SetAttribute "label", objFSO.GetFileName(sheetFavorite.Range("A" & line))
      .SetAttribute "imageMso", "Favorites"
      .SetAttribute "onAction", "OpenFavoriteList"
    End With
    Menu.AppendChild Button
    Set Button = Nothing
  
  Next
  DOMDoc.AppendChild Menu
  returnedVal = DOMDoc.XML
'  Call Library.showDebugForm(DOMDoc.XML)
  
  Set Menu = Nothing
  Set DOMDoc = Nothing
End Function


'--------------------------------------------------------------------------------------------------
Function OpenFavoriteList(control As IRibbonControl)
  Dim fileNamePath As String
  Dim line As Long
  
  line = Replace(control.ID, "Favorite_", "")
  fileNamePath = sheetFavorite.Range("A" & line)
  
  If Library.chkFileExists(fileNamePath) Then
    Workbooks.Open fileName:=fileNamePath
  End If
  Application.GoTo Reference:=Range("A1"), Scroll:=True
End Function





'Label �ݒ�----------------------------------------------------------------------------------------
Public Sub getLabel(control As IRibbonControl, ByRef setRibbonVal)
  
  Call init.setting
  setRibbonVal = Replace(ribbonVal("Lbl_" & control.ID), "<BR>", vbNewLine)
End Sub


'Action �ݒ�---------------------------------------------------------------------------------------
Sub getAction(control As IRibbonControl)
  Dim setRibbonVal As Variant
  
  Call init.setting
  setRibbonVal = ribbonVal("Act_" & control.ID)
  
  If setRibbonVal Like "*Ctl_Ribbon*" Then
    Call Application.run(setRibbonVal, control)
  
  ElseIf setRibbonVal = "" Then
    Call Library.showDebugForm("Act_" & control.ID)
  Else
    Call Application.run(setRibbonVal)
  End If
End Sub


'Supertip �ݒ�-------------------------------------------------------------------------------------
Public Sub getSupertip(control As IRibbonControl, ByRef setRibbonVal)
  Call init.setting
  setRibbonVal = ribbonVal("Sup_" & control.ID)
End Sub


'Description �ݒ�----------------------------------------------------------------------------------
Public Sub getDescription(control As IRibbonControl, ByRef setRibbonVal)
  Call init.setting
  setRibbonVal = Replace(ribbonVal("Dec_" & control.ID), "<BR>", vbNewLine)

End Sub

'getImageMso �ݒ�----------------------------------------------------------------------------------
Public Sub getImage(control As IRibbonControl, ByRef image)
  Call init.setting
  image = ribbonVal("Img_" & control.ID)
End Sub


'size �ݒ�-----------------------------------------------------------------------------------------
Public Sub getSize(control As IRibbonControl, ByRef setRibbonVal)
  Dim getVal As String
  
  Call init.setting
  setRibbonVal = ribbonVal("Siz_" & control.ID)
  Select Case setRibbonVal
    Case "large"
      setRibbonVal = 1
    Case "normal"
      setRibbonVal = 0
    Case Else
      setRibbonVal = 0
  End Select
End Sub

'--------------------------------------------------------------------------------------------------
'�L��/�����؂�ւ�
Function getEnabled(control As IRibbonControl, ByRef returnedVal)
  Dim wb As Workbook
  Call init.setting
  
  If Workbooks.count = 0 Then
    returnedVal = False
  ElseIf setVal("debugMode") = "develop" Then
    returnedVal = True
  Else
    returnedVal = False
  End If
  
End Function


'--------------------------------------------------------------------------------------------------
Sub getVisible(control As IRibbonControl, ByRef returnedVal)
  Call init.setting
  returnedVal = Library.getRegistry("CustomRibbon")
End Sub

'--------------------------------------------------------------------------------------------------
Sub noDispTab(control As IRibbonControl)
  Call Library.setRegistry("CustomRibbon", False)
  Call RefreshRibbon
End Sub

'--------------------------------------------------------------------------------------------------
Sub setDispTab(control As IRibbonControl, pressed As Boolean)
  Call Library.setRegistry("CustomRibbon", pressed)
  Call RefreshRibbon
End Sub


'--------------------------------------------------------------------------------------------------
Function RefreshRibbon()
  #If VBA7 And Win64 Then
    Set ribbonUI = GetRibbon(CLngPtr(Library.getRegistry("ribbonUI")))
  #Else
    Set ribbonUI = GetRibbon(CLng(Library.getRegistry("ribbonUI")))
  #End If
  ribbonUI.Invalidate

End Function

'��������------------------------------------------------------------------------------------------
Function setCenter(control As IRibbonControl)
  If TypeName(Selection) = "Range" Then
    Selection.HorizontalAlignment = xlCenterAcrossSelection
  End If
End Function
