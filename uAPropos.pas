unit uAPropos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfAPropos = class(TForm)
    ImageWindows: TImage;
    ImageMine: TImage;
    LBL_Nom: TLabel;
    LBL_EMail: TLabel;
    LBL_GSM: TLabel;
    BOK: TButton;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  fAPropos: TfAPropos;

implementation

{$R *.dfm}

end.
