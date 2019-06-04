program DynOptim;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit_data in 'Unit_data.pas',
  U_thread in 'U_thread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Optimization';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
