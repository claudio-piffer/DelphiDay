unit Demo.XmlEntities; 

{$I EntityDac.inc}

interface

uses
  Classes, SysUtils, FMTBcd, SqlTimSt,
  Generics.Collections,
  EntityDAC.ComplexData,
  EntityDAC.Context,
  EntityDAC.DataProvider,
  EntityDAC.Entity, 
  EntityDAC.EntityAttributes, 
  EntityDAC.EntityConnection,
  EntityDAC.EntityContext,
  EntityDAC.MetaData,
  EntityDAC.NullableTypes,
  EntityDAC.Serializer,
  EntityDAC.Utils;
 
type
  TDept = class;
  TEmp = class;
  TDeptEmps = class;
  
  [XmlMapped]
  TDept = class(TMappedEntity)
  private
    FDeptno: TIntegerAttribute;
    FDname: TStringAttribute;
    FLoc: TStringAttribute;

    FEmps: TDeptEmps;

    function GetDeptno: Integer; virtual;
    procedure SetDeptno(const Value: Integer); virtual;
    function GetDname: String; virtual;
    procedure SetDname(const Value: String); virtual;
    function GetLoc: String; virtual;
    procedure SetLoc(const Value: String); virtual;
  protected
    constructor Create(AMetaType: TMetaType); overload; override;
  public
    constructor Create; overload; override;

    property Deptno: Integer read GetDeptno write SetDeptno;
    property Dname: String read GetDname write SetDname;
    property Loc: String read GetLoc write SetLoc;

    property Emps: TDeptEmps read FEmps;
  end;
  
  [XmlMapped]
  TEmp = class(TMappedEntity)
  private
    FEmpno: TIntegerAttribute;
    FEname: TStringAttribute;
    FJob: TStringAttribute;
    FMgr: TIntegerNullableAttribute;
    FHiredate: TDateTimeNullableAttribute;
    FSal: TDoubleNullableAttribute;
    FComm: TDoubleNullableAttribute;
    FDeptno: TIntegerAttribute;

    FDept: TMappedReference;

    function GetEmpno: Integer; virtual;
    procedure SetEmpno(const Value: Integer); virtual;
    function GetEname: String; virtual;
    procedure SetEname(const Value: String); virtual;
    function GetJob: String; virtual;
    procedure SetJob(const Value: String); virtual;
    function GetMgr: IntegerNullable; virtual;
    procedure SetMgr(const Value: IntegerNullable); virtual;
    function GetHiredate: TDateTimeNullable; virtual;
    procedure SetHiredate(const Value: TDateTimeNullable); virtual;
    function GetSal: DoubleNullable; virtual;
    procedure SetSal(const Value: DoubleNullable); virtual;
    function GetComm: DoubleNullable; virtual;
    procedure SetComm(const Value: DoubleNullable); virtual;
    function GetDeptno: Integer; virtual;
    procedure SetDeptno(const Value: Integer); virtual;
  protected

    function GetDept: TDept;
    procedure SetDept(const Value: TDept);
    constructor Create(AMetaType: TMetaType); overload; override;
  public
    constructor Create; overload; override;

    property Empno: Integer read GetEmpno write SetEmpno;
    property Ename: String read GetEname write SetEname;
    property Job: String read GetJob write SetJob;
    property Mgr: IntegerNullable read GetMgr write SetMgr;
    property Hiredate: TDateTimeNullable read GetHiredate write SetHiredate;
    property Sal: DoubleNullable read GetSal write SetSal;
    property Comm: DoubleNullable read GetComm write SetComm;
    property Deptno: Integer read GetDeptno write SetDeptno;

    property Dept: TDept read GetDept write SetDept;
  end;

{$IFDEF USE_GENERICS}
  TDeptEmps = class(TMappedCollection<TEmp>)
  end;
{$ELSE}
  TDeptEmps = class(TMappedCollection)
  private
    function GetItem(Index: Integer): TEmp;
  public
    property Items[Index: Integer]: TEmp read GetItem; default;
  end;
{$ENDIF}

implementation

{ TDept }

