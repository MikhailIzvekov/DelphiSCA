{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit TreeFm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, System.Actions, Vcl.ActnList,
  DockForm, ToolsAPI, PropInspAPI, System.ImageList, Vcl.ImgList,
  DelphiAST.Classes,
  SyntaxNodeInspector;

type
  TTreeForm = class(TDockableForm)
    TreeView: TTreeView;
    ToolBar: TToolBar;
    RefreshToolButton: TToolButton;
    ActionList: TActionList;
    RefreshAction: TAction;
    ImageList: TImageList;
    procedure RefreshActionExecute(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
  private
    class var FInstance: TTreeForm;
  private
    FSyntaxNodePersistent: TSyntaxNodePersistent;
    procedure GetNodeCoord(const ANode: TSyntaxNode; var BeginCoord: TOTACharPos; var EndCoord: TOTACharPos);
    procedure Select(const AView: IOTAEditView; const ANode: TSyntaxNode);
    procedure Inspect(const AObjectInspector: IOTAPropInspServices; const ANode: TSyntaxNode);
    procedure AddNode(const AParent: TTreeNode; const ANode: TSyntaxNode);
    procedure ClearTree;
  public
    procedure Show;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    class property Instance: TTreeForm read FInstance;
    class constructor Init;
    class destructor Done;
  end;

implementation

{$R *.dfm}

uses
  DeskUtil,
  DelphiAST, DelphiAST.Consts,
  IDEServices, Helpers, ASTUtils;

{ TTreeForm }

procedure TTreeForm.AddNode(const AParent: TTreeNode; const ANode: TSyntaxNode);
var
  NewNode: TTreeNode;
  I: Integer;
begin
  NewNode := TreeView.Items.AddChild(AParent, ANode.Caption);
  NewNode.Info := ANode;
  for I := Low(ANode.ChildNodes) to High(ANode.ChildNodes) do
    AddNode(NewNode, ANode.ChildNodes[I]);
end;

procedure TTreeForm.ClearTree;
begin
  if TreeView.Items.Count > 0 then
  begin
    TreeView.Items[0].Info.Free;
    TreeView.Items.Clear;
  end;
end;

constructor TTreeForm.Create(AOwner: TComponent);
begin
  inherited;
  DeskSection := Name;
  AutoSave := True;
  SaveStateNecessary := True;
end;

destructor TTreeForm.Destroy;
begin
  SaveStateNecessary := True;
  Inspect(TServices.ObjectInspector, nil);

  if @UnregisterFieldAddress <> nil then
    UnregisterFieldAddress(@FInstance);

  inherited;
  FInstance := nil;
end;

class destructor TTreeForm.Done;
begin
  FreeAndNil(FInstance);
end;

procedure TTreeForm.GetNodeCoord(const ANode: TSyntaxNode; var BeginCoord, EndCoord: TOTACharPos);
begin
  BeginCoord.Line := ANode.Line;
  BeginCoord.CharIndex := ANode.Col - 1;

  EndCoord.Line := ANode.EndLine;
  EndCoord.CharIndex := ANode.EndCol - 1;
end;

class constructor TTreeForm.Init;
begin
  FInstance := TTreeForm.Create(nil);

  if @RegisterFieldAddress <> nil then
    RegisterFieldAddress('TTreeForm', @TTreeForm.Instance);
  RegisterDesktopFormClass(TTreeForm, 'ASTHelper', 'TTreeForm');
end;

procedure TTreeForm.Inspect(const AObjectInspector: IOTAPropInspServices; const ANode: TSyntaxNode);
var
  OldNode: TSyntaxNodePersistent;
begin
  OldNode := FSyntaxNodePersistent;
  FSyntaxNodePersistent := nil;
  try
    if Assigned(ANode) then
    begin
      FSyntaxNodePersistent := TSyntaxNodePersistent.CreatePersistent(ANode);
      (AObjectInspector as INTAPropInspServices).SelectObjects([FSyntaxNodePersistent])
    end
    else
      (AObjectInspector as INTAPropInspServices).SelectObjects([]);
  finally
    FreeAndNil(OldNode);
  end;
end;

procedure TTreeForm.RefreshActionExecute(Sender: TObject);
begin
  ClearTree;
  AddNode(nil, TASTUtils.CreateTree(TServices.GetEditorText(TServices.Editor.TopBuffer)));
end;

procedure TTreeForm.Select(const AView: IOTAEditView; const ANode: TSyntaxNode);
var
  StartCharPos: TOTACharPos;
  EndCharPos: TOTACharPos;
  StartEditPos: TOTAEditPos;
  EndEditPos: TOTAEditPos;
begin
  GetNodeCoord(ANode, StartCharPos, EndCharPos);

  // initial selection
  TServices.SelectTextInEditor(AView, StartCharPos, EndCharPos);

  // often initial selection is not enough (ide bug?), so select that way
  AView.ConvertPos(False, StartEditPos, StartCharPos);
  AView.ConvertPos(False, EndEditPos, EndCharPos);
  TServices.SelectTextInEditor(AView, StartEditPos, EndEditPos);

  // get selection into view
  if (StartEditPos.Line < AView.TopPos.Line) or
     (EndEditPos.Line >= AView.TopPos.Line + AView.ViewSize.cy) then
  begin
    if StartEditPos.Col < AView.ViewSize.cy then
      StartEditPos.Col := 1;
    AView.TopPos := StartEditPos;
  end;
  AView.Paint;
end;

procedure TTreeForm.Show;
begin
  if not Floating then
  begin
    ForceShow;
    FocusWindow(Self);
  end
  else
    inherited;
end;

procedure TTreeForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  Select(TServices.Editor.TopView, Node.Info);
  Inspect(TServices.ObjectInspector, Node.Info);
end;

end.
