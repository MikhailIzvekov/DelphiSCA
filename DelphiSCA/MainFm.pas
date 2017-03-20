{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit MainFm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList, Vcl.StdActns,
  DiagnosticsIntf, Spring.Container.Common, Spring.Container, DelphiAST.Classes, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    ActionList: TActionList;
    FileOpenAction: TFileOpen;
    OpenMenuItem: TMenuItem;
    ResultsMemo: TMemo;
    procedure FileOpenActionAccept(Sender: TObject);
  private
    FFactories: IDiagnosticsFactory;
    FNodeIterator: INodeIterator;

    procedure OnVisitNode(ANode: TSyntaxNode);
  public
    { Public declarations }
    [Inject]
    procedure Init(
      const AFactories: IDiagnosticsFactory;
      const ANodeIterator: INodeIterator);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  DelphiAST;

{ TMainForm }

procedure TMainForm.FileOpenActionAccept(Sender: TObject);
var
  SyntaxTree: TSyntaxNode;
begin
  SyntaxTree := TPasSyntaxTreeBuilder.Run((Sender as TFileOpen).Dialog.FileName, False);
  try
    FNodeIterator.Run(SyntaxTree);
  finally
    SyntaxTree.Free;
  end;
end;

procedure TMainForm.Init(const AFactories: IDiagnosticsFactory; const ANodeIterator: INodeIterator);
begin
  FFactories := AFactories;
  FNodeIterator := ANodeIterator;
  FNodeIterator.NodeVisit := OnVisitNode;
end;

procedure TMainForm.OnVisitNode(ANode: TSyntaxNode);
var
  Factory: IDiagnosticsFactory_;
  DResult: TDiagnosticsResult;
begin
  for Factory in FFactories.ByType[ANode.Typ] do
  begin
    DResult := Factory(ANode).Execute;
    if DResult.Fail then
      ResultsMemo.Lines.Add(DResult.Msg);
  end;
end;

end.
