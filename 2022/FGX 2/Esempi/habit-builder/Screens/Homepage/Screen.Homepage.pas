unit Screen.Homepage;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, FGX.StaticLabel, FGX.Image, FGX.CardPanel, FGX.ScrollBox, Screen.Base, Data.Entities;

type
  THabitSelectedEvent = procedure (Sender: TObject; const AHabbit: THabit) of object;

  TScreenHomepage = class(TScreenBase)
    cpQuoteBanner: TfgCardPanel;
    imgIllustration: TfgImage;
    lQuote: TfgLabel;
    lQuoteAuthor: TfgLabel;
    lDaysContainer: TfgLayout;
    lHabitTitle: TfgLabel;
    sbContent: TfgVerticalScrollBox;
  protected
    FOnHabitSelected: THabitSelectedEvent;
    function GetTitle: string; override;
    procedure HabitFrameTapHandler(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetSafeAreaPaddings(const ATop, ABottom: Single); override;

    property OnHabitSelected: THabitSelectedEvent read FOnHabitSelected write FOnHabitSelected;
  end;

var
  ScreenHomepage: TScreenHomepage;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log, System.DateUtils, Frame.Day, FGX.DateUtils, FGX.Helpers.UI,
  Frame.DayProgress, Frame.HabbitWeek, FGX.Asserts, FGX.Assets,
  Assets.Consts;

{ TFrameHomepage }

constructor TScreenHomepage.Create(AOwner: TComponent);
var
  DayNumber: Integer;
  Day: TFrameDay;
  WeekDate: TDate;
  Habbit: THabit;
  HabbitWeekFrame: TFrameHabbitWeek;
begin
  inherited;
  WeekDate := DecDay(Now, 5);
  for DayNumber := 1 to 5 do
  begin
    Day := TFrameDay.Create(nil);
    Day.Date := WeekDate;
    Day.Margins.Left := 4;
    Day.Margins.Right := 14;

    WeekDate := IncDay(WeekDate, 1);
    AddFrame(lDaysContainer, Day);
  end;

  for Habbit in Repository.ActiveHabbits do
  begin
    HabbitWeekFrame := TFrameHabbitWeek.Create(nil);
    AddFrame(sbContent, HabbitWeekFrame, 0);
    HabbitWeekFrame.LoadHabit(Habbit);
    HabbitWeekFrame.Margins.Top := 4;
    HabbitWeekFrame.Margins.Bottom := 4;
    HabbitWeekFrame.Margins.Left := 16;
    HabbitWeekFrame.OnTap := HabitFrameTapHandler;
  end;
end;

function TScreenHomepage.GetTitle: string;
begin
  Result := 'Homepage';
end;

procedure TScreenHomepage.HabitFrameTapHandler(Sender: TObject);
begin
  if Assigned(FOnHabitSelected) then
    FOnHabitSelected(Self, TFrameHabbitWeek(Sender).Habit);
end;

procedure TScreenHomepage.SetSafeAreaPaddings(const ATop, ABottom: Single);
begin
  inherited;
  sbContent.Padding.Top := ATop;
  sbContent.Padding.Bottom := ABottom;
end;

end.
