unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sockets, StdCtrls;

type
  TForm1 = class(TForm)
    __c: TTcpClient;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  __cmassiv, __smassiv : array[0..40000000] of byte;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  __C.RemotePort:='20000';
  __C.RemoteHost:='127.0.0.1';

//  if not __c.Connect then Halt(0);
end;

procedure TForm1.Button1Click(Sender: TObject);
var i : integer;
begin
  __c.Connect;
  if not __c.Connected then exit;
  for i:=0 to 9 do __cmassiv[i]:=i;
  __c.SendBuf(__cmassiv, 10);
  __c.disConnect;

end;

end.
