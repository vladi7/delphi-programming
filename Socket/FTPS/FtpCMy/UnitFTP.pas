unit UnitFTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Dialogs, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdFTP, ExtCtrls, Controls, IdFTPList,
  StdCtrls, Classes, forms, IdGlobal{, IdExplicitTLSClientServerBase};

type
  TForm2 = class(TForm)
    IdFTP1: TIdFTP;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 type T_Connection= Record

  _Host : string;//'ftp.turstolica.by';
  _Username :string;//= 'givojno1';
  _Password :string;//= 'xdEW5QA1';
  _Port : integer;//= 21;

 end;{T_Connection}

Procedure _InitConnectFtp(__HOST,__NAME, __PASSWORD : ansistring;__ftpPort : integer; var _ConnectFtp : T_Connection);
procedure ConnectToFTP(IdFtp1 : Tidftp;_d : T_Connection;_Memo : Tmemo);
procedure DisconnectFTP(IdFTP1 : TIdFtp; _Memo : Tmemo);
procedure CopyFtpFile(IdFTP1 : TIdFTP; _Memo : Tmemo;  _source, _destin : string);
procedure PutFtpFile(IdFTP1 : TIdFTP; _Memo : Tmemo;  _source, _destin : string);
procedure ReadFTPDirToStrings(IdFtp1 : Tidftp; _Memo : Tmemo; MyStringList : Tstrings);
procedure ChangeFtpDir(IdFTP1 : TIdFTP; __strs : ansistring; _Memo : Tmemo);
procedure RenameFtpFile(IdFTP1 : TIdFTP; _Memo : Tmemo;  _source, _destin : string);

var
  Form2: TForm2;
  _ConnectFtp : T_Connection;

implementation

{$R *.dfm}

Procedure _InitConnectFtp(__HOST,__NAME, __PASSWORD : ansistring;__ftpPort : integer; var _ConnectFtp : T_Connection);
begin
 with _ConnectFtp do
   begin
    _Host := __HOST;//'192.168.150.2';
    _Username :=__NAME;//'tep' {'givojno1'};
    _Password :=__PASSWORD;//'tep'{'xdEW5QA1'};
    _Port := __ftpPort;//21;
   end;{_ConnectFtp}
end;{_InitConnectFtp}

procedure ConnectToFTP(IdFtp1 : Tidftp;_d : T_Connection;_Memo : Tmemo);
begin
  IdFTP1.Host := _d._Host;
  IdFTP1.Username :=_d._Username;
  IdFTP1.Password :=_d._Password;;
  IdFTP1.Port :=_d._Port;
//  IdFTP1.PassiveUseControlHost := True;
  IdFTP1.Passive := True;  ///обязательно

  try
    IdFTP1.Connect;
    if _Memo<> Nil then _Memo.Lines.Add('Присоединились к порту ' + IdFTP1.Host);
  except
    if _Memo<> Nil then _Memo.Lines.Add('Ошибка соединения с портом ' + IdFTP1.Host);
  end;

//  IdFTP1.ChangeDir('www');
//  IdFTP1.ChangeDir('turstolica.by');
//  IdFTP1.ChangeDir('tep');
end;

procedure DisconnectFTP(IdFTP1 : TIdFtp; _Memo : Tmemo);
begin
  if Assigned(IdFTP1) then
  begin
    Sleep(500);
    IdFTP1.Disconnect;
    if _Memo<> Nil then _Memo.Lines.Add('Отключились от порта ' + IdFTP1.Host);
  end;
end;

procedure ReadFTPDirToStrings(IdFtp1 : Tidftp; _Memo : Tmemo; MyStringList : Tstrings);
var
  i:integer;
  Afiles : TstringList;
begin
  AFiles := TStringList.Create;
  IdFTP1.List(AFiles, '', True);
  if _Memo<>Nil then _Memo.Lines.Add('Прочитали список фалов с сайта');
  if MyStringList=Nil then Exit;
  MyStringList.Clear;
    for i:=0 to AFiles.Count-1 do
       MyStringList.Add(AFiles.Strings[i]);
  Afiles.Destroy;
  sleep(500);
  (*
    for i:=0 to idFTP1.DirectoryListing.Count-1 do
       MyStringList.Add(idFTP1.DirectoryListing.Items[i].FileName);
    *)
end;


procedure ReadFtpDirectory(IdFTP1 : TIdFTP; _Memo : Tmemo; Listbox1 : Tlistbox);
var
  i:integer;
  Afiles : TstringList;
begin
  AFiles := TStringList.Create;
  IdFTP1.List(AFiles, '', True);
  Afiles.Destroy;
  if _Memo<>Nil then _Memo.Lines.Add('Прочитали список фалов с сайта');
  if ListBox1=Nil then Exit;
  ListBox1.Items.Clear;
    for i:=0 to idFTP1.DirectoryListing.Count-1 do
       ListBox1.Items.Add(idFTP1.DirectoryListing.Items[i].FileName);
end;

procedure CopyFtpFile(IdFTP1 : TIdFTP; _Memo : Tmemo;  _source, _destin : string);
var
  filePath, dir, serverName, pageName: string;
begin
   dir := IDFTP1.RetrieveCurrentDir;
   if IdFTP1.Connected then
     begin
      filePath := _destin;
      pageName := _source;
      DeleteFile(filePath);
      IdFTP1.Get(pageName, filePath,  False);
      serverName := dir + '/' + pageName;
      if _Memo<> Nil then _Memo.Lines.Add('Файл ' + serverName  + ' успешно скопирован из сервера по адресу ' + filePath);
     end;
end;{CopyFtpFile}


procedure PutFtpFile(IdFTP1 : TIdFTP; _Memo : Tmemo;  _source, _destin : string);
var
  filePath, dir, serverName, pageName: string;
begin
   dir := IDFTP1.RetrieveCurrentDir;
   if IdFTP1.Connected then
     begin

      filePath := _source;
      pageName := _destin;
      IdFTP1.Put(filePath, pageName, False);

      serverName := dir + '/' + filePath;
      if _Memo<> Nil then _Memo.Lines.Add('Файл ' + serverName  + ' успешно скопирован на сервер по адресу ' + filePath);
     end;
end;{PutftpFile}

procedure RenameFtpFile(IdFTP1 : TIdFTP; _Memo : Tmemo;  _source, _destin : string);
var
  filePath, dir, serverName, pageName: string;
begin
   dir := IDFTP1.RetrieveCurrentDir;
   if IdFTP1.Connected then
     begin

      filePath := _source;
      pageName := _destin;
      IdFTP1.Rename(filePath, pageName);

      serverName := dir + '/' + filePath;
      if _Memo<> Nil then _Memo.Lines.Add('Файл ' + serverName  + ' успешно переименован в ' + filePath);
     end;
end;{RenameftpFile}

procedure ChangeFtpDir(IdFTP1 : TIdFTP; __strs : ansistring; _Memo : Tmemo);
begin
  Try
   if IdFTP1.Connected then
     begin
      IdFTP1.ChangeDir(__strs);
      if _Memo<>Nil then _Memo.Lines.Add('Сменили директорий');
     end;{if}
 Except
 end;{Try .. Except}
end;

