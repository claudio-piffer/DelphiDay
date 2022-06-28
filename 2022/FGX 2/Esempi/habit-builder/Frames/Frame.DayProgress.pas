unit Frame.DayProgress;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, FGX.CardPanel, FGX.GraphicControl, FGX.Shape, FGX.SvgPath, Data.Entities,
  Frame.Base;

const
  Progress50 = 'M2 11.1359C2 7.64892 6.15084 5.83155 8.71312 8.19673L28 26L45.8033 45.2869C48.1685 47.8492 46.3511 52 42.8641 52H14C7.37258 52 2 46.6274 2 40V11.1359Z';
  Progress100 = 'M 2,2C 4,0 8,0 12,0L 36,0C 40,0 44,0 46,2C 48,4 48,8 48,12L 48,36C 48,40 48,44 46,46C 44,48 40,48 36,48L 12,48C 8,48 4,48 2,46C 0,44 0,40 0,36L 0,12C 0,8 0,4 2,2 Z ';

type
  TFrameDayProgress = class(TFrameBase)
    cpBackground: TfgCardPanel;
    fgSvgPath1: TfgSvgPath;
  private
    FProgress: THabbitTrackDay;
    procedure SetProgress(const Value: THabbitTrackDay);
  public
    property Progress: THabbitTrackDay read FProgress write SetProgress;
  end;

var
  FrameDayProgress: TFrameDayProgress;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.Math, FGX.Application, FGX.Dialogs, FGX.Log;

{ TFrameDayProgress }

procedure TFrameDayProgress.SetProgress(const Value: THabbitTrackDay);
begin
  FProgress := Value;
  if IsZero(FProgress.Progress) then
    fgSvgPath1.PathData := ''
  else if InRange(FProgress.Progress, 0, 0.5) then
    fgSvgPath1.PathData := Progress50
  else if FProgress.Progress > 0.75 then
    fgSvgPath1.PathData := Progress100;
end;

end.
