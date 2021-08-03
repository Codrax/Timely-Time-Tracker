unit TTSp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MMSystem, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.ComCtrls, Vcl.Grids, Vcl.Samples.Calendar, InfScr, infoshow;

type
  TTTS = class(TForm)
    TR: TTimer;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    UIO: TMenuItem;
    Exit: TMenuItem;
    N1: TMenuItem;
    Calendar1: TCalendar;
    ManageSettings1: TMenuItem;
    procedure TRTimer(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure UIOClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ManageSettings1Click(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;


var
  TTS: TTTS;
  sec: Integer;
  F: textfile;
  temp: string;
  filename: string;
  timetostop: Integer;
  NewDate: Integer;
  OldDate: Integer;

implementation

{$R *.dfm}

procedure TTTS.CreateParams(var Params: TCreateParams);
var
A: textfile;
begin
  inherited;
  Params.ExStyle := Params.ExStyle and not WS_EX_APPWINDOW;
  Params.WndParent := Application.Handle;

  calendar1.Update;
  filename:=inttostr(calendar1.Day) + inttostr(calendar1.Month) + inttostr(calendar1.Year);
     //Prepare File/Data
  if NOT (directoryexists('C:\ProgramData\TTS')) then mkdir('C:\ProgramData\TTS');
  if NOT (directoryexists('C:\ProgramData\TTS\dts')) then mkdir('C:\ProgramData\TTS\dts');
      //Check for existing data
  if fileexists('C:\ProgramData\TTS\dts\' + filename + '.dat') then try begin
    assignfile(F,'C:\ProgramData\TTS\dts\' + filename + '.dat');
    reset(F);
    read(F,temp);
      //Load File
  if strtoint(temp)>0 then try sec:=strtoint(temp);
    finally end; end
    finally
    closefile(F);
  end;
     //Open for writing


     //create other files
  if NOT fileexists('C:\ProgramData\TTS\howlongwait.dat') then begin
    assignfile(A,'C:\ProgramData\TTS\howlongwait.dat');
    rewrite(A);
    write(A,'-1');
    closefile(A);
  end;
  if NOT (fileexists('C:\ProgramData\TTS\disablequit.no')) and NOT (fileexists('C:\ProgramData\TTS\disablequit.in')) then begin
    assignfile(A,'C:\ProgramData\TTS\disablequit.no');
    rewrite(A);
    closefile(A);
  end;
  if NOT (fileexists('C:\ProgramData\TTS\forcequit60s.no')) and NOT (fileexists('C:\ProgramData\TTS\forcequit60s.in')) then begin
    assignfile(A,'C:\ProgramData\TTS\forcequit60s.no');
    rewrite(A);
    closefile(A);
  end;
  if NOT (fileexists('C:\ProgramData\TTS\remindersenabled.no')) and NOT (fileexists('C:\ProgramData\TTS\remindersenabled.in')) then begin
    assignfile(A,'C:\ProgramData\TTS\remindersenabled.in');
    rewrite(A);
    closefile(A);
  end;


end;



procedure TTTS.ExitClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TTTS.FormCreate(Sender: TObject);

begin


if fileexists('C:\ProgramData\TTS\disablequit.in') then Exit.Enabled:=false;



TTS.Hide;
TTS.Width:=1;
TTS.Height:=1;
if sec=timetostop then begin
      sndPlaySound('C:\Windows\Media\Alarm10.wav', SND_ASYNC);
      Form1.SoundAlarm.Enabled:=true;
      Form1.Show;
      if fileexists('C:\ProgramData\TTS\forcequit60s.in') then begin
       Form1.AutoStop.Enabled:=true;
       Form1.Label3.Hide;
       Form1.Label2.Hide;
       Form1.Label4.Width:=340;
       Form1.Label5.Left:=120;
       Form1.tmr.Show;
    end; end;
end;

procedure TTTS.ManageSettings1Click(Sender: TObject);
begin
WinExec('C:\Program Files\Timely Time Tracker\Tweaker.exe', SW_SHOW);
end;

procedure TTTS.TRTimer(Sender: TObject);
var
temptime: String;
T: textfile;
tempstop: String;
begin
//Load time to stop alarm
if fileexists('C:\ProgramData\TTS\howlongwait.dat') then begin
    assignfile(T,'C:\ProgramData\TTS\howlongwait.dat');
    reset(T);
    read(T,tempstop);
    timetostop:=strtoint(tempstop);
    closefile(T);
  end;
//  In case of next day
OldDate:=Calendar1.Day;
Calendar1.CalendarDate:=Date;
NewDate:=Calendar1.Day;

if NewDate>OldDate then sec:=0;
temptime:=datetostr(date);
//
filename:=inttostr(calendar1.Day) + inttostr(calendar1.Month) + inttostr(calendar1.Year);
TTS.Hide;
Sec:=sec+1;
assignfile(F,'C:\ProgramData\TTS\dts\' + filename + '.dat');
  rewrite(F);
  write (F,inttostr(sec));
  CloseFile(F);

  //IF TIMES UP
  if sec=timetostop then begin
      sndPlaySound('C:\Windows\Media\Alarm10.wav', SND_ASYNC);
      Form1.SoundAlarm.Enabled:=true;
      Form1.Show;
      if fileexists('C:\ProgramData\TTS\forcequit60s.in') then begin
       Form1.AutoStop.Enabled:=true;
       Form1.Label3.Hide;
       Form1.Label2.Hide;
       Form1.Label4.Width:=340;
       Form1.Label5.Left:=120;
       Form1.tmr.Show;
    end;
  end;

  if fileexists('C:\ProgramData\TTS\remindersenabled.in') then begin
  //Form 2 Notification Animation (15min)
  if sec=timetostop-900 then begin
    Form2.ShowAN.Enabled:=true;
    Form2.Top:=50;
    Form2.Left:=screen.Width + 200;
    Form2.Label2.Caption:='15 Minutes Left!';
  end;
  //Form 2 Notification Animation (10min)
  if sec=timetostop-600 then begin
    Form2.ShowAN.Enabled:=true;
    Form2.Top:=50;
    Form2.Left:=screen.Width + 200;
    Form2.Label2.Caption:='10 Minutes Left!';
  end;
  //Form 2 Notification Animation (5min)
  if sec=timetostop-300 then begin
    Form2.ShowAN.Enabled:=true;
    Form2.Top:=50;
    Form2.Left:=screen.Width + 200;
    Form2.Label2.Caption:='5 Minutes Left!';
  end;
  //Form 2 Notification Animation (1min)
  if sec=timetostop-300 then begin
    Form2.ShowAN.Enabled:=true;
    Form2.Top:=50;
    Form2.Left:=screen.Width + 200;
    Form2.Label2.Caption:='1 Minutes Left!';
  end;
  end;
end;

procedure TTTS.UIOClick(Sender: TObject);
begin

WinExec('C:\Program Files\Timely Time Tracker\Timely.exe', SW_SHOW);
end;

end.
