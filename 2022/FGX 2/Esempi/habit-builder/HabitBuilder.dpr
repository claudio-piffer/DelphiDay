program HabitBuilder;

uses
  FGX.Application,
  FGX.Forms,
  Data.Entities in 'Data\Data.Entities.pas',
  Form.Base in 'Forms\Form.Base.pas' {FormBasic: TfgForm},
  Form.OnBoarding in 'Forms\OnBoarding\Form.OnBoarding.pas' {FormOnBoarding: TfgForm},
  Form.OnBoarding.Model in 'Forms\OnBoarding\Form.OnBoarding.Model.pas',
  Form.Login in 'Forms\Sign up and Log in\Form.Login.pas' {FormLogin: TfgForm},
  Form.ResetPassword in 'Forms\Sign up and Log in\Form.ResetPassword.pas' {FormResetPassword: TfgForm},
  Form.SignUp in 'Forms\Sign up and Log in\Form.SignUp.pas' {FormSignUp: TfgForm},
  Frame.Day in 'Frames\Frame.Day.pas' {FrameDay: TfgForm},
  Frame.DayProgress in 'Frames\Frame.DayProgress.pas' {FrameDayProgress: TfgForm},
  Frame.HabbitWeek in 'Frames\Frame.HabbitWeek.pas' {FrameHabbitWeek: TfgForm},
  Frame.Base in 'Frames\Frame.Base.pas' {FrameBase: TfgForm},
  Screen.Homepage in 'Screens\Homepage\Screen.Homepage.pas' {ScreenHomepage: TfgForm},
  Screen.Base in 'Screens\Screen.Base.pas' {ScreenBase: TfgForm},
  Screen.Community in 'Screens\Communities\Screen.Community.pas' {ScreenCommunity: TfgForm},
  Screen.Courses in 'Screens\Courses\Screen.Courses.pas' {ScreenCourses: TfgForm},
  Screen.NewHabit in 'Screens\Homepage\Screen.NewHabit.pas' {ScreenNewHabit: TfgForm},
  Frame.ReminderEditor in 'Frames\Frame.ReminderEditor.pas' {FrameReminderEditor: TfgForm},
  Frame.Reminders in 'Frames\Frame.Reminders.pas' {FrameReminders: TfgForm},
  Form.Main in 'Form.Main.pas' {FormMain: TfgForm},
  Screen.Settings in 'Screens\Settings\Screen.Settings.pas' {ScreenSettings: TfgForm},
  Assets.Consts in 'Assets.Consts.pas',
  Screen.Habbit in 'Screens\Homepage\Screen.Habbit.pas' {FormHabit: TfgForm},
  Form.Reminders in 'Forms\Reminders\Form.Reminders.pas' {FormReminderEditor: TfgForm},
  FGX.DateUtils in 'Utils\FGX.DateUtils.pas',
  FGX.Helpers.UI in 'Utils\FGX.Helpers.UI.pas',
  Navigation.Controller in 'Utils\Navigation.Controller.pas';

{$R *.res}

begin
//  TfgLog.MinimumLevel := TfgLogLevel.Info;
  Randomize;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormOnBoarding, FormOnBoarding);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.Run;
end.
