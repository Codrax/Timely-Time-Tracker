object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Debug Options'
  ClientHeight = 242
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 209
    Height = 25
    Caption = 'Current Sec Loading...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 157
    Width = 17
    Height = 13
    Caption = 'Sec'
  end
  object Label3: TLabel
    Left = 288
    Top = 24
    Width = 88
    Height = 13
    Caption = 'Int:TimeToStop = '
  end
  object Button1: TButton
    Left = 111
    Top = 200
    Width = 53
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 202
    Width = 97
    Height = 21
    TabOrder = 1
    TextHint = 'Enter a int value'
  end
  object Button2: TButton
    Left = 420
    Top = 209
    Width = 99
    Height = 25
    Caption = 'Disable Debug'
    ElevationRequired = True
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 328
    Top = 209
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 55
    Width = 41
    Height = 25
    Caption = '15mn'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 81
    Width = 41
    Height = 25
    Caption = '10min'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 104
    Width = 41
    Height = 25
    Caption = '5min'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 128
    Width = 41
    Height = 25
    Caption = '1min'
    TabOrder = 7
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 8
    Top = 176
    Width = 75
    Height = 25
    Caption = '+1'
    TabOrder = 8
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 89
    Top = 176
    Width = 75
    Height = 25
    Caption = '-1'
    TabOrder = 9
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 55
    Top = 55
    Width = 75
    Height = 98
    Caption = 'Alarm Expire'
    TabOrder = 10
    OnClick = Button10Click
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 16
    Top = 16
  end
end