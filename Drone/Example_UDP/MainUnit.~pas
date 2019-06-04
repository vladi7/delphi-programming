unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdUDPServer, XPMan, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, StdCtrls, IdSocketHandle;

type
  TMainForm = class(TForm)
    UDPClient: TIdUDPClient;
    UDPServer: TIdUDPServer;
    GroupText: TGroupBox;
    FileGroup: TGroupBox;
    SendEdit: TEdit;
    SendBtn: TButton;
    Memo: TMemo;
    SendFileBtn: TButton;
    FileEdit: TEdit;
    SetFile: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure SetFileClick(Sender: TObject);
    procedure SendBtnClick(Sender: TObject);
    procedure UDPServerUDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    procedure SendFileBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

(***************** РАБОТА НА СТОРОНЕ КЛИЕНТА **********************************)

procedure TMainForm.FormCreate(Sender: TObject);
var
 s: string;
begin
  // здесь мы просим ввести IP адрес, по умолчанию стоит "localhost", так что если
  // мы ни чего не введем, то прогрмма будет общаться сама с сабой, ну а если
  // введем, то неплохобы позаботится о наличии на удаленном компьютере
  // запущенной копии нашей программы, для проверки работоспособности
  if InputQuery('Программа-пример по UDP',
  'Введите IP адрес удаленной машины, иначе будете разговаривать сами с сабой :)',s)=true then
  UDPClient.Host:=s;
end;


procedure TMainForm.SetFileClick(Sender: TObject);
begin
  // здесь просто указываем файл для отправки
  if OpenDialog.Execute then  FileEdit.Text:=OpenDialog.FileName;
end;

procedure TMainForm.SendBtnClick(Sender: TObject);
begin
  // здесь просто отправляем текстовое сообщение
  UDPClient.Send('text'+SendEdit.Text);
  SendEdit.Clear;
end;

procedure TMainForm.SendFileBtnClick(Sender: TObject);
var
  MemStream  : TMemoryStream;
begin
  // здесь отправляем файл
  // создаем поток в памяти
  MemStream:= TMemoryStream.Create;
  // загружаем файл в наш поток
  MemStream.LoadFromFile(FileEdit.Text);
  //

  // отправляем наш поток
  UDPClient.SendBuffer(MemStream.Memory^,MemStream.Size);
  // освобождаем память
  MemStream.Free;
end;

(***************** РАБОТА НА СТОРОНЕ СЕРВЕРА **********************************)

procedure TMainForm.UDPServerUDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var
  // объявляем 2 потока, один для строк, другой для любой другой информации
  // в нашем случае для файлов (так же можно пересылать что угодно)
  StrStream  : TStringStream;
  MemStream  : TMemoryStream;
begin
  // здесь происходит обработка данных пришедших от клиента
  // на данном этапе есть маленькая логическая бомба, все что длинной до 255
  // я считаю текстом (стандартное ограничение строковой переменной) , а что
  // больше 255, то это уже файл, на самом деле и файл может весить 255,
  // это конечно редкость но может быть, как это исправить подумай сам (мне лень) :)
  if AData.Size<=255 then
  begin
    // итак к нам пришел текст, работаем с потоком строк
    // создаем строковый поток
    StrStream:=TStringStream.Create('');
    // читаем данные в этот поток из пришедшего потока
    StrStream.CopyFrom(AData, AData.Size);
    // добавляем данные в приемник, указывая перед этим от кого этот текст
    Memo.Lines.Add(ABinding.PeerIP+': '+copy(StrStream.DataString,5,length(StrStream.DataString)));
    // освобождаем память
    StrStream.Free;
  end else
  begin
    // итак к нам пришел файл, работаем с потоком в памяти
    MemStream:= TMemoryStream.Create;
    // загружаем файл в наш поток
    MemStream.CopyFrom(AData, AData.Size);
    // выводим диалог сохранения файла
    if SaveDialog.Execute then MemStream.SaveToFile(SaveDialog.FileName);
    // освобождаем память
    MemStream.Free;
  end;
end;


end.
