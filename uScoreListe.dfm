object fScoreList: TfScoreList
  Left = 198
  Top = 110
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'D'#233'mineures les plus rapides !'
  ClientHeight = 141
  ClientWidth = 309
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
  object TitreDebutant: TLabel
    Left = 12
    Top = 24
    Width = 50
    Height = 13
    Caption = 'D'#233'butant :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object TitreIntermediaire: TLabel
    Left = 12
    Top = 44
    Width = 66
    Height = 13
    Caption = 'Interm'#233'diaire :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object TitreExpert: TLabel
    Left = 12
    Top = 64
    Width = 36
    Height = 13
    Caption = 'Expert :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object TempsDebutant: TLabel
    Left = 93
    Top = 24
    Width = 67
    Height = 13
    Caption = '999 secondes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object TempsIntermediaire: TLabel
    Left = 93
    Top = 44
    Width = 67
    Height = 13
    Caption = '999 secondes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object TempsExpert: TLabel
    Left = 93
    Top = 64
    Width = 67
    Height = 13
    Caption = '999 secondes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object NameDebutant: TLabel
    Left = 181
    Top = 24
    Width = 44
    Height = 13
    Caption = 'Anonyme'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object NameIntermediaire: TLabel
    Left = 181
    Top = 44
    Width = 44
    Height = 13
    Caption = 'Anonyme'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object NameExpert: TLabel
    Left = 181
    Top = 64
    Width = 44
    Height = 13
    Caption = 'Anonyme'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BEffacer: TButton
    Left = 32
    Top = 96
    Width = 109
    Height = 25
    Caption = 'Effacer les scores'
    TabOrder = 1
    TabStop = False
    OnClick = BEffacerClick
  end
  object BOK: TButton
    Left = 170
    Top = 96
    Width = 109
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
