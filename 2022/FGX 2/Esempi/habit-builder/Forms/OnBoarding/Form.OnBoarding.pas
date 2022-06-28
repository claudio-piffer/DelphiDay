unit Form.OnBoarding;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Form.Base, FGX.Button.Types, FGX.Button, FGX.VirtualPagerLayout, FGX.PagerLayout, FGX.Image,
  FGX.StaticLabel, FGX.GraphicControl, FGX.Shape, FGX.Circle, FGX.Assets,
  System.Generics.Collections, Form.OnBoarding.Model;

type
  TFormOnBoarding = class(TFormBasic)
    plIntroduction: TfgPagerLayout;
    lNavigation: TfgLayout;
    btnSkip: TfgButton;
    btnNext: TfgButton;
    lPageIndicator: TfgLayout;
    lPageTitle: TfgLabel;
    imgPage: TfgImage;
    lSlogan: TfgLabel;
    cPage1: TfgCircle;
    cPage2: TfgCircle;
    cPage3: TfgCircle;
    cPage4: TfgCircle;
    btnGetStarted: TfgButton;
    procedure btnNextTap(Sender: TObject);
    procedure plIntroductionChanged(Sender: TObject);
    procedure CloseForm(Sender: TObject);
  private
    FModel: TOnBoardingModel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GoNextPage;
  end;

var
  FormOnBoarding: TFormOnBoarding;

implementation

{$R *.xfm}

uses
  System.SysUtils, Assets.Consts, FGX.Animation, FGX.Animation.Helpers, FGX.Animation.Types, Form.Login;

{ TFormOnBoarding }

procedure TFormOnBoarding.CloseForm(Sender: TObject);
begin
  inherited;
  CloseModal;
  FormLogin.ShowModal;
end;

procedure TFormOnBoarding.btnNextTap(Sender: TObject);
begin
  GoNextPage;
end;

constructor TFormOnBoarding.Create(AOwner: TComponent);

  procedure BuildPages;
  var
    I: Integer;
    Image: TfgImage;
  begin
    plIntroduction.DeleteControls;
    plIntroduction.BeginUpdate;
    for I := 0 to FModel.PagesCount - 1 do
    begin
      Image := TfgImage.Create(Self);
      Image.ImageName := FModel.Pages[I].ImageName;
      plIntroduction.AddControl(Image);
    end;
    plIntroduction.EndUpdate;
  end;

var
  HideAnimator: TfgAnimation;
  ShowAnimator: TfgAnimation;
begin
  inherited;
  FModel := TOnBoardingModel.Create;
  BuildPages;

  HideAnimator := lPageTitle.AnimationManager.CreateOpacityAnimation(1, 0, 200)
                                             .SetOnFinish(procedure
                                                          begin
                                                            lPageTitle.Text := FModel.Pages[plIntroduction.PageIndex].Title;
                                                          end);

  ShowAnimator := lPageTitle.AnimationManager.CreateOpacityAnimation(0, 1, 200)
                                             .SetRunOrder(TfgAnimationRunOrder.AfterPrevious);

  lPageTitle.AnimationManager.AddGroupAnimation
                             .Add(HideAnimator)
                             .Add(ShowAnimator)
                             .SetName('Switch Title');
end;

destructor TFormOnBoarding.Destroy;
begin
  FreeAndNil(FModel);
  inherited;
end;

procedure TFormOnBoarding.GoNextPage;
begin
  plIntroduction.GoToNextPage(True);
  plIntroduction.Changed;
end;

procedure TFormOnBoarding.plIntroductionChanged(Sender: TObject);

  procedure Activate(const AIndicator: TfgCircle);
  begin
    AIndicator.Fill.ColorName := R.Theme.Color.TEXT_TEXT;
    AIndicator.Stroke.Thickness := 0;
  end;

  procedure Deactivate(const AIndicator: TfgCircle);
  begin
    AIndicator.Fill.ColorName := R.Theme.Color.PRIMARY_COLOR;
    AIndicator.Stroke.Thickness := 1;
  end;

var
  ActiveIndex: Integer;
  ActiveIndicator: TfgCircle;
  I: Integer;
begin
  inherited;
  ActiveIndex := plIntroduction.PageIndex;
  for I := 0 to lPageIndicator.ControlsCount - 1 do
    if I <> ActiveIndex then
      Deactivate(lPageIndicator.Controls[I] as TfgCircle);

  ActiveIndicator := lPageIndicator.Controls[ActiveIndex] as TfgCircle;
  Activate(ActiveIndicator);

  lPageTitle.AnimationManager.Animations['Switch Title'].Start;

  if ActiveIndex = FModel.PagesCount - 1 then
  begin
    btnGetStarted.Visible := True;
    lNavigation.Visible := False;
  end
  else
  begin
    btnGetStarted.Visible := False;
    lNavigation.Visible := True;
  end;
end;

end.
