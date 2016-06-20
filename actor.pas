unit actor;

interface

uses
  System.Classes, System.Types,
  FMX.Ani, FMX.Graphics, FMX.Objects, FMX.Controls,
  actor.animation;

type
  TActor = class
  private
    m_bitmap: TBitmap;
    m_image: TImage;
    m_animation: TActorAnimation;

    function GetX: single;
    function GetY: single;
    procedure SetX(const Value: single);
    procedure SetY(const Value: single);
    function GetHeight: single;
    function GetWidth: single;
  public
    constructor Create(const resourceName: string; opacity: single);
    destructor Destroy; override;

    property Image: TImage read m_image;
    property X: single read GetX write SetX;
    property Y: single read GetY write SetY;
    property Width: single read GetWidth;
    property Height: single read GetHeight;
    property Animation: TActorAnimation read m_animation;
  end;

implementation

uses
  helpers.bitmap;

{ TActor }

constructor TActor.Create(const resourceName: string; opacity: single);
begin
  m_bitmap := TBitmapHelpers.LoadBitmap(resourceName);

  m_image := TImage.Create(nil);
  m_image.Bitmap := m_bitmap;
  m_image.Width := m_bitmap.Width;
  m_image.Height := m_bitmap.Height;
  m_image.Opacity := opacity;

  m_animation := TActorAnimation.Create(m_image);
end;

destructor TActor.Destroy;
begin
  m_animation.Free;
  m_image.Free;
  m_bitmap.Free;
  inherited;
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

end.
