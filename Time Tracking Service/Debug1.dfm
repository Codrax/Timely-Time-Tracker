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
  object Label4: TLabel
    Left = 288
    Top = 43
    Width = 90
    Height = 13
    Caption = 'Int:MusicOption = '
  end
  object Label5: TLabel
    Left = 288
    Top = 62
    Width = 114
    Height = 13
    Caption = 'Str:Current open app ='
    OnClick = Label5Click
  end
  object Label6: TLabel
    Left = 288
    Top = 81
    Width = 109
    Height = 13
    Caption = 'Str:Current Caption = '
    OnClick = Label5Click
  end
  object Label7: TLabel
    Left = 288
    Top = 119
    Width = 25
    Height = 13
    Caption = 'Idle: '
  end
  object Label8: TLabel
    Left = 288
    Top = 100
    Width = 89
    Height = 13
    Caption = 'Int:InfoScr Left = '
    OnClick = Label5Click
  end
  object Button1: TButton
    Left = 120
    Top = 200
    Width = 44
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 202
    Width = 106
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
  object Button11: TButton
    Left = 420
    Top = 157
    Width = 99
    Height = 25
    Caption = 'Delete Log'
    TabOrder = 11
    OnClick = Button11Click
  end
  object CheckBox1: TCheckBox
    Left = 328
    Top = 134
    Width = 97
    Height = 17
    Caption = 'Enable Logging'
    TabOrder = 12
    OnClick = CheckBox1Click
  end
  object Button12: TButton
    Left = 328
    Top = 157
    Width = 75
    Height = 25
    Caption = 'Open Log'
    TabOrder = 13
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 136
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Light Theme'
    TabOrder = 14
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 136
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Dark Theme'
    TabOrder = 15
    OnClick = Button14Click
  end
  object CheckBox2: TCheckBox
    Left = 422
    Top = 134
    Width = 97
    Height = 17
    Caption = 'Enable 90 timer'
    TabOrder = 16
  end
  object Button16: TButton
    Left = 170
    Top = 200
    Width = 41
    Height = 25
    Caption = 'Ok 90'
    TabOrder = 17
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 170
    Top = 176
    Width = 41
    Height = 25
    Caption = 'Ok TTS'
    TabOrder = 18
    OnClick = Button16Click
  end
  object Button15: TButton
    Left = 217
    Top = 176
    Width = 41
    Height = 25
    Caption = 'Ok IScr'
    TabOrder = 19
    OnClick = Button16Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 16
    Top = 16
  end
end
