unit Demo.Classes;

{$I EntityDac.inc}

interface

uses
  Classes, SysUtils, FMTBcd, SqlTimSt,
  EntityDAC.Common.Functions,
  EntityDAC.ComplexData,
  EntityDAC.Context,
  EntityDAC.Entity,
  EntityDAC.EntityAttributes,
  EntityDAC.EntityConnection,
  EntityDAC.EntityContext,
  EntityDAC.MetaData,
  EntityDAC.NullableTypes,
  EntityDAC.Types,
  Demo.MetaData,
  Demo.Linq;
 
type
  TDept = class;
  TEmp = class;

{$IFDEF USE_GENERICS}
  TDeptEmps = TMappedCollection<TEmp>;
{$ELSE}
  TDeptEmps = class(TMappedCollection)
  private
    function GetItem(Index: Integer): TEmp; reintroduce;
  public
    property Items[Index: Integer]: TEmp read GetItem; default;
  end;
{$ENDIF}

  TDept = class(TMappedEntity)
  private
    FDeptno: Integer;
    FDname: String;
    FLoc: String;

    FEmps: TCollectionData;

    function GetDeptno: Integer; virtual;
    procedure SetDeptno(const Value: Integer); virtual;
    function GetDname: String; virtual;
    procedure SetDname(const Value: String); virtual;
    function GetLoc: String; virtual;
    procedure SetLoc(const Value: String); virtual;

    function GetEmps: TDeptEmps;

    function GetMetaType: TDeptMetaType;
  protected
    procedure Register; override;

    constructor Create(AMetaType: TMetaType); overload; override;
  public
    constructor Create; overload; override;

    property Deptno: Integer read GetDeptno write SetDeptno;
    property Dname: String read GetDname write SetDname;
    property Loc: String read GetLoc write SetLoc;

    property Emps: TDeptEmps read GetEmps;

    property MetaType: TDeptMetaType read GetMetaType;
  published
  end;

  TEmp = class(TMappedEntity)
  private
    FEmpno: Integer;
    FEname: String;
    FJob: String;
    FMgr: IntegerNullable;
    FHiredate: TDateTimeNullable;
    FSal: DoubleNullable;
    FComm: DoubleNullable;
    FDeptno: IntegerNullable;

    FDept: TReferenceData;

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
    function GetDeptno: IntegerNullable; virtual;
    procedure SetDeptno(const Value: IntegerNullable); virtual;

    function GetDept: TDept;
    procedure SetDept(const Value: TDept);


    function GetMetaType: TEmpMetaType;
  protected
    procedure Register; override;

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
    property Deptno: IntegerNullable read GetDeptno write SetDeptno;

    property Dept: TDept read GetDept write SetDept;

    property MetaType: TEmpMetaType read GetMetaType;
  published
  end;

implementation

{ TDept }

constructor TDept.Create(AMetaType: TMetaType);
begin
  inherited Create(AMetaType);
end;

constructor TDept.Create;
begin
  Create(DemoModel.Dept);
end;

procedure TDept.Register;
begin
  inherited;

  RegisterAttribute(FDeptno, MetaType.Deptno);
  RegisterAttribute(FDname, MetaType.Dname);
  RegisterAttribute(FLoc, MetaType.Loc);

  RegisterCollection(FEmps, MetaType.Emps, TDeptEmps);
end;

function TDept.GetMetaType;
begin
  Result := DemoModel.Dept;
end;

function TDept.GetDeptno: Integer;
begin
  Result := FDeptno;
end;

procedure TDept.SetDeptno(const Value: Integer);
begin
  if AttributeChanging(MetaType.Deptno, Value) then begin
    FDeptno := Value;
    AttributeChanged(MetaType.Deptno);
  end;
end;

function TDept.GetDname: String;
begin
  Result := FDname;
end;

procedure TDept.SetDname(const Value: String);
begin
  if AttributeChanging(MetaType.Dname, Value) then begin
    FDname := Value;
    AttributeChanged(MetaType.Dname);
  end;
end;

function TDept.GetLoc: String;
begin
  Result := FLoc;
end;

