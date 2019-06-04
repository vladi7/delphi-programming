unit Unit_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP, IdAntiFreezeBase, IdAntiFreeze;

type
  TForm1 = class(TForm)
    Btest: TButton;
    Memo1: TMemo;
    IdFTP1: TIdFTP;
    ListBox1: TListBox;
    Bread: TButton;
    Bsave: TButton;
    Label1: TLabel;
    Bclose: TButton;
    IdAntiFreeze1: TIdAntiFreeze;
    Button1: TButton;
    procedure BtestClick(Sender: TObject);
    procedure BreadClick(Sender: TObject);
    procedure BsaveClick(Sender: TObject);
    procedure BcloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses UnitFtp;
{$R *.dfm}

procedure TForm1.BtestClick(Sender: TObject);
begin
 _InitConnectFtp('127.0.0.1','BELKA', '04102004', 30001,_ConnectFtp);
 ConnectToFTP(IdFtp1, _ConnectFtp, Memo1);
 ChangeFtpDir(IdFtp1,'Data123',Memo1);
 ReadFTPDirToStrings(IdFtp1, Memo1, Listbox1.items);
 CopyFtpFile(IdFTP1, Memo1,  'Guitar.jpg', ExtractFilePath(Application.exename)+'Guitar.jpg');
 DisconnectFTP(IdFTP1, Memo1);
end;

procedure TForm1.BreadClick(Sender: TObject);
begin
 _InitConnectFtp('127.0.0.1','BELKA', '04102004', 30001,_ConnectFtp);
 ConnectToFTP(IdFtp1, _ConnectFtp, Memo1);
 ChangeFtpDir(IdFtp1,'Data123',Memo1);
 CopyFtpFile(IdFTP1, Memo1,  'TEP1ANs.sig', ExtractFilePath(Application.exename)+'TEP1ANs.sig');
 CopyFtpFile(IdFTP1, Memo1,  'TEP2DIs.sig', ExtractFilePath(Application.exename)+'TEP2DIs.sig');
 DisconnectFTP(IdFTP1, Memo1);

end;

procedure TForm1.BsaveClick(Sender: TObject);
begin
 _InitConnectFtp('127.0.0.1','BELKA', '04102004', 30001,_ConnectFtp);
 ConnectToFTP(IdFtp1, _ConnectFtp, Memo1);
 RenameFtpFile(IdFTP1, Memo1, 'Guitar1.jpg', 'Guitar.jpg');
 ChangeFtpDir(IdFtp1,'Data123',Memo1);
 PutFtpFile(IdFTP1, Memo1,  ExtractFilePath(Application.exename)+'TEP1ANs.sig', 'TEP1ANs.sig');
 PutFtpFile(IdFTP1, Memo1,  ExtractFilePath(Application.exename)+'TEP2DIs.sig', 'TEP2DIs.sig');
 PutFtpFile(IdFTP1, Memo1,  ExtractFilePath(Application.exename)+'TEP2DIs.sig', 'TEP3DIs.sig');
 DisconnectFTP(IdFTP1, Memo1);

end;

procedure TForm1.BcloseClick(Sender: TObject);
begin
 Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 _InitConnectFtp('127.0.0.1','BELKA', '04102004', 20001,_ConnectFtp);
 ConnectToFTP(IdFtp1, _ConnectFtp, Memo1);
 RenameFtpFile(IdFTP1, Memo1, 'Guitar1.jpg', 'Guitar.jpg');
 ReadFTPDirToStrings(IdFtp1, Memo1, Listbox1.items);
 DisconnectFTP(IdFTP1, Memo1);

end;

end.
