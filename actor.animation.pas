unit actor.animation;

interface

uses
  System.Types,
  FMX.Ani, FMX.Objects, FMX.Controls;

type
  TActorAnimation = class
  private
    m_floatAnimation: TFloatAnimation;
    m_pathAnimation: TPathAnimation;

    procedure DoAnimationFinish(sender: TObject);
    function GetAnimating: boolean;
  public
    constructor Create(image: TImage);
    destructor Destroy; override;

    procedure FadeIn(dur: single);
    procedure FadeOut(dur: single);
    procedure MoveTo(x, y, dur: single);

    property Animating: boolean read GetAnimating;
  end;

implementation

{ TActorAnimation }

constructor TActorAnimation.Create(image: TImage);
begin
  m_floatAnimation := TFloatAnimation.Create(image);
  with m_floatAnimation do
  begin
    Parent := image;
    OnFinish := DoAnimationFinish;
  end;

  m_pathAnimation := TPathAnimation.Create(image);
  with m_pathAnimation do
  begin
    Parent := image;
    OnFinish := DoAnimationFinish;
  end;

end;

destructor TActorAnimation.Destroy;
begin
  m_pathAnimation.Free;
  m_floatAnimation.Free;
  inherited;
end;

procedure TActorAnimation.DoAnimationFinish(sender: TObject);
begin
  // It stays enabled even after finishing, so reset the flag
  // This will need updating - animations are only expect to run on their own
  m_floatAnimation.Enabled := false;
  m_pathAnimation.Enabled := false;
end;

procedure TActorAnimation.FadeIn(dur: single);
begin
  if not m_floatAnimation.Enabled then
    with m_floatAnimation do
    begin
      StartValue := 0;
      StopValue := 1;
      Duration := dur;
      PropertyName := 'Opacity';
      Start;
    end;
end;

procedure TActorAnimation.FadeOut(dur: single);
begin
  if not m_floatAnimation.Enabled then
    with m_floatAnimation do
    begin
      StartValue := 1;
      StopValue := 0;
      Duration := dur;
      PropertyName := 'Opacity';
      Start;
    end;
end;

function TActorAnimation.GetAnimating: boolean;
begin
  result := m_floatAnimation.Enabled or m_pathAnimation.Enabled;
end;

procedure TActorAnimation.MoveTo(x, y, dur: single);
begin
  if not m_pathAnimation.Enabled then
    with m_pathAnimation do
    begin
      Path.Clear;
      Path.MoveTo(TPointF.Create(0, 0));
      Path.MoveTo(TPointF.Create(x, y));
      Path.ClosePath;
      Duration := dur;
      Start;
    end;
end;

end.
