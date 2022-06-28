unit Frame.Base;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types;

type
  TFrameBase = class(TfgForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrameBase: TFrameBase;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log;

end.
