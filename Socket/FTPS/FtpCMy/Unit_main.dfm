object Form1: TForm1
  Left = 138
  Top = 82
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ftp-client'
  ClientHeight = 393
  ClientWidth = 736
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 456
    Top = 16
    Width = 96
    Height = 16
    Caption = 'Port : 30001'
  end
  object Btest: TButton
    Left = 16
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Test'
    TabOrder = 0
    OnClick = BtestClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 171
    Width = 736
    Height = 222
    Align = alBottom
    ReadOnly = True
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 0
    Top = 35
    Width = 736
    Height = 136
    Align = alBottom
    ItemHeight = 16
    TabOrder = 2
  end
  object Bread: TButton
    Left = 104
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Read'
    TabOrder = 3
    OnClick = BreadClick
  end
  object Bsave: TButton
    Left = 192
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = BsaveClick
  end
  object Bclose: TButton
    Left = 336
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 5
    OnClick = BcloseClick
  end
  object Button1: TButton
    Left = 272
    Top = 8
    Width = 49
    Height = 25
    Caption = 'b1'
    TabOrder = 6
    OnClick = Button1Click
  end
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 424
    Top = 8
  end
  object IdAntiFreeze1: TIdAntiFreeze
    IdleTimeOut = 5000
    Left = 584
  end
end
