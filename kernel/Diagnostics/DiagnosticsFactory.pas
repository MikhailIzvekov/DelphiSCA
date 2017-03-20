{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit DiagnosticsFactory;

interface

uses
  Spring.Container.Common,
  DelphiAST.Consts, DelphiAST.Classes,
  DiagnosticsIntf;

type
  TDiagnosticsFactory = class(TInterfacedObject, IDiagnosticsFactory)
  private
    FFactories: array[TSyntaxNodeType] of TDiagnosticsFactories;

    procedure SetDiagnosticsFactory_Or(const Value: TArray<IDiagnosticsFactory_Or>);
    procedure SetADiagnosticsFactory_And(const Value: TArray<IDiagnosticsFactory_And>);

    function GetByType(const ATyp: TSyntaxNodeType): TDiagnosticsFactories;
    procedure SetByType(const ATyp: TSyntaxNodeType; const Value: TDiagnosticsFactories);
  protected
    property ByType[const ATyp: TSyntaxNodeType]: TDiagnosticsFactories read GetByType write SetByType;
  public
    [Inject]
    property DiagnosticsFactory_Or: TArray<IDiagnosticsFactory_Or> write SetDiagnosticsFactory_Or;
    [Inject]
    property ADiagnosticsFactory_And: TArray<IDiagnosticsFactory_And> write SetADiagnosticsFactory_And;
    // ... TODO
  end;

implementation

{ TDiagnosticsFactory }

function TDiagnosticsFactory.GetByType(const ATyp: TSyntaxNodeType): TDiagnosticsFactories;
begin
  Result := FFactories[ATyp];
end;

procedure TDiagnosticsFactory.SetADiagnosticsFactory_And(const Value: TArray<IDiagnosticsFactory_And>);
begin
  SetByType(ntAnd, TDiagnosticsFactories(Value));
end;

procedure TDiagnosticsFactory.SetByType(const ATyp: TSyntaxNodeType; const Value: TDiagnosticsFactories);
begin
  FFactories[ATyp] := Value;
end;

procedure TDiagnosticsFactory.SetDiagnosticsFactory_Or(const Value: TArray<IDiagnosticsFactory_Or>);
begin
  SetByType(ntOr, TDiagnosticsFactories(Value));
end;

end.
