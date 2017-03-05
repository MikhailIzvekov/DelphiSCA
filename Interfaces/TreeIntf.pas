unit TreeIntf;

interface

uses
  DelphiAST.Classes;

type
  IEquivalenceChecker = interface
    function Equal(const ANode1: TSyntaxNode; const ANode2: TSyntaxNode): Boolean;
  end;

implementation

end.
