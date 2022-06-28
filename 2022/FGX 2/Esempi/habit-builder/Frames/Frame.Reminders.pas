unit Frame.Reminders;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Frame.Base, FGX.Switch, FGX.StaticLabel, FGX.GraphicControl, FGX.Shape, FGX.Rectangle,
  FGX.CollectionView, FGX.Button.Types, FGX.Button,
  System.Generics.Collections;

type
  TfgReminder = record
    Enabled: Boolean;
    Time: TTime;
  end;

  TFrameReminders = class(TFrameBase)
    cvReminders: TfgCollectionView;
    cvReminders_Styles: TfgCollectionViewStyles;
    cvReminders_StyleAlarmOn: TfgCollectionViewStyle;
    fgRectangle1: TfgRectangle;
    fgLabel6: TfgLabel;
    fgSwitch2: TfgSwitch;
    cvReminders_StyleAlarmOff: TfgCollectionViewStyle;
    fgRectangle2: TfgRectangle;
    fgLabel7: TfgLabel;
    fgSwitch3: TfgSwitch;
    lFooter: TfgLayout;
    btnAddNewReminder: TfgButton;
    btnClearAll: TfgButton;
    function cvRemindersGetItemCount(Sender: TObject): Integer;
    procedure fgSwitch2Changed(Sender: TObject);
    function cvRemindersGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure cvRemindersBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
    procedure cvRemindersGetItemId(Sender: TObject; const AIndex: Integer; var AId: Int64);
  private
    FReminders: TList<TfgReminder>;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FrameReminders: TFrameReminders;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log;

constructor TFrameReminders.Create(AOwner: TComponent);
const
  StartHour = 6; //sec
var
  I: Integer;
  Reminder: TfgReminder;
begin
  inherited;
  FReminders := TList<TfgReminder>.Create;
  for I := 0 to 32 do
  begin
    Reminder.Enabled := False;
    Reminder.Time := EncodeTime(StartHour + I * 30 div 60, I * 30 mod 60, 0, 0);
    FReminders.Add(Reminder);
  end;
end;

destructor TFrameReminders.Destroy;
begin
  FreeAndNil(FReminders);
  inherited;
end;

procedure TFrameReminders.cvRemindersBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  TimeLabel: TfgLabel;
  EnabledSwitch: TfgSwitch;
begin
  TimeLabel := AItem.GetControlByLookupName<TfgLabel>('time');
  TimeLabel.Text := FormatDateTime('hh:nn', FReminders[AIndex].Time);

  EnabledSwitch := AItem.GetControlByLookupName<TfgSwitch>('enabled');
  EnabledSwitch.IsChecked := FReminders[AIndex].Enabled;
end;

function TFrameReminders.cvRemindersGetItemCount(Sender: TObject): Integer;
begin
  Result := FReminders.Count;
end;

procedure TFrameReminders.cvRemindersGetItemId(Sender: TObject; const AIndex: Integer; var AId: Int64);
begin
  AId := AIndex;
end;

function TFrameReminders.cvRemindersGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  if FReminders[AIndex].Enabled then
    Result := cvReminders_StyleAlarmOn.StyleName
  else
    Result := cvReminders_StyleAlarmOff.StyleName;
end;

procedure TFrameReminders.fgSwitch2Changed(Sender: TObject);
var
  ItemIndex: Integer;
  Reminder: TfgReminder;
begin
  inherited;
  if cvReminders.FindItemIndexByObject(Sender, ItemIndex) then
  begin
    Reminder := FReminders[ItemIndex];
    Reminder.Enabled := not Reminder.Enabled;
    FReminders[ItemIndex] := Reminder;
    cvReminders.ReloadItem(ItemIndex);
  end;
end;

end.
