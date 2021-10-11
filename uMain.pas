unit uMain;

interface             

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, ExtCtrls, ImgList, Menus, Buttons, StdCtrls, Registry;

type
  Caze = Record
   Image: TImage;
   Info: 0..8;
   Checked, Marqued, Mined: Boolean;
  end;
  TLevel = (L_Un, L_Deux, L_Trois, L_Perso);

type
  TfMain = class(TForm)
    ChampDeMines: TPanel;
    ImageListe: TImageList;
    Affiche: TPanel;
    MainMenu: TMainMenu;
    MI_Partie: TMenuItem;
    MI_NouvellePartie: TMenuItem;
    MI_Separator1: TMenuItem;
    MI_Debutant: TMenuItem;
    MI_Intermediaire: TMenuItem;
    MI_Expert: TMenuItem;
    MI_Personalise: TMenuItem;
    MI_Separator2: TMenuItem;
    MI_MTemps: TMenuItem;
    MI_Separator3: TMenuItem;
    MI_Quitter: TMenuItem;
    MI_Aide: TMenuItem;
    MI_APropos: TMenuItem;
    BNew: TBitBtn;
    Timer: TTimer;
    ETime: TEdit;
    EMine: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure CheckCase(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoadNewGame(Sender: TObject);
    procedure ShowElapsedTime(Sender: TObject);
    procedure MI_QuitterClick(Sender: TObject);
    procedure MI_MTempsClick(Sender: TObject);
    procedure MI_AProposClick(Sender: TObject);
  private
    { Déclarations privées }
    Procedure Descover(i, j: Integer);
    procedure NewGame();
    function isEndGame(): Boolean;
    procedure EndGame();
    procedure AfficherCacherDrapeau(i,j: integer);
    procedure TesterMine(i,j: integer);
    procedure GameOver();
    procedure ShowFinedMine();
    procedure ViderChampDeMines();
    procedure MinerChampDeMines();
    procedure CheckMenuItem();
    procedure CreateScoreListIfNoteExist();
    function UpdateScoreListe(): Boolean;
  public
    { Déclarations publiques }
    NbrLgn,NbrCln,NbrMine: Integer;
    NLMax, NCMax: integer;
    Level : TLevel;
  end;

var
  fMain: TfMain;
  T: Array of Array of Caze;
  Time, FinedMine: Integer;


implementation

uses uPerso, uScoreListe, uAPropos;

{$R *.dfm}

function TfMain.UpdateScoreListe(): Boolean;
var
  Reg: TRegistry;
  Name: String;
begin
  Result := False;
  Reg := TRegistry.Create();
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  case (Level) of
    L_Un    : Reg.OpenKey('\SoftWare\Demineur\Debutant\',True);
    L_Deux  : Reg.OpenKey('\SoftWare\Demineur\Intermediaire\',True);
    L_Trois : Reg.OpenKey('\SoftWare\Demineur\Expert\',True);
  end;

  if (Level <> L_Perso) then begin
    if (Time < Reg.ReadInteger('Time')) then begin
      Name := InputBox('Meilleur démineur...','Veuillez saisire votre nom :','Anonyme');
      Reg.WriteString('Name',Name);
      Reg.WriteInteger('Time',Time);
      Result := True;
    end;
    Reg.CloseKey();
  end;

  Reg.Free();
end;

procedure TfMain.CreateScoreListIfNoteExist();
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create();
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  if not Reg.KeyExists('\SoftWare\Demineur') then begin 
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
  end;
  Reg.Free();
end;

procedure TfMain.EndGame();
begin
  Timer.Enabled := False;
  ChampDeMines.Enabled := False;
  if UpdateScoreListe() then fScoreList.ShowModal();
end;

procedure TfMain.CheckMenuItem();
begin
  MI_Debutant.Checked := Level =L_Un;
  MI_Intermediaire.Checked := Level =L_Deux;
  MI_Expert.Checked := Level =L_Trois;
  MI_Personalise.Checked := Level =L_Perso;
end;

procedure TfMain.MinerChampDeMines();
var
  i,j,Cpt: Integer;
begin
  Randomize();
  Cpt := 0;
  while (Cpt < NbrMine) do begin
    i := Random(NbrLgn);
    j := Random(NbrCln);
    if (not T[i,j].Mined) then begin
      T[i,j].Mined := True;

      if (i-1 >= 0) then begin
        if (j-1 >= 0) then INC(T[i-1,j-1].Info);
        INC(T[i-1,j].Info);
        if (j+1 < NbrCln) then INC(T[i-1,j+1].Info);
      end;

      if (j-1 >= 0) then INC(T[i,j-1].Info);
      if (j+1 < NbrCln) then INC(T[i,j+1].Info);

      if (i+1 < NbrLgn) then begin
        if (j-1 >= 0) then INC(T[i+1,j-1].Info);
        INC(T[i+1,j].Info);
        if (j+1 < NbrCln) then INC(T[i+1,j+1].Info);
      end;

      Cpt := Cpt + 1;
    end;
  end;
end;

procedure TfMain.ViderChampDeMines();
var
  i,j: Integer;
begin
  for i:=0 to NbrLgn - 1 do
    for j:=0 to NbrCln - 1 do begin
      ImageListe.GetIcon(9,T[i,j].Image.Picture.Icon);
      T[i,j].Info := 0;
      T[i,j].Mined := False;
      T[i,j].Image.Tag := i * NbrCln + j;
      T[i,j].Checked := False;
      T[i,j].Marqued := False;
    end;
end;

procedure TfMain.GameOver();
var
  i,j: Integer;
begin
  Timer.Enabled := False;
  ChampDeMines.Enabled := False;
  for i := 0 to NbrLgn - 1 do
    for j := 0 to NbrCln - 1 do begin
      if (T[i,j].Marqued)and(not T[i,j].Mined) then
        ImageListe.GetIcon(12,T[i,j].Image.Picture.Icon);
      if (not T[i,j].Marqued)and(T[i,j].Mined) then
        ImageListe.GetIcon(11,T[i,j].Image.Picture.Icon);
    end;
end;

procedure TfMain.TesterMine(i,j: integer);
begin
  if (not T[i,j].Mined) then begin
    Descover(i,j);
    if isEndGame() then EndGame();
  end else GameOver();
end;

procedure TfMain.AfficherCacherDrapeau(i,j: integer);
begin
  if (not T[i,j].Marqued) then begin
    T[i,j].Marqued := True;
    ImageListe.GetIcon(10,T[i,j].Image.Picture.Icon);
    FinedMine := FinedMine + 1;
    if isEndGame() then EndGame();
  end else begin
    T[i,j].Marqued := False;
    ImageListe.GetIcon(9,T[i,j].Image.Picture.Icon);
    FinedMine := FinedMine - 1;
  end;
  ShowFinedMine();
end;

function TfMain.isEndGame(): Boolean;
var
  i,j: Integer;
begin
  i := 0;
  Result := FinedMine = NbrMine;
  while (i < NbrLgn) and Result do begin
    j := 0;
    while (j < NbrCln) and Result do begin
      if T[i,j].Mined then Result := T[i,j].Marqued
      else Result := T[i,j].Checked;
      j := j + 1;
    end;
    i := i + 1;
  end;
end;

procedure  TfMain.CheckCase(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,j: integer;
begin
  i := (Sender as TControl).Tag div NbrCln;
  j := (Sender as TControl).Tag mod NbrCln;
  Timer.Enabled := True;
  if (not T[i,j].Checked) then begin
    if (Button = mbRight) then AfficherCacherDrapeau(i,j);
    if (not T[i,j].Marqued) and (Button = mbLeft) then TesterMine(i,j);
  end;
end;

procedure TfMain.NewGame();
begin
  CheckMenuItem();

  ChampDeMines.Enabled := True;
  ChampDeMines.Width := 16 * NbrCln + 4;
  ChampDeMines.Height := 16 * NbrLgn + 4;
  ChampDeMines.Left := 8;

  fMain.Width := ChampDeMines.Width + 20;
  fMain.Height := ChampDeMines.Top + ChampDeMines.Height + 60;
  fMain.Position := poScreenCenter;

  Timer.Enabled := False;
  BNew.Left := (Affiche.Width - BNew.Width) div 2;
  ETime.Left := Affiche.Width - ETime.Width - 12;
  ETime.Text := '000'; Time := 0; FinedMine := 0;
  ShowFinedMine();

  ViderChampDeMines();

  MinerChampDeMines();
end;

Procedure TfMain.Descover(i, j: Integer);
begin
  if (not T[i,j].Checked)and(not T[i,j].Marqued) then begin
    ImageListe.GetIcon(T[i,j].Info,T[i,j].Image.Picture.Icon);
    T[i,j].Checked := True;
    if (T[i,j].Info = 0) then begin

      if (i-1 >= 0) then begin
        if (j-1 >= 0) then Descover(i-1,j-1);
        Descover(i-1,j);
        if (j+1 < NbrCln) then Descover(i-1,j+1);
      end;

      if (j-1 >= 0) then Descover(i,j-1);
      if (j+1 < NbrCln) then Descover(i,j+1);

      if (i+1 < NbrLgn) then begin
        if (j-1 >= 0) then Descover(i+1,j-1);
        Descover(i+1,j);
        if (j+1 < NbrCln) then Descover(i+1,j+1);
      end;

    end;
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  i,j: integer;
begin
  CreateScoreListIfNoteExist();
  
  Level := L_Trois;
  NLMax := 24; NCMax := 30;
  NbrCln := 30; NbrLgn := 16; NbrMine := 99;
  SetLength(T,NLMax,NCMax);
  for i:=0 to NLMax-1 do
    for j:=0 to NCMax-1 do begin
      T[i,j].Image := TImage.Create(self);
      T[i,j].Image.Parent := ChampDeMines;
      T[i,j].Image.Left := j * 16;
      T[i,j].Image.Top := i * 16;
      T[i,j].Image.AutoSize := True;
      T[i,j].Image.OnMouseDown := CheckCase;
    end;
  NewGame();
end;

procedure TfMain.LoadNewGame(Sender: TObject);
begin
  case (Sender as TComponent).Tag of
    1: begin NbrLgn := 09; NbrCln := 09; NbrMine := 10; Level := L_Un;    end;
    2: begin NbrLgn := 16; NbrCln := 16; NbrMine := 40; Level := L_Deux;  end;
    3: begin NbrLgn := 16; NbrCln := 30; NbrMine := 99; Level := L_Trois; end;
    4: fPerso.ShowModal();
  end;
  if (Sender as TComponent).Tag  = 4 then begin
    if (fPerso.ModalResult = mrOK) then NewGame();
  end else NewGame();
end;

procedure TfMain.ShowElapsedTime(Sender: TObject);
begin
  INC(Time);
  case (Time div 10) of
         0: ETime.Text := '00' + IntToStr(Time);
      1..9: ETime.Text :=  '0' + IntToStr(Time);
    10..90: ETime.Text := IntToStr(Time);
  end;
  if (Time = 999) then begin
    MessageDlg('Temps limite dépassé !',mtWarning,[mbOK],0);
    GameOver();
  end;
end;

procedure TfMain.ShowFinedMine();
var
  Ch: String;
begin
  case ((NbrMine - FinedMine) div 10) of
    -9..-1: ch := '-';
         0: If (NbrMine >= FinedMine) then Ch := '00' else Ch := '-0';
      1..9: Ch := '0';
    10..90: Ch := '';
  end;
  EMine.Text := Ch + IntToStr(ABS(NbrMine  - FinedMine));
end;

procedure TfMain.MI_QuitterClick(Sender: TObject);
begin
  Application.Terminate();
end;

procedure TfMain.MI_MTempsClick(Sender: TObject);
begin
  fScoreList.ShowModal();
end;

procedure TfMain.MI_AProposClick(Sender: TObject);
begin
  fAPropos.ShowModal();
end;

end.
