object Form1: TForm1
  Left = 686
  Top = 231
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1047#1072#1087#1086#1083#1085#1077#1085#1080#1077' '#1079#1072#1103#1074#1086#1082' ('#1074#1077#1088#1089#1080#1103' 1.2.0)'
  ClientHeight = 615
  ClientWidth = 442
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object InstructionLabel: TLabel
    Left = 0
    Top = 592
    Width = 442
    Height = 23
    Align = alBottom
    Caption = ' ESC - '#1101#1082#1089#1090#1088#1077#1085#1085#1086#1077' '#1087#1088#1077#1088#1099#1074#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 271
  end
  object SystemPageControl: TPageControl
    Left = 0
    Top = 0
    Width = 445
    Height = 587
    ActivePage = SUDIRTabSheet
    TabOrder = 0
    OnChange = SystemPageControlChange
    object SUDIRTabSheet: TTabSheet
      Caption = #1057#1059#1044#1048#1056
      ImageIndex = 1
      object SUDIRWaitInstructionLabel: TLabel
        Left = 24
        Top = 16
        Width = 392
        Height = 112
        Caption = 
          #1047#1072#1076#1077#1088#1078#1082#1072' '#1084#1077#1078#1076#1091' '#1085#1072#1078#1072#1090#1080#1103#1084#1080' '#1082#1083#1072#1074#1080#1096' '#1087#1088#1080' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1080' '#1074#1088#1077#1084#1103 +
          ' '#1085#1072' '#1087#1086#1076#1075#1088#1091#1079#1082#1091' '#1086#1090#1082#1088#1099#1074#1072#1102#1097#1080#1093#1089#1103' '#1086#1082#1086#1085' '#1074' '#1057#1059#1044#1048#1056'. '#1063#1077#1084' '#1084#1077#1085#1100#1096#1077' '#1079#1072#1076#1077#1088#1078#1082#1072', '#1090 +
          #1077#1084' '#1073#1099#1089#1090#1088#1077#1077' '#1087#1088#1086#1089#1090#1072#1074#1083#1103#1102#1090#1089#1103' "'#1075#1072#1083#1082#1080'". '#1045#1089#1083#1080' '#1074#1086#1079#1085#1080#1082#1083#1080' '#1087#1088#1086#1073#1083#1077#1084#1099' '#1087#1088#1080' '#1088#1072#1073 +
          #1086#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' ('#1085#1072#1087#1088#1080#1084#1077#1088', "'#1075#1072#1083#1082#1080'" '#1085#1077' '#1091#1089#1087#1077#1074#1072#1102#1090' '#1087#1088#1086#1089#1090#1072#1074#1083#1103#1090#1100#1089#1103'), '#1085#1091#1078 +
          #1085#1086' '#1091#1074#1077#1083#1080#1095#1080#1090#1100' '#1079#1072#1076#1077#1088#1078#1082#1091'. '#1045#1089#1083#1080' '#1086#1082#1085#1072' '#1057#1059#1044#1048#1056' '#1085#1077' '#1091#1089#1087#1077#1074#1072#1102#1090' '#1087#1088#1086#1075#1088#1091#1078#1072#1090#1100#1089#1103',' +
          ' '#1085#1091#1078#1085#1086' '#1091#1074#1077#1083#1080#1095#1080#1090#1100' '#1074#1088#1077#1084#1103' '#1085#1072' '#1079#1072#1075#1088#1091#1079#1082#1091' '#1086#1082#1085#1072'. '#1055#1086#1083#1103' '#1085#1077' '#1084#1086#1075#1091#1090' '#1073#1099#1090#1100' '#1087#1091#1089#1090 +
          #1099#1084#1080'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object SUDIRRoleInstructionLabel: TLabel
        Left = 24
        Top = 208
        Width = 406
        Height = 64
        Caption = 
          #1044#1072#1083#1077#1077' '#1091#1082#1072#1079#1099#1074#1072#1077#1090#1089#1103' '#1088#1086#1083#1100' '#1089#1086#1075#1083#1072#1089#1085#1086' '#1088#1086#1083#1077#1074#1086#1081' '#1084#1086#1076#1077#1083#1080' ('#1086#1073#1099#1095#1085#1086' '#1091#1082#1072#1079#1099#1074#1072#1077#1090 +
          #1089#1103' '#1074' '#1088#1086#1083#1077#1074#1086#1081' '#1079#1072#1103#1074#1082#1077') '#1080' '#1085#1086#1084#1077#1088#1072' '#1054#1057#1041' '#1080' '#1042#1057#1055' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103'. '#1053#1086#1084#1077#1088' '#1054#1057#1041' ' +
          #1091#1082#1072#1079#1099#1074#1072#1077#1090#1089#1103' '#1074' 4 '#1089#1080#1084#1074#1086#1083#1072', '#1085#1086#1084#1077#1088' '#1042#1057#1055' - '#1074' 5 '#1089#1080#1084#1074#1086#1083#1086#1074'. '#1055#1086#1083#1103' '#1085#1077' '#1084#1086#1075#1091#1090 +
          ' '#1073#1099#1090#1100' '#1087#1091#1089#1090#1099#1084#1080'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object SUDIRRoleLabel: TLabel
        Left = 24
        Top = 296
        Width = 194
        Height = 16
        Caption = #1056#1086#1083#1100' ('#1089#1086#1075#1083#1072#1089#1085#1086' '#1088#1086#1083#1077#1074#1086#1081' '#1084#1086#1076#1077#1083#1080')'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object SUDIRWaitLabeledEdit: TLabeledEdit
        Left = 34
        Top = 160
        Width = 121
        Height = 31
        EditLabel.Width = 80
        EditLabel.Height = 16
        EditLabel.Caption = #1047#1072#1076#1077#1088#1078#1082#1072', '#1084#1089
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '100'
        OnKeyPress = SUDIRWaitLabeledEditKeyPress
      end
      object SUDIRLoadWndLabeledEdit: TLabeledEdit
        Left = 226
        Top = 160
        Width = 121
        Height = 31
        EditLabel.Width = 104
        EditLabel.Height = 16
        EditLabel.Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1086#1082#1085#1072', '#1084#1089
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '2000'
        OnKeyPress = SUDIRLoadWndLabeledEditKeyPress
      end
      object SUDIRRoleComboBox: TComboBox
        Left = 24
        Top = 318
        Width = 392
        Height = 24
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 2
        OnChange = SUDIRRoleComboBoxChange
        Items.Strings = (
          #1057#1054#1063#1051' ('#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090' '#1087#1086' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1102' '#1095#1072#1089#1090#1085#1099#1093' '#1083#1080#1094')'
          #1052#1055#1055' ('#1084#1077#1085#1077#1076#1078#1077#1088' '#1087#1086' '#1087#1088#1086#1076#1072#1078#1072#1084')'
          #1042#1057#1054#1063#1051' ('#1042#1077#1076#1091#1097#1080#1081' '#1089#1087#1077#1094'-'#1090' '#1087#1086' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1102' '#1095#1072#1089#1090#1085#1099#1093' '#1083#1080#1094')'
          #1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100' '#1042#1057#1055' / '#1047#1072#1084#1077#1089#1090#1080#1090#1077#1083#1100)
      end
      object SUDIROsbLabeledEdit: TLabeledEdit
        Left = 24
        Top = 368
        Width = 131
        Height = 31
        EditLabel.Width = 66
        EditLabel.Height = 16
        EditLabel.Caption = #1053#1086#1084#1077#1088' '#1054#1057#1041
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnKeyPress = SUDIROsbLabeledEditKeyPress
      end
      object SUDIRVspLabeledEdit: TLabeledEdit
        Left = 226
        Top = 368
        Width = 121
        Height = 31
        EditLabel.Width = 64
        EditLabel.Height = 16
        EditLabel.Caption = #1053#1086#1084#1077#1088' '#1042#1057#1055
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnKeyPress = SUDIRVspLabeledEditKeyPress
      end
      object SUDIRSysBitBtn1: TBitBtn
        Left = 24
        Top = 424
        Width = 283
        Height = 49
        Caption = #1044#1072#1090#1100' '#1048#1085#1092#1086#1073#1072#1085#1082' '#1080' '#1057#1074#1077#1088#1082#1091
        Default = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 6
        ParentFont = False
        TabOrder = 8
        OnClick = SUDIRSysBitBtn1Click
        NumGlyphs = 2
      end
      object SUDIRSysBitBtn2: TBitBtn
        Left = 24
        Top = 495
        Width = 283
        Height = 50
        Caption = #1044#1072#1090#1100' '#1058#1088#1072#1085#1079#1072#1082#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = SUDIRSysBitBtn2Click
      end
      object InfobankCheckBox: TCheckBox
        Left = 319
        Top = 416
        Width = 82
        Height = 17
        Caption = #1048#1085#1092#1086#1073#1072#1085#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Visible = False
      end
      object SverkaCheckBox: TCheckBox
        Left = 319
        Top = 439
        Width = 66
        Height = 17
        Caption = #1057#1074#1077#1088#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Visible = False
      end
      object TransactCheckBox: TCheckBox
        Left = 319
        Top = 495
        Width = 82
        Height = 17
        Caption = #1058#1088#1072#1085#1079#1072#1082#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Visible = False
      end
      object SKADCheckBox: TCheckBox
        Left = 319
        Top = 464
        Width = 58
        Height = 17
        Caption = #1057#1050#1040#1044
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Visible = False
      end
    end
    object ZNDTabSheet: TTabSheet
      Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1076#1086#1089#1090#1091#1087
      object ZNDCheckLabel: TLabel
        Left = 24
        Top = 208
        Width = 407
        Height = 48
        Caption = 
          #1047#1076#1077#1089#1100' '#1091#1082#1072#1079#1099#1074#1072#1077#1090#1089#1103' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1086#1089#1090#1072#1074#1083#1103#1077#1084#1099#1093' "'#1075#1072#1083#1086#1082'". '#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1087 +
          #1088#1086#1089#1090#1072#1074#1080#1090#1100' '#1087#1077#1088#1074#1091#1102' "'#1075#1072#1083#1082#1091'" '#1074' '#1089#1090#1086#1083#1073#1094#1077', '#1072' '#1079#1072#1090#1077#1084' '#1091#1082#1072#1079#1072#1090#1100', '#1089#1082#1086#1083#1100#1082#1086' '#1089#1090#1072 +
          #1074#1080#1090#1100' '#1086#1090' '#1085#1077#1105' '#1074#1085#1080#1079'. '#1055#1086#1083#1077' '#1085#1077' '#1084#1086#1078#1077#1090' '#1073#1099#1090#1100' '#1087#1091#1089#1090#1099#1084'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object ZNDWaitInstructionLabel: TLabel
        Left = 24
        Top = 16
        Width = 396
        Height = 80
        Caption = 
          #1047#1072#1076#1077#1088#1078#1082#1072' '#1084#1077#1078#1076#1091' '#1085#1072#1078#1072#1090#1080#1103#1084#1080' '#1082#1083#1072#1074#1080#1096' '#1087#1088#1080' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'. '#1063#1077#1084' '#1084#1077 +
          #1085#1100#1096#1077' '#1079#1072#1076#1077#1088#1078#1082#1072', '#1090#1077#1084' '#1073#1099#1089#1090#1088#1077#1077' '#1087#1088#1086#1089#1090#1072#1074#1083#1103#1102#1090#1089#1103' "'#1075#1072#1083#1082#1080'". '#1045#1089#1083#1080' '#1074#1086#1079#1085#1080#1082#1083#1080' ' +
          #1087#1088#1086#1073#1083#1077#1084#1099' '#1087#1088#1080' '#1088#1072#1073#1086#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' ('#1085#1072#1087#1088#1080#1084#1077#1088', "'#1075#1072#1083#1082#1080'" '#1085#1077' '#1091#1089#1087#1077#1074#1072#1102#1090' '#1087#1088#1086 +
          #1089#1090#1072#1074#1083#1103#1090#1100#1089#1103'), '#1085#1091#1078#1085#1086' '#1091#1074#1077#1083#1080#1095#1080#1090#1100' '#1079#1072#1076#1077#1088#1078#1082#1091'. '#1055#1086#1083#1077' '#1085#1077' '#1084#1086#1078#1077#1090' '#1073#1099#1090#1100' '#1087#1091#1089#1090#1099#1084 +
          '.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object ZNDWaitLabeledEdit: TLabeledEdit
        Left = 42
        Top = 136
        Width = 121
        Height = 31
        EditLabel.Width = 80
        EditLabel.Height = 16
        EditLabel.Caption = #1047#1072#1076#1077#1088#1078#1082#1072', '#1084#1089
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '50'
        OnKeyPress = ZNDWaitLabeledEditKeyPress
      end
      object CheckRadioGroup: TRadioGroup
        Left = 208
        Top = 111
        Width = 185
        Height = 64
        Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' "'#1075#1072#1083#1082#1080'"'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 1
        Items.Strings = (
          #1054#1076#1080#1085#1086#1095#1085#1086#1077' '#1085#1072#1078#1072#1090#1080#1077' TAB'
          #1044#1074#1086#1081#1085#1086#1077' '#1085#1072#1078#1072#1090#1080#1077' TAB')
        ParentFont = False
        TabOrder = 1
      end
      object ZNDCountCheckLabeledEdit: TLabeledEdit
        Left = 42
        Top = 304
        Width = 121
        Height = 31
        EditLabel.Width = 114
        EditLabel.Height = 16
        EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' "'#1075#1072#1083#1086#1082'"'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '91'
        OnKeyPress = ZNDCountCheckLabeledEditKeyPress
      end
      object CountCheckBitBtn: TBitBtn
        Left = 208
        Top = 291
        Width = 193
        Height = 57
        Cancel = True
        Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' "'#1075#1072#1083#1082#1080'"'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 2
        ParentFont = False
        TabOrder = 3
        OnClick = CountCheckBitBtnClick
        NumGlyphs = 2
      end
    end
  end
end
