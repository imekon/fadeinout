unit helpers.bitmap;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes,
  FMX.DialogService.Async, FMX.Graphics;

type
  TBitmapHelpers = class
  public
    class function LoadBitmap(const resourceName: string): TBitmap;
  end;

implementation

{ TBitmapHelpers }

class function TBitmapHelpers.LoadBitmap(const resourceName: string): TBitmap;
var
  bitmap: TBitmap;
  stream: TResourceStream;

begin
  stream := TResourceStream.Create(HInstance, resourceName, RT_RCDATA);
  bitmap := TBitmap.CreateFromStream(stream);

  if bitmap.IsEmpty then
    TDialogServiceAsync.MessageDialog(Format('Cannot load image: %s', [resourceName]),
      TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0);

  stream.Free;
  result := bitmap;
end;

end.
