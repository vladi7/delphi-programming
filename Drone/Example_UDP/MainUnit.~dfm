object MainForm: TMainForm
  Left = 399
  Top = 250
  BorderStyle = bsToolWindow
  Caption = 'Server/Client  UDP'
  ClientHeight = 193
  ClientWidth = 325
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupText: TGroupBox
    Left = 0
    Top = 0
    Width = 325
    Height = 124
    Align = alTop
    Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1090#1077#1082#1089#1090#1086#1084
    TabOrder = 0
    object SendEdit: TEdit
      Left = 8
      Top = 16
      Width = 233
      Height = 21
      TabOrder = 0
    end
    object SendBtn: TButton
      Left = 246
      Top = 15
      Width = 70
      Height = 22
      Caption = #1054#1090#1086#1089#1083#1072#1090#1100
      TabOrder = 1
      OnClick = SendBtnClick
    end
    object Memo: TMemo
      Left = 9
      Top = 40
      Width = 305
      Height = 77
      ReadOnly = True
      TabOrder = 2
    end
  end
  object FileGroup: TGroupBox
    Left = 0
    Top = 124
    Width = 325
    Height = 69
    Align = alClient
    Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1092#1072#1081#1083#1072#1084#1080
    TabOrder = 1
    object SendFileBtn: TButton
      Left = 171
      Top = 42
      Width = 70
      Height = 22
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      TabOrder = 0
      OnClick = SendFileBtnClick
    end
    object FileEdit: TEdit
      Left = 8
      Top = 16
      Width = 307
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object SetFile: TButton
      Left = 246
      Top = 42
      Width = 70
      Height = 22
      Caption = #1059#1082#1072#1079#1072#1090#1100
      TabOrder = 2
      OnClick = SetFileClick
    end
  end
  object UDPClient: TIdUDPClient
    BufferSize = 100000
    Host = 'localhost'
    Port = 1152
    Left = 16
    Top = 48
  end
  object UDPServer: TIdUDPServer
    Active = True
    BufferSize = 100000
    Bindings = <>
    DefaultPort = 1152
    OnUDPRead = UDPServerUDPRead
    Left = 48
    Top = 48
  end
  object OpenDialog: TOpenDialog
    Left = 80
    Top = 48
  end
  object SaveDialog: TSaveDialog
    Left = 112
    Top = 48
  end
end
