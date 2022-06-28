program EDACDemo;

uses
  FGX.Application,
  FGX.Forms,
  Form.Main in 'Form.Main.pas' {FormMain: TfgForm},
  Demo.Classes in 'EDAC\Model\Demo.Classes.pas',
  Demo.Context in 'EDAC\Model\Demo.Context.pas',
  Demo.Linq in 'EDAC\Model\Demo.Linq.pas',
  Demo.MetaData in 'EDAC\Model\Demo.MetaData.pas',
  Assets.Consts in 'Assets.Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
