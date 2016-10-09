object Form2: TForm2
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Server Debuger Tool'
  ClientHeight = 138
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 90
    Top = 0
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 8
    Top = 0
    Width = 76
    Height = 13
    Caption = #1054#1090#1074#1077#1090' '#1089#1077#1088#1074#1077#1088#1072
  end
  object Label3: TLabel
    Left = 8
    Top = 19
    Width = 16
    Height = 13
    Caption = 'cID'
  end
  object Label4: TLabel
    Left = 135
    Top = 19
    Width = 43
    Height = 13
    Caption = #1082#1086#1084#1072#1085#1076#1072
  end
  object Label5: TLabel
    Left = 8
    Top = 65
    Width = 63
    Height = 13
    Caption = #1040#1076#1088#1077#1089' '#1093#1086#1089#1090#1072
  end
  object Label6: TLabel
    Left = 183
    Top = 87
    Width = 22
    Height = 13
    Caption = ':885'
  end
  object ButtonGO: TButton
    Left = 262
    Top = 35
    Width = 105
    Height = 27
    Caption = #1055#1086#1089#1083#1072#1090#1100' '#1079#1072#1087#1088#1086#1089
    Enabled = False
    TabOrder = 0
    OnClick = ButtonGOClick
  end
  object Edit1: TEdit
    Left = 0
    Top = 38
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'cID'
  end
  object Edit2: TEdit
    Left = 135
    Top = 38
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'ONLINE'
  end
  object Edit3: TEdit
    Left = 0
    Top = 84
    Width = 177
    Height = 21
    TabOrder = 3
  end
  object ButtonConnect: TButton
    Left = 211
    Top = 82
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 4
    OnClick = ButtonConnectClick
  end
  object ButtonDisconnect: TButton
    Left = 292
    Top = 82
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    Enabled = False
    TabOrder = 5
    OnClick = ButtonDisconnectClick
  end
  object Button1: TButton
    Left = 0
    Top = 113
    Width = 178
    Height = 25
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103' '#1082' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1084#1091' '#1086#1082#1085#1091
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 184
    Top = 113
    Width = 183
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 7
    OnClick = Button2Click
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    Host = '127.0.0.1'
    IPVersion = Id_IPv4
    Port = 885
    ReadTimeout = -1
    Left = 224
    Top = 13
  end
end
