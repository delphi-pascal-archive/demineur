unit uPerso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfPerso = class(TForm)
    EHauteur: TLabeledEdit;
    ELargeur: TLabeledEdit;
    EMines: TLabeledEdit;
    BOK: TButton;
    BAnnuler: TButton;
    procedure FormShow(Sender: TObject);
    procedure BOKClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fPerso: TfPerso;

implementation

uses uMain;

{$R *.dfm}

procedure TfPerso.FormShow(Sender: TObject);
begin
  EHauteur.Text := IntToStr(fMain.NbrLgn);
  ELargeur.Text := IntToStr(fMain.NbrCln);
  EMines.Text := IntToStr(fMain.NbrMine);
end;

procedure TfPerso.BOKClick(Sender: TObject);
var
  New_NbrLgn, New_NbrCln, New_NbrMine : Integer;
begin
  New_NbrLgn := StrToInt(EHauteur.Text);
  New_NbrCln := StrToInt(ELargeur.Text);
  New_NbrMine := StrToInt(EMines.Text);

  if (New_NbrLgn > fMain.NLMax) then New_NbrLgn := fMain.NLMax;
  if (New_NbrLgn < 9) then New_NbrLgn := 9;

  if (New_NbrCln > fMain.NCMax) then New_NbrCln := fMain.NCMax;
  if (New_NbrCln < 9) then New_NbrCln := 9;
  
  if (New_NbrMine > (New_NbrLgn * New_NbrCln div 2)) then New_NbrMine := New_NbrLgn * New_NbrCln div 2;
  if (New_NbrMine < 10) then New_NbrMine := 10;

  fMain.NbrLgn  := New_NbrLgn;
  fMain.NbrCln  := New_NbrCln;
  fMain.NbrMine := New_NbrMine;

  fMain.Level := L_Perso;
end;

end.
