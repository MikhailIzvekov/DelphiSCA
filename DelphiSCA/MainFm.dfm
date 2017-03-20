object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 507
  ClientWidth = 703
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ResultsMemo: TMemo
    Left = 0
    Top = 0
    Width = 703
    Height = 507
    Align = alClient
    TabOrder = 0
  end
  object MainMenu: TMainMenu
    Left = 56
    Top = 120
    object OpenMenuItem: TMenuItem
      Action = FileOpenAction
    end
  end
  object ActionList: TActionList
    Left = 136
    Top = 120
    object FileOpenAction: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Dialog.Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
      OnAccept = FileOpenActionAccept
    end
  end
end
