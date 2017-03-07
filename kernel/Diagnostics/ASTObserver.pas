unit ASTObserver;

interface

implementation

uses
  DelphiAST.Classes;

type
  TCustomDFSObserver = class(TInterfacedObject)
  private
    procedure Visit(const ANode: TSyntaxNode); virtual; abstract;
  public
    procedure Run(const ARoot: TSyntaxNode); virtual;
  end;

{ TCustomDFSObserver }

procedure TCustomDFSObserver.Run(const ARoot: TSyntaxNode);
var
  Node: TSyntaxNode;
begin
  Visit(ARoot);
  for Node in ARoot.ChildNodes do
    Run(Node);
end;

end.
