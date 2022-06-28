unit Data.Entities;

interface

uses
  System.Generics.Collections, FGX.Assets;

type
  THabbitTrackDay = record
  public
    Day: TDate;
    Progress: Single;
    constructor Create(const ADay: TDate; const AProgress: Single = 1);
  end;

  THabit = class
  public
    Title: string;
    NeedRemind: Boolean;
    ReminderTime: TTime;
    AccentColor: TfgAssetName;
    Days: TList<THabbitTrackDay>;
    constructor Create;
    destructor Destroy; override;
  end;

  TRepository = class
  private
    FActiveHabbits: TObjectList<THabit>;
  public
    constructor Create;
    destructor Destroy; override;

    { Habits }
    function ActiveHabbits: TList<THabit>;
  end;

var
  Repository: TRepository;

implementation

uses
  System.SysUtils, FGX.DateUtils, System.DateUtils, Assets.Consts;

{ TRepository }

function TRepository.ActiveHabbits: TList<THabit>;
begin
  Result := FActiveHabbits;
end;

constructor TRepository.Create;

  procedure FillTrackDays(const ADays: TList<THabbitTrackDay>);
  var
    I: Integer;
    WeekDate: TDateTime;
  begin
    WeekDate := DecDay(Now, 5);
    for I := 1 to 10 do
    begin
      ADays.Add(THabbitTrackDay.Create(WeekDate, Random(100) / 100));
      WeekDate := IncDay(WeekDate, 1);
    end;
  end;

var
  Habit: THabit;
begin
  FActiveHabbits := TObjectList<THabit>.Create;

  Habit := THabit.Create;
  Habit.Title := 'Read A Book';
  Habit.NeedRemind := False;
  Habit.AccentColor := R.Color.COLORS_ECLIPSE;
  FillTrackDays(Habit.Days);
  FActiveHabbits.Add(Habit);

  Habit := THabit.Create;
  Habit.Title := 'Exercise';
  Habit.NeedRemind := False;
  Habit.AccentColor := R.Color.COLORS_FOG;
  FillTrackDays(Habit.Days);
  FActiveHabbits.Add(Habit);

  Habit := THabit.Create;
  Habit.Title := 'Wake Up Early';
  Habit.NeedRemind := False;
  Habit.AccentColor := R.Color.COLORS_MORNING;
  FillTrackDays(Habit.Days);
  FActiveHabbits.Add(Habit);

  Habit := THabit.Create;
  Habit.Title := 'Walk Dog';
  Habit.NeedRemind := False;
  Habit.AccentColor := R.Color.COLORS_SUNSET;
  FillTrackDays(Habit.Days);
  FActiveHabbits.Add(Habit);
end;

destructor TRepository.Destroy;
begin
  FreeAndNil(FActiveHabbits);
  inherited;
end;

{ THabbitTrackDay }

constructor THabbitTrackDay.Create(const ADay: TDate; const AProgress: Single);
begin
  Day := ADay;
  Progress := AProgress;
end;

{ THabit }

constructor THabit.Create;
begin
  Days := TList<THabbitTrackDay>.Create;
end;

destructor THabit.Destroy;
begin
  Days.Free;
  inherited;
end;

initialization
  Repository := TRepository.Create;
end.
