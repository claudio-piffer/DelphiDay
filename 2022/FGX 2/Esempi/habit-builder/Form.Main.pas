unit Form.Main;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Form.Base, FGX.Button.Types, FGX.Image, FGX.StaticLabel, FGX.Button, FGX.ScrollBox, FGX.CardPanel,
  Screen.Homepage, FGX.VirtualPagerLayout, FGX.PagerLayout, Screen.Base,
  Screen.NewHabit, Screen.Settings, FGX.Timer, Data.Entities,
  System.Generics.Collections, FGX.Assets, FGX.PageControl;

type
  TNavigationController = class;

  TNavigationButtonInfo = record
    ScreenId: string;
    ActiveIcon: TfgAssetName;
    InactiveIcon: TfgAssetName;
    Button: TfgButton;
  end;

  TFormMain = class(TFormBasic)
    lToolbar: TfgLayout;
    lTitle: TfgLabel;
    imgAvatar: TfgImage;
    btnMenu: TfgButton;
    imgBackground: TfgImage;
    lNavigationBar: TfgLayout;
    lNavigationContainer: TfgLayout;
    btnAddHabit: TfgButton;
    fgLayout1: TfgLayout;
    fgLayout2: TfgLayout;
    fgTimer: TfgTimer;
    btnHome: TfgButton;
    btnCourses: TfgButton;
    btnCommunity: TfgButton;
    btnSettings: TfgButton;
    plScreens: TfgPageControl;
    procedure fgFormShow(Sender: TObject);
    procedure btnAddHabitTap(Sender: TObject);
    procedure fgTimerTimer(Sender: TObject);
    procedure NavigationTap(Sender: TObject);
    procedure btnMenuTap(Sender: TObject);
  private
    FNavigationController: TNavigationController;
    FNavigationButtons: TList<TNavigationButtonInfo>;
    { Handler }
    procedure ScreenChangedHandler(Sender: TObject; const AScreen: TScreenBase);
    procedure HabitSelectedHandler(Sender: TObject; const AHabbit: THabit);
    { Navigation }
    procedure HighlightButton(const AButton: TfgButton);
  protected
    procedure DoResized; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TScreenChangedEvent = procedure (Sender: TObject; const AScreen: TScreenBase) of object;

  TNavigationController = class
  private
    [Weak] FMainForm: TFormMain;
    FScreens: TDictionary<string, TScreenBase>;
    FRoute: TStack<TScreenBase>;
    FOnChanged: TScreenChangedEvent;
    function FindPageIndex(const AInstance: TfgControl; out APageIndex: Integer): Boolean;
  protected
    procedure DoChanged; virtual;
  public
    constructor Create(const AMainForm: TFormMain);
    destructor Destroy; override;

    procedure RegisterPermanentScreen(const AId: string; const AScreenClass: TfgScreenBaseClass); overload;
    procedure RegisterPermanentScreen(const AId: string; const AScreen: TScreenBase); overload;

    procedure ShowMainScreen(const AId: string);
    procedure ShowChildScreen(const AId: string);
    procedure ShowPreviousScreen;

    function HasPreviousScreen: Boolean;

    property OnChanged: TScreenChangedEvent read FOnChanged write FOnChanged;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log, System.DateUtils, Frame.Day, FGX.DateUtils, FGX.Helpers.UI,
  Frame.DayProgress, Frame.HabbitWeek, FGX.Asserts, Assets.Consts, Screen.Courses, Screen.Community,
  FGX.Animation, Screen.Habbit, Form.OnBoarding;

procedure TFormMain.btnAddHabitTap(Sender: TObject);
begin
  FNavigationController.ShowChildScreen('habit-new');
end;

procedure TFormMain.btnMenuTap(Sender: TObject);
begin
  if FNavigationController.HasPreviousScreen then
    FNavigationController.ShowPreviousScreen
  else
    // Show menu
    ;
end;

constructor TFormMain.Create(AOwner: TComponent);
var
  HomeScreen: TScreenHomepage;
  NavigationButtonInfo: TNavigationButtonInfo;
begin
  inherited;
  FNavigationController := TNavigationController.Create(Self);
  FNavigationController.OnChanged := ScreenChangedHandler;

  { Registering screens }
  FNavigationController.RegisterPermanentScreen('empty', TScreenBase);
  FNavigationController.RegisterPermanentScreen('courses', TScreenCourses);
  FNavigationController.RegisterPermanentScreen('community', TScreenCommunity);
  FNavigationController.RegisterPermanentScreen('settings', TScreenSettings);
  FNavigationController.RegisterPermanentScreen('habit-view', TFormHabit);
  FNavigationController.RegisterPermanentScreen('habit-new', TScreenNewHabit);

  HomeScreen := TScreenHomepage.Create(nil);
  HomeScreen.OnHabitSelected := HabitSelectedHandler;
  FNavigationController.RegisterPermanentScreen('home', HomeScreen);

  FNavigationButtons := TList<TNavigationButtonInfo>.Create;

  { Home }
  NavigationButtonInfo.ScreenId := 'home';
  NavigationButtonInfo.Button := btnHome;
  NavigationButtonInfo.ActiveIcon := R.Bitmap.UI_BUTTONS_HOME;
  NavigationButtonInfo.InactiveIcon := R.Bitmap.UI_BUTTONS_HOME_INACTIVE;
  FNavigationButtons.Add(NavigationButtonInfo);

  { Courses }
  NavigationButtonInfo.ScreenId := 'courses';
  NavigationButtonInfo.Button := btnCourses;
  NavigationButtonInfo.ActiveIcon := R.Bitmap.UI_BUTTONS_COURSES;
  NavigationButtonInfo.InactiveIcon := R.Bitmap.UI_BUTTONS_COURSES_INACTIVE;
  FNavigationButtons.Add(NavigationButtonInfo);

  { Community }
  NavigationButtonInfo.ScreenId := 'community';
  NavigationButtonInfo.Button := btnCommunity;
  NavigationButtonInfo.ActiveIcon := R.Bitmap.UI_BUTTONS_COMMUNITY;
  NavigationButtonInfo.InactiveIcon := R.Bitmap.UI_BUTTONS_COMMUNITY_INACTIVE;
  FNavigationButtons.Add(NavigationButtonInfo);

  { Settings }
  NavigationButtonInfo.ScreenId := 'settings';
  NavigationButtonInfo.Button := btnSettings;
  NavigationButtonInfo.ActiveIcon := R.Bitmap.UI_BUTTONS_SETTINGS;
  NavigationButtonInfo.InactiveIcon := R.Bitmap.UI_BUTTONS_SETTINGS_INACTIVE;
  FNavigationButtons.Add(NavigationButtonInfo);
end;

destructor TFormMain.Destroy;
begin
  FreeAndNil(FNavigationButtons);
  FreeAndNil(FNavigationController);
  inherited;
end;

procedure TFormMain.DoResized;
//var
//  I: Integer;
begin
  inherited;
  if IsCreating or IsLoading then
    Exit;
end;

procedure TFormMain.fgFormShow(Sender: TObject);
begin
  inherited;
  FNavigationController.ShowMainScreen('home');
end;

procedure TFormMain.fgTimerTimer(Sender: TObject);
begin
  inherited;
  FormOnBoarding.ShowModal;
  fgTimer.Enabled := False;
end;

procedure TFormMain.HabitSelectedHandler(Sender: TObject; const AHabbit: THabit);
begin
  FNavigationController.ShowChildScreen('habit-view');
end;

procedure TFormMain.HighlightButton(const AButton: TfgButton);
var
  Info: TNavigationButtonInfo;
begin
  for Info in FNavigationButtons do
    if Info.Button = AButton then
      Info.Button.IconName := Info.ActiveIcon
    else
      Info.Button.IconName := Info.InactiveIcon;
end;

procedure TFormMain.NavigationTap(Sender: TObject);

  function FindScreenId(const AButton: TfgButton; out AScreenId: string): Boolean;
  var
    Info: TNavigationButtonInfo;
  begin
    for Info in FNavigationButtons do
      if Info.Button = AButton then
      begin
        AScreenId := Info.ScreenId;
        Exit(True);
      end;
    Result := False;
  end;

