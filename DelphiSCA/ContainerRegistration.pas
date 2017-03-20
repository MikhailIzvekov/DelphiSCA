{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit ContainerRegistration;

interface

uses
  Spring.Container.Common, Spring.Container;

procedure RegisterComponents(AContainer: TContainer);

implementation

uses
  SysUtils,
  DelphiAST.Classes, DelphiAST.Consts,
  TreeIntf, DiagnosticsIntf,
  Equivalence, DiagnosticsFactory, ASTObserver,
  D001_IdenticalSubExpressions;

const
  AllDiagnosticsClasses: array[0..1] of TDiagnosticsClass = (
    T001_IdenticalSubExpressions,
    T001_IdenticalSubExpressions2
  );

procedure RegisterDiagnosticsFactories(AContainer: TContainer);
var
  DiagnosticClass: TDiagnosticsClass;
  ServiceName: String;
  ImplementorName: String;
begin
  for DiagnosticClass in AllDiagnosticsClasses do
  begin
    ServiceName := DiagnosticClass.ClassName.Substring(1);
    ImplementorName := DiagnosticClass.ClassName;
    case DiagnosticClass.NodeType of
      ntAdd:
        AContainer.RegisterFactory<IDiagnosticsFactory_Add>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAlignmentParam:
        Acontainer.RegisterFactory<IDiagnosticsFactory_AlignmentParam>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAnd:
        Acontainer.RegisterFactory<IDiagnosticsFactory_And>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAnonymousMethod:
        Acontainer.RegisterFactory<IDiagnosticsFactory_AnonymousMethod>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntArguments:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Arguments>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAs:
        Acontainer.RegisterFactory<IDiagnosticsFactory_As>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAssign:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Assign>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAt:
        Acontainer.RegisterFactory<IDiagnosticsFactory_At>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAttribute:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Attribute>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAttributes:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Attributes>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntBounds:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Bounds>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntCall:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Call>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntCase:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Case>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntCaseElse:
        Acontainer.RegisterFactory<IDiagnosticsFactory_CaseElse>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntCaseLabel:
        Acontainer.RegisterFactory<IDiagnosticsFactory_CaseLabel>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntCaseLabels:
        Acontainer.RegisterFactory<IDiagnosticsFactory_CaseLabels>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntCaseSelector:
        Acontainer.RegisterFactory<IDiagnosticsFactory_CaseSelector>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntClassConstraint:
        Acontainer.RegisterFactory<IDiagnosticsFactory_ClassConstraint>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntConstant:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Constant>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntConstants:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Constants>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntConstraints:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Constraints>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntConstructorConstraint:
        Acontainer.RegisterFactory<IDiagnosticsFactory_ConstructorConstraint>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntContains:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Contains>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntDefault:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Default>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntDeref:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Deref>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntDimension:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Dimension>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntDiv:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Div>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntDot:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Dot>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntDownTo:
        Acontainer.RegisterFactory<IDiagnosticsFactory_DownTo>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntElement:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Element>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntElse:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Else>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntEmptyStatement:
        Acontainer.RegisterFactory<IDiagnosticsFactory_EmptyStatement>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntEnum:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Enum>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntEqual:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Equal>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntExcept:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Except>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntExceptionHandler:
        Acontainer.RegisterFactory<IDiagnosticsFactory_ExceptionHandler>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntExports:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Exports>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntExpression:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Expression>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntExpressions:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Expressions>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntExternal:
        Acontainer.RegisterFactory<IDiagnosticsFactory_External>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntFDiv:
        Acontainer.RegisterFactory<IDiagnosticsFactory_FDiv>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntField:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Field>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntFields:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Fields>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntFinalization:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Finalization>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntFinally:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Finally>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntFor:
        Acontainer.RegisterFactory<IDiagnosticsFactory_For>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntFrom:
        Acontainer.RegisterFactory<IDiagnosticsFactory_From>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntGeneric:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Generic>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntGoto:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Goto>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntGreater:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Greater>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntGreaterEqual:
        Acontainer.RegisterFactory<IDiagnosticsFactory_GreaterEqual>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntGuid:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Guid>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntHelper:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Helper>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntIdentifier:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Identifier>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntIf:
        Acontainer.RegisterFactory<IDiagnosticsFactory_If>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntImplementation:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Implementation>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntImplements:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Implements>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntIn:
        Acontainer.RegisterFactory<IDiagnosticsFactory_In>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntIndex:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Index>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntIndexed:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Indexed>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntInherited:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Inherited>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntInitialization:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Initialization>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntInterface:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Interface>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntIs:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Is>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntLabel:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Label>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntLHS:
        Acontainer.RegisterFactory<IDiagnosticsFactory_LHS>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntLiteral:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Literal>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntLower:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Lower>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntLowerEqual:
        Acontainer.RegisterFactory<IDiagnosticsFactory_LowerEqual>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntMessage:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Message>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntMethod:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Method>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntMod:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Mod>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntMul:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Mul>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntName:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Name>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntNamedArgument:
        Acontainer.RegisterFactory<IDiagnosticsFactory_NamedArgument>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntNotEqual:
        Acontainer.RegisterFactory<IDiagnosticsFactory_NotEqual>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntNot:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Not>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntOr:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Or>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntPackage:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Package>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntParameter:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Parameter>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntParameters:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Parameters>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntPath:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Path>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntPositionalArgument:
        Acontainer.RegisterFactory<IDiagnosticsFactory_PositionalArgument>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntProtected:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Protected>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntPrivate:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Private>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntProperty:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Property>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntPublic:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Public>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntPublished:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Published>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntRaise:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Raise>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntRead:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Read>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntRecordConstraint:
        Acontainer.RegisterFactory<IDiagnosticsFactory_RecordConstraint>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntRepeat:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Repeat>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntRequires:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Requires>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntResolutionClause:
        Acontainer.RegisterFactory<IDiagnosticsFactory_ResolutionClause>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntResourceString:
        Acontainer.RegisterFactory<IDiagnosticsFactory_ResourceString>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntReturnType:
        Acontainer.RegisterFactory<IDiagnosticsFactory_ReturnType>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntRHS:
        Acontainer.RegisterFactory<IDiagnosticsFactory_RHS>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntRoundClose:
        Acontainer.RegisterFactory<IDiagnosticsFactory_RoundClose>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntRoundOpen:
        Acontainer.RegisterFactory<IDiagnosticsFactory_RoundOpen>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntSet:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Set>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntShl:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Shl>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntShr:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Shr>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntStatement:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Statement>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntStatements:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Statements>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntStrictPrivate:
        Acontainer.RegisterFactory<IDiagnosticsFactory_StrictPrivate>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntStrictProtected:
        Acontainer.RegisterFactory<IDiagnosticsFactory_StrictProtected>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntSub:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Sub>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntSubrange:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Subrange>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntThen:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Then>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntTo:
        Acontainer.RegisterFactory<IDiagnosticsFactory_To>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntTry:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Try>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntType:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Type>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntTypeArgs:
        Acontainer.RegisterFactory<IDiagnosticsFactory_TypeArgs>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntTypeDecl:
        Acontainer.RegisterFactory<IDiagnosticsFactory_TypeDecl>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntTypeParam:
        Acontainer.RegisterFactory<IDiagnosticsFactory_TypeParam>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntTypeParams:
        Acontainer.RegisterFactory<IDiagnosticsFactory_TypeParams>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntTypeSection:
        Acontainer.RegisterFactory<IDiagnosticsFactory_TypeSection>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntValue:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Value>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntVariable:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Variable>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntVariables:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Variables>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntXor:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Xor>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntUnaryMinus:
        Acontainer.RegisterFactory<IDiagnosticsFactory_UnaryMinus>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntUnit:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Unit>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntUses:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Uses>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntWhile:
        Acontainer.RegisterFactory<IDiagnosticsFactory_While>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntWith:
        Acontainer.RegisterFactory<IDiagnosticsFactory_With>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntWrite:
        Acontainer.RegisterFactory<IDiagnosticsFactory_Write>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntAnsiComment:
        Acontainer.RegisterFactory<IDiagnosticsFactory_AnsiComment>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntBorComment:
        Acontainer.RegisterFactory<IDiagnosticsFactory_BorComment>(ServiceName, ImplementorName, TParamResolution.ByType);
      ntSlashesComment:
        Acontainer.RegisterFactory<IDiagnosticsFactory_SlashesComment>(ServiceName, ImplementorName, TParamResolution.ByType);
    end;
  end;
end;

procedure RegisterDiagnostics(AContainer: TContainer);
begin
  AContainer.RegisterType<IDiagnostics, T001_IdenticalSubExpressions>(T001_IdenticalSubExpressions.ClassName);
  AContainer.RegisterType<IDiagnostics, T001_IdenticalSubExpressions2>(T001_IdenticalSubExpressions2.ClassName);
end;

procedure RegisterComponents(AContainer: TContainer);
begin
  AContainer.RegisterType<IEquivalenceChecker, TChildrensEquivalenceChecker>;
  AContainer.RegisterType<IDiagnosticsFactory, TDiagnosticsFactory>;
  AContainer.RegisterType<INodeIterator, TSingleEventObserver>;

  RegisterDiagnostics(AContainer);
  RegisterDiagnosticsFactories(AContainer);
end;

end.
