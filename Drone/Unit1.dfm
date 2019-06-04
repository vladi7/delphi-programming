object Form1: TForm1
  Left = 254
  Top = 124
  Width = 928
  Height = 480
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
    Left = 168
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object __UDP: TUdpSocket
    Left = 232
    Top = 120
  end
  object __Udpvideo: TUdpSocket
    Left = 328
    Top = 120
  end
  object IdUDPServer1: TIdUDPServer
    Active = True
    BufferSize = 1000000
    Bindings = <>
    DefaultPort = 11111
    OnUDPRead = IdUDPServer1UDPRead
    Left = 464
    Top = 64
  end
end
