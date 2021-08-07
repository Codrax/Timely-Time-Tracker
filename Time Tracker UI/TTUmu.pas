unit TTUmu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Samples.Calendar, Vcl.WinXCtrls, Vcl.Imaging.pngimage, MMSystem, ShellAPI, Vcl.Themes;

type
  TTimely = class(TForm)
    title: TLabel;
    Timer1: TTimer;
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
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OpenLast5Timer(Sender: TObject);
    procedure FormMouseLeave(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure theme_darkClick(Sender: TObject);
    procedure theme_lightClick(Sender: TObject);
    procedure bkgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure bkgMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Timely: TTimely;
  times: Integer;

implementation

{$R *.dfm}

procedure TTimely.bkgMouseLeave(Sender: TObject);
begin
OpenLast5.Enabled:=false;
end;

procedure TTimely.bkgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
OpenLast5.Enabled:=true;
end;

procedure TTimely.FormCreate(Sender: TObject);
begin
if fileexists('C:\ProgramData\TTS\modedark.dat') then begin
  theme_light.Show;
  theme_dark.Hide;
  TStyleManager.SetStyle('Windows10 Dark');
  bkg.Color:=clBlack;
end else begin
  theme_light.Hide;
  theme_dark.Show;
  TStyleManager.SetStyle('Windows10');
  bkg.Color:=$00E6E6E6;
end;
TimeAc.Left:=224;
bkg.Width:=700;
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
  if fileexists('C:\ProgramData\TTS\dts\' + odate1 + '.dat') then begin
    assignfile(O,'C:\ProgramData\TTS\dts\' + odate1  + '.dat');
    reset(O);
    read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    if not (day1.Height=trunc((tempi/86400)*100)) then
    day1.Height:= trunc((tempi/86400)*100);
    day1.Hint:=inttostr(day1.Height)+'%';
    day1.Top:=192+(100-day1.Height);
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
  if fileexists('C:\ProgramData\TTS\dts\' + odate2 + '.dat') then begin
    assignfile(O,'C:\ProgramData\TTS\dts\' + odate2 + '.dat');
    reset(O);
    read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    if not (day2.Height=trunc((tempi/86400)*100)) then
    day2.Height:= trunc((tempi/86400)*100);
    day2.Hint:=inttostr(day2.Height)+'%';
    day2.Top:=192+(100-day2.Height);
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
  if fileexists('C:\ProgramData\TTS\dts\' + odate3 + '.dat') then begin
    assignfile(O,'C:\ProgramData\TTS\dts\' + odate3 + '.dat');
    reset(O);
    read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    if not (day3.Height=trunc((tempi/86400)*100)) then
    day3.Height:= trunc((tempi/86400)*100);
    day3.Hint:=inttostr(day3.Height)+'%';
    day3.Top:=192+(100-day3.Height);
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
  if fileexists('C:\ProgramData\TTS\dts\' + odate4 + '.dat') then begin
    assignfile(O,'C:\ProgramData\TTS\dts\' + odate4 + '.dat');
    reset(O);
    read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    if not (day4.Height=trunc((tempi/86400)*100)) then
    day4.Height:= trunc((tempi/86400)*100);
    day4.Hint:=inttostr(day4.Height)+'%';
    day4.Top:=192+(100-day4.Height);
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
  if fileexists('C:\ProgramData\TTS\dts\' + odate5 + '.dat') then begin
    assignfile(O,'C:\ProgramData\TTS\dts\' + odate5 + '.dat');
    reset(O);
     read(O,temp);
    closefile(O);
    try
    tempi:=strtoint(temp);
    if not (day5.Height=trunc((tempi/86400)*100)) then
    day5.Height:= trunc((tempi/86400)*100);
    day5.Hint:=inttostr(day5.Height)+'%';
    day5.Top:=192+(100-day5.Height);
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
Assignfile(A,'C:\ProgramData\TTS\modedark.dat'); Rewrite(A); Closefile(A);
end;

procedure TTimely.theme_lightClick(Sender: TObject);
begin
theme_light.Hide;
theme_dark.Show;
TStyleManager.SetStyle('Windows10');
bkg.Color:=$00E6E6E6;
deletefile('C:\ProgramData\TTS\modedark.dat');
end;

procedure TTimely.Timer1Timer(Sender: TObject);
var
F: textfile;
curdate: String;
temp: String;
begin
//read date
calendar1.CalendarDate:=date;
curdate:=inttostr(calendar1.Day) + inttostr(calendar1.Month) + inttostr(calendar1.Year);
if fileexists('C:\ProgramData\TTS\dts\' + curdate + '.dat') then begin
assignfile(F,'C:\ProgramData\TTS\dts\' + curdate + '.dat');
reset(F);
read(F,temp);
closefile(F);
try
times:=strtoint(temp);
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