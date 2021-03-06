unit InfScr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, MMSystem, Vcl.Themes, CodsButton;

type
  TForm1 = class(TForm)
    ico: TImage;
    Title: TLabel;
    SoundAlarm: TTimer;
    AutoStop: TTimer;
    tmr2: TLabel;
    crn1: TImage;
    crn2: TImage;
    border: TImage;
    ShowAN: TTimer;
    HideAN: TTimer;
    sd: CButton;
    dm: CButton;
    tmr: CButton;
    Add: CButton;
    procedure SoundAlarmTimer(Sender: TObject);
    procedure PowerOffPC(Sender: TObject);
    procedure Dism(Sender: TObject);
    procedure AutoStopTimer(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure ShowANTimer(Sender: TObject);
    procedure HideANTimer(Sender: TObject);
    procedure tmrStateChange(Sender: CButton; State: CButtonState);
    procedure sdStateChange(Sender: CButton; State: CButtonState);
    procedure dmStateChange(Sender: CButton; State: CButtonState);
  private
    { Private declarations }
    procedure SetAddColors;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  TimeTillStop: Integer =90;
  BonusTime: Integer = 0;
  MusicOption1: Integer;
  i: integer;

implementation

uses
  TTSp;

{$R *.dfm}

procedure TForm1.HideANTimer(Sender: TObject);
begin
  if i > 12 then
    Self.Left := Self.Left + 60
  else begin
    Self.Left := Self.Left - (20 - 2 * i);
    i := i + 1;
  end;
  if Self.Left >= Screen.DesktopRect.Width + Screen.DesktopRect.Left then begin HideAN.Enabled:=false; Self.Hide; end;
end;

procedure TForm1.Dism(Sender: TObject);
begin
  SoundAlarm.Enabled:=false;
  sndPlaySound(nil, 0);
  i := 0;
  HideAN.Enabled := true;
end;

procedure TForm1.dmStateChange(Sender: CButton; State: CButtonState);
begin
  SetAddColors;
end;

procedure TForm1.PowerOffPC(Sender: TObject);
begin
  WinExec('shutdown /p', SW_SHOW);
end;

procedure TForm1.sdStateChange(Sender: CButton; State: CButtonState);
begin
  SetAddColors;
  tmr.State := sd.State;
  if sd.State = mbsDown then
  begin
    tmr.Font.Size := 14;
  end
  else
  begin
    tmr.Font.Size := 20;
  end;
  tmr.Invalidate;
end;

procedure TForm1.SetAddColors;
begin
  if sd.Width > 200 then begin
    Add.State := sd.State
  end
  else
  begin
    Add.State := dm.State;
  end;

  if add.State = mbsDown then begin
    add.Width := 24;
    add.Height := 24;
    add.Font.Size := 26;
  end else begin
    add.Font.Size := 30;
    add.Width := 26;
    add.Height := 26;
  end;

  Add.Invalidate;
end;

procedure TForm1.ShowANTimer(Sender: TObject);
begin
  HideAn.Enabled := false;
  Self.Visible := true;
  Self.Left := Self.Left-40;
  if Self.Left <= Screen.DesktopRect.Width + Screen.DesktopRect.Left - Self.Width - 20 then begin ShowAN.Enabled:=false; end;
end;

procedure TForm1.SoundAlarmTimer(Sender: TObject);
begin
if fileexists(datalocation + 'allowaddbutton.in') then Add.Show else Add.Hide;

TTS.SelectMusicOption;
end;

procedure TForm1.tmrStateChange(Sender: CButton; State: CButtonState);
begin
  sd.State := tmr.State;
  SetAddColors;
end;

procedure TForm1.AddClick(Sender: TObject);
begin
  SoundAlarm.Enabled:=false;
  Form1.Hide;
  BonusTime:=BonusTime+3600;
  AutoStop.Enabled:=false;
  TimeTillStop:=90;
  sndPlaySound(nil, 0);
end;

procedure TForm1.AutoStopTimer(Sender: TObject);
begin
  tmr.Text:=inttostr(TimeTIllStop);
  TimeTillStop:=TimeTillStop-1;
  if TimeTillStop<1 then begin
  PowerOffPC(nil);
  AutoStop.Enabled:=false;
end;
end;

end.