var
  NavigationButton: TfgButton;
  //NewImageName: TfgAssetName;
  ScreenId: string;
begin
  TfgAssert.IsClass(Sender, TfgButton);

  inherited;
  NavigationButton := TfgButton(Sender);
  HighlightButton(NavigationButton);

  if FindScreenId(NavigationButton, ScreenId) then
    FNavigationController.ShowMainScreen(ScreenId);
end;

procedure TFormMain.ScreenChangedHandler(Sender: TObject; const AScreen: TScreenBase);
begin
  lTitle.Text := AScreen.Title;
  if FNavigationController.HasPreviousScreen then
    btnMenu.IconName := R.Bitmap.BUTTONS_ICONS_BACK
  else
    btnMenu.IconName := R.Bitmap.BUTTONS_ICONS_MENU;
end;

{ TNavigationController }

constructor TNavigationController.Create(const AMainForm: TFormMain);
begin
  TfgAssert.IsNotNil(AMainForm, 'AMainForm');

  FMainForm := AMainForm;
  FRoute := TStack<TScreenBase>.Create;
  FScreens := TDictionary<string, TScreenBase>.Create;
end;

destructor TNavigationController.Destroy;
begin
  FreeAndNil(FScreens);
  FreeAndNil(FRoute);
  inherited;
end;

procedure TNavigationController.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self, FRoute.Peek);
end;

function TNavigationController.FindPageIndex(const AInstance: TfgControl; out APageIndex: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to FMainForm.plScreens.PagesCount - 1 do
    if FMainForm.plScreens.Pages[I].Controls[0] = AInstance then
    begin
      APageIndex := I;
      Exit(True);
    end;

  Result := False;
end;

function TNavigationController.HasPreviousScreen: Boolean;
begin
  Result := FRoute.Count > 1;
end;

procedure TNavigationController.RegisterPermanentScreen(const AId: string; const AScreen: TScreenBase);
var
  Page: TfgCustomPage;
begin
  AScreen.SetSafeAreaPaddings(FMainForm.lToolbar.Height + FMainForm.lToolbar.Margins.Bottom,
                              FMainForm.lNavigationContainer.Height + 16);
  Page := FMainForm.plScreens.AddPage;
  AddFrame(Page, AScreen);
  FScreens.Add(AId, AScreen);
end;

procedure TNavigationController.RegisterPermanentScreen(const AId: string; const AScreenClass: TfgScreenBaseClass);
var
  ScreenForm: TScreenBase;
begin
  ScreenForm := AScreenClass.Create(nil);
  RegisterPermanentScreen(AId, ScreenForm);
end;

procedure TNavigationController.ShowChildScreen(const AId: string);
var
  ScreenInstance: TScreenBase;
  PageIndex: Integer;
begin
  if FScreens.TryGetValue(AId, ScreenInstance) and FindPageIndex(ScreenInstance, PageIndex) then
  begin
    FRoute.Push(ScreenInstance);
    FMainForm.plScreens.PageIndex := PageIndex;
    DoChanged;
  end;
end;

procedure TNavigationController.ShowMainScreen(const AId: string);
var
  ScreenInstance: TScreenBase;
  PageIndex: Integer;
begin
  if FScreens.TryGetValue(AId, ScreenInstance) and FindPageIndex(ScreenInstance, PageIndex) then
  begin
    FRoute.Clear;
    FRoute.Push(ScreenInstance);
    FMainForm.plScreens.PageIndex := PageIndex;

    DoChanged;
  end;
end;

procedure TNavigationController.ShowPreviousScreen;
var
  ScreenInstance: TScreenBase;
  PageIndex: Integer;
begin
  if FRoute.Count <= 1 then
    Exit;

  FRoute.Pop;
  ScreenInstance := FRoute.Peek;

  if FindPageIndex(ScreenInstance, PageIndex) then
  begin
    FRoute.Clear;
    FRoute.Push(ScreenInstance);
    FMainForm.plScreens.PageIndex := PageIndex;
    DoChanged;
  end;

end;

end.
