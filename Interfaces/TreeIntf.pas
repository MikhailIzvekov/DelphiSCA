{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
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
