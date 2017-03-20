{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit D001_IdenticalSubExpressions;

interface


uses
  DelphiAST.Classes, DelphiAST.Consts,
  DiagnosticsIntf, TreeIntf;

type
  T001_IdenticalSubExpressions = class(TCustomDiagnostics, IDiagnostics)
  private
    FEquivalenceChecker: IEquivalenceChecker;
    FNode: TSyntaxNode;
  protected
    function Execute: TDiagnosticsResult;
  public
    constructor Create(const AEquivalenceChecker: IEquivalenceChecker; const ANode: TSyntaxNode);
  public
    class function NodeType: TSyntaxNodeType; override;
  end;

  T001_IdenticalSubExpressions2 = class(T001_IdenticalSubExpressions, IDiagnostics)
    class function NodeType: TSyntaxNodeType; override;
  end;

implementation

uses
  SysUtils
{$IFDEF UNITTEST}
  , TestFramework//, Delphi.Mocks
{$ENDIF}
;

{$IFDEF UNITTEST}
type
  TestT001_IdenticalSubExpressions = class(TTestCase)
  strict private
    FSUT: T001_IdenticalSubExpressions;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;
{$ENDIF}

{ T001_IdenticalSubExpressions }

constructor T001_IdenticalSubExpressions.Create(const AEquivalenceChecker: IEquivalenceChecker; const ANode: TSyntaxNode);
begin
  Assert(Assigned(ANode), 'Node must be assigned');
  Assert(NodeType = ANode.Typ);

  FEquivalenceChecker := AEquivalenceChecker;
  FNode := ANode;
end;

function T001_IdenticalSubExpressions.Execute: TDiagnosticsResult;
begin
  Result := PassResult;

  if Length(FNode.ChildNodes) = 2 then
    if FEquivalenceChecker.Equal(FNode.ChildNodes[Low(FNode.ChildNodes)], FNode.ChildNodes[High(FNode.ChildNodes)]) then
    begin
      Result.Fail := True;
      Result.Msg := Format('There are identical sub-expressions: %s (%d:%d)', [FNode.FileName, FNode.Line, FNode.Col]);
    end;
end;

class function T001_IdenticalSubExpressions.NodeType: TSyntaxNodeType;
begin
  Result := ntAnd;
end;

{ T001_IdenticalSubExpressions2 }

class function T001_IdenticalSubExpressions2.NodeType: TSyntaxNodeType;
begin
  Result := ntOr;
end;

{$IFDEF UNITTEST}

{ TestT001_IdenticalSubExpressions }

procedure TestT001_IdenticalSubExpressions.SetUp;
begin
  inherited;
//  FSUT := T001_IdenticalSubExpressions.Create(nil, nil);
end;

procedure TestT001_IdenticalSubExpressions.TearDown;
begin
  inherited;
  FreeAndNil(FSUT);
end;

procedure TestT001_IdenticalSubExpressions.TestExecute;
begin
//  FSUT.Execute;
end;
{$ENDIF}

initialization
{$IFDEF UNITTEST}
  RegisterTest(TestT001_IdenticalSubExpressions.Suite);
{$ENDIF}

end.
