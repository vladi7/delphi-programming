object Form2: TForm2
  Left = 138
  Top = 89
  Width = 140
  Height = 95
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 80000
    ProxySettings.ProxyType = fpcmSite
    ProxySettings.Port = 0
    Left = 24
    Top = 16
  end
end
