{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit IDEServices;

interface

uses
  Classes, Menus,
  ToolsAPI, PropInspAPI;

type
  TServices = class
    class function Editor: IOTAEditorServices;
    class function ObjectInspector: IOTAPropInspServices;

    class function AddMenuItem(const ACaption: String; const AProc: TNotifyEvent): TMenuItem;

    class function GetEditorText(const AEditor: IOTAEditBuffer): String;
    class procedure SelectTextInEditor(
      const AView: IOTAEditView; const SelStart: TOTACharPos; const SelEnd: TOTACharPos); overload;
    class procedure SelectTextInEditor(
      const AView: IOTAEditView; const SelStart: TOTAEditPos; const SelEnd: TOTAEditPos); overload;
  end;

implementation

uses
  SysUtils, ActnList;

{ TServices }

class function TServices.AddMenuItem(const ACaption: String; const AProc: TNotifyEvent): TMenuItem;
var
  NTAServices: INTAServices;
  Action: TAction;
  ActionList: TCustomActionList;
  MainMenu: TMainMenu;
  Menu: TMenuItem;
  I: Integer;
begin
  Result := nil;
  NTAServices := BorlandIDEServices as INTAServices;
  ActionList := NTAServices.ActionList;
  MainMenu := NTAServices.MainMenu;
  if Assigned(MainMenu) and Assigned(ActionList) then
  begin
    Result := TMenuItem.Create(nil);

    Action := TAction.Create(Result);
    Action.ActionList := ActionList;
    Action.Caption := ACaption;
    Action.OnExecute := AProc;

    Result.Action := Action;

    Menu := MainMenu.Items;
    for I := 0 to Menu.Count - 1 do
      if Menu[I].Name = 'ToolsMenu' then
      begin
        Menu := Menu[I];
        Break;
      end;

    Menu.Insert(0, Result);
  end
end;

class function TServices.Editor: IOTAEditorServices;
begin
  BorlandIDEServices.QueryInterface(IOTAEditorServices, Result);
end;

class function TServices.GetEditorText(const AEditor: IOTAEditBuffer): String;
const
  BufferSize = 4096;
var
  Reader: IOTAEditReader;
  ReadCount: Integer;
  Position: Integer;
  Buffer: AnsiString;
begin
  Result := '';
  Reader := AEditor.CreateReader;
  Position := 0;
  repeat
    SetLength(Buffer, BufferSize);
    ReadCount := Reader.GetText(Position, PAnsiChar(Buffer), BufferSize);
    SetLength(Buffer, ReadCount);
    Result := Result + string(Buffer);
    Inc(Position, ReadCount);
  until ReadCount < BufferSize;
end;

class function TServices.ObjectInspector: IOTAPropInspServices;
begin
  BorlandIDEServices.QueryInterface(IOTAPropInspServices, Result);
end;

class procedure TServices.SelectTextInEditor(const AView: IOTAEditView; const SelStart, SelEnd: TOTACharPos);
begin
  AView.Buffer.BlockVisible := False;
  AView.Buffer.BlockType    := btNonInclusive;
  AView.Buffer.BlockStart   := SelStart;
  AView.Buffer.BlockAfter   := SelEnd;
  AView.Buffer.BlockVisible := True;
end;

class procedure TServices.SelectTextInEditor(const AView: IOTAEditView; const SelStart, SelEnd: TOTAEditPos);
begin
  AView.CursorPos := SelStart;
  AView.Block.BeginBlock;
  AView.CursorPos := SelEnd;
  AView.Block.EndBlock;
  AView.Block.SetVisible(True);
end;

end.
