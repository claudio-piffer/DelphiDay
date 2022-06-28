unit Navigation.Controller;

interface

uses
  Form.Main, Screen.Base;

type
  TNavigationController = class
  private
    [Weak] FMainForm: TFormMain;
  public
    constructor Create;
    destructor Destroy; override;

    procedure RegisterScreen(const AName: string; const AScreenClass: TfgScreenBaseClass);

    procedure ShowScreen(const AName: string);
  end;

var
  NavigationController: TNavigationController;

implementation

uses
  FGX.Helpers.UI;

{ TNavigationController }

constructor TNavigationController.Create;
begin

end;

destructor TNavigationController.Destroy;
begin

  inherited;
end;

procedure TNavigationController.RegisterScreen(const AName: string; const AScreenClass: TfgScreenBaseClass);
var
  ScreenForm: TScreenBase;
begin
  ScreenForm := AScreenClass.Create(nil);
  ScreenForm.SetSafeAreaPaddings(FMainForm.lToolbar.Height + FMainForm.lToolbar.Margins.Bottom,
                                 FMainForm.lNavigationContainer.Height + 16);
  AddFrame(FMainForm.plScreens, ScreenForm);
end;

procedure TNavigationController.ShowScreen(const AName: string);
begin

end;

end.
