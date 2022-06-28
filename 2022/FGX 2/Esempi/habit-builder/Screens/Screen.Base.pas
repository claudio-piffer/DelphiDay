unit Screen.Base;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Frame.Base;

type
  TScreenBase = class(TFrameBase)
  protected
    function GetTitle: string; virtual;
  public
    procedure SetSafeAreaPaddings(const ATop, ABottom: Single); virtual;
    function IsChild: Boolean; virtual;
    property Title: string read GetTitle;
  end;
  TfgScreenBaseClass = class of TScreenBase;

var
  ScreenBase: TScreenBase;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log;

{ TScreenBase }

function TScreenBase.GetTitle: string;
begin
  Result := string.Empty;
end;

function TScreenBase.IsChild: Boolean;
begin
  Result := False;
end;

procedure TScreenBase.SetSafeAreaPaddings(const ATop, ABottom: Single);
begin

end;

end.
