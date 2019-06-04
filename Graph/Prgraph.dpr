program Prgraph;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit_data in 'Unit_data.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
