program FtpClient;

uses
  Forms,
  Unit_main in 'Unit_main.pas' {Form1},
  UnitFTP in 'UnitFTP.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ftp-client';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
