unit Screen.Habbit;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Screen.Base, FGX.CardPanel, FGX.StaticLabel, FGX.Image, FGX.ScrollBox, FGX.Button.Types, FGX.Button,
  FGX.CollectionView, FGX.GraphicControl, FGX.Shape, FGX.SvgPath, FGX.Line;

const
  Progress50 = 'M2 11.1359C2 7.64892 6.15084 5.83155 8.71312 8.19673L28 26L45.8033 45.2869C48.1685 47.8492 46.3511 52 42.8641 52H14C7.37258 52 2 46.6274 2 40V11.1359Z';
  Progress100 = 'M 2,2C 4,0 8,0 12,0L 36,0C 40,0 44,0 46,2C 48,4 48,8 48,12L 48,36C 48,40 48,44 46,46C 44,48 40,48 36,48L 12,48C 8,48 4,48 2,46C 0,44 0,40 0,36L 0,12C 0,8 0,4 2,2 Z ';

type
  TFormHabit = class(TScreenBase)
    cpShortInfo: TfgCardPanel;
    fgImage1: TfgImage;
    fgLayout1: TfgLayout;
    lTitle: TfgLabel;
    fgLayout2: TfgLayout;
    fgImage2: TfgImage;
    fgLabel2: TfgLabel;
    fgLayout3: TfgLayout;
    fgImage3: TfgImage;
    fgLabel3: TfgLabel;
    cpSchedule: TfgCardPanel;
    fgVerticalScrollBox1: TfgVerticalScrollBox;
    lCalendarHeader: TfgLayout;
    btnPrevMonth: TfgButton;
    lCurrentMonth: TfgLabel;
    btnNextMonth: TfgButton;
    lWeekDays: TfgLayout;
    fgLabel5: TfgLabel;
    fgLabel6: TfgLabel;
    fgLabel7: TfgLabel;
    fgLabel8: TfgLabel;
    fgLabel9: TfgLabel;
    fgLabel10: TfgLabel;
    fgLabel11: TfgLabel;
    cvMonthDays: TfgCollectionView;
    cvMonthDays_Styles: TfgCollectionViewStyles;
    cvMonthDays_Style1: TfgCollectionViewStyle;
    fgCardPanel3: TfgCardPanel;
    fgLabel12: TfgLabel;
    cpBackground: TfgCardPanel;
    fgSvgPath1: TfgSvgPath;
    cpStats: TfgCardPanel;
    fgLayout6: TfgLayout;
    fgLabel13: TfgLabel;
    fgLayout7: TfgLayout;
    fgLayout8: TfgLayout;
    fgLine1: TfgLine;
    fgLayout9: TfgLayout;
    fgLine2: TfgLine;
    fgLabel14: TfgLabel;
    fgLabel15: TfgLabel;
    fgImage4: TfgImage;
    fgLayout11: TfgLayout;
    fgLayout10: TfgLayout;
    fgLayout12: TfgLayout;
    fgLabel16: TfgLabel;
    fgLabel17: TfgLabel;
    fgImage5: TfgImage;
    fgLayout13: TfgLayout;
    fgLayout14: TfgLayout;
    fgLabel18: TfgLabel;
    fgLabel19: TfgLabel;
    fgImage6: TfgImage;
    fgLine3: TfgLine;
    fgLayout15: TfgLayout;
    fgLayout16: TfgLayout;
    fgLabel20: TfgLabel;
    fgLabel21: TfgLabel;
    fgImage7: TfgImage;
    btnGetStarted: TfgButton;
    fgButton3: TfgButton;
    function cvMonthDaysGetItemCount(Sender: TObject): Integer;
    procedure cvMonthDaysBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
  protected
    FDate: TDate;
    function ItemIndexToMonthDay(const AItemIndex: Integer): Word;
    function GetTitle: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetSafeAreaPaddings(const ATop, ABottom: Single); override;
    function IsChild: Boolean; override;
  end;

var
  FormHabit: TFormHabit;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.Math, FGX.Application, FGX.Dialogs, FGX.Log, System.DateUtils;

constructor TFormHabit.Create(AOwner: TComponent);
begin
  inherited;
  FDate := Today;
end;

procedure TFormHabit.cvMonthDaysBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  DayLabel: TfgLabel;
  FillPath: TfgSvgPath;
  Progress: Single;
begin
  inherited;
  DayLabel := AItem.GetControlByLookupName<TfgLabel>('day');
  DayLabel.Text := ItemIndexToMonthDay(AIndex).ToString;

  FillPath := AItem.GetControlByLookupName<TfgSvgPath>('fill');
  Progress := Random(100) / 100;
  if IsZero(Progress) then
    FillPath.PathData := ''
  else if InRange(Progress, 0, 0.5) then
    FillPath.PathData := Progress50
  else if Progress > 0.75 then
    FillPath.PathData := Progress100;
end;

function TFormHabit.cvMonthDaysGetItemCount(Sender: TObject): Integer;
begin
  inherited;
  Result := 35;
end;

function TFormHabit.GetTitle: string;
begin
  Result := 'Habit';
end;

function TFormHabit.IsChild: Boolean;
begin
  Result := True;
end;

function TFormHabit.ItemIndexToMonthDay(const AItemIndex: Integer): Word;
begin
  Result := AItemIndex;
end;

procedure TFormHabit.SetSafeAreaPaddings(const ATop, ABottom: Single);
begin
  inherited;
  fgVerticalScrollBox1.Padding.Bottom := ABottom;
  fgVerticalScrollBox1.Padding.Top := ATop;
end;

end.
