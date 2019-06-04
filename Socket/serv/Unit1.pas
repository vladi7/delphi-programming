unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sockets, StdCtrls, ExtCtrls, WinSock;

type
  TForm1 = class(TForm)
    __S: TTcpServer;
    __ctrans: TTcpClient;
    __s1: TTcpServer;
    __ctrans1: TTcpClient;
    procedure FormCreate(Sender: TObject);
    procedure __SGetThread(Sender: TObject;
      var ClientSocketThread: TClientSocketThread);
    procedure __SAccept(Sender: TObject; ClientSocket: TCustomIpClient);
    procedure __s1Accept(Sender: TObject; ClientSocket: TCustomIpClient);
    procedure __ctransConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const dobav=  '250 Requested file action okay, completed.'+#13#10;
type mtype=array[0..40000000] of byte;
var
  Form1: TForm1;
  __cmassiv, __smassiv : mtype;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  __S.LocalPort:='20001';
  __s.Active:=True;
//  __S1.LocalPort:='20000';
//  __s1.Active:=True;
  __ctrans.RemotePort:='30001';
  __ctrans.Remotehost:='127.0.0.1';
//  __ctrans.active:=true;
  __ctrans1.RemotePort:='20000';
  __ctrans1.Remotehost:='127.0.0.1';
end;

procedure TForm1.__SGetThread(Sender: TObject;
  var ClientSocketThread: TClientSocketThread);
  var
    i : integer;
begin
// ClientSocketThread.ClientSocket.ReceiveBuf(__smassiv, 9);
i:=1;
if i=0 then;
end;

procedure TForm1.__SAccept(Sender: TObject; ClientSocket: TCustomIpClient);
var
  _structs, _structc:TSockAddrIn;
  __str : ansistring;
  beg_s, i : integer;
  
function __as(var m : mtype):ansistring;
var
   i : integer;
begin
 Result:='';
 i:=0;
 while (m[i]<>0) do
   begin
    Result:=Result+char(m[i]);
    inc(i);
   end;{while}
end;{__as}

begin
  __ctrans.Connect;
  if not __ctrans.Connected then exit;

    beg_s:=__ctrans.BytesReceived;
    __ctrans.WaitForData;
    __ctrans.ReceiveBuf(__cmassiv,10000000);
    __str:=__as(__cmassiv);
    if length(__str)<3 then exit;
    ClientSocket.SendBuf(__cmassiv,length(__str));
    sleep(200);

  while  __ctrans.Connected do
  begin
    if not ClientSocket.connected then break;
    beg_s:=ClientSocket.BytesReceived;
    ClientSocket.ReceiveBuf(__smassiv,10000000);
    __str:=__as(__smassiv);
    if __str='' then;
    if length(__str)<3 then exit;
    if not __ctrans.connected then break;
    __ctrans.SendBuf(__smassiv,{ClientSocket.BytesReceived-beg_s}length(__str));
    for i:=1 to length(__str) do __smassiv[i-1]:=0;
    sleep(1);

    if not __ctrans.connected then break;
    beg_s:=__ctrans.BytesReceived;
    __ctrans.ReceiveBuf(__cmassiv,10000000);
    __str:=__as(__cmassiv);
    if __str='' then;

    if length(__str)<3 then exit;
    if not ClientSocket.connected then break;
    if Pos('221', __str)>0 then break;
    if (pos('250',__str)>0) and true then
      begin
        for i:=1 to Length(dobav) do
          __cmassiv[i-1]:=ord(dobav[i]);
        ClientSocket.SendBuf(__cmassiv,Length(dobav));
        for i:=1 to length(dobav) do __cmassiv[i-1]:=0;
      end
    else
      begin
        ClientSocket.SendBuf(__cmassiv,{__ctrans.BytesReceived-beg_s}length(__str));
        for i:=1 to length(__str) do __cmassiv[i-1]:=0;
      end;

  end;{while}

  __ctrans.disConnect;
  ClientSocket.Disconnect;
end;

procedure TForm1.__s1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
begin
   ClientSocket.ReceiveBuf(__cmassiv,1);
  if ClientSocket.BytesReceived=0 then;

end;

procedure TForm1.__ctransConnect(Sender: TObject);
var
   i : integer;
begin
 if i=0 then;
end;

end.
