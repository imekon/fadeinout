unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  actor;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    state: integer;
  public
    { Public declarations }
    actor: TActor;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  state := 0;
  actor := TActor.Create('someshape', 0);
  actor.X := ClientWidth / 2 - actor.Width / 2;
  actor.Y := ClientHeight / 2 - actor.Height / 2;

  AddObject(actor.Image);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  actor.Free;
end;

procedure TMainForm.OnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if actor.Animating then
    exit;

  case state of
    0: actor.FadeIn(3);
    1: actor.FadeOut(3);
    2: actor.FadeIn(2);
    3: actor.MoveTo(300, 0, 2);
    4: actor.MoveTo(-400, 0, 2);
  end;

  inc(state);
end;

end.
