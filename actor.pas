unit actor;

interface

uses
  System.Classes,
  FMX.Graphics;

type
  TActor = class
  private
    bitmap: TBitmap;
  public
    constructor Create(const resourceName: string);
    destructor Destroy; override;
  end;

implementation

uses
  helpers.bitmap;

{ TActor }

constructor TActor.Create(const resourceName: string);
begin
  bitmap := TBitmapHelpers.LoadBitmap(resourceName);
end;

destructor TActor.Destroy;
begin
  bitmap.Free;
  inherited;
end;

end.
