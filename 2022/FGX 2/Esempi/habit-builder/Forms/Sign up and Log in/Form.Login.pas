unit Form.Login;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Form.Base, FGX.Image, FGX.StaticLabel, FGX.Button.Types, FGX.Button, FGX.CardPanel,
  FGX.GraphicControl, FGX.Shape, FGX.Line, FGX.BottomSheetLayout, FGX.Rectangle, FGX.Edit, FGX.ScrollBox;

type
  TFormLogin = class(TFormBasic)
    imgDissolution: TfgImage;
    lPageTitle: TfgLabel;
    btnLoginViaGoogle: TfgButton;
    btnLoginViaFacebook: TfgButton;
    lKeyboardPlaceholder: TfgLayout;
    fgCardPanel1: TfgCardPanel;
    fgLabel1: TfgLabel;
    fgLine1: TfgLine;
    lEmail: TfgLayout;
    fgRectangle1: TfgRectangle;
    fgImage2: TfgImage;
    edEmail: TfgEdit;
    fgLayout1: TfgLayout;
    fgRectangle2: TfgRectangle;
    fgImage3: TfgImage;
    edPassword: TfgEdit;
    btnShowPassword: TfgButton;
    btnLogin: TfgButton;
    lForgotPassword: TfgLabel;
    lSignUp: TfgLabel;
    fgLayout2: TfgLayout;
    sbContent: TfgVerticalScrollBox;
    imgBackground: TfgImage;
    procedure fgFormVirtualKeyboardFrameChanged(Sender: TObject; const AVKFrame: TRectF);
    procedure fgBottomSheetLayout1_SheetStateChanged(Sender: TObject; const AOldState, ANewState: TfgBottomSheetState);
    procedure lForgotPasswordTap(Sender: TObject);
    procedure lSignUpTap(Sender: TObject);
    procedure btnShowPasswordTouch(Sender: TObject; const ATouches: TfgTouches; const AAction: TfgTouchAction;
      var AHandled: Boolean);
    procedure btnLoginTap(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log, FGX.VirtualKeyboard, Form.ResetPassword, Form.SignUp,
  Form.Main;

procedure TFormLogin.fgBottomSheetLayout1_SheetStateChanged(Sender: TObject; const AOldState,
  ANewState: TfgBottomSheetState);
begin
  inherited;
  if ANewState = TfgBottomSheetState.Dragging then
    TfgVirtualKeyboard.Hide;
end;

procedure TFormLogin.btnLoginTap(Sender: TObject);
begin
  inherited;
  CloseModal;
end;

procedure TFormLogin.btnShowPasswordTouch(Sender: TObject; const ATouches: TfgTouches; const AAction: TfgTouchAction;
  var AHandled: Boolean);
begin
  inherited;
  case AAction of
    TfgTouchAction.Down:
      edPassword.IsPassword := False;
    TfgTouchAction.Up,
    TfgTouchAction.Cancel:
      edPassword.IsPassword := True;
  end;
end;

procedure TFormLogin.fgFormVirtualKeyboardFrameChanged(Sender: TObject; const AVKFrame: TRectF);
begin
  lKeyboardPlaceholder.Height := AVKFrame.Height;
  lKeyboardPlaceholder.Visible := lKeyboardPlaceholder.Height > 0;
end;

procedure TFormLogin.lForgotPasswordTap(Sender: TObject);
begin
  inherited;
  FormResetPassword := TFormResetPassword.Create(nil);
  FormResetPassword.ShowModal;
end;

procedure TFormLogin.lSignUpTap(Sender: TObject);
begin
  inherited;
  FormSignUp := TFormSignUp.Create(nil);
  FormSignUp.ShowModal;
end;

end.
