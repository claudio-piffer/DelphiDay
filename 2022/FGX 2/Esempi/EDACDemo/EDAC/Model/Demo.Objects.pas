unit Demo.Objects; 

{$I EntityDac.inc}

interface

uses
  SysUtils, Classes, FmtBcd, SqlTimSt,
  Generics.Collections,
  EntityDAC.ComplexData,
  EntityDAC.Context,
  EntityDAC.DataProvider,
  EntityDAC.EntityAttributes, 
  EntityDAC.EntityConnection,
  EntityDAC.MetaData,
  EntityDAC.MetaEntity, 
  EntityDAC.NullableTypes,
  EntityDAC.ObjectContext,
  EntityDAC.Types,
  Demo.ObjectLinq;
 
type
  TDept = class;
  TEmp = class;
  [Table('DEPT')]
  [Model('DemoObject')]
  [Key('FDeptno')]
  TDept = class
  private
    [Column('DEPTNO')]
    [Generator(gtTable)]
    FDeptno: Integer;
    [Column('DNAME', 14, [CanBeNull])]
    FDname: String;
    [Column('LOC', 13, [CanBeNull])]
    FLoc: String;

    [Column]
    [Collection('TEmp', 'FDept', 'FDeptno', 'FDeptno', srCascade, drCascade)]
    FEmps: Collection<TEmp>;

    function GetDeptno: Integer; virtual;
    procedure SetDeptno(const Value: Integer); virtual;
    function GetDname: String; virtual;
    procedure SetDname(const Value: String); virtual;
    function GetLoc: String; virtual;
    procedure SetLoc(const Value: String); virtual;
  protected
  public
    property Deptno: Integer read GetDeptno write SetDeptno;
    property Dname: String read GetDname write SetDname;
    property Loc: String read GetLoc write SetLoc;

    property Emps: Collection<TEmp> read FEmps;
  published
  end;

  [Table('EMP')]
  [Model('DemoObject')]
  [Key('FEmpno')]
  TEmp = class
  private
    [Column('EMPNO')]
    [Generator(gtTable)]
    FEmpno: Integer;
    [Column('ENAME', 10, [CanBeNull])]
    FEname: String;
    [Column('JOB', 9, [CanBeNull])]
    FJob: String;
    [Column('MGR', [CanBeNull])]
    FMgr: IntegerNullable;
    [Column('HIREDATE', [CanBeNull])]
    FHiredate: TDateTimeNullable;
    [Column('SAL', [CanBeNull])]
    FSal: DoubleNullable;
    [Column('COMM', [CanBeNull])]
    FComm: DoubleNullable;
    [Column('DEPTNO', [CanBeNull])]
    FDeptno: IntegerNullable;

    [Column]
    [Reference('TDept', 'FEmps', 'FDeptno', 'FDeptno', srCascade, drCascade)]
    FDept: Reference<TDept>;

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
  protected
    function GetDept: TDept;
    procedure SetDept(const Value: TDept);
  public
    property Empno: Integer read GetEmpno write SetEmpno;
    property Ename: String read GetEname write SetEname;
    property Job: String read GetJob write SetJob;
    property Mgr: IntegerNullable read GetMgr write SetMgr;
    property Hiredate: TDateTimeNullable read GetHiredate write SetHiredate;
    property Sal: DoubleNullable read GetSal write SetSal;
    property Comm: DoubleNullable read GetComm write SetComm;
    property Deptno: IntegerNullable read GetDeptno write SetDeptno;

    property Dept: TDept read GetDept write SetDept;
  published
  end;

implementation

uses
  EntityDAC.Utils,
  EntityDAC.Values;

{ TDept }

function TDept.GetDeptno: Integer;
begin
  Result := FDeptno;
end;

procedure TDept.SetDeptno(const Value: Integer);
begin
  FDeptno := Value;
end;

function TDept.GetDname: String;
begin
  Result := FDname;
end;

procedure TDept.SetDname(const Value: String);
begin
  FDname := Value;
end;

function TDept.GetLoc: String;
begin
  Result := FLoc;
end;

procedure TDept.SetLoc(const Value: String);
begin
  FLoc := Value;
end;

{ TEmp }

function TEmp.GetEmpno: Integer;
begin
  Result := FEmpno;
end;

procedure TEmp.SetEmpno(const Value: Integer);
begin
  FEmpno := Value;
end;

function TEmp.GetEname: String;
begin
  Result := FEname;
end;

procedure TEmp.SetEname(const Value: String);
begin
  FEname := Value;
end;

function TEmp.GetJob: String;
begin
  Result := FJob;
end;

procedure TEmp.SetJob(const Value: String);
begin
  FJob := Value;
end;

function TEmp.GetMgr: IntegerNullable;
begin
  Result := FMgr;
end;

procedure TEmp.SetMgr(const Value: IntegerNullable);
begin
  FMgr := Value;
end;

function TEmp.GetHiredate: TDateTimeNullable;
begin
  Result := FHiredate;
end;

procedure TEmp.SetHiredate(const Value: TDateTimeNullable);
begin
  FHiredate := Value;
end;

function TEmp.GetSal: DoubleNullable;
begin
  Result := FSal;
end;

procedure TEmp.SetSal(const Value: DoubleNullable);
begin
  FSal := Value;
end;

function TEmp.GetComm: DoubleNullable;
begin
  Result := FComm;
end;

procedure TEmp.SetComm(const Value: DoubleNullable);
begin
  FComm := Value;
end;

function TEmp.GetDeptno: IntegerNullable;
begin
  Result := FDeptno;
end;

procedure TEmp.SetDeptno(const Value: IntegerNullable);
begin
  FDeptno := Value;
  FDept.FieldChanged(True);
end;

function TEmp.GetDept: TDept;
begin
  Result := FDept.Value as TDept;
end;

procedure TEmp.SetDept(const Value: TDept);
begin
  if FDept.Value <> Value then begin
    FDept.Value := Value;
    FDept.FieldChanged(False);
  end;
end;

{******************************************************************************}
{  The following code is used for automatic entity mapping                     }
{******************************************************************************}

initialization
  ForceRtti(TDept);
  ForceRtti(TEmp);

end.
