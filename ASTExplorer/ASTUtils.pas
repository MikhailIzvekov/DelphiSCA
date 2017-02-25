{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit ASTUtils;

interface

uses
  DelphiAST.Classes;

type
  TASTUtils = class
    class function CreateTree(const AText: String): TSyntaxNode;
  end;

implementation

uses
  Classes,
  DelphiAST;

{ TASTUtils }

class function TASTUtils.CreateTree(const AText: String): TSyntaxNode;
var
  Stream: TStringStream;
  Builder: TPasSyntaxTreeBuilder;
begin
  Stream := TStringStream.Create(AText);
  try
    Builder := TPasSyntaxTreeBuilder.Create;
    Builder.InterfaceOnly := False;
    try
      Builder.InitDefinesDefinedByCompiler;
      Result := Builder.Run(Stream);
    finally
      Builder.Free;
    end;
  finally
    Stream.Free;
  end;
end;

end.
