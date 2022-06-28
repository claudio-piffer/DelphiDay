unit Form.ResetPassword;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Form.Base, FGX.CardPanel, FGX.Image, FGX.StaticLabel, FGX.Edit, FGX.GraphicControl, FGX.Shape,
  FGX.Rectangle, FGX.Button.Types, FGX.Button;

type
  TFormResetPassword = class(TFormBasic)
    lPageTitle: TfgLabel;
    fgImage1: TfgImage;
    fgCardPanel1: TfgCardPanel;
    fgLabel1: TfgLabel;
    lEmail: TfgLayout;
    fgRectangle1: TfgRectangle;
    fgImage2: TfgImage;
    fgEdit1: TfgEdit;
    btnSendResetLink: TfgButton;
    lLogin: TfgLabel;
    btnBack: TfgButton;
    procedure btnSendResetLinkTap(Sender: TObject);
    procedure btnBackTap(Sender: TObject);
    procedure lLoginTap(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormResetPassword: TFormResetPassword;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log, FGX.Toasts;

procedure TFormResetPassword.btnBackTap(Sender: TObject);
begin
  inherited;
  CloseModal;
end;

procedure TFormResetPassword.btnSendResetLinkTap(Sender: TObject);
begin
  inherited;
  TfgToastFactory.Show('Send reset link');
end;

procedure TFormResetPassword.lLoginTap(Sender: TObject);
begin
  inherited;
  CloseModal;
end;

end.
