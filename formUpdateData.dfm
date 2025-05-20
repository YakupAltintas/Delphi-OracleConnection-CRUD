object frmUpdateData: TfrmUpdateData
  Left = 0
  Top = 0
  Caption = 'Kay'#305't G'#252'ncelle'
  ClientHeight = 263
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 48
    Top = 48
    Width = 14
    Height = 15
    Caption = 'TC'
  end
  object Label2: TLabel
    Left = 47
    Top = 104
    Width = 15
    Height = 15
    Caption = 'Ad'
  end
  object Label3: TLabel
    Left = 30
    Top = 160
    Width = 32
    Height = 15
    Caption = 'Soyad'
  end
  object editTC: TEdit
    Left = 80
    Top = 45
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object editAd: TEdit
    Left = 80
    Top = 101
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object editSoyad: TEdit
    Left = 80
    Top = 157
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object btnGuncelle: TButton
    Left = 96
    Top = 208
    Width = 75
    Height = 25
    Caption = 'G'#252'ncelle'
    TabOrder = 3
    OnClick = btnGuncelleClick
  end
end
