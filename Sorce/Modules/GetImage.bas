Attribute VB_Name = "GetImage"
'Public path As String
'
'Function GetImage_Paste()
'
'  Dim dirPath As String
'  Dim FolderName As String
'
'  dirPath = Library_GetDirPath("")
'
'  FolderName = Mid(dirPath, InStrRev(dirPath, "\") + 1)
'
'    '���[�N�V�[�g��ǉ����A���O�t����
'  Worksheets.Add After:=Worksheets(Worksheets.count)
'  ActiveSheet.Name = FolderName
'
'  ' �V�[�g�̐F��ԐF�ɂ���
'  With ActiveWorkbook.Sheets(FolderName).Tab
'      .Color = RGB(255, 0, 0)
'      .TintAndShade = 0
'  End With
'
'  Call GetImage_InsertPicture(dirPath, FolderName)
'
'
'
'
'
'
'
'
'
''    Dim dNumber As Long
''    Dim arrDirectory() As String
''
''    '�t�H���_�I���_�C�A���O��\������v���V�[�W���Ăяo��
''    If path = "" Then
''      path = OpenFolderDialog()
''      If path = "" Then
''        Exit Function
''      End If
''    End If
''
''
''    '�I�������t�H���_���̃t�H���_�����擾����v���V�[�W�����Ăяo��
''    dNumber = DirectoryNumber(path)
''
''    ReDim arrDirectory(dNumber)
''
''    '�V�[�g��ǉ�����v���V�[�W�����Ăяo��
''    arrDirectory = GetImage_AddSheets(path, arrDirectory)
''
''    '�摜��}������v���V�[�W�����Ăяo��
''    Call InsertPicture(dNumber, path, arrDirectory)
''
''    '�ŏ��̃V�[�g�I��
'''    Sheets(arrDirectory(0)).Select
'
'End Function
'
'
''�_�C�A���O��\������v���V�[�W��
'Function OpenFolderDialog() As String
'
'    Dim FolderDlg As Office.FileDialog
'
'    '�t�H���_�I���_�C�A���O��
'    Set FolderDlg = Application.FileDialog(msoFileDialogFolderPicker)
'    '�ݒ�A�\���A�߂�l
'    With FolderDlg
'      .InitialFileName = ActiveWorkbook.path & "\"
'      .AllowMultiSelect = False
'      If .Show = -1 Then OpenFolderDialog = FolderDlg.SelectedItems(1)
'    End With
'    Set FolderDlg = Nothing
'
'End Function
'
'
''�t�H���_�����擾����v���V�[�W��
'Function DirectoryNumber(argPath As String) As Long
'
'    Dim dName As String
'    Dim num As Long
'
'    '�I�������t�H���_���擾
'    dName = Dir(argPath & "\*.*", vbDirectory)
'
'    '�t�H���_�����[�v
'    Do While dName <> ""
'        'dName���t�H���_���`�F�b�N
'        If GetAttr(argPath & "\" & dName) And vbDirectory Then
'            'dName���A���݃t�H���_�܂��͐e�t�H���_���`�F�b�N
'            If dName <> "." And dName <> ".." Then
'                num = num + 1
'            End If
'        End If
'        '���̃t�H���_���ɍs��
'        dName = Dir()
'    Loop
'
'    DirectoryNumber = num
'
'End Function
'
'
''�V�[�g��ǉ�����v���V�[�W��
'Function GetImage_AddSheets(argPath As String, argArrDirectory() As String) As String()
'
'    Dim dName As String
'    Dim i As Long
'    Dim tmpSheet As Worksheet
'
'    '�I�������t�H���_���擾
'    dName = Dir(argPath & "\*.*", vbDirectory)
'
'    '�t�H���_�����[�v
'    Do While dName <> ""
'        'dName���t�H���_���`�F�b�N
'        If GetAttr(argPath & "\" & dName) And vbDirectory Then
'            'dName���A���݃t�H���_�܂��͐e�t�H���_���`�F�b�N
'            If dName <> "." And dName <> ".." Then
'                i = i + 1
'                '�ǉ�����V�[�g�Ɠ����̃V�[�g�����邩�`�F�b�N(�P���ڂ̂ݎ��s)
'                If i = 1 Then
'                    '�V�[�g����1�Ȃ�V�[�g���ύX(�V�[�g��&"1")
'                    If Sheets.count = 1 Then
'                        ActiveSheet.Name = ActiveSheet.Name & "1"
'                    '�V�[�g��������
'                    Else
'                        '�V�[�g�����[�v
'                        For Each tmpSheet In Sheets
'                            'dName���u�b�N�ɂ���V�[�g�Ɠ����Ȃ�폜
'                            If tmpSheet.Name = dName Then
'                                '�m�F��ʔ�\��
'                                Application.DisplayAlerts = False
'                                tmpSheet.Delete
'                                Application.DisplayAlerts = True
'                                Exit For
'                            End If
'                        Next
'                    End If
'                End If
'                '���[�N�V�[�g��ǉ����A���O�t����
'                Worksheets.Add After:=Worksheets(Worksheets.count)
'                dName = Left(dName, 30)
'                ActiveSheet.Name = dName
'                'MsgBox ActiveSheet.CodeName
'
'                '�ǉ������V�[�g�ȊO�̃V�[�g���폜(�P���ڂ̂ݎ��s)
''                If i = 1 Then
''                    '�V�[�g�����[�v
''                    For Each tmpSheet In Sheets
''                        'dName���u�b�N�ɂ���V�[�g�ƕʖ��Ȃ�폜
''                        If tmpSheet.Name <> dName Then
''                            '�m�F��ʔ�\��
''                            Application.DisplayAlerts = False
''                            tmpSheet.Delete
''                            Application.DisplayAlerts = True
''                        End If
''                    Next
''                End If
'
'                ' �V�[�g�̐F��ԐF�ɂ���
'                With ActiveWorkbook.Sheets(dName).Tab
'                    .Color = 255
'                    .TintAndShade = 0
'                End With
'
'                '�t�H���_��(�V�[�g��)��z��Ɋi�[
'                argArrDirectory(i - 1) = dName
'            End If
'        End If
'        '���̃t�H���_�����ɍs��
'        dName = Dir()
'    Loop
'
'    AddSheets = argArrDirectory
'
'End Function
'
'
''�摜��}������v���V�[�W��
'Sub GetImage_InsertPicture(dirPath As String, FolderName As String)
'
'    Dim i As Long
'    Dim fName As String
'    Dim cellRange, pict As Object
'    Dim x, y, cellHeight, pictHeight As Long
'
'      'x��y(�摜��}������Z��)�̏����l
'      x = 2
'      y = 2
'
'      '�V�[�g�I��
'      Sheets(FolderName).Select
'
'      ' �V�[�g�̘g����\��
'      ActiveWindow.DisplayGridlines = False
'
'      '�t�H���_���̃t�@�C�����擾
'      fName = Dir(dirPath & "\*", vbNormal)
'
'      '�t�@�C�������[�v
'      Do While fName <> ""
'          '�t�@�C�����摜�t�@�C�����`�F�b�N
'          If Right(fName, 4) = ".jpg" Or _
'             Right(fName, 4) = ".png" Or _
'             Right(fName, 4) = ".bmp" Or _
'             Right(fName, 4) = ".png" Or _
'             Right(fName, 4) = ".gif" Then
'              '�V�[�g�ɉ摜��\��t��
'              ActiveSheet.Pictures.Insert(argPath & "\" & argArrDirectory(i) & "\" & fName).Select
'              '�摜�̈ʒu
'              Set pict = ActiveSheet.Shapes(Selection.Name)
'              With pict
'                .Left = Cells(y, x).Left
'                .Top = Cells(y, x).Top
'              End With
'
'              '�摜�ɘg���ǉ�
'              ActiveSheet.Shapes(Selection.Name).Select
'              With Selection.ShapeRange.line
'                .Visible = msoTrue
'                .ForeColor.ObjectThemeColor = msoThemeColorBackground1
'                .ForeColor.TintAndShade = 0
''                  .ForeColor.Brightness = -0.5
'                .Transparency = 0
'              End With
'
'              ' �V�[�g�̐F��߂�
''              With ActiveWorkbook.Sheets(argArrDirectory(i)).Tab
''                  .Color = xlAutomatic
''                  .TintAndShade = 0
''              End With
'
'              ' �摜�t�@�C������ݒ�
'              Cells(y - 1, 1).Value = fName
'
'              '1�Z���̍����擾
'              cellHeight = ActiveCell.Height
'              '�摜�̏c�̒����擾
'              pictHeight = pict.Height
'
'              '�摜�}���ʒu�����炷
'              y = y + Int(pictHeight / cellHeight) + 2
'          End If
'          '���̃t�@�C�������ɍs��
'          fName = Dir()
'      Loop
'      '�Z��A1���A�N�e�B�u��
'      Range("A1").Select
'
'End Sub
'
'
'
'
