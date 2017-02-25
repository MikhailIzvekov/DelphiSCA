{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit Helpers;

interface

uses
  ComCtrls, SysUtils,
  DelphiAST.Classes;

type
  TTreeNodeHelper = class helper for TTreeNode
  private
    function GetInfo: TSyntaxNode;
    procedure SetInfo(const Value: TSyntaxNode);
  public
    property Info: TSyntaxNode read GetInfo write SetInfo;
  end;

  TSyntaxNodeHelper = class helper for TSyntaxNode
  private
    function GetEndCol: Integer;
    function GetEndLine: Integer;
    function GetCaption: String;
  public
    property EndLine: Integer read GetEndLine;
    property EndCol: Integer read GetEndCol;
    property Caption: String read GetCaption;
  end;

implementation

uses
   DelphiAST.Consts;

{ TTreeNodeHelper }

function TTreeNodeHelper.GetInfo: TSyntaxNode;
begin
  Result := TObject(Data) as TSyntaxNode;
end;

procedure TTreeNodeHelper.SetInfo(const Value: TSyntaxNode);
begin
  Data := Value;
end;

{ TSyntaxNodeHelper }

function TSyntaxNodeHelper.GetCaption: String;
var
  Attr: TAttributeEntry;
begin
  Result := SyntaxNodeNames[Typ];

  if Self is TValuedSyntaxNode then
    Result := Result + ': value="' + TValuedSyntaxNode(Self).Value + '"';

  for Attr in Attributes do
    Result := Result + ' ' + AttributeNameStrings[Attr.Key] + '="' + Attr.Value + '"';
end;

function TSyntaxNodeHelper.GetEndCol: Integer;
begin
  if Self is TCompoundSyntaxNode then
    Exit(TCompoundSyntaxNode(Self).EndCol);

  Result := Col + GetAttribute(anName).Length;

  if Self is TValuedSyntaxNode then
    Inc(Result, TValuedSyntaxNode(Self).Value.Length);
end;

function TSyntaxNodeHelper.GetEndLine: Integer;
begin
  if Self is TCompoundSyntaxNode then
    Exit(TCompoundSyntaxNode(Self).EndLine);

  Result := Line;
end;

end.
