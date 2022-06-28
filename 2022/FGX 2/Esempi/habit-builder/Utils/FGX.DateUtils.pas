unit FGX.DateUtils;

interface

uses
  System.DateUtils, FGX.Platform;

function DecDay(const AValue: TDateTime; const ANumberOfDays: Integer = 1): TDateTime; inline;
function DecHour(const AValue: TDateTime; const ANumberOfHours: Int64 = 1): TDateTime; inline;
function DecMinute(const AValue: TDateTime; const ANumberOfMinutes: Int64 = 1): TDateTime; inline;
function DecSecond(const AValue: TDateTime; const ANumberOfSeconds: Int64 = 1): TDateTime; inline;
function DecMilliSecond(const AValue: TDateTime; const ANumberOfMilliSeconds: Int64 = 1): TDateTime;

function FirstDayOfMonth(const AValue: TDateTime; const AFirstDayOfWeek: TfgFirstDayOfWeek): Word;

implementation

uses
  System.SysUtils;

function DecDay(const AValue: TDateTime; const ANumberOfDays: Integer = 1): TDateTime; inline;
begin
  Result := DecHour(AValue, ANumberOfDays * HoursPerDay);
end;

function DecHour(const AValue: TDateTime; const ANumberOfHours: Int64 = 1): TDateTime; inline;
begin
  Result := DecMinute(AValue, ANumberOfHours * MinsPerHour);
end;

function DecMinute(const AValue: TDateTime; const ANumberOfMinutes: Int64 = 1): TDateTime; inline;
begin
  Result := DecSecond(AValue, ANumberOfMinutes * SecsPerMin);
end;

function DecSecond(const AValue: TDateTime; const ANumberOfSeconds: Int64 = 1): TDateTime; inline;
begin
  Result := DecMilliSecond(Avalue, ANumberOfSeconds * MSecsPerSec);
end;

function DecMilliSecond(const AValue: TDateTime; const ANumberOfMilliSeconds: Int64 = 1): TDateTime;
var
  TS: TTimeStamp;
  TempTime: Comp;
begin
  TS := DateTimeToTimeStamp(AValue);
  TempTime := TimeStampToMSecs(TS);
  TempTime := TempTime - ANumberOfMilliSeconds;
  TS := MSecsToTimeStamp(TempTime);
  Result := TimeStampToDateTime(TS);
end;

function FirstDayOfMonth(const AValue: TDateTime; const AFirstDayOfWeek: TfgFirstDayOfWeek): Word;
var
  FirstMonth: TDateTime;
  //Day: Word;
begin
  FirstMonth := StartOfTheMonth(AValue);
  Result := DayOfTheWeek(FirstMonth);
end;

end.
