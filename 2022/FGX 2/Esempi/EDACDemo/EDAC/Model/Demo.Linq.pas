unit Demo.Linq; 

{$I EntityDac.inc}

interface

uses
  EntityDAC.Linq.Expression,
  EntityDAC.MetaData,
  Demo.MetaData;
 
type
  IDeptExpression = interface;
  IEmpExpression = interface;
  // collections
  IDeptEmpsExpression = interface;
  
  IDeptExpression = interface(IMetaType)
  ['{4D873A5E-7D30-48FF-9B02-7697397C6A8E}']
    function Deptno: TExpression;
    function Dname: TExpression;
    function Loc: TExpression;

    function Emps: IDeptEmpsExpression;
    function Unique: IDeptExpression;
  end;
  
  IEmpExpression = interface(IMetaType)
  ['{D066A14A-4CE1-4EE0-8776-3977678D9810}']
    function Empno: TExpression;
    function Ename: TExpression;
    function Job: TExpression;
    function Mgr: TExpression;
    function Hiredate: TExpression;
    function Sal: TExpression;
    function Comm: TExpression;
    function Deptno: TExpression;

    function Dept: IDeptExpression;
    function Unique: IEmpExpression;
  end;

  TDeptExpression = class(TMetaTypeExpression, IDeptExpression)
  public
    function UniqueDept: IDeptExpression;
    function IDeptExpression.Unique = UniqueDept;

    function Deptno: TExpression;
    function Dname: TExpression;
    function Loc: TExpression;

    function Emps: IDeptEmpsExpression;
  end;

  TEmpExpression = class(TMetaTypeExpression, IEmpExpression)
  public
    function UniqueEmp: IEmpExpression;
    function IEmpExpression.Unique = UniqueEmp;

    function Empno: TExpression;
    function Ename: TExpression;
    function Job: TExpression;
    function Mgr: TExpression;
    function Hiredate: TExpression;
    function Sal: TExpression;
    function Comm: TExpression;
    function Deptno: TExpression;

    function Dept: IDeptExpression;
  end;

  IDeptEmpsExpression = interface(IMetaCollection)
  ['{4D873A5E-7D30-48FF-9B02-7697397C6A8E}']
    function RowType: IEmpExpression;
  end;

  TDeptEmpsExpression = class(TMetaCollectionExpression, IDeptEmpsExpression)
  public
    function RowTypeEmp: IEmpExpression;
    function IDeptEmpsExpression.RowType = RowTypeEmp;
  end;

implementation

{ TDeptExpression }

function TDeptExpression.UniqueDept: IDeptExpression;
begin
  Result := (inherited Unique) as IDeptExpression;
end;

function TDeptExpression.Deptno: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Dept.Deptno));
end;

function TDeptExpression.Dname: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Dept.Dname));
end;

function TDeptExpression.Loc: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Dept.Loc));
end;

function TDeptExpression.Emps: IDeptEmpsExpression;
begin
  Result := TDeptEmpsExpression.Create(Self, (Model as TDemoModel).Dept.Emps) as IDeptEmpsExpression;
end;

{ TEmpExpression }

function TEmpExpression.UniqueEmp: IEmpExpression;
begin
  Result := (inherited Unique) as IEmpExpression;
end;

function TEmpExpression.Empno: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Emp.Empno));
end;

function TEmpExpression.Ename: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Emp.Ename));
end;

function TEmpExpression.Job: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Emp.Job));
end;

function TEmpExpression.Mgr: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Emp.Mgr));
end;

function TEmpExpression.Hiredate: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Emp.Hiredate));
end;

function TEmpExpression.Sal: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Emp.Sal));
end;

function TEmpExpression.Comm: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Emp.Comm));
end;

function TEmpExpression.Deptno: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, (Model as TDemoModel).Emp.Deptno));
end;

function TEmpExpression.Dept: IDeptExpression;
begin
  Result := TDeptExpression.Create(Self, (Model as TDemoModel).Emp.Dept);
end;

{ TDeptEmpsExpression }

function TDeptEmpsExpression.RowTypeEmp: IEmpExpression;
begin
  Result := TEmpExpression.Create(Self as TMetaExpression, (Model as TDemoModel).Emp) as IEmpExpression;
end;

end.
