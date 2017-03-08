unit TreeIntf;

interface

uses
  DelphiAST.Classes;

type
  IEquivalenceChecker = interface
  ['{BC1CA693-9FB1-4C89-A8DD-ED5EA89DE312}']
    function Equal(const ANode1: TSyntaxNode; const ANode2: TSyntaxNode): Boolean;
  end;

implementation

end.
