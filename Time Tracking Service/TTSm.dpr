program TTSm;

{$R *.dres}

uses
  Vcl.Forms,
  SysUtils,
  Messages,
  Windows,
  TTSp in 'TTSp.pas' {TTS},
  InfScr in 'InfScr.pas' {Form1},
  infoshow in 'infoshow.pas' {Form2},
  Debug1 in 'Debug1.pas' {Form3},
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Dialogs,
  TimelyLib in '..\Shared\TimelyLib.pas';

{$R *.res}
var
j: integer;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TTTS, TTS);
  Application.CreateForm(TForm3, Form3);
  for j := 1 to ParamCount do begin
   if ParamStr(j)='/debug' then Form3.initdebug;
   if ParamStr(j)='/log' then enablelogging:=true;
 end;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  if fileexists('C:\Users\' + WUserName + '\AppData\Local\TTS\enabledebug.in') then Form3.initdebug;



  Application.Run;
end.
