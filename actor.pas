unit actor;

interface

uses
  System.Classes,
  FMX.Ani, FMX.Graphics, FMX.Objects;

type
  TActor = class
  private
    m_bitmap: TBitmap;
    m_image: TImage;
    m_animation: TFloatAnimation;

    function GetX: single;
    function GetY: single;
    procedure SetX(const Value: single);
    procedure SetY(const Value: single);
    function GetHeight: single;
    function GetWidth: single;

    procedure DoAnimationFinish(sender: TObject);
    function GetAnimating: boolean;
  public
    constructor Create(const resourceName: string);
    destructor Destroy; override;

    procedure Start;

    property Image: TImage read m_image;
    property X: single read GetX write SetX;
    property Y: single read GetY write SetY;
    property Width: single read GetWidth;
    property Height: single read GetHeight;
    property Animating: boolean read GetAnimating;
  end;

implementation

uses
  helpers.bitmap;

{ TActor }

constructor TActor.Create(const resourceName: string);
begin
  m_bitmap := TBitmapHelpers.LoadBitmap(resourceName);

  m_image := TImage.Create(nil);
  m_image.Bitmap := m_bitmap;
  m_image.Width := m_bitmap.Width;
  m_image.Height := m_bitmap.Height;
  m_image.Opacity := 0;

  m_animation := TFloatAnimation.Create(m_image);
  m_animation.StartValue := 0;
  m_animation.StopValue := 1;
  m_animation.Duration := 2;
  m_animation.PropertyName := 'Opacity';
  m_animation.Parent := m_image;
  m_animation.OnFinish := DoAnimationFinish;
end;

destructor TActor.Destroy;
begin
  m_image.Free;
  m_bitmap.Free;
  inherited;
end;

procedure TActor.DoAnimationFinish(sender: TObject);
begin
  //
end;

function TActor.GetAnimating: boolean;
begin
  result := m_animation.Enabled;
end;

function TActor.GetHeight: single;
begin
  result := m_image.Width;
end;

function TActor.GetWidth: single;
begin
  result := m_image.Height;
end;

function TActor.GetX: single;
begin
  result := m_image.Position.X;
end;

function TActor.GetY: single;
begin
  result := m_image.Position.Y;
end;

procedure TActor.SetX(const Value: single);
begin
  m_image.Position.X := value;
end;

procedure TActor.SetY(const Value: single);
begin
  m_image.Position.Y := value;
end;

procedure TActor.Start;
begin
  m_animation.Start;
end;

end.
