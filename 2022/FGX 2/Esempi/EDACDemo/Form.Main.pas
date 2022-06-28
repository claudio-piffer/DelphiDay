unit Form.Main;

interface

{$SCOPEDENUMS ON}

uses
  System.Types,
  System.Classes,
  FGX.Forms,
  FGX.Forms.Types,
  FGX.Controls,
  FGX.Controls.Types,
  FGX.Layout,
  FGX.Layout.Types,
  FGX.NavigationBar.Types,
  FGX.NavigationBar,
  FGX.DrawerLayout,
  FGX.StaticLabel,
  EntityDAC.MetaData,
  EntityDAC.Values,
  EntityDAC.Linq,
  FireDac.Stan.Intf,
  FireDac.Stan.Option,
  FireDac.Stan.Error,
  FireDac.Phys.Intf,
  FireDac.Stan.Def,
  FireDac.Stan.Pool,
  FireDac.Stan.Async,
  FireDac.Phys,
  FireDac.Stan.ExprFuncs,
  FireDac.Phys.SQLiteDef,
  FireDac.Phys.SQLite,
  FireDac.DApt,
  Data.DB,
  FireDac.Comp.Client,
  FireDac.Stan.Param,
  FireDac.DatS,
  FireDac.DApt.Intf,
  FireDac.Comp.DataSet,
  FireDac.Stan.StorageBin,
  FireDac.UI.Intf,
  EntityDAC.DataProvider,
  EntityDAC.DataProvider.FireDac,
  FireDac.Phys.SQLiteWrapper.Stat,
  EntityDAC.Common.DataSet,
  EntityDAC.Common.VirtualDataSet,
  EntityDAC.EntityDataSet,
  EntityDAC.EntityConnection,
  EntityDAC.Context,
  EntityDAC.EntityContext,
  FireDac.Comp.UI,
  FireDac.ConsoleUI.Wait,
  FGX.CollectionView,
  Demo.Classes,
  Demo.Linq,
  EntityDAC.Enumerable,
  Demo.Context,
  FGX.Button.Types,
  FGX.Button,
  FireDac.Moni.Base,
  FireDac.Moni.Custom,
  FGX.Image;

type
  TFormMain = class(TfgForm)
    EntityConnection: TEntityConnection;
    fgNavigationBar1: TfgNavigationBar;
    fgCollectionView1: TfgCollectionView;
    fgCollectionView1_Styles: TfgCollectionViewStyles;
    FDMoniCustomClientLink1: TFDMoniCustomClientLink;
    fgLabel1: TfgLabel;
    fgLabel2: TfgLabel;
    fgLabel3: TfgLabel;
    fgCollectionView1_Style1: TfgCollectionViewStyle;
    procedure fgFormCreate(Sender: TObject);
    function fgCollectionView1GetItemCount(Sender: TObject): Integer;
    procedure fgCollectionView1BindItem(Sender: TObject; const AIndex: Integer; const AStyle: string; const AItem: TfgItemWrapper);
    procedure fgNavigationBar1ActionButtons0Tap(Sender: TObject);
    procedure fgFormDestroy(Sender: TObject);
    procedure FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase;
      const AClassName, AObjName, AMessage: string);
  private
    Depts: ILinqQueryable;
    Emps: ILinqQueryable;
    FContext: TDemoContext;
    FEmpsData: IObjectEnumerable< TEmp >;
    FDemoContext: TDemoContext;
    procedure LoadEmpsData;
  public
    {Public declarations}
  end;

var
  FormMain: TFormMain;

implementation

{$R *.xfm}

uses
  System.SysUtils,
  System.IOUtils,
  FGX.Application,
  FGX.Dialogs,
  FGX.Log,
  FGX.Assets,
  FGX.Assets.CustomFile,
  Assets.Consts;

procedure TFormMain.FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase; const AClassName, AObjName, AMessage: string);
begin
  TfgLog.Info(AMessage);
end;

procedure TFormMain.fgCollectionView1BindItem(Sender: TObject; const AIndex: Integer; const AStyle: string; const AItem: TfgItemWrapper);
begin
  if Assigned(FEmpsData) then
  begin
    AItem.GetControlByLookupName< TfgLabel >('overline').Text := FEmpsData.Elements[AIndex].Ename;
    AItem.GetControlByLookupName< TfgLabel >('primary').Text := FEmpsData.Elements[AIndex].Dept.Dname;
    AItem.GetControlByLookupName< TfgLabel >('secondary').Text := FEmpsData.Elements[AIndex].Job;
  end;
end;

function TFormMain.fgCollectionView1GetItemCount(Sender: TObject): Integer;
begin
  if Assigned(FEmpsData) then
    Result := FEmpsData.Count
  else
    Result := 0;
end;

procedure TFormMain.fgFormCreate(Sender: TObject);
var
  Asset: TfgAssetFile;
  LFileNameDB: string;
begin
  if TfgAssetsManager.Current.Find< TfgAssetFile >(R.Files.DB_DEMODB, Asset) then
  begin
    LFileNameDB := Asset.FileName;
    EntityConnection.ConnectionString := 'Data Provider=FireDAC;SQL Dialect=SQLite;Login Prompt=False;DirectMode=1;MonitorBy=Custom;DataBase=' + LFileNameDB;
    EntityConnection.Connect;
    FDemoContext := TDemoContext.Create(EntityConnection);
    // LoadEmpsData;
  end;
end;

procedure TFormMain.fgFormDestroy(Sender: TObject);
begin
  FDemoContext.Free;
end;

procedure TFormMain.fgNavigationBar1ActionButtons0Tap(Sender: TObject);
begin
  LoadEmpsData;
  fgCollectionView1.ReloadItems;
end;

procedure TFormMain.LoadEmpsData;
var
  LEmpExpression: IEmpExpression;
  LQuery: ILinqQueryable;
begin
  LEmpExpression := FDemoContext.Emp;

  LQuery := Linq.From(LEmpExpression)
    .Select();

  FEmpsData := FDemoContext.GetEntities< TEmp >(LQuery);
end;

end.
