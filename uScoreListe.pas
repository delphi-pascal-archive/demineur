unit uScoreListe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, StdCtrls;

type
  TfScoreList = class(TForm)
    TitreDebutant: TLabel;
    TitreIntermediaire: TLabel;
    TitreExpert: TLabel;
    TempsDebutant: TLabel;
    TempsIntermediaire: TLabel;
    TempsExpert: TLabel;
    NameDebutant: TLabel;
    NameIntermediaire: TLabel;
    NameExpert: TLabel;
    BEffacer: TButton;
    BOK: TButton;
    procedure FormShow(Sender: TObject);
    procedure BEffacerClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  fScoreList: TfScoreList;

implementation

{$R *.dfm}

procedure TfScoreList.FormShow(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create();
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  Reg.OpenKeyReadOnly('SoftWare\Demineur\Debutant\');
  TempsDebutant.Caption := IntToStr(Reg.ReadInteger('Time')) + ' secondes';
  NameDebutant.Caption := Reg.ReadString('Name');
  Reg.CloseKey();

  Reg.OpenKeyReadOnly('SoftWare\Demineur\Intermediaire\');
  TempsIntermediaire.Caption := IntToStr(Reg.ReadInteger('Time')) + ' secondes';
  NameIntermediaire.Caption := Reg.ReadString('Name');
  Reg.CloseKey();

  Reg.OpenKeyReadOnly('SoftWare\Demineur\Expert\');
  TempsExpert.Caption := IntToStr(Reg.ReadInteger('Time')) + ' secondes';
  NameExpert.Caption := Reg.ReadString('Name');
  Reg.CloseKey();

  Reg.Free();
end;

procedure TfScoreList.BEffacerClick(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create();
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  Reg.OpenKey('\SoftWare\Demineur\Debutant\',True);
  Reg.WriteInteger('Time',999);
  Reg.WriteString('Name','Anonyme');
  Reg.CloseKey();

  Reg.OpenKey('\SoftWare\Demineur\Intermediaire\',True);
  Reg.WriteInteger('Time',999);
  Reg.WriteString('Name','Anonyme');
  Reg.CloseKey();

  Reg.OpenKey('\SoftWare\Demineur\Expert\',True);
  Reg.WriteInteger('Time',999);
  Reg.WriteString('Name','Anonyme');
  Reg.CloseKey();

  Reg.Free();

  TempsDebutant.Caption := '999 secondes';
  NameDebutant.Caption := 'Anonyme';

  TempsIntermediaire.Caption := '999 secondes';
  NameIntermediaire.Caption := 'Anonyme';

  TempsExpert.Caption := '999 secondes';
  NameExpert.Caption := 'Anonyme';
end;

end.
