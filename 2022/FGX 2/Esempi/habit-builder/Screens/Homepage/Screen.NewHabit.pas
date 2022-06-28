unit Screen.NewHabit;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Screen.Base, FGX.Edit, FGX.CardPanel, FGX.Button.Types, FGX.Button, FGX.StaticLabel, FGX.Switch,
  FGX.CollectionView, FGX.GraphicControl, FGX.Shape, FGX.SvgPath, FGX.Image, FGX.Spacer, FGX.BottomSheetLayout,
  FGX.Rectangle, FGX.VirtualPagerLayout, FGX.PagerLayout, FGX.ScrollBox,
  Form.Reminders;

type
  TScreenNewHabit = class(TScreenBase)
    fgCardPanel1: TfgCardPanel;
    fgEdit1: TfgEdit;
    fgCardPanel3: TfgCardPanel;
    fgCardPanel4: TfgCardPanel;
    fgCardPanel5: TfgCardPanel;
    fgLayout2: TfgLayout;
    fgLabel1: TfgLabel;
    fgButton1: TfgButton;
    fgLabel2: TfgLabel;
    fgButton2: TfgButton;
    fgLabel3: TfgLabel;
    fgSwitch1: TfgSwitch;
    fgCollectionView1: TfgCollectionView;
    fgCollectionView1_Styles: TfgCollectionViewStyles;
    fgCollectionView1_Style1: TfgCollectionViewStyle;
    lDay: TfgLabel;
    cpBackground: TfgCardPanel;
    fgSvgPath1: TfgSvgPath;
    fgCardPanel6: TfgCardPanel;
    fgImage1: TfgImage;
    fgLabel4: TfgLabel;
    fgLabel5: TfgLabel;
    fgImage2: TfgImage;
    FooterContainer: TfgLayout;
    fgVerticalScrollBox1: TfgVerticalScrollBox;
    fgLayout4: TfgLayout;
    fgLayout1: TfgLayout;
    function fgCollectionView1GetItemCount(Sender: TObject): Integer;
    procedure fgButton2Tap(Sender: TObject);
    function fgCollectionView2GetItemCount(Sender: TObject): Integer;
    procedure fgCollectionView2GetItemId(Sender: TObject; const AIndex: Integer; var AId: Int64);
   protected
     function GetTitle: string; override;
   public
    constructor Create(AOwner: TComponent); override;
    procedure SetSafeAreaPaddings(const ATop, ABottom: Single); override;

    function IsChild: Boolean; override;
  end;

var
  ScreenNewHabit: TScreenNewHabit;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log, Frame.ReminderEditor, System.DateUtils, Frame.Reminders,
  FGX.Helpers.UI, FGX.Animation.Helpers;

constructor TScreenNewHabit.Create(AOwner: TComponent);
begin
  inherited;
  FooterContainer.AnimationManager.AddTranslationAnimation(TPointF.Zero, TPointF.Create(0, -16), 1000)
                                  .SetRepeatCount(0)
                                  .SetAutoReverse
                                  .Start;
end;

procedure TScreenNewHabit.fgButton2Tap(Sender: TObject);
begin
  FormReminderEditor := TFormReminderEditor.Create(nil);
  FormReminderEditor.ShowModal;
end;

function TScreenNewHabit.fgCollectionView1GetItemCount(Sender: TObject): Integer;
begin
  Result := 7;
end;

function TScreenNewHabit.fgCollectionView2GetItemCount(Sender: TObject): Integer;
begin
  Result := 48;
end;

procedure TScreenNewHabit.fgCollectionView2GetItemId(Sender: TObject; const AIndex: Integer; var AId: Int64);
begin
  inherited;
  AId := AIndex;
end;

function TScreenNewHabit.GetTitle: string;
begin
  Result := 'New Habit';
end;

function TScreenNewHabit.IsChild: Boolean;
begin
  Result := True;
end;

procedure TScreenNewHabit.SetSafeAreaPaddings(const ATop, ABottom: Single);
begin
  inherited;
  fgVerticalScrollBox1.Padding.Top := ATop;
  fgVerticalScrollBox1.Padding.Bottom := ABottom;
end;

end.
