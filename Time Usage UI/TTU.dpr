program TTU;

uses
  Vcl.Forms,
  TTUmu in 'TTUmu.pas' {Timely};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTimely, Timely);
  Application.Run;
end.