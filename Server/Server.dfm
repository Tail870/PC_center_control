object FormServer: TFormServer
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1074#1088#1077#1084#1077#1085#1077#1084' '#1076#1086#1089#1090#1091#1087#1072
  ClientHeight = 423
  ClientWidth = 709
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
    Left = 3
    Top = 355
    Width = 93
    Height = 13
    Caption = #1056#1091#1073#1083#1077#1081' '#1079#1072' '#1084#1080#1085#1091#1090#1091':'
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 24
    Width = 409
    Height = 325
    Color = clSkyBlue
    ColCount = 3
    DefaultColWidth = 128
    DrawingStyle = gdsGradient
    FixedColor = clGradientActiveCaption
    FixedCols = 2
    RowCount = 13
    GradientEndColor = clBtnFace
    GradientStartColor = clMenu
    GridLineWidth = 3
    Options = [goVertLine, goHorzLine, goRangeSelect, goColMoving, goEditing]
    TabOrder = 0
    OnKeyPress = StringGrid1KeyPress
  end
  object StringGrid2: TStringGrid
    Left = 415
    Top = 24
    Width = 282
    Height = 353
    Color = clSkyBlue
    ColCount = 2
    DefaultColWidth = 128
    DrawingStyle = gdsGradient
    FixedColor = clGradientActiveCaption
    RowCount = 14
    GradientEndColor = clBtnFace
    GradientStartColor = clMenu
    GridLineWidth = 3
    Options = [goVertLine, goHorzLine, goRangeSelect, goColMoving, goEditing]
    TabOrder = 1
    Visible = False
    OnKeyPress = StringGrid1KeyPress
  end
  object Button1: TButton
    Left = 232
    Top = 355
    Width = 177
    Height = 22
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1082#1072#1089#1089#1086#1074#1091#1102' '#1090#1072#1073#1083#1080#1094#1091' >>'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 102
    Top = 353
    Width = 80
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    Text = '0'
  end
  object Button2: TButton
    Left = 0
    Top = 0
    Width = 409
    Height = 25
    Caption = #1057#1074#1077#1088#1085#1091#1090#1100
    TabOrder = 4
    OnClick = Button2Click
  end
  object IdTCPServer1: TIdTCPServer
    Active = True
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 885
      end>
    DefaultPort = 885
    ListenQueue = 5
    OnExecute = IdTCPServer1Execute
    Left = 192
    Top = 368
  end
end
