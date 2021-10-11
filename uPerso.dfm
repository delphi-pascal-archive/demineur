object fPerso: TfPerso
  Left = 323
  Top = 213
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Peronalis'#233' !!!'
  ClientHeight = 124
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EHauteur: TLabeledEdit
    Left = 76
    Top = 25
    Width = 48
    Height = 21
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'Hauteur : '
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object ELargeur: TLabeledEdit
    Left = 76
    Top = 51
    Width = 48
    Height = 21
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Largeur : '
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object EMines: TLabeledEdit
    Left = 76
    Top = 77
    Width = 48
    Height = 21
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = 'Mines : '
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object BOK: TButton
    Left = 140
    Top = 25
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
    TabStop = False
    OnClick = BOKClick
  end
  object BAnnuler: TButton
    Left = 140
    Top = 73
    Width = 75
    Height = 25
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 4
    TabStop = False
  end
end
