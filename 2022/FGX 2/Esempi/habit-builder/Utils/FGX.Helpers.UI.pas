unit FGX.Helpers.UI;

interface

uses
  FGX.Controls, FGX.Forms;

procedure AddFrame(const AParent: TfgControl; const AFrame: TfgForm; const AFlexGrow: Single = 1);

implementation

uses
  FGX.Controls.Types;

procedure AddFrame(const AParent: TfgControl; const AFrame: TfgForm; const AFlexGrow: Single);
begin
  AFrame.BeginUpdate;
  try
    AFrame.PositionMode := TfgPositionMode.Relative;
    AFrame.Alignment.FlexGrow := AFlexGrow;
    AFrame.FullScreen := False;
    AFrame.Parent := AParent;
    AFrame.Show;
  finally
    AFrame.EndUpdate;
  end;
end;

end.
