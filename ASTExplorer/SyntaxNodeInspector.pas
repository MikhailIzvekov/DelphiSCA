{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit SyntaxNodeInspector;

interface

uses
  Classes,
  DelphiAST.Classes, DelphiAST.Consts;

type
  TAttributesPersistent = class(TPersistent)
  private
    FOwner: TPersistent;
    FNode: TSyntaxNode;
    function GetAttributeValue(Index: TAttributeName): String;
  protected
    function GetOwner: TPersistent; override;
  public
    property Node: TSyntaxNode read FNode write FNode;
    constructor Create(const AOwner: TPersistent);
  published
    property anType: String index anType read GetAttributeValue;
    property anClass: String index anClass read GetAttributeValue;
    property anForwarded: String index anForwarded read GetAttributeValue;
    property anKind: String index anKind read GetAttributeValue;
    property anName: String index anName read GetAttributeValue;
    property anVisibility: String index anVisibility read GetAttributeValue;
    property anCallingConvention: String index anCallingConvention read GetAttributeValue;
    property anPath: String index anPath read GetAttributeValue;
    property anMethodBinding: String index anMethodBinding read GetAttributeValue;
    property anReintroduce: String index anReintroduce read GetAttributeValue;
    property anOverload: String index anOverload read GetAttributeValue;
    property anAbstract: String index anAbstract read GetAttributeValue;
  end;

  TSyntaxNodePersistent = class(TPersistent)
  private
    FNode: TSyntaxNode;
    FAttributes: TAttributesPersistent;
    function GetCol: Integer;
    function GetLine: Integer;
    function GetTyp: TSyntaxNodeType;
    procedure SetNode(const Value: TSyntaxNode);
  protected
    property Node: TSyntaxNode read FNode write SetNode;
  public
    constructor Create;
    destructor Destroy; override;
  public
    class function CreatePersistent(const ANode: TSyntaxNode): TSyntaxNodePersistent;
  published
    property Attributes: TAttributesPersistent read FAttributes;
    property Typ: TSyntaxNodeType read GetTyp;
    property Col: Integer read GetCol;
    property Line: Integer read GetLine;
  end;

implementation

uses
  DesignEditors, DesignIntf, TypInfo, SysUtils;

type
  TCompoundSyntaxNodePersistent = class(TSyntaxNodePersistent)
  private
    function GetNode: TCompoundSyntaxNode;
    function GetEndCol: Integer;
    function GetEndLine: Integer;
  published
    property EndCol: Integer read GetEndCol;
    property EndLine: Integer read GetEndLine;
  end;

  TValuedSyntaxNodePersistent = class(TSyntaxNodePersistent)
  private
    function GetNode: TValuedSyntaxNode;
    function GetValue: string;
  published
    property Value: string read GetValue;
  end;

  TCommentNodePersistent = class(TSyntaxNodePersistent)
  private
    function GetNode: TCommentNode;
    function GetText: string;
  published
    property Text: string read GetText;
  end;

  TAttributesProperty = class(TClassProperty)
  private
    function FilterFunc(const ATestEditor: IProperty): Boolean;
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

{ TSyntaxNodePersistent }

constructor TSyntaxNodePersistent.Create;
begin
  FAttributes := TAttributesPersistent.Create(Self);
  RegisterPropertyEditor(TypeInfo(TAttributesPersistent), TSyntaxNodePersistent, '', TAttributesProperty);
end;

class function TSyntaxNodePersistent.CreatePersistent(const ANode: TSyntaxNode): TSyntaxNodePersistent;
begin
  if ANode is TCompoundSyntaxNode then
    Result := TCompoundSyntaxNodePersistent.Create
  else
    if ANode is TValuedSyntaxNode then
      Result := TValuedSyntaxNodePersistent.Create
    else
      if ANode is TCommentNode then
        Result := TCommentNodePersistent.Create
      else
        Result := TSyntaxNodePersistent.Create;

  Result.Node := ANode;
end;

destructor TSyntaxNodePersistent.Destroy;
begin
  FAttributes.Free;
  inherited;
end;

function TSyntaxNodePersistent.GetCol: Integer;
begin
  Result := FNode.Col;
end;

function TSyntaxNodePersistent.GetLine: Integer;
begin
  Result := FNode.Line;
end;

function TSyntaxNodePersistent.GetTyp: TSyntaxNodeType;
begin
  Result := FNode.Typ;
end;

procedure TSyntaxNodePersistent.SetNode(const Value: TSyntaxNode);
begin
  FNode := Value;
  FAttributes.Node := Value;
end;

{ TAttributesPersistent }

constructor TAttributesPersistent.Create(const AOwner: TPersistent);
begin
  FOwner := AOwner;
end;

function TAttributesPersistent.GetAttributeValue(Index: TAttributeName): String;
begin
  Result := FNode.GetAttribute(Index);
end;

function TAttributesPersistent.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TAttributesProperty }

function TAttributesProperty.FilterFunc(const ATestEditor: IProperty): Boolean;
begin
  Result := ATestEditor.GetValue <> '';
end;

procedure TAttributesProperty.GetProperties(Proc: TGetPropProc);
var
  I: Integer;
  J: Integer;
  Components: IDesignerSelections;
begin
  Components := TDesignerSelections.Create;
  for I := 0 to PropCount - 1 do
  begin
    J := GetOrdValueAt(I);
    if J <> 0 then
      Components.Add(TComponent(GetOrdValueAt(I)));
  end;
  if Components.Count > 0 then
    GetComponentProperties(Components, tkProperties, Designer, Proc, FilterFunc);
end;

{ TCompoundSyntaxNodePersistent }

function TCompoundSyntaxNodePersistent.GetEndCol: Integer;
begin
  Result := GetNode.EndCol;
end;

function TCompoundSyntaxNodePersistent.GetEndLine: Integer;
begin
  Result := GetNode.EndLine;
end;

function TCompoundSyntaxNodePersistent.GetNode: TCompoundSyntaxNode;
begin
  Result := Node as TCompoundSyntaxNode;
end;

{ TValuedSyntaxNodePersistent }

function TValuedSyntaxNodePersistent.GetNode: TValuedSyntaxNode;
begin
  Result := Node as TValuedSyntaxNode;
end;

function TValuedSyntaxNodePersistent.GetValue: string;
begin
  Result := GetNode.Value;
end;

{ TCommentNodePersistent }

function TCommentNodePersistent.GetNode: TCommentNode;
begin
  Result := Node as TCommentNode;
end;

function TCommentNodePersistent.GetText: string;
begin
  Result := GetNode.Text;
end;

end.
