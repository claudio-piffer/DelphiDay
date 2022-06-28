unit Frame.ReminderEditor;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Frame.Base, FGX.Button.Types, FGX.StaticLabel, FGX.Button, FGX.DateTimeControl, FGX.TimePicker;

type
  TFrameReminderEditor = class(TFrameBase)
    lHeader: TfgLayout;
    btnCancel: TfgButton;
    lTitle: TfgLabel;
    btnSave: TfgButton;
    tpAlarmTime: TfgTimePicker;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrameReminderEditor: TFrameReminderEditor;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log;

end.
