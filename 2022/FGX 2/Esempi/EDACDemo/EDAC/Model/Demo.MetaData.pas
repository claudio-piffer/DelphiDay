unit Demo.MetaData; 

{$I EntityDac.inc}

interface

uses
  SysUtils, Classes,
  EntityDAC.MetaData;
 
type
  TDemoModel = class;
  TDeptTable = class;
  TEmpTable = class;
  TDeptMetaType = class;
  TEmpMetaType = class;
  TDeptEmpsAssociation = class;

  TDemoModel = class(TMetaModel)
  private
    FDBDept: TDeptTable;
    FDBEmp: TEmpTable;
    FDept: TDeptMetaType;
    FEmp: TEmpMetaType;
  protected
    property DBDept: TDeptTable read FDBDept;
    property DBEmp: TEmpTable read FDBEmp;
  public
    constructor Create(Name: string);

    property Dept: TDeptMetaType read FDept;
    property Emp: TEmpMetaType read FEmp;
  end;
  
  TDeptTable = class(TMetaTable)
  public
    constructor Create(AModel: TDemoModel); reintroduce;
  end;
  
  TEmpTable = class(TMetaTable)
  public
    constructor Create(AModel: TDemoModel); reintroduce;
  end;

  TDeptMetaType = class(TMappedMetaType)
  private
    FDeptno: TMappedAttribute;
    FDname: TMappedAttribute;
    FLoc: TMappedAttribute;

    FEmps: TMetaCollection;
  protected
    procedure CreateAttributes; override;
    procedure CreateKey; override;
  public
    constructor Create(AModel: TDemoModel); overload;

    property Deptno: TMappedAttribute read FDeptno;
    property Dname: TMappedAttribute read FDname;
    property Loc: TMappedAttribute read FLoc;

    property Emps: TMetaCollection read FEmps;
  end;

  TEmpMetaType = class(TMappedMetaType)
  private
    FEmpno: TMappedAttribute;
    FEname: TMappedAttribute;
    FJob: TMappedAttribute;
    FMgr: TMappedAttribute;
    FHiredate: TMappedAttribute;
    FSal: TMappedAttribute;
    FComm: TMappedAttribute;
    FDeptno: TMappedAttribute;

    FDept: TMetaReference;
  protected
    procedure CreateAttributes; override;
    procedure CreateKey; override;
  public
    constructor Create(AModel: TDemoModel); overload;

    property Empno: TMappedAttribute read FEmpno;
    property Ename: TMappedAttribute read FEname;
    property Job: TMappedAttribute read FJob;
    property Mgr: TMappedAttribute read FMgr;
    property Hiredate: TMappedAttribute read FHiredate;
    property Sal: TMappedAttribute read FSal;
    property Comm: TMappedAttribute read FComm;
    property Deptno: TMappedAttribute read FDeptno;

    property Dept: TMetaReference read FDept;
  end;


  TDeptEmpsAssociation = class(TMetaAssociationOneToMany)
  public
    constructor Create(AModel: TDemoModel);
  end;

var
  DemoModel: TDemoModel;

implementation

uses
  EntityDAC.Types,
  Demo.Classes;

{ TDemoModel }

constructor TDemoModel.Create(Name: string);
begin
  inherited;

  FDBDept := TDeptTable.Create(Self);
  FDBEmp := TEmpTable.Create(Self);
  FDept := TDeptMetaType.Create(Self);
  FEmp := TEmpMetaType.Create(Self);
  TDeptEmpsAssociation.Create(Self);
end;

{ TDeptTable }

constructor TDeptTable.Create(AModel: TDemoModel);
begin
  inherited Create(AModel, 'DEPT');

  TMetaColumn.Create(Self, 'DEPTNO');
  TMetaColumn.Create(Self, 'DNAME');
  TMetaColumn.Create(Self, 'LOC');
end;

{ TEmpTable }

