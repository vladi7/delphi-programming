object Form1: TForm1
  Left = 254
  Top = 124
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 26
    Height = 13
    Caption = 'Order'
  end
  object __spin: TSpinEdit
    Left = 56
    Top = 8
    Width = 121
    Height = 22
    MaxValue = 10
    MinValue = 2
    TabOrder = 0
    Value = 3
    OnChange = __spinChange
  end
  object __grid: TStringGrid
    Left = 8
    Top = 56
    Width = 320
    Height = 120
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Do'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 200
    Width = 75
    Height = 25
    Caption = 'To Excel...'
    TabOrder = 3
    OnClick = Button2Click
  end
  object __Rgrid: TStringGrid
    Left = 344
    Top = 56
    Width = 353
    Height = 113
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 4
    OnDrawCell = __RgridDrawCell
  end
  object Button3: TButton
    Left = 184
    Top = 200
    Width = 75
    Height = 25
    Caption = 'From Excel...'
    TabOrder = 5
    OnClick = Button3Click
  end
end