procedure TDept.SetLoc(const Value: String);
begin
  if AttributeChanging(MetaType.Loc, Value) then begin
    FLoc := Value;
    AttributeChanged(MetaType.Loc);
  end;
end;

function TDept.GetEmps: TDeptEmps;
begin
  Result := TDeptEmps(FEmps.Entities);
end;

{ TEmp }

constructor TEmp.Create(AMetaType: TMetaType);
begin
  inherited Create(AMetaType);
end;

constructor TEmp.Create;
begin
  Create(DemoModel.Emp);
end;

procedure TEmp.Register;
begin
  inherited;

  RegisterAttribute(FEmpno, MetaType.Empno);
  RegisterAttribute(FEname, MetaType.Ename);
  RegisterAttribute(FJob, MetaType.Job);
  RegisterAttribute(FMgr, MetaType.Mgr);
  RegisterAttribute(FHiredate, MetaType.Hiredate);
  RegisterAttribute(FSal, MetaType.Sal);
  RegisterAttribute(FComm, MetaType.Comm);
  RegisterAttribute(FDeptno, MetaType.Deptno);

  RegisterReference(FDept, MetaType.Dept);
end;

function TEmp.GetMetaType;
begin
  Result := DemoModel.Emp;
end;

function TEmp.GetEmpno: Integer;
begin
  Result := FEmpno;
end;

procedure TEmp.SetEmpno(const Value: Integer);
begin
  if AttributeChanging(MetaType.Empno, Value) then begin
    FEmpno := Value;
    AttributeChanged(MetaType.Empno);
  end;
end;

function TEmp.GetEname: String;
begin
  Result := FEname;
end;

procedure TEmp.SetEname(const Value: String);
begin
  if AttributeChanging(MetaType.Ename, Value) then begin
    FEname := Value;
    AttributeChanged(MetaType.Ename);
  end;
end;

function TEmp.GetJob: String;
begin
  Result := FJob;
end;

procedure TEmp.SetJob(const Value: String);
begin
  if AttributeChanging(MetaType.Job, Value) then begin
    FJob := Value;
    AttributeChanged(MetaType.Job);
  end;
end;

function TEmp.GetMgr: IntegerNullable;
begin
  Result := FMgr;
end;

procedure TEmp.SetMgr(const Value: IntegerNullable);
begin
  if AttributeChanging(MetaType.Mgr, Value) then begin
    FMgr := Value;
    AttributeChanged(MetaType.Mgr);
  end;
end;

function TEmp.GetHiredate: TDateTimeNullable;
begin
  Result := FHiredate;
end;

procedure TEmp.SetHiredate(const Value: TDateTimeNullable);
begin
  if AttributeChanging(MetaType.Hiredate, Value) then begin
    FHiredate := Value;
    AttributeChanged(MetaType.Hiredate);
  end;
end;

function TEmp.GetSal: DoubleNullable;
begin
  Result := FSal;
end;

procedure TEmp.SetSal(const Value: DoubleNullable);
begin
  if AttributeChanging(MetaType.Sal, Value) then begin
    FSal := Value;
    AttributeChanged(MetaType.Sal);
  end;
end;

function TEmp.GetComm: DoubleNullable;
begin
  Result := FComm;
end;

procedure TEmp.SetComm(const Value: DoubleNullable);
begin
  if AttributeChanging(MetaType.Comm, Value) then begin
    FComm := Value;
    AttributeChanged(MetaType.Comm);
  end;
end;

function TEmp.GetDeptno: IntegerNullable;
begin
  Result := FDeptno;
end;

procedure TEmp.SetDeptno(const Value: IntegerNullable);
begin
  if AttributeChanging(MetaType.Deptno, Value) then begin
    FDeptno := Value;
    AttributeChanged(MetaType.Deptno);
  end;
end;

function TEmp.GetDept: TDept;
begin
  Result := FDept.Entity as TDept;
end;

procedure TEmp.SetDept(const Value: TDept);
begin
  FDept.Entity := Value;
end;

{ TDeptEmps }

{$IFNDEF USE_GENERICS}
function TDeptEmps.GetItem(Index: Integer): TEmp;
begin
  Result := inherited Items[Index] as TEmp;
end;
{$ENDIF}

end.
