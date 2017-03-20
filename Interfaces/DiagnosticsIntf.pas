{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit DiagnosticsIntf;

interface

uses
  SysUtils,
  DelphiAST.Consts, DelphiAST.Classes;

type
  TDiagnosticsResult = record
    Fail: Boolean;
    Msg: String;
  end;

  IDiagnostics = interface
  ['{FEE449FB-B7D0-488C-BC99-FF86833C99BA}']
    function Execute: TDiagnosticsResult;
  end;

  {$M+}
  IDiagnosticsFactory_ = interface(TFunc<TSyntaxNode, IDiagnostics>)
    function Invoke(Arg: TSyntaxNode): IDiagnostics;
  end;
  {$M-}

  TDiagnosticsFactories = TArray<IDiagnosticsFactory_>;

  IDiagnosticsFactory = interface
  ['{0360F258-1244-4FEE-B99D-4D56E965DCED}']
    function GetByType(const ATyp: TSyntaxNodeType): TDiagnosticsFactories;

    property ByType[const ATyp: TSyntaxNodeType]: TDiagnosticsFactories read GetByType;
  end;

  {$REGION 'All node types diagnostics factories'}
  IDiagnosticsFactory_Add = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Addr = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_AlignmentParam = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_And = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_AnonymousMethod = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Arguments = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_As = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Assign = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_At = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Attribute = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Attributes = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Bounds = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Call = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Case = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_CaseElse = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_CaseLabel = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_CaseLabels = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_CaseSelector = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_ClassConstraint = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Constant = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Constants = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Constraints = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_ConstructorConstraint = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Contains = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Default = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Deref = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Dimension = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Div = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Dot = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_DownTo = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Element = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Else = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_EmptyStatement = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Enum = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Equal = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Except = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_ExceptionHandler = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Exports = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Expression = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Expressions = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_External = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_FDiv = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Field = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Fields = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Finalization = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Finally = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_For = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_From = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Generic = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Goto = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Greater = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_GreaterEqual = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Guid = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Helper = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Identifier = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_If = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Implementation = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Implements = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_In = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Index = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Indexed = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Inherited = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Initialization = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Interface = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Is = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Label = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_LHS = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Literal = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Lower = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_LowerEqual = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Message = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Method = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Mod = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Mul = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Name = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_NamedArgument = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_NotEqual = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Not = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Or = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Package = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Parameter = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Parameters = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Path = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_PositionalArgument = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Protected = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Private = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Property = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Public = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Published = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Raise = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Read = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_RecordConstraint = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Repeat = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Requires = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_ResolutionClause = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_ResourceString = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_ReturnType = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_RHS = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_RoundClose = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_RoundOpen = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Set = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Shl = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Shr = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Statement = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Statements = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_StrictPrivate = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_StrictProtected = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Sub = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Subrange = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Then = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_To = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Try = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Type = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_TypeArgs = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_TypeDecl = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_TypeParam = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_TypeParams = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_TypeSection = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Value = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Variable = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Variables = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Xor = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_UnaryMinus = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Unit = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Uses = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_While = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_With = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_Write = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_AnsiComment = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_BorComment = interface(IDiagnosticsFactory_)
  end;

  IDiagnosticsFactory_SlashesComment = interface(IDiagnosticsFactory_)
  end;
  {$ENDREGION}

  TCustomDiagnostics = class abstract(TInterfacedObject)
  public
    class function NodeType: TSyntaxNodeType; virtual; abstract;
  end;

  TDiagnosticsClass = class of TCustomDiagnostics;

  INodeIterator = interface
  ['{E92D694B-712F-4023-8CB4-3C8BC443A01E}']
    procedure Run(const ARoot: TSyntaxNode);
    function GetNodeVisit: TProc<TSyntaxNode>;
    procedure SetNodeVisit(const Value: TProc<TSyntaxNode>);
    property NodeVisit: TProc<TSyntaxNode> read GetNodeVisit write SetNodeVisit;
  end;

const
  PassResult: TDiagnosticsResult = (
    Fail: False;
    Msg: '';
  );

implementation

end.
