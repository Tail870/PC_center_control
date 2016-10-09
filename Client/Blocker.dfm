object FormBlocker: TFormBlocker
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = ' '
  ClientHeight = 328
  ClientWidth = 584
  Color = clSkyBlue
  TransparentColor = True
  TransparentColorValue = clMaroon
  DefaultMonitor = dmDesktop
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  StyleElements = [seFont, seClient]
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 500
    Height = 250
    Caption = #1055#1050' '#1079#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085
    Color = clCream
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object Label1: TLabel
      Left = 70
      Top = 51
      Width = 174
      Height = 13
      Caption = '1     2     3     4     5     6     7     8     9'
    end
    object Label2: TLabel
      Left = 8
      Top = 210
      Width = 48
      Height = 13
      Caption = '1     2     3'
    end
    object Label3: TLabel
      Left = 8
      Top = 229
      Width = 174
      Height = 13
      Caption = '1     2     3     4     5     6     7     8     9'
    end
    object Button1: TButton
      Left = 70
      Top = 70
      Width = 350
      Height = 80
      Caption = #1053#1072#1095#1072#1090#1100' '#1088#1072#1073#1086#1090#1091'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 50
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 413
      Top = 210
      Width = 84
      Height = 37
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1080
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 248
    Width = 500
    Height = 72
    Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1080
    Color = clCream
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    Visible = False
    object Label4: TLabel
      Left = 25
      Top = 15
      Width = 302
      Height = 13
      Caption = #1055#1077#1088#1077#1076' '#1085#1072#1095#1072#1083#1086#1084' '#1088#1072#1073#1086#1090#1099' '#1086#1087#1083#1072#1090#1080#1090#1077' '#1074#1088#1077#1084#1103' '#1091' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072'.'
    end
    object Label5: TLabel
      Left = 25
      Top = 39
      Width = 269
      Height = 13
      Caption = #1042#1086' '#1074#1088#1077#1084#1103' '#1086#1087#1083#1072#1090#1099' '#1074#1088#1077#1084#1077#1085#1080' '#1091#1090#1086#1095#1085#1080#1090#1077' '#1074#1072#1096' '#1082#1086#1084#1087#1100#1102#1090#1077#1088'.'
    end
    object Label6: TLabel
      Left = 25
      Top = 27
      Width = 248
      Height = 13
      Caption = #1058#1072#1088#1080#1092#1099' '#1090#1072#1082' '#1078#1077' '#1089#1087#1088#1072#1096#1080#1074#1072#1081#1090#1077' '#1091' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072'.'
    end
    object Label7: TLabel
      Left = 25
      Top = 51
      Width = 348
      Height = 13
      Caption = #1055#1086' '#1085#1072#1078#1072#1090#1080#1102' '#1082#1085#1086#1087#1082#1080' "'#1053#1072#1095#1072#1090#1100' '#1088#1072#1073#1086#1090#1091'!" '#1084#1086#1078#1077#1090#1077' '#1087#1088#1080#1089#1090#1091#1087#1072#1090#1100' '#1082' '#1088#1072#1073#1086#1090#1077'.'
    end
  end
  object TimerTerminator: TTimer
    Interval = 500
    OnTimer = TimerTerminatorTimer
    Left = 528
    Top = 112
  end
  object TimerUnlock: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = TimerUnlockTimer
    Left = 528
    Top = 160
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    Host = '192.168.1.8'
    IPVersion = Id_IPv4
    Port = 885
    ReadTimeout = -1
    Left = 528
    Top = 56
  end
  object TrayIcon1: TTrayIcon
    OnMouseMove = TrayIcon1MouseMove
    Left = 528
    Top = 8
  end
end