(*
procedure TForm1.Button7Click(Sender: TObject);
begin
  if OpenDialog1.Execute
  then DiskFileEdit.Text := OpenDialog1.FileName;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  PageNameEdit.Text := ExtractFileName(DiskFileEdit.Text);
end;


procedure TForm1.Button3Click(Sender: TObject);
var
  filePath, dir, serverName, pageName: string;
begin
//  ConnectToFTP(IdFtp1,_ConnectFtp,Memo1);
  try
  dir := IDFTP1.RetrieveCurrentDir;
  if IdFTP1.Connected
  then begin
      filePath := DiskFileEdit.Text;
      pageName := PageNameEdit.Text;
      IdFTP1.Put(filePath, pageName, False);
      serverName := dir + '/' + pageName;
      Memo1.Lines.Add('Файл ' + filePath + ' успешно скопирован на сервер по адресу ' + serverName);
  end;
  except
  end;
//  DisconnectFTP(IdFtp1,Memo1);
end;


procedure TForm1.ListBox1DblClick(Sender: TObject);
var
   __strs : ansistring;
   i : integer;
begin
 with Sender as Tlistbox do
  begin
   if itemindex<0 then Exit;
   __strs:=items[itemindex];
  for i:=0 to idFTP1.DirectoryListing.Count-1 do
    if __strs=(idFTP1.DirectoryListing.Items[i].FileName)
       then
            if  not (ditDirectory in [idFTP1.DirectoryListing.Items[i].ItemType]) then
                   Exit;
  Try
   if IdFTP1.Connected then
     begin
      IdFTP1.ChangeDir(__strs);
      ReadFtpDirectory(IDFTP1, Memo1, Sender as Tlistbox);
     end;{if}
 Except
 end;{Try .. Except}
  end;{if}
end;


procedure TForm1.BmkdirClick(Sender: TObject);
begin
 IDFTP1.MakeDir(Eddirname.text);
 ReadFtpDirectory(IDFTP1, Memo1, listbox1);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   __strs, __strd : ansistring;
begin
 with Listbox1 do
  begin
   if itemindex<0 then Exit;
   __strs:=items[itemindex];
   if __strs='' then Exit;
   if not  SaveDialog1.Execute then Exit;
   __strd := SaveDialog1.filename;
 Try
      CopyFtpFile(IdFTP1, Memo1, __strs, __strd);
      ReadFtpDirectory(IDFTP1, Memo1, Listbox1);
 Except
 end;{Try .. Except}
  end;{if}
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   __strs : ansistring;
  dir, serverName, pageName: string;
  i : integer;
  flag_dir : Boolean;
begin
  with Listbox1 do
  begin
   if itemindex<0 then Exit;
   __strs:=items[itemindex];
   if __strs='' then Exit;
   flag_dir:=True;
   for i:=0 to idFTP1.DirectoryListing.Count-1 do
     if __strs=(idFTP1.DirectoryListing.Items[i].FileName)
       then
            if  not (ditDirectory in [idFTP1.DirectoryListing.Items[i].ItemType]) then
                   Flag_dir:=False;

 Try
   dir := IDFTP1.RetrieveCurrentDir;
   if IdFTP1.Connected then
     begin
      pageName := __strs;
      if flag_dir then IdFTP1.RemoveDir(pageName)
      else IdFTP1.Delete(pageName);
      serverName := dir + '/' + pageName;
      Memo1.Lines.Add('Файл ' + serverName  + ' успешно удален.');
      ReadFtpDirectory(IDFTP1, Memo1, Listbox1);
     end;
 Except
 end;{Try .. Except}
  end;{if}
end;
 *)
procedure TForm2.FormCreate(Sender: TObject);
begin
// SaveDialog1.InitialDir:=ExtractFilePath(Application.exename);
// OpenDialog1.InitialDir:=ExtractFilePath(Application.exename);
(*
 _InitConnectFtp(_ConnectFtp);
 ConnectToFTP(IdFtp1,_ConnectFtp,NIL{Memo1});
 ReadFtpDirectory(IDFTP1, NIL, NIL{Listbox1});
 DisconnectFTP(IdFtp1,NIL);
 *)
end;

(*
procedure TForm1.Button4Click(Sender: TObject);
begin
 ReadFtpDirectory(IDFTP1, Memo1, Listbox1);
end;
 *)

procedure TForm2.FormDestroy(Sender: TObject);
begin
  DisconnectFTP(IdFtp1,NIL);
end;

end.
