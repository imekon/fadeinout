program fadeinout;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {MainForm},
  actor in 'actor.pas',
  helpers.bitmap in 'helpers.bitmap.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
