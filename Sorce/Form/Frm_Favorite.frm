VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} Frm_Favorite 
   Caption         =   "���C�ɓ���"
   ClientHeight    =   6285
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   10785
   OleObjectBlob   =   "Frm_Favorite.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "Frm_Favorite"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim myMenu As Variant


'**************************************************************************************************
' * �����ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Private Sub UserForm_Initialize()
  
  Set myMenu = Application.CommandBars.add(Position:=msoBarPopup, Temporary:=True)
  
  With myMenu
    With .Controls.add
      .Caption = "�擪�Ɉړ�"
      .OnAction = "Ctl_Favorite.moveTop"
      .FaceId = 594
    End With
    With .Controls.add
      .Caption = "1��Ɉړ�"
      .OnAction = "Ctl_Favorite.moveUp"
      .FaceId = 595
    End With
    With .Controls.add
      .BeginGroup = True
      .Caption = "1���Ɉړ�"
      .OnAction = "Ctl_Favorite.moveDown"
      .FaceId = 596
    End With
    With .Controls.add
      .Caption = "�Ō�Ɉړ�"
      .OnAction = "Ctl_Favorite.moveBottom"
      .FaceId = 597
    End With
    With .Controls.add
      .BeginGroup = True
      .Caption = "�폜"
      .OnAction = "Ctl_Favorite.delete"
      .FaceId = 293
    End With
  
  End With
End Sub

'==================================================================================================
Private Sub Lst_Favorite_MouseDown(ByVal Button As Integer, ByVal Shift As Integer, ByVal X As Single, ByVal Y As Single)
    If Button = 2 Then myMenu.ShowPopup
End Sub


'**************************************************************************************************
' * �����L�����Z��
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Private Sub Cancel_Click()
  Unload Me
End Sub




'**************************************************************************************************
' * �������s
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Private Sub run_Click()
  Unload Me
End Sub


'**************************************************************************************************
' * ���X�g�{�b�N�X
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Private Sub Lst_Favorite_Click()
  Dim DetailMeg As String
  Dim line As Long
  Dim filePath As String
  
  On Error GoTo catchError
  
  Call init.setting
  line = Lst_Favorite.ListIndex + 2
  filePath = sheetFavorite.Range("A" & line)
  
  DetailMeg = "<<�t�@�C�����>>" & vbNewLine
  DetailMeg = DetailMeg & "�p�X�@�F" & filePath & vbNewLine
  DetailMeg = DetailMeg & "�X�V���F" & FileDateTime(filePath) & vbNewLine
 
 
  Frm_Favorite.DetailMeg.Value = DetailMeg
  
  Exit Sub
'�G���[������--------------------------------------------------------------------------------------
catchError:

End Sub


