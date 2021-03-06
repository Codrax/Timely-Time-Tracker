unit TTUmu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Samples.Calendar, Vcl.WinXCtrls, Vcl.Imaging.pngimage, MMSystem, ShellAPI, Vcl.Themes,
  TimelyLib, ApplicationUsageStats, AboutUI;

type
  TTimely = class(TForm)
    title: TLabel;
    secpass: TTimer;
    TimeAc: TLabel;
    Calendar1: TCalendar;
    credit: TLabel;
    hrs: TLabel;
    mins: TLabel;
    secs: TLabel;
    hours: TLabel;
    minutes: TLabel;
    seconds: TLabel;
    loadicon: TActivityIndicator;
    lt5days: TLabel;
    day5: TLabel;
    day4: TLabel;
    day3: TLabel;
    day2: TLabel;
    day1: TLabel;
    h24: TLabel;
    h12: TLabel;
    h1: TLabel;
    OpenLast5: TTimer;
    shelf: TImage;
    backupcalendar: TCalendar;
    a1: TLabel;
    a2: TLabel;
    a3: TLabel;
    a4: TLabel;
    a5: TLabel;
    ver: TLabel;
    theme_dark: TImage;
    theme_light: TImage;
    bkg: TLabel;
    delay3s: TTimer;
    geardark: TImage;
    gearlight: TImage;
    Image1: TImage;
    Image2: TImage;
    closeapp: TLabel;
    minimise: TLabel;
    border: TImage;
    OpenAnim: TTimer;
    CloseAnim: TTimer;
    AppUsageOpen: TLabel;
    Idle: TLabel;
    procedure secpassTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OpenLast5Timer(Sender: TObject);
    procedure FormMouseLeave(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure theme_darkClick(Sender: TObject);
    procedure theme_lightClick(Sender: TObject);
    procedure bkgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure bkgMouseLeave(Sender: TObject);
    procedure day1MouseEnter(Sender: TObject);
    procedure day2MouseEnter(Sender: TObject);
    procedure day3MouseEnter(Sender: TObject);
    procedure day4MouseEnter(Sender: TObject);
    procedure day5MouseEnter(Sender: TObject);
    procedure delay3sTimer(Sender: TObject);
    procedure geardarkClick(Sender: TObject);
    procedure closeappClick(Sender: TObject);
    procedure minimiseClick(Sender: TObject);
    procedure borderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure borderMouseLeave(Sender: TObject);
    procedure OpenAnimTimer(Sender: TObject);
    procedure CloseAnimTimer(Sender: TObject);
    procedure AppUsageOpenClick(Sender: TObject);
    procedure OpenAbout(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  daytp = 200;

var
  Timely: TTimely;
  times: Integer;
  day1inf, day2inf, day3inf, day4inf, day5inf, i, tmp: integer;

  datalocation: string;

implementation

{$R *.dfm}

procedure TTimely.AppUsageOpenClick(Sender: TObject);
begin
  AppUsage.SyncDataTimer(nil);
  AppUsage.OpenAnim.enabled := true;
  AppUsage.Top := Screen.Height div 2 - AppUsage.Height div 2;
  AppUsage.Left := Screen.Width;
end;

procedure TTimely.bkgMouseLeave(Sender: TObject);
begin
OpenLast5.Enabled:=false;
end;



procedure TTimely.bkgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
OpenLast5.Enabled:=true;
ReleaseCapture;
SendMessage(Timely.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TTimely.borderMouseLeave(Sender: TObject);
begin
OpenLast5.enabled:=false;
end;

procedure TTimely.borderMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
OpenLast5.Enabled:=true;
ReleaseCapture;
SendMessage(Timely.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TTimely.CloseAnimTimer(Sender: TObject);
begin
  if i > 12 then
    Self.Left := Self.Left + 100
  else begin
    Self.Left := Self.Left - (Screen.Width div 50 - 2 * i);
    i := i + 1;
  end;
  if Self.Left >= Screen.DesktopWidth then begin CloseAnim.Enabled:=false; Application.Terminate; i := 0; end;
end;

procedure TTimely.closeappClick(Sender: TObject);
begin
  CloseAnim.Enabled := true;
end;

procedure TTimely.OpenAbout(Sender: TObject);
begin
  AboutTimely.Top := Screen.Height div 2 - AboutTimely.Height div 2;
  AboutTimely.Left := Screen.Width;
  AboutTimely.vertx.Caption := ver.Caption;
  AboutTimely.OpenAnim.Enabled := true;
end;

procedure TTimely.day1MouseEnter(Sender: TObject);
begin
delay3s.Enabled:=true;
a1.Caption:=inttostr(trunc(day1inf/3600)) + 'h ' + inttostr(trunc((day1inf mod(3600))/60)) + 'm';
end;

procedure TTimely.day2MouseEnter(Sender: TObject);
begin
delay3s.Enabled:=true;
a2.Caption:=inttostr(trunc(day2inf/3600)) + 'h ' + inttostr(trunc((day2inf mod(3600))/60)) + 'm';
end;

procedure TTimely.day3MouseEnter(Sender: TObject);
begin
delay3s.Enabled:=true;
a3.Caption:=inttostr(trunc(day3inf/3600)) + 'h ' + inttostr(trunc((day3inf mod(3600))/60)) + 'm';
end;

procedure TTimely.day4MouseEnter(Sender: TObject);
begin
delay3s.Enabled:=true;
a4.Caption:=inttostr(trunc(day4inf/3600)) + 'h ' + inttostr(trunc((day4inf mod(3600))/60)) + 'm';
end;

procedure TTimely.day5MouseEnter(Sender: TObject);
begin
delay3s.Enabled:=true;
a5.Caption:=inttostr(trunc(day5inf/3600)) + 'h ' + inttostr(trunc((day5inf mod(3600))/60)) + 'm';
end;

procedure TTimely.delay3sTimer(Sender: TObject);
begin
//other stuff
a1.Caption:='1day ago';
a2.Caption:='2days ago';
a3.Caption:='3days ago';
a4.Caption:='4days ago';
a5.Caption:='5days ago';

delay3s.Enabled:=false;
end;

procedure TTimely.FormCreate(Sender: TObject);
begin
Self.Top := Screen.Height div 2 - Self.Height div 2;
Self.Left := Screen.Width;
datalocation := 'C:\Users\' + WUSername + '\AppData\Local\TTS\';

if fileexists(datalocation + 'modedark.dat') then begin
  theme_light.Show;
  theme_dark.Hide;
  TStyleManager.SetStyle('Windows10 Dark');
  bkg.Color:=clBlack;
  geardark.hide;
  gearlight.Show;
  closeapp.Font.Color:=clWhite;
end else begin
  theme_light.Hide;
  theme_dark.Show;
  TStyleManager.SetStyle('Windows10');
  bkg.Color:=$00E6E6E6;
  geardark.Show;
  gearlight.Hide;
  closeapp.Font.Color:=clBlack;
end;
TimeAc.Left:=224;
bkg.Width:=700;
bkg.Height:=363;
end;

procedure TTimely.FormMouseLeave(Sender: TObject);
begin
OpenLast5.Enabled:=false;
end;

procedure TTimely.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
OpenLast5.Enabled:=true;

end;

procedure TTimely.geardarkClick(Sender: TObject);
begin
WinExec('C:\Program Files\Timely Time Tracker\Tweaker.exe', SW_SHOW);
end;

procedure TTimely.minimiseClick(Sender: TObject);
begin
Application.Minimize;
end;

procedure TTimely.OpenAnimTimer(Sender: TObject);
begin
  Self.Left := Self.Left - screen.Width div 20;
  if Self.Left <= Screen.Width div 2 - Self.Width div 2 then OpenAnim.Enabled := false;
end;

procedure TTimely.OpenLast5Timer(Sender: TObject);
var
O: textfile;
odate1: string;
odate2: string;
odate3: string;
odate4: string;
odate5: string;
temp: string;
tempi: integer;
dayshopped: integer;
begin


//day1
if calendar1.Day>1 then odate1:=inttostr(calendar1.Day-1) + inttostr(calendar1.Month) + inttostr(calendar1.Year)
else begin
backupcalendar.CalendarDate:=date; backupcalendar.PrevMonth; backupcalendar.Day:=30; backupcalendar.Day:=31; odate1:=inttostr(backupcalendar.Day) + inttostr(backupcalendar.Month) + inttostr(backupcalendar.Year); dayshopped:=dayshopped+1;
end;
  if fileexists(datalocation + 'dts\' + odate1 + '.dat') then begin
    assignfile(O,datalocation + 'dts\' + odate1  + '.dat');
    reset(O);
    read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    day1inf:=tempi;
    tmp := trunc((tempi/86400)*100);
    if tmp > 100 then day1.Caption := '+' else day1.Caption := '';
    if not (day1.Height=tmp) then
    day1.Height:= tmp;
    day1.Hint:=inttostr(day1.Height)+'%';
    day1.Top:=daytp+(100-day1.Height);
    except
    day1.Height:= 15;
    day1.Caption:='Error';
    end;

end;
//day2
if calendar1.Day>2 then odate2:=inttostr(calendar1.Day-2) + inttostr(calendar1.Month) + inttostr(calendar1.Year)
else begin
backupcalendar.CalendarDate:=date; backupcalendar.PrevMonth; backupcalendar.Day:=30; backupcalendar.Day:=31; odate2:=inttostr(backupcalendar.Day-dayshopped) + inttostr(backupcalendar.Month) + inttostr(backupcalendar.Year); dayshopped:=dayshopped+1;
end;
  if fileexists(datalocation + 'dts\' + odate2 + '.dat') then begin
    assignfile(O,datalocation + 'dts\' + odate2 + '.dat');
    reset(O);
    read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    day2inf:=tempi;
    tmp := trunc((tempi/86400)*100);
    if tmp > 100 then day2.Caption := '+' else day2.Caption := '';
    if not (day2.Height=tmp) then
    day2.Height:= tmp;
    day2.Hint:=inttostr(day2.Height)+'%';
    day2.Top:=daytp+(100-day2.Height);
    except
    day2.Height:= 15;
    day2.Caption:='Error';
    end;
end;
//day3
if calendar1.Day>3 then odate3:=inttostr(calendar1.Day-3) + inttostr(calendar1.Month) + inttostr(calendar1.Year)
else begin
backupcalendar.CalendarDate:=date; backupcalendar.PrevMonth; backupcalendar.Day:=30; backupcalendar.Day:=31; odate3:=inttostr(backupcalendar.Day-dayshopped) + inttostr(backupcalendar.Month) + inttostr(backupcalendar.Year); dayshopped:=dayshopped+1;
end;
  if fileexists(datalocation + 'dts\' + odate3 + '.dat') then begin
    assignfile(O,datalocation + 'dts\' + odate3 + '.dat');
    reset(O);
    read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    day3inf:=tempi;
    tmp := trunc((tempi/86400)*100);
    if tmp > 100 then day3.Caption := '+' else day3.Caption := '';
    if not (day3.Height=tmp) then
    day3.Height:= tmp;
    day3.Hint:=inttostr(day3.Height)+'%';
    day3.Top:=daytp+(100-day3.Height);
    except
    day3.Height:= 15;
    day3.Caption:='Error';
    end;
end;
//day4
if calendar1.Day>4 then odate4:=inttostr(calendar1.Day-4) + inttostr(calendar1.Month) + inttostr(calendar1.Year)
else begin
backupcalendar.CalendarDate:=date; backupcalendar.PrevMonth; backupcalendar.Day:=30; backupcalendar.Day:=31;
odate4:=inttostr(backupcalendar.Day-dayshopped) + inttostr(backupcalendar.Month) + inttostr(backupcalendar.Year); dayshopped:=dayshopped+1;
end;
  if fileexists(datalocation + 'dts\' + odate4 + '.dat') then begin
    assignfile(O,datalocation + 'dts\' + odate4 + '.dat');
    reset(O);
    read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    day4inf:=tempi;
    tmp := trunc((tempi/86400)*100);
    if tmp > 100 then day4.Caption := '+' else day4.Caption := '';
    if not (day4.Height=tmp) then
    day4.Height:= tmp;
    day4.Hint:=inttostr(day4.Height)+'%';
    day4.Top:=daytp+(100-day4.Height);
    except
    day4.Height:= 15;
    day4.Caption:='Error';
    end;
end;
//day5
if calendar1.Day>5 then odate5:=inttostr(calendar1.Day-5) + inttostr(calendar1.Month) + inttostr(calendar1.Year)
else begin
backupcalendar.CalendarDate:=date; backupcalendar.PrevMonth; backupcalendar.Day:=30; backupcalendar.Day:=31; odate5:=inttostr(backupcalendar.Day-dayshopped) + inttostr(backupcalendar.Month) + inttostr(backupcalendar.Year); dayshopped:=dayshopped+1;
end;
  if fileexists(datalocation + 'dts\' + odate5 + '.dat') then begin
    assignfile(O,datalocation + 'dts\' + odate5 + '.dat');
    reset(O);
     read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    day5inf:=tempi;
    tmp := trunc((tempi/86400)*100);
    if tmp > 100 then day5.Caption := '+' else day5.Caption := '';
    if not (day5.Height=tmp) then
    day5.Height:= tmp;
    day5.Hint:=inttostr(day5.Height)+'%';
    day5.Top:=daytp+(100-day5.Height);
    except
    day5.Height:= 15;
    day5.Caption:='Error';
    end;
end;

end;

procedure TTimely.theme_darkClick(Sender: TObject);
var
A: textfile;
begin
theme_light.Show;
theme_dark.Hide;
TStyleManager.SetStyle('Windows10 Dark');
bkg.Color:=clBlack;
Assignfile(A,datalocation + 'modedark.dat'); Rewrite(A); Closefile(A);
geardark.hide;
gearlight.Show;
closeapp.Font.Color:=clWhite;
end;

procedure TTimely.theme_lightClick(Sender: TObject);
begin
theme_light.Hide;
theme_dark.Show;
TStyleManager.SetStyle('Windows10');
bkg.Color:=$00E6E6E6;
deletefile(datalocation + 'modedark.dat');
geardark.Show;
gearlight.hide;
closeapp.Font.Color:=clBlack;
end;

procedure TTimely.secpassTimer(Sender: TObject);
var
F: textfile;
curdate: String;
inttm: integer;
temp: String;
begin
minimise.Font.Color:= closeapp.Font.Color;
//read date
calendar1.CalendarDate:=date;
curdate:=inttostr(calendar1.Day) + inttostr(calendar1.Month) + inttostr(calendar1.Year);
if fileexists(datalocation + 'dts\' + curdate + '.dat') then begin
assignfile(F,datalocation + 'dts\' + curdate + '.dat');
reset(F);
read(F,temp);
closefile(F);
try
inttm := strtoint(temp);
if inttm = times then Idle.Show else Idle.Hide;
times := inttm;
except
hrs.Caption:='Er';
mins.Caption:='ro';
secs.Caption:='r';
end;
end;


//set info
if not (mins.Caption='ro') then begin
hrs.Caption:=inttostr(trunc(times/3600));
mins.Caption:=inttostr(trunc((times mod(3600))/60));
secs.Caption:=inttostr(times mod(60));
end;
TimeAc.Hide;
hrs.Show;
hours.Show;
mins.Show;
minutes.Show;
secs.Show;
seconds.Show;
loadicon.Hide;
end;

end.
