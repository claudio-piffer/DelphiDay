unit Frame.Day;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, FGX.StaticLabel, FGX.CardPanel, Frame.Base;

type
  TFrameDay = class(TFrameBase)
    cpDayEtalon: TfgCardPanel;
    lDay: TfgLabel;
    lNumber: TfgLabel;
  private
    FDate: TDate;
    procedure SetDate(const Value: TDate);
  public
    property Date: TDate write SetDate;
  end;

var
  FrameDay: TFrameDay;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, System.DateUtils;

{ TFrameDay }

procedure TFrameDay.SetDate(const Value: TDate);
begin
  FDate := Value;
  lDay.Text := FormatSettings.ShortDayNames[DayOfTheWeek(Value)];
  lNumber.Text := DayOf(Value).ToString;
end;

end.
