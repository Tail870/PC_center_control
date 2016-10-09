object Form1: TForm1
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1059#1089#1090#1072#1085#1086#1074#1097#1080#1082
  ClientHeight = 278
  ClientWidth = 609
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 61
    Top = 0
    Width = 222
    Height = 13
    Caption = #1044#1086#1073#1088#1086' '#1087#1086#1078#1072#1083#1086#1074#1072#1090#1100' '#1074' '#1087#1088#1086#1075#1088#1072#1084#1084#1091' '#1091#1089#1090#1072#1085#1086#1074#1082#1080'!'
  end
  object Label8: TLabel
    Left = 0
    Top = 215
    Width = 348
    Height = 13
    Caption = '__________________________________________________________'
  end
  object Label2: TLabel
    Left = 0
    Top = 234
    Width = 84
    Height = 13
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086':'
  end
  object ButtonEsc: TButton
    Left = 0
    Top = 253
    Width = 348
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 0
    OnClick = ButtonEscClick
  end
  object GroupBox1: TGroupBox
    Left = 5
    Top = 19
    Width = 337
    Height = 105
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100':'
    TabOrder = 1
    object Label3: TLabel
      Left = 73
      Top = 28
      Width = 172
      Height = 13
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1083#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1089#1077#1088#1074#1077#1088#1072
    end
    object Label4: TLabel
      Left = 73
      Top = 59
      Width = 250
      Height = 13
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1083#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1080#1083#1080' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1082#1083#1080#1077#1085#1090#1072
    end
    object ButtonSer: TButton
      Left = 3
      Top = 23
      Width = 64
      Height = 25
      Caption = #1057#1077#1088#1074#1077#1088
      TabOrder = 0
      OnClick = ButtonSerClick
    end
    object ButtonCli: TButton
      Left = 3
      Top = 54
      Width = 64
      Height = 25
      Caption = #1050#1083#1080#1077#1085#1090
      TabOrder = 1
      OnClick = ButtonCliClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 5
    Top = 121
    Width = 337
    Height = 88
    Caption = #1059#1076#1072#1083#1080#1090#1100':'
    TabOrder = 2
    object Label7: TLabel
      Left = 73
      Top = 58
      Width = 169
      Height = 13
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1082#1083#1080#1077#1085#1090#1072
    end
    object Label6: TLabel
      Left = 73
      Top = 27
      Width = 168
      Height = 13
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1089#1077#1088#1074#1077#1088#1072
    end
    object ButtonDelSer: TButton
      Left = 3
      Top = 22
      Width = 64
      Height = 25
      Caption = #1057#1077#1088#1074#1077#1088
      TabOrder = 0
      OnClick = ButtonDelSerClick
    end
    object ButtonDelCli: TButton
      Left = 3
      Top = 53
      Width = 64
      Height = 25
      Caption = #1050#1083#1080#1077#1085#1090
      TabOrder = 1
      OnClick = ButtonDelCliClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 19
    Width = 334
    Height = 190
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1085#1085#1099#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1082#1083#1080#1077#1085#1090#1072':'
    TabOrder = 3
    Visible = False
    object Label10: TLabel
      Left = 27
      Top = 61
      Width = 134
      Height = 13
      Caption = 'ID '#1082#1083#1080#1077#1085#1090#1072' '#1073#1077#1079' '#1087#1088#1086#1073#1077#1083#1086#1074': '
    end
    object Label11: TLabel
      Left = 69
      Top = 88
      Width = 92
      Height = 13
      Caption = 'IP-'#1072#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072':'
    end
    object Edit3: TEdit
      Left = 167
      Top = 58
      Width = 121
      Height = 21
      TabOrder = 0
      OnKeyPress = Edit3KeyPress
    end
    object Edit4: TEdit
      Left = 167
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 1
      OnKeyPress = Edit4KeyPress
    end
    object ButtonCliF: TButton
      Left = 167
      Top = 111
      Width = 121
      Height = 25
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1083#1080#1077#1085#1090
      TabOrder = 2
      OnClick = ButtonCliFClick
    end
  end
  object ButtonSeDeTo: TButton
    Left = 90
    Top = 229
    Width = 105
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1077#1088#1074#1077#1088#1072
    TabOrder = 4
    OnClick = ButtonSeDeToClick
  end
  object Memo1: TMemo
    Left = 348
    Top = 0
    Width = 261
    Height = 278
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Times New Roman'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    Visible = False
  end
  object Button1: TButton
    Left = 240
    Top = 229
    Width = 108
    Height = 25
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' >>>'
    TabOrder = 6
    OnClick = Button1Click
  end
end
