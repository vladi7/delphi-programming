unit UUDP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, thdrone;

type
  TForm1 = class(TForm)
    __UdpC: TIdUDPClient;
    Button1: TButton;
    __UdpVideo: TIdUDPClient;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
   Procedure sendcommand(__str : ansistring;del : integer);
   Procedure sendcommandA(__str : ansistring;del : integer);
   Procedure sendcommand_1(__str : ansistring;a : word;del : integer);
   Procedure read_data;
   Function read_command:ansistring;
    { Public declarations }
  end;
type
 tbuf =  array [0..1000000] of byte;
 __buffer = ^tbuf ;
var
  Form1: TForm1;
  _thread : Droneread;
implementation

{$R *.dfm}
Procedure TForm1.sendcommand(__str : ansistring;del : integer);
var
   __b : __buffer;
   i : integer;
   __str1 : ansistring;
begin
  New(__b);
  for i:=1 to Length(__str) do __b^[i-1]:=Ord(__str[i]);
  __UdpC.SendBuffer(__b^,Length(__str));
  Dispose(__b);
  __str1:=__str+' '+datetimetostr(Now);
  sleep(del*1000);
  Memo1.Lines.Add(__str1+' '+read_command);
end;{sendcommand}

Procedure TForm1.sendcommand_1(__str : ansistring;a : word;del : integer);
var
   __b : __buffer;
   i : integer;
   __str1 : ansistring;
begin
  New(__b);
  for i:=1 to Length(__str) do __b^[i-1]:=Ord(__str[i]);
  __b^[length(__str)]:=Lo(a);
  __b^[length(__str)+1]:=Hi(a);
  __UdpC.SendBuffer(__b^,Length(__str)+2);
//  i:=__UdpC.Binding.Send(__b^,Length(__str)+2,0);
//  if i<>0 then;
  Dispose(__b);
  __str1:=__str+' '+datetimetostr(Now);
  sleep(del*1000);
  Memo1.Lines.Add(__str1+' '+read_command);
end;{sendcommand_1}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  Sendcommand('command',3);
  Sendcommand('takeoff',5);
  Sendcommand('forward 20',4);
  Sendcommand('cw 180',4);
  Sendcommand('forward 20',4);
  Sendcommand('land',5);
//  Sendcommand('conn_req:6037',5);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Sendcommand('command',3);
   read_data;
//   Sendcommand('conn_req',3);
//   Sendcommand('conn_req:6037',5);
//   Sendcommand_1('conn_req:',6037,5);
//   Sendcommand('conn_req:6037',5);
end;

procedure TForm1.read_data;
var
   __b : __buffer;
   i : integer;
   PeerIp : string;
   PeerPort : integer;
begin
  New(__b);
  while True do
    begin
//       __UdpVideo.ReceiveBuffer(__b^,1,PeerIp,Peerport,1000);
     PeerIp:= __UdpVideo.Host;
     Peerport:= __UdpVideo.port;
     i:=__UdpVideo.Binding.Recvfrom(__b^,2048, 0, PeerIp,Peerport);
     if i=0 then;
     sleep(1000);
    end;
  Dispose(__b);
end;

procedure TForm1.sendcommandA(__str: ansistring; del: integer);
var
   __b : __buffer;
   i : integer;
begin
  New(__b);
  for i:=1 to Length(__str) do __b^[i-1]:=Ord(__str[i]);
__UdpC.Binding.Sendto(__Udpc.Host,__Udpc.Port,   __b^,Length(__str));
  Dispose(__b);
  sleep(del*1000);
end;{sendcommandA}

procedure TForm1.Button3Click(Sender: TObject);
begin
  Sendcommand('command',3);
  Sendcommand('takeoff',5);
  Sendcommand('land',5);

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SendcommandA('command',3);
  SendcommandA('takeoff',5);
  SendcommandA('land',5);

end;

Function TForm1.read_command:ansistring;
var
  __bread : array[0..1000000] of byte;
  a, i : integer;
  __str : ansistring;
begin
 Result:='';
 a:=__UdpC.ReceiveBuffer(__bread, 128, 1000);
 if a>0 then
    begin
      __str:='';
      for i:=0 to a-1 do __str:=__str+char(__bread[i]);
      Result:=__str+' '+datetimetostr(Now);
    end
 else
    begin
      __UdpC.Active:=False;
      sleep(1000);
      __UdpC.Active:=True;

    end;

end;

end.
