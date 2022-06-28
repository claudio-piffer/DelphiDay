unit Form.SignUp;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Form.Base, FGX.Image, FGX.StaticLabel, FGX.Button.Types, FGX.CheckBox, FGX.Button, FGX.Edit,
  FGX.GraphicControl, FGX.Shape, FGX.Rectangle, FGX.Line, FGX.ScrollBox;

type
  TFormSignUp = class(TFormBasic)
    fgImage1: TfgImage;
    lPageTitle: TfgLabel;
    lEmail: TfgLayout;
    fgRectangle1: TfgRectangle;
    fgImage2: TfgImage;
    fgEdit1: TfgEdit;
    lPassword: TfgLayout;
    fgRectangle2: TfgRectangle;
    fgImage3: TfgImage;
    fgEdit2: TfgEdit;
    fgButton4: TfgButton;
    fgCheckBox1: TfgCheckBox;
    fgCheckBox2: TfgCheckBox;
    btnCreateAccount: TfgButton;
    fgLayout2: TfgLayout;
    fgLine1: TfgLine;
    fgLabel1: TfgLabel;
    fgLine2: TfgLine;
    fgLayout3: TfgLayout;
    btnLoginViaFacebook: TfgButton;
    btnLoginViaGoogle: TfgButton;
    lSignIn: TfgLabel;
    fgVerticalScrollBox1: TfgVerticalScrollBox;
    fgLayout1: TfgLayout;
    fgRectangle3: TfgRectangle;
    fgImage4: TfgImage;
    fgEdit3: TfgEdit;
    procedure lSignInTap(Sender: TObject);
    procedure btnCreateAccountTap(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSignUp: TFormSignUp;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts;

procedure TFormSignUp.btnCreateAccountTap(Sender: TObject);
begin
  inherited;
  TfgToastFactory.Show('Create account');
end;

procedure TFormSignUp.lSignInTap(Sender: TObject);
begin
  inherited;
  CloseModal;
end;

end.
