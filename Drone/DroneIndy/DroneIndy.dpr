program DroneIndy;

uses
  Forms,
  UUDP in 'UUDP.pas' {Form1},
  thdrone in '..\..\ProbaParse\thdrone.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
