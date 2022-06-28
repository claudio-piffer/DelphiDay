unit Frame.HabbitWeek;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, FGX.CardPanel, FGX.GraphicControl, FGX.Shape, FGX.Line, FGX.StaticLabel, Data.Entities, Frame.Base;

type
  TFrameHabbitWeek = class(TFrameBase)
    fgCardPanel1: TfgCardPanel;
    lTitle: TfgLabel;
    lSeparator: TfgLine;
  private
    FHabit: THabit;
  public
    procedure LoadHabit(const AHabit: THabit);
    property Habit: THabit read FHabit;
  end;

var
  FrameHabbitWeek: TFrameHabbitWeek;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log, System.Math, Frame.DayProgress, FGX.Helpers.UI;

{ TForm2 }

procedure TFrameHabbitWeek.LoadHabit(const AHabit: THabit);
var
  I: Integer;
  TrackDay: TFrameDayProgress;
begin
  FHabit := AHabit;
  lTitle.Text := AHabit.Title;

  for I := 0 to Min(AHabit.Days.Count, 5) do
  begin
    TrackDay := TFrameDayProgress.Create(nil);
    TrackDay.BeginUpdate;
    try
      TrackDay.cpBackground.BackgroundColorName := AHabit.AccentColor + ' Light';
      TrackDay.fgSvgPath1.Fill.ColorName := AHabit.AccentColor;
      TrackDay.cpBackground.Margins.Left := 2;
      TrackDay.cpBackground.Margins.Right := 10;
      AddFrame(fgCardPanel1, TrackDay);
    finally
      TrackDay.EndUpdate;
    end;
    TrackDay.Progress := AHabit.Days[I];
  end;
end;

end.
