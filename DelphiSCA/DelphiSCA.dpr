{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
program DelphiSCA;

uses
  SysUtils,
  Forms,
  MainFm in 'MainFm.pas' {MainForm},
  ContainerRegistration in 'ContainerRegistration.pas',
  Spring.Container;

{$R *.res}

procedure RegisterForm(const AContainer: TContainer);
begin
  AContainer.RegisterType<TMainForm, TMainForm>.DelegateTo(
    function: TMainForm
    begin
      Application.CreateForm(TMainForm, Result);
    end);
end;

var
  Container: TContainer;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Container := GlobalContainer;
  RegisterComponents(Container);
  RegisterForm(Container);
  Container.Build;
  Container.Resolve<TMainForm>;

  ReportMemoryLeaksOnShutdown := True;
  Application.Run;
end.

