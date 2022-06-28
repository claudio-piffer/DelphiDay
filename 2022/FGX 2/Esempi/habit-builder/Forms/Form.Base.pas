unit Form.Base;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls.Types, FGX.Layout,
  FGX.Layout.Types;

type
  TFormBasic = class(TfgForm)
  public
    procedure ShowModal;
    procedure CloseModal;
  end;

var
  FormBasic: TFormBasic;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log, FGX.Animation, FGX.Animation.Types, FGX.Controls;

{ TForm1 }

procedure TFormBasic.CloseModal;
var
  Form: IFGXForm;
  Options: TfgAnimationOptions;
begin
  if Supports(Self, IFGXForm, Form) and (Form.GetCloseAction = TfgFormCloseAction.Free) then
    Include(Options, TfgAnimationOption.ReleaseControlOnFinish);

  TfgAnimationHelper.HideModalForm(Self, Options);
end;

procedure TFormBasic.ShowModal;
begin
  Realign;
  TfgAnimationHelper.ShowModalForm(Self);
end;

end.
