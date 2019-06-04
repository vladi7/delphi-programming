object Form1: TForm1
  Left = 362
  Top = 208
  Width = 445
  Height = 555
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 192
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 24
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 105
    Top = 81
    Width = 75
    Height = 25
    Caption = 'Button3A'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 236
    Width = 429
    Height = 281
    Align = alBottom
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object __UdpC: TIdUDPClient
    Active = True
    BufferSize = 1000000
    Host = '192.168.10.1'
    Port = 8889
    Left = 48
    Top = 16
  end
  object __UdpVideo: TIdUDPClient
    Active = True
    BufferSize = 1000000
    Host = '192.168.10.1'
    Port = 6037
    Left = 80
    Top = 17
  end
end