constructor TEmpTable.Create(AModel: TDemoModel);
begin
  inherited Create(AModel, 'EMP');

  TMetaColumn.Create(Self, 'EMPNO');
  TMetaColumn.Create(Self, 'ENAME');
  TMetaColumn.Create(Self, 'JOB');
  TMetaColumn.Create(Self, 'MGR');
  TMetaColumn.Create(Self, 'HIREDATE');
  TMetaColumn.Create(Self, 'SAL');
  TMetaColumn.Create(Self, 'COMM');
  TMetaColumn.Create(Self, 'DEPTNO');
end;

{ TDeptMetaType }

constructor TDeptMetaType.Create(AModel: TDemoModel);
begin
  inherited Create(AModel, AModel.DBDept, 'Dept', TDept);
end;

procedure TDeptMetaType.CreateAttributes;
begin
  inherited;

  FDeptno := TMappedAttribute.Create(Self, 'Deptno', etInteger, False, 'DEPTNO', False, False, '', 'INTEGER NOT NULL');
  FDname := TMappedAttribute.Create(Self, 'Dname', etString, False, 'DNAME', True, False, 14, '', 'VARCHAR(14)');
  FLoc := TMappedAttribute.Create(Self, 'Loc', etString, False, 'LOC', True, False, 13, '', 'VARCHAR(13)');
  
  TTableMetaKeyGenerator.Create(TMetaModel(DemoModel), '', FDeptno);
end;

procedure TDeptMetaType.CreateKey;
begin
  inherited;
  
  TMetaKey.Create(Self, '', ToAttributeArray([FDeptno]));
end;

{ TEmpMetaType }

constructor TEmpMetaType.Create(AModel: TDemoModel);
begin
  inherited Create(AModel, AModel.DBEmp, 'Emp', TEmp);
end;

procedure TEmpMetaType.CreateAttributes;
begin
  inherited;

  FEmpno := TMappedAttribute.Create(Self, 'Empno', etInteger, False, 'EMPNO', False, False, '', 'INTEGER NOT NULL');
  FEname := TMappedAttribute.Create(Self, 'Ename', etString, False, 'ENAME', True, False, 10, '', 'VARCHAR(10)');
  FJob := TMappedAttribute.Create(Self, 'Job', etString, False, 'JOB', True, False, 9, '', 'VARCHAR2(9)');
  FMgr := TMappedAttribute.Create(Self, 'Mgr', etInteger, True, 'MGR', True, False, '', 'INTEGER');
  FHiredate := TMappedAttribute.Create(Self, 'Hiredate', etDateTime, True, 'HIREDATE', True, False, '', 'TIMESTAMP');
  FSal := TMappedAttribute.Create(Self, 'Sal', etDouble, True, 'SAL', True, False, '', 'REAL');
  FComm := TMappedAttribute.Create(Self, 'Comm', etDouble, True, 'COMM', True, False, '', 'REAL');
  FDeptno := TMappedAttribute.Create(Self, 'Deptno', etInteger, True, 'DEPTNO', True, False, '', 'INTEGER');
  
  TTableMetaKeyGenerator.Create(TMetaModel(DemoModel), '', FEmpno);
end;

procedure TEmpMetaType.CreateKey;
begin
  inherited;
  
  TMetaKey.Create(Self, '', ToAttributeArray([FEmpno]));
end;

{ TDeptEmpsAssociation }

constructor TDeptEmpsAssociation.Create(AModel: TDemoModel);
begin
  inherited Create(AModel,
    'Emp.Dept', AModel.Dept, ToAttributeArray([AModel.Dept.Deptno]),
    'Dept.Emps', AModel.Emp, ToAttributeArray([AModel.Emp.Deptno])
    , srCascade, drCascade);

  AModel.Emp.FDept := Self.ParentReference;
  AModel.Dept.FEmps := Self.ChildCollection;
end;

initialization
  DemoModel := TDemoModel.Create('Demo');

finalization
  DemoModel.Free;

end.
