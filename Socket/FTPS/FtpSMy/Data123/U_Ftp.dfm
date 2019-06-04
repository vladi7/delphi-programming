object Form1: TForm1
  Left = 198
  Top = 179
  Width = 837
  Height = 271
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 64
    Width = 829
    Height = 173
    Align = alBottom
    TabOrder = 0
  end
  object IdFTPServer1: TIdFTPServer
    Active = True
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 21
    Greeting.NumericCode = 220
    Greeting.Text.Strings = (
      'Indy FTP Server ready.')
    Greeting.TextCode = '220'
    MaxConnectionReply.NumericCode = 0
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 500
    ReplyUnknownCommand.Text.Strings = (
      'Syntax error, command unrecognized.')
    ReplyUnknownCommand.TextCode = '500'
    AllowAnonymousLogin = True
    AnonymousAccounts.Strings = (
      'anonymous'
      'ftp'
      'guest')
    SystemType = 'WIN32'
    OnAfterUserLogin = IdFTPServer1AfterUserLogin
    OnChangeDirectory = IdFTPServer1ChangeDirectory
    OnGetFileSize = IdFTPServer1GetFileSize
    OnUserLogin = IdFTPServer1UserLogin
    OnListDirectory = IdFTPServer1ListDirectory
    OnRenameFile = IdFTPServer1RenameFile
    OnDeleteFile = IdFTPServer1DeleteFile
    OnRetrieveFile = IdFTPServer1RetrieveFile
    OnStoreFile = IdFTPServer1StoreFile
    OnMakeDirectory = IdFTPServer1MakeDirectory
    OnRemoveDirectory = IdFTPServer1RemoveDirectory
    Left = 16
    Top = 8
  end
end
