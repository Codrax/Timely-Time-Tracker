unit TTSp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MMSystem, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.ComCtrls, Vcl.Grids, Vcl.Samples.Calendar, InfScr, infoshow, Vcl.Themes, DateUtils, TimelyLib;

type
  TTTS = class(TForm)
    TR: TTimer;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    UIO: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    Calendar1: TCalendar;
    ManageSettings1: TMenuItem;
    StartCheck500ms: TTimer;
    AppsUsageSync: TTimer;
    procedure TRTimer(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure UIOClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ManageSettings1Click(Sender: TObject);
    procedure StartCheck500msTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AppsUsageSyncTimer(Sender: TObject);
  private
    procedure log(text: string; date: boolean; time: boolean);
    procedure CheckForTimerExpire;
    procedure InitAlarmExpire;
    procedure ExtractMusic;
    procedure InitNotif;
    function truncexe(filename: string; forcetrunc: boolean = false): string;
    function SmartCaptionParse(caption, exe: string): string;
    function IdleTime: DWord;
    function QuickRead(filename: string): string;
    procedure QuickWrite(filename: string; data: string);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure SelectMusicOption;
  end;

var
  enablelogging, logonce: boolean;
  TTS: TTTS;

  sec: Integer;
  temp,
  themenow,
  datalocation,
  filename: string;
  timetostop: Integer = -1;
  NewDate,
  OldDate,
  lastsecond,
  MusicOption: Integer;
  idlestrictness: integer = 0;

  enablefilenametrunc: boolean = false;
  errorno: boolean = false;

implementation

{$R *.dfm}

uses
  Debug1;

function TTTS.IdleTime: DWord;
var
  LastInput: TLastInputInfo;
begin
  LastInput.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(LastInput);
  Result := (GetTickCount - LastInput.dwTime) DIV 1000;
end;

procedure TTTS.ExtractMusic;
var
ResStream: TResourceStream;
begin
  ResStream := TResourceStream.Create(HInstance, 'Resource_1', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile(datalocation + 'music\classic.wav');
  finally
    ResStream.Free;
  end;
  ResStream := TResourceStream.Create(HInstance, 'Resource_2', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile(datalocation + 'music\electric.wav');
  finally
    ResStream.Free;
  end;
  ResStream := TResourceStream.Create(HInstance, 'Resource_3', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile(datalocation + 'music\flute.wav');
  finally
    ResStream.Free;
  end;
  ResStream := TResourceStream.Create(HInstance, 'Resource_4', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile(datalocation + 'music\loudbell.wav');
  finally
    ResStream.Free;
  end;
end;

procedure TTTS.AppsUsageSyncTimer(Sender: TObject);
var
  FD: TStringList;
  btm,
  usage,
  wline: integer;
  fnm,
  afile,
  exen,
  capt: string;
begin
  btm := AppsUsageSync.Interval div 1000;

  fnm := inttostr(calendar1.Day) + inttostr(calendar1.Month) + inttostr(calendar1.Year);
  afile := 'C:\Users\' + WUSername + '\AppData\Local\TTS\dts\' + fnm + '-app-usage.dat';

  try
    exen := truncexe(GetFileName);
    capt := SmartCaptionParse(trim(GetCurrentAppName),truncexe(exen, true));
  except

  end;
  usage := 0;

  if (exen = '') then Exit;
  if (capt = '') then capt := 'Unknown Title';


  fd := TStringList.Create;
  try
    if fileexists(afile) then
    begin
      try
        fd.LoadFromFile(afile);
      except
        Exit;
      end;
      wline := fd.IndexOf(exen);
    end else wline := -1;

    if wline <> -1 then begin
      try
        usage := strtoint(fd[wline + 2]) + btm;
      except
        usage := 0;
      end;
      fd[wline + 1] := capt;
      fd[wline + 2] := inttostr(usage);
    end else begin
      fd.Add( exen );
      fd.Add( capt );
      fd.Add( inttostr(usage) );
    end;
    try
      fd.SaveToFile(afile);
    except

    end;
  finally
    fd.Free;
  end;
end;

procedure TTTS.CheckForTimerExpire;
var
  acolor: TColor;
begin
  with Form1 do begin
  if fileexists(datalocation + 'allowaddbutton.in') then Add.Show else Add.Hide;
  SoundAlarm.Enabled := false;
  if fileexists(datalocation + 'forcequit60s.in') or (Form3.CheckBox2.Checked) then begin
       AutoStop.Enabled:=true;
       dm.Hide;
       tmr.Text := '90';
       TimeTillStop := 89;
       sd.Width:=365;
       Add.Pen.Color := sd.Colors.Leave;
       Add.Pen.AltHoverColor := sd.Colors.Enter;
       Add.Pen.AltPressColor := sd.Colors.Down;
       tmr.Show;
    end else begin
      AutoStop.Enabled:=false;
       dm.Show;
       sd.Width:=180;
       Add.Pen.Color := dm.Colors.Leave;
       Add.Pen.AltHoverColor := dm.Colors.Enter;
       Add.Pen.AltPressColor := dm.Colors.Down;
       tmr.Hide;
    end;
    if TStyleManager.ActiveStyle.Name = 'Windows10' then acolor := clBlack else acolor := clWhite;

      add.TextColors.Enter := acolor;
      tmr.TextColors.Enter := acolor;
      dm.TextColors.Enter := acolor;
      sd.TextColors.Enter := acolor;
      add.TextColors.Down := acolor;
      tmr.TextColors.Down := acolor;
      dm.TextColors.Down := acolor;
      sd.TextColors.Down := acolor;
      add.TextColors.Leave := acolor;
      tmr.TextColors.Leave := acolor;
      dm.TextColors.Leave := acolor;
      sd.TextColors.Leave := acolor;

    add.Invalidate;
    SoundAlarm.Enabled := true;
  end;
end;

procedure TTTS.CreateParams(var Params: TCreateParams);
var
  st2: TStringList;
  A: textfile;
  i: integer;
begin
  inherited;
  datalocation := 'C:\Users\' + WUSername + '\AppData\Local\TTS\';

  Params.ExStyle := Params.ExStyle and not WS_EX_APPWINDOW;
  Params.WndParent := Application.Handle;

  calendar1.Update;
  filename:=inttostr(calendar1.Day) + inttostr(calendar1.Month) + inttostr(calendar1.Year);

     //Prepare File/Data
  if NOT (directoryexists(datalocation)) then mkdir(datalocation);
  if NOT (directoryexists(datalocation + 'music')) then mkdir(datalocation + 'music');
  if NOT (directoryexists(datalocation + 'dts')) then mkdir(datalocation + 'dts');
  if (not fileexists(datalocation + 'music\classic.wav')) or (not fileexists(datalocation + 'music\electric.wav'))  or (not fileexists(datalocation + 'music\flute.wav')) or (not fileexists(datalocation + 'music\loudbell.wav')) then ExtractMusic;

      //Check for existing data
  if fileexists(datalocation + 'dts\' + filename + '.dat') then
  begin

    try
      i := strtoint(QuickRead(datalocation + 'dts\' + filename + '.dat'));
      if i > 0 then sec := i;
    except
      log('(!) EXCEPTION OCCURED WHEN CONVERTING SEC. Temp Value:' + temp ,true,true);

        st2 := TStringList.Create;
        try
          st2.Add('Exception occured on: ' + datetostr(date) + ' at ' + timetostr(time));
          st2.Add('Reason: Variabile loaded from text file was not a valid integer value');
          st2.SaveToFile(datalocation + 'errorlog' + inttostr(calendar1.Day) + '.' + inttostr(calendar1.month) + '.' + inttostr(calendar1.year) + '.txt');
        finally
          st2.Free;
        end;
    end;
  end;
     //Open for writing


     //create other files
     try
  if NOT (fileexists(datalocation + 'allowaddbutton.no')) and NOT (fileexists(datalocation + 'allowaddbutton.in')) then QuickWrite( datalocation + 'allowaddbutton.no', '');
  if NOT (fileexists(datalocation + 'disablequit.no')) and NOT (fileexists(datalocation + 'disablequit.in')) then QuickWrite( datalocation + 'disablequit.no','');
  if NOT (fileexists(datalocation + 'forcequit60s.no')) and NOT (fileexists(datalocation + 'forcequit60s.in')) then QuickWrite( datalocation + 'forcequit60s.no','');
  if NOT (fileexists(datalocation + 'remindersenabled.no')) and NOT (fileexists(datalocation + 'remindersenabled.in')) then QuickWrite( datalocation + 'remindersenabled.in','');
  if NOT fileexists(datalocation + 'howlongwait.dat') then QuickWrite( datalocation + 'howlongwait.dat','-1');
  if NOT fileexists(datalocation + 'normalmode.in') then QuickWrite( datalocation + 'normalmode.in','');
  if NOT fileexists(datalocation + 'songchoice.dat') then QuickWrite( datalocation + 'songchoice.dat','2');
  if NOT fileexists(datalocation + 'dtwkedit.no') and NOT fileexists(datalocation + 'dtwkedit.in') then QuickWrite( datalocation + 'dtwkedit.no','');
  except
      log('(!) EXCEPTION OCCURED WHEN CREATING FILES.' ,true,true);
  end;



  if fileexists(datalocation + 'songchoice.dat') then begin
  //OTHER DATA READER



      try
        MusicOption:= strtoint(QuickRead(datalocation + 'songchoice.dat'));
      except
        deletefile(datalocation + 'songchoice.dat');
        log('(!) EXCEPTION OCCURED WHEN READING & CONVERTING SONG CHOICE!' ,true,true);
      end;

  end;
end;



procedure TTTS.Exit1Click(Sender: TObject);
begin
Application.MainForm.Close;
end;

procedure TTTS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
log('' ,false,false);
log('///PROGRAM CLOSED QUERY///' ,true,true);
log('' ,false,false);
end;

procedure TTTS.FormCreate(Sender: TObject);

begin
//Theme Loader
if fileexists(datalocation + 'modedark.dat') then begin
  TStyleManager.SetStyle('Windows10 Dark');
  themenow:='dark';
end else begin
  TStyleManager.SetStyle('Windows10');
  themenow:='light';
end;


if fileexists(datalocation + 'disablequit.in') then Exit1.Enabled:=false;

if Exit1.Enabled=false then log('Allow Quiting: false' ,false,false) else log('Allow Quiting: true' ,false,false);

TTS.Hide;
TTS.Width:=1;
TTS.Height:=1;
end;

procedure TTTS.InitAlarmExpire;
begin
  begin
  MusicOption1:=MusicOption;
    SelectMusicOption;
      Form1.SoundAlarm.Enabled:=true;
      Form1.showAn.Enabled := true;
      CheckForTimerExpire;
      Form1.Visible := true;
      Form1.Left := Screen.DesktopRect.Width + Screen.DesktopRect.Left;
      Form1.Top := Screen.DesktopRect.Top + 35;
  end;
end;

procedure TTTS.InitNotif;
begin
  Form2.ShowAN.Enabled:=true;
  Form2.Show;
  Form2.Left := Screen.DesktopRect.Width + Screen.DesktopRect.Left;
  Form2.Top := Screen.DesktopRect.Top + 35;

  if fileexists('C:\Windows\Media\Windows Notify Messaging.wav') then
    sndPlaySound('C:\Windows\Media\Windows Notify Messaging.wav', SND_ASYNC);
end;

procedure TTTS.log(text: string; date, time: boolean);
var
  logstr: string;
  L: textfile;
begin
if (enablelogging=true) then begin

  logstr:=logstr+ text;
  if time=true then logstr:=logstr + ' Time: ' + timetostr(now);
  if date=true then logstr:=logstr + ' Date: ' + datetostr(now);

  if directoryexists(datalocation + '') then begin
    AssignFile(L,datalocation + 'log.txt');
    if fileexists(datalocation + 'log.txt') then Append(L) else Rewrite(L);
    WriteLn(L,logstr);
    CloseFile(L);
  end;

end;
end;

procedure TTTS.ManageSettings1Click(Sender: TObject);
begin
WinExec('C:\Program Files\Timely Time Tracker\Tweaker.exe', SW_SHOW);
end;

function TTTS.QuickRead(filename: string): string;
var
  ts: TStringList;
begin
  if not fileexists(filename) then Exit;
  ts := TStringList.Create;
  try
    try ts.LoadFromFile(filename); except end;
    Result := trim(ts.Text);
  finally
    ts.Free;
  end;
end;

procedure TTTS.QuickWrite(filename, data: string);
var
  ts: TStringList;
begin
  ts := TStringList.Create;
  try
    ts.Add(data);
    try ts.SaveToFile(filename); except end;
  finally
    ts.Free;
  end;
end;

procedure TTTS.SelectMusicOption;
begin
  case MusicOption of
  1:
  if fileexists('C:\Windows\Media\Alarm10.wav') then begin Form1.SoundAlarm.Interval:=4500; sndPlaySound('C:\Windows\Media\Alarm10.wav', SND_ASYNC); end;
  2:
  if fileexists( PChar( datalocation + 'music\classic.wav' )) then begin Form1.SoundAlarm.Interval:=8000; sndPlaySound( PChar( datalocation + 'music\classic.wav' ), SND_ASYNC); end;
  3:
  if fileexists( PChar( datalocation + 'music\electric.wav' ) ) then begin Form1.SoundAlarm.Interval:=8000; sndPlaySound( PChar( datalocation + 'music\electric.wav' ), SND_ASYNC); end;
  4:
  if fileexists( PChar( datalocation + 'music\flute.wav' ) ) then begin Form1.SoundAlarm.Interval:=8000; sndPlaySound( PChar( datalocation + 'music\flute.wav' ), SND_ASYNC); end;
  5:
  if fileexists( PChar( datalocation + 'music\loudbell.wav' ) ) then begin Form1.SoundAlarm.Interval:=8150; sndPlaySound( PChar( datalocation + 'music\loudbell.wav' ), SND_ASYNC); end;
  end;
end;

function TTTS.SmartCaptionParse(caption, exe: string): string;
var
  a: integer;
begin
  if exe = 'cmd.exe' then
    Result := 'Command Prompt'
  else
if exe = 'chrome.exe' then
    Result := 'Google Chrome'
  else
if exe = 'msedge.exe' then
    Result := 'Microsoft Edge'
  else
if exe = 'notepad++.exe' then
    Result := 'Notepad ++'
  else
if exe = 'explorer.exe' then
    Result := 'Windows Explorer'
  else
if exe = 'powershell.exe' then
    Result := 'Windows PowerShell'
  else  begin
    a := PosLast(' - ',caption) + 3;
    if a = 3 then a := 0;
    
    Result := Copy( caption, a, caption.Length );
  end;

end;

procedure TTTS.StartCheck500msTimer(Sender: TObject);
begin
if (sec>timetostop) and not (timetostop = -1) then InitAlarmExpire;

  StartCheck500ms.Enabled:=false;
end;

procedure TTTS.TRTimer(Sender: TObject);
begin
if Form1.Visible or Form2.Visible then
if (GetAsyncKeyState( VK_F11 ) < 0) then begin
  Form1.Left := 20;
  Form1.Top := 20;
  Form2.Left := 20;
  Form2.Top := 20;
end;
try
  idlestrictness := strtoint( QuickRead(datalocation + 'idletime.dat') );
except end;

if (idlestrictness <> 0) then begin
  case idlestrictness of
    1: if (IdleTime > 60) then Exit;
    2: if (IdleTime > 180) then Exit;
    3: try
      if (truncexe('GetFileName',true) = 'explorer.exe') and (IdleTime > 360) then Exit;
    except

    end;
  end;
end;


if logonce=false then begin
  log(' ',false,false);
  log('////////////////////////////////////////////////////////////////////////////////////////////',false,false);
  log(' ',false,false);
  log('                                Timely Time Tracker Debug Log                              ',false,false);
  log('                                            v2.1                                            ',false,false);
  log(' ',false,false);
  log('////////////////////////////////////////////////////////////////////////////////////////////',false,false);
  log(' ',false,false);
  log('Start Time: ',true,true);
  log('Value of sec is: ' + inttostr(sec) ,false,false);
  log('' ,false,false);
  log('-Variabiles: ',false,false);
  if themenow='light' then log('Theme: LIGHT',false,false) else log('Theme: DARK',false,false);
end;

if fileexists(datalocation + 'modedark.dat') then begin
  if themenow='light' then begin
    TStyleManager.SetStyle('Windows10 Dark');
    log('Theme Changed to: LIGHT',false,true);
    TTS.Show;
    TTS.SetFocus;
    TTS.Hide;
    themenow:='dark';
  end;
end else begin
  if themenow='dark' then begin
    TStyleManager.SetStyle('Windows10');
    log('(i) Theme Changed to: LIGHT',false,true);
    TTS.Show;
    TTS.SetFocus;
    TTS.Hide;
    themenow:='light';
  end;
end;


//Load time to stop alarm

try
  timetostop:=strtoint(QuickRead(datalocation + 'howlongwait.dat')) + BonusTime;
except
  log('(!) EXCEPTION OCCURED WHEN LOADING TIMETOSTOP! Temp Value:' + QuickRead(datalocation + 'howlongwait.dat') ,true,true);
end;

  //log('(!) EXCEPTION OCCURED WHEN LOADING TIMETOSTOP! Temp Value:' + tempstop ,true,true);


//  In case of next day
OldDate:=Calendar1.Day;
Calendar1.CalendarDate:=Date;
NewDate:=Calendar1.Day;

if NewDate>OldDate then sec:=0;

//
filename:=inttostr(calendar1.Day) + inttostr(calendar1.Month) + inttostr(calendar1.Year);
TTS.Hide;

sec := sec + TR.Interval div 1000;
lastsecond:=SecondOfTheDay(Now);

QuickWrite( datalocation + 'dts\' + filename + '.dat', inttostr(sec) );


  //IF TIMES UP
  if sec=timetostop then InitAlarmExpire;
  if fileexists(datalocation + 'remindersenabled.in') then begin

  //Form 2 Notification Animation (15min)
  if sec=timetostop-900 then begin
    log('-15 min left animation launched' ,false,true);
    Form2.Label2.Caption:='15 Minutes Left!';
    InitNotif;
  end;
  //Form 2 Notification Animation (10min)
  if sec=timetostop-600 then begin
    log('-10 min left animation launched' ,false,true);
    Form2.Label2.Caption:='10 Minutes Left!';
    InitNotif;
  end;
  //Form 2 Notification Animation (5min)
  if sec=timetostop-300 then begin
    log('-5 min left animation launched' ,false,true);
    Form2.Label2.Caption:='5 Minutes Left!';
    InitNotif;
  end;
  //Form 2 Notification Animation (1min)
  if sec=timetostop-60 then begin
    log('-1 min left animation launched' ,false,true);
    Form2.Label2.Caption:='1 Minute Left!';
    InitNotif;
  end;

  end;

if logonce=false then begin

if Form1.Add.Visible=true then log('Plus Button: enabled',false,false) else log('Plus Button: disabled',false,false);
if fileexists(datalocation + 'forcequit60s.in') then log('ForceQuit90: enabled',false,false) else log('ForceQuit90: disabled',false,false);
if fileexists(datalocation + 'remindersenabled.in') then log('Reminders: enabled',false,false) else log('Reminders: disabled',false,false);
log('TimeToStop: ' + inttostr(TimeToStop) ,false,false);
log('Song Choice: ' + inttostr(MusicOption) ,false,false);
log('' ,false,false);
log('Application Log: ' ,false,false);

logonce:=true
end;
end;

function TTTS.truncexe(filename: string; forcetrunc: boolean): string;
begin
  if (NOT enablefilenametrunc) and (NOT forcetrunc) then begin
    result := filename;
  end else begin
    result := Copy(filename, PosLast(filename,'\') + 1, filename.Length);
  end;
end;

procedure TTTS.UIOClick(Sender: TObject);
begin

WinExec('C:\Program Files\Timely Time Tracker\Timely.exe', SW_SHOW);
end;

end.
