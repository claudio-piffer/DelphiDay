unit Demo.ObjectContext;

{$I EntityDac.inc}

interface

uses
  Classes,
  EntityDAC.MetaData,
  EntityDAC.EntityConnection,
  EntityDAC.ObjectContext,
  Demo.ObjectLinq;

type
{$IFDEF VER16P}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
{$ENDIF}
  TDemoContext = class(TCustomObjectContext)
  public
  {$IFNDEF EXPRESS}
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AConnection: TEntityConnection); overload;
    constructor Create(AOwner: TComponent; AModel: TMetaModel; AConnection: TEntityConnection); overload; override;
  {$ENDIF}
    constructor Create; overload; override;
    constructor Create(AConnection: TEntityConnection); overload;
    constructor Create(AModel: TMetaModel; AConnection: TEntityConnection); overload; override;

    function Dept: IDeptExpression;
    function Emp: IEmpExpression;

    property CacheManager;
    property QueryCompiler;
{$IFNDEF EXPRESS}
  published
    property Connection;
    property Options;

    property OnGetGeneratorValue;
{$ENDIF}
  end;

{$IFNDEF EXPRESS}
procedure Register;
{$ENDIF}

implementation

{$IFNDEF EXPRESS}
uses
  EntityDAC.Context;

procedure Register;
begin
  RegisterComponents('Devart EntityDAC Custom', [TDemoContext]);
end;
{$ENDIF}

{ TDemoContext }

{$IFNDEF EXPRESS}
constructor TDemoContext.Create(AOwner: TComponent);
begin
  Create(AOwner, 'DemoObject', nil);
end;

constructor TDemoContext.Create(AOwner: TComponent; AConnection: TEntityConnection);
begin
  Create(AOwner, 'DemoObject', AConnection);
end;

constructor TDemoContext.Create(AOwner: TComponent; AModel: TMetaModel; AConnection: TEntityConnection);
begin
  inherited Create(AOwner, AModel, AConnection);

  Options.AllowNullableString := False;
  Options.AllowNullableBytes := False;
end;
{$ENDIF}

constructor TDemoContext.Create;
begin
  Create('DemoObject', nil);
end;

constructor TDemoContext.Create(AConnection: TEntityConnection);
begin
  Create(Models.Get('DemoObject'), AConnection);
end;

constructor TDemoContext.Create(AModel: TMetaModel; AConnection: TEntityConnection);
begin
  inherited Create(AModel, AConnection);

  Options.AllowNullableString := False;
  Options.AllowNullableBytes := False;
end;

function TDemoContext.Dept: IDeptExpression;
begin
  Result := TDeptExpression.Create(Model, Model['Dept']) as IDeptExpression;
end;

function TDemoContext.Emp: IEmpExpression;
begin
  Result := TEmpExpression.Create(Model, Model['Emp']) as IEmpExpression;
end;

end.
