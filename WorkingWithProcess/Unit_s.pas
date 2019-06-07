unit Unit_s;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses TlHELP32; 

{$R *.dfm}

var
  dwFlags, th32ProcessID: DWORD;
  __Handle : Thandle;
  __struc : tagPROCESSENTRY32;
  __List : TstringList;

Procedure __Init;
begin
 __List:=TstringList.create;
 dwflags:=TH32CS_SNAPALL;
 th32ProcessID:=0;
 __Handle:=CreateToolhelp32Snapshot(dwflags	,th32ProcessID);
 __struc.dwSize:=100000;
end;{__Init}

Procedure __Read;
begin
 if not Process32First(__Handle,__struc) then Exit;
 __List.Add(AnsiString(__struc.szExeFile)+';'+inttostr(__struc.th32ProcessID));
 while Process32Next(__Handle,__struc) do
    __List.Add(AnsiString(__struc.szExeFile)+';'+inttostr(__struc.th32ProcessID));
 CloseHandle(__Handle);
end;{__read}

procedure TForm1.Button1Click(Sender: TObject);
var
   __stream : TMemorystream;
begin
 Listbox1.items.Clear;
 __Init;
 __Read;
 __stream:=TMemorystream.Create;
 __List.SaveToStream(__stream);
 __stream.Position:=0;
 ListBox1.Items.LoadFromStream(__stream);
 __stream.Free;
 __List.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   __str : ansistring;
begin
 if ListBox1.ItemIndex<0 then Exit;
 __str:=Listbox1.Items[ListBox1.ItemIndex];
 Delete(__str,1,Pos(';',__str));
 TerminateProcess
 (
 OpenProcess(
    PROCESS_ALL_ACCESS	,	// access flag
    True,	// handle inheritance flag
    strtoint(__str) 	// process identifier
   ),
 0);
 Sleep(2000);
 Button1Click(Nil);
end;

end.
 