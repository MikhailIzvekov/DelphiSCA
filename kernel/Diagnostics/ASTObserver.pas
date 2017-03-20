{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit ASTObserver;

interface

uses
  SysUtils,
  DelphiAST.Classes,
  DiagnosticsIntf;

type
  TCustomDFSObserver = class(TInterfacedObject)
  protected
    procedure Visit(const ANode: TSyntaxNode); virtual; abstract;
  public
    procedure Run(const ARoot: TSyntaxNode); virtual;
  end;

  TSingleEventObserver = class(TCustomDFSObserver, INodeIterator)
  private
    FNodeVisit: TProc<TSyntaxNode>;
    procedure SetNodeVisit(const Value: TProc<TSyntaxNode>);
    function GetNodeVisit: TProc<TSyntaxNode>;
  protected
    procedure Visit(const ANode: TSyntaxNode); override;
  public
    property NodeVisit: TProc<TSyntaxNode> read GetNodeVisit write SetNodeVisit;
  end;

implementation

{ TCustomDFSObserver }

procedure TCustomDFSObserver.Run(const ARoot: TSyntaxNode);
var
  Node: TSyntaxNode;
begin
  Visit(ARoot);
  for Node in ARoot.ChildNodes do
    Run(Node);
end;

{ TSingleEventObserver }

function TSingleEventObserver.GetNodeVisit: TProc<TSyntaxNode>;
begin
  Result := FNodeVisit;
end;

procedure TSingleEventObserver.SetNodeVisit(const Value: TProc<TSyntaxNode>);
begin
  FNodeVisit := Value;
end;

procedure TSingleEventObserver.Visit(const ANode: TSyntaxNode);
begin
  if Assigned(FNodeVisit) then
    FNodeVisit(ANode);
end;

end.