constructor TDept.Create(AMetaType: TMetaType);
begin
  inherited Create(AMetaType);

  FDeptno := TIntegerAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Deptno'));
  FDname := TStringAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Dname'));
  FLoc := TStringAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Loc'));

  TTableMetaKeyGenerator.Create(AMetaType.Model, '', FDeptno.MetaAttribute);

  FEmps := TDeptEmps.Create(Self, AMetaType.MetaCollections.Get('Emps'));
end;

constructor TDept.Create;
begin
  Create(Models.GetMetaType(Self.ClassType));
end;

function TDept.GetDeptno: Integer;
begin
  Result := FDeptno.Value;
end;

procedure TDept.SetDeptno(const Value: Integer);
begin
  FDeptno.Value := Value;
end;

function TDept.GetDname: String;
begin
  Result := FDname.Value;
end;

procedure TDept.SetDname(const Value: String);
begin
  FDname.Value := Value;
end;

function TDept.GetLoc: String;
begin
  Result := FLoc.Value;
end;

procedure TDept.SetLoc(const Value: String);
begin
  FLoc.Value := Value;
end;

{ TEmp }

constructor TEmp.Create(AMetaType: TMetaType);
begin
  inherited Create(AMetaType);

  FEmpno := TIntegerAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Empno'));
  FEname := TStringAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Ename'));
  FJob := TStringAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Job'));
  FMgr := TIntegerNullableAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Mgr'));
  FHiredate := TDateTimeNullableAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Hiredate'));
  FSal := TDoubleNullableAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Sal'));
  FComm := TDoubleNullableAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Comm'));
  FDeptno := TIntegerAttribute.Create(Attributes, AMetaType.MetaAttributes.Get('Deptno'));

  FDept := TMappedReference.Create(Self, AMetaType.MetaReferences.Get('Dept'));
end;

constructor TEmp.Create;
begin
  Create(Models.GetMetaType(Self.ClassType));
end;

function TEmp.GetEmpno: Integer;
begin
  Result := FEmpno.Value;
end;

procedure TEmp.SetEmpno(const Value: Integer);
begin
  FEmpno.Value := Value;
end;

function TEmp.GetEname: String;
begin
  Result := FEname.Value;
end;

procedure TEmp.SetEname(const Value: String);
begin
  FEname.Value := Value;
end;

function TEmp.GetJob: String;
begin
  Result := FJob.Value;
end;

procedure TEmp.SetJob(const Value: String);
begin
  FJob.Value := Value;
end;

function TEmp.GetMgr: IntegerNullable;
begin
  Result := FMgr.Value;
end;

procedure TEmp.SetMgr(const Value: IntegerNullable);
begin
  FMgr.Value := Value;
end;

function TEmp.GetHiredate: TDateTimeNullable;
begin
  Result := FHiredate.Value;
end;

procedure TEmp.SetHiredate(const Value: TDateTimeNullable);
begin
  FHiredate.Value := Value;
end;

function TEmp.GetSal: DoubleNullable;
begin
  Result := FSal.Value;
end;

procedure TEmp.SetSal(const Value: DoubleNullable);
begin
  FSal.Value := Value;
end;

function TEmp.GetComm: DoubleNullable;
begin
  Result := FComm.Value;
end;

procedure TEmp.SetComm(const Value: DoubleNullable);
begin
  FComm.Value := Value;
end;

function TEmp.GetDeptno: Integer;
begin
  Result := FDeptno.Value;
end;

procedure TEmp.SetDeptno(const Value: Integer);
begin
  FDeptno.Value := Value;
end;

function TEmp.GetDept: TDept;
begin
  Result := FDept.Value as TDept;
end;

procedure TEmp.SetDept(const Value: TDept);
begin
  FDept.Value := Value;
end;

{$IFNDEF USE_GENERICS}
function TDeptEmps.GetItem(Index: Integer): TEmp;
begin
  Result := inherited Items[Index] as TEmp;
end;
{$ENDIF}

{******************************************************************************}
{  The following code is used for automatic entity mapping                     }
{******************************************************************************}

initialization
  ForceRtti(TDept);
  ForceRtti(TEmp);

end.
