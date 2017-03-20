{ This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/. }
unit LicenseChecker;

interface

uses
  IOUtils,
  TestFramework;

type
  // Test for class TPrimitiveEquivalenceChecker
  TLicenseChecker = class(TTestCase)
  strict private
    FIgnoreFolders: TArray<String>;
    FRootFolder: String;
    procedure CheckFile(const AFileName: String);
  public
    procedure SetUp; override;
  published
    procedure TestPas;
  end;

implementation

uses
  SysUtils, Classes;

const
  LicenseBlock: array[0..2] of String = (
    '{ This Source Code Form is subject to the terms of the Mozilla Public',
    '  License, v. 2.0. If a copy of the MPL was not distributed with this',
    '  file, You can obtain one at http://mozilla.org/MPL/2.0/. }'
  );

{ TLicenseChecker }

procedure TLicenseChecker.CheckFile(const AFileName: String);
var
  S: String;
begin
  with TFile.OpenText(AFileName) do
  try
    for S in LicenseBlock do
      CheckEquals(S, ReadLine, AFileName);
  finally
    Free;
  end;
end;

procedure TLicenseChecker.SetUp;
begin
  inherited;
  FRootFolder := TDirectory.GetParent(TDirectory.GetParent(TPath.GetDirectoryName(ParamStr(0))));
  FIgnoreFolders := TArray<String>.Create('\lib', '\Samples', '\Test\Data');
end;

procedure TLicenseChecker.TestPas;
var
  FileName: String;
begin
  for FileName in TDirectory.GetFiles(FRootFolder,
    '*.pas', TSearchOption.soAllDirectories,
    function(const Path: string; const SearchRec: TSearchRec): Boolean
    var
      IgnoredFolder: String;
    begin
      for IgnoredFolder in FIgnoreFolders do
        if Path.StartsWith(FRootFolder + IgnoredFolder) then
          Exit(False);
      Result := True;
    end) do
    CheckFile(FileName);
end;

initialization
  RegisterTest(TLicenseChecker.Suite);

end.
