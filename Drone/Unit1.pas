unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sockets, StdCtrls, Winsock, IdBaseComponent, IdComponent,
  IdUDPBase, IdUDPClient, IdUDPServer, IdSocketHandle;

type
  TForm1 = class(TForm)
    Button1: TButton;
    __UDP: TUdpSocket;
    __Udpvideo: TUdpSocket;
    IdUDPServer1: TIdUDPServer;
    procedure Button1Click(Sender: TObject);
    procedure IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  __buffer : array[0..100000] of Byte;
implementation

{$R *.dfm}
var
 ServerAddr: TSockAddrIn; // здесь будет храниться информация

Procedure __Send(__str : ansistring;__dell : integer);
var
  i : integer;
begin
 for i:=1 to Length(__str) do __buffer[i-1]:=ord(__str[i]);
 (*
Serveraddr.sin_family:=Af_inet;
ServerAddr.sin_port := htons(8889);
ServerAddr.sin_addr.S_addr := inet_addr(PAnsiChar('192.168.10.1')); // указываем IP получателя пакета
 i:=form1.__UDP.SendTo(__buffer, Length(__str),ServerAddr);
 *)
 i:=form1.__UDP.SendBuf(__buffer, Length(__str){,ServerAddr}); //alternative
 if i=0 then;

 sleep(__dell*1000);
end;{__Send}

procedure TForm1.Button1Click(Sender: TObject);
var
  i, __size : integer;
begin
  __Udp.LocalHost:='127.0.0.1';
  __Udp.LocalPort:='9000';
  __Udp.RemoteHost:='192.168.10.1';
  __Udp.RemotePort:='8889';

  __UdpVideo.LocalHost:='127.0.0.1';
  __UdpVideo.LocalPort:='6037';
  __UdpVideo.RemoteHost:='192.168.10.1';
  __UdpVideo.RemotePort:='8889';

  __Udp.Open;
  __UdpVideo.Open;
  __Send('command',3);
  __Send('takeoff',5);
  __Send('forward 50',4);
  __Send('cw 180',4);
  __Send('forward 50',4);
  __Send('land',5);
//  __Send('conn_req:6037',5);
  __Send('streamon',5);

//i:=  __UdpVideo.ReceiveBuf(__buffer,1);
//if i=0 then;
 (*
Serveraddr.sin_family:=Af_inet;
ServerAddr.sin_port := htons(6037);
ServerAddr.sin_addr.S_addr := inet_addr(PAnsiChar('127.0.0.1')); // указываем IP получателя пакета
i:=__UdpVideo.ReceiveFrom(__buffer,2048, ServerAddr, __size);

if i=0 then;
*)
   __UdpVideo.close;
   __Udp.Close;
end;


procedure TForm1.IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var
   i : integer;
begin
  if AData.Size<=255 then;
  i:=25;
  if i<>0 then;
end;

end.
