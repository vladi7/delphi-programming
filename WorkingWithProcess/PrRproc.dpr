program PrRproc;

uses
  Forms,
  Unit_s in 'Unit_s.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
