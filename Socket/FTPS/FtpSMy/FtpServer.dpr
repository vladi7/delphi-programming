program FtpServer;

uses
  Forms,
  U_Ftp in 'U_Ftp.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ftp-server';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
