object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 545
  ClientWidth = 1045
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 489
    Top = 46
    Width = 32
    Height = 15
    Caption = 'Soyad'
  end
  object Label2: TLabel
    Left = 249
    Top = 47
    Width = 15
    Height = 15
    Caption = 'Ad'
  end
  object Label3: TLabel
    Left = 1
    Top = 47
    Width = 14
    Height = 15
    Caption = 'TC'
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 72
    Width = 1045
    Height = 473
    Align = alBottom
    Color = clBtnFace
    DrawingStyle = gdsGradient
    FixedColor = clAqua
    GradientEndColor = clYellow
    GradientStartColor = clMoneyGreen
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDblClick = DBGrid1DblClick
  end
  object editAd: TEdit
    Left = 289
    Top = 43
    Width = 177
    Height = 23
    TabOrder = 1
    OnChange = editAdChange
  end
  object editTC: TEdit
    Left = 41
    Top = 43
    Width = 177
    Height = 23
    TabOrder = 2
    OnChange = editTCChange
  end
  object editSoyad: TEdit
    Left = 537
    Top = 43
    Width = 177
    Height = 23
    TabOrder = 3
    OnChange = editSoyadChange
  end
  object btnInsertUser: TButton
    Left = 952
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Yeni Kay'#305't'
    TabOrder = 4
    OnClick = btnInsertUserClick
  end
end
