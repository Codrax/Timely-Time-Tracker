unit InfScr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, MMSystem;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SoundAlarm: TTimer;
    AutoStop: TTimer;
    tmr: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure SoundAlarmTimer(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure AutoStopTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  TimeTillStop: Integer =90;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Form1.Top:=50;
Form1.Left:=screen.Width-(form1.Width+100)
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
SoundAlarm.Enabled:=false;
Form1.Hide;
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
WinExec('cmd /k "shutdown /s"', SW_SHOW);
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
WinExec('cmd /k "shutdown /s"', SW_SHOW);
end;

procedure TForm1.SoundAlarmTimer(Sender: TObject);
begin
 sndPlaySound('C:\Windows\Media\Alarm10.wav', SND_ASYNC);
end;

procedure TForm1.AutoStopTimer(Sender: TObject);
begin
tmr.Caption:=inttostr(TimeTIllStop);
TimeTillStop:=TimeTillStop-1;
if TimeTillStop<1 then begin
WinExec('cmd /k "shutdown /s"', SW_SHOW);
WinExec('cmd /k "shutdown /s"', SW_SHOW);
AutoStop.Enabled:=false;
end;
end;

end.
