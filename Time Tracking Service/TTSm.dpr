program TTSm;

uses
  Vcl.Forms,
  TTSp in 'TTSp.pas' {TTS},
  InfScr in 'InfScr.pas' {Form1},
  infoshow in 'infoshow.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTTS, TTS);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.