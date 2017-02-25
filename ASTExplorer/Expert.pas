{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit Expert;

interface

uses
  Menus,
  ToolsAPI, DockForm;

type
  TASTExplorer = class(TNotifierObject, IOTANotifier, IOTAWizard)
  private
    FMenuItem: TMenuItem;
  public
    procedure Execute; overload;
    procedure Execute(Sender: TObject); overload;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  procedure Register;

implementation

uses
  DeskUtil, SysUtils,
  TreeFm, IDEServices;

procedure Register;
begin
  RegisterPackageWizard(TASTExplorer.Create as IOTAWizard);
end;

{ TASTExplorer }

constructor TASTExplorer.Create;
begin
  FMenuItem := TServices.AddMenuItem(GetName, Execute);
end;

procedure TASTExplorer.Execute;
begin
  TTreeForm.Instance.Show;
end;

destructor TASTExplorer.Destroy;
begin
  FreeAndNil(FMenuItem);
  inherited;
end;

procedure TASTExplorer.Execute(Sender: TObject);
begin
  Execute;
end;

function TASTExplorer.GetIDString: string;
begin
  Result := 'ASTExplorer';
end;

function TASTExplorer.GetName: string;
begin
  Result := 'AST Explorer';
end;

function TASTExplorer.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

end.
