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
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 56
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 272
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 2
    OnClick = Button3Click
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocket2
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 443
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 120
    Top = 24
  end
  object __httpcl: TTcpClient
    Left = 168
    Top = 136
  end
  object IdTCPClient1: TIdTCPClient
    IOHandler = IdSSLIOHandlerSocket2
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 0
    Left = 360
    Top = 48
  end
  object IdSSLIOHandlerSocket2: TIdSSLIOHandlerSocket
    SSLOptions.Method = sslvTLSv1
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 392
    Top = 48
  end
end
