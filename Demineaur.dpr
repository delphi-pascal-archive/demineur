program Demineaur;



uses
  Forms,
  uMain in 'uMain.pas' {fMain},
  uPerso in 'uPerso.pas' {fPerso},
  uScoreListe in 'uScoreListe.pas' {fScoreList},
  uAPropos in 'uAPropos.pas' {fAPropos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfPerso, fPerso);
  Application.CreateForm(TfScoreList, fScoreList);
  Application.CreateForm(TfAPropos, fAPropos);
  Application.Run;
end.
