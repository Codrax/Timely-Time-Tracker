program TTU;



{$R *.dres}

uses
  Vcl.Forms,
  TTUmu in 'TTUmu.pas' {Timely},
  TimelyLib in '..\Shared\TimelyLib.pas',
  Vcl.Themes,
  Vcl.Styles,
  ApplicationUsageStats in 'ApplicationUsageStats.pas' {AppUsage},
  AboutUI in 'AboutUI.pas' {AboutTimely};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TTimely, Timely);
  Application.CreateForm(TAppUsage, AppUsage);
  Application.CreateForm(TAboutTimely, AboutTimely);
  Application.Run;
end.
