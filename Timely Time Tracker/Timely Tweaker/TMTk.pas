unit TMTk;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button3: TButton;
    CheckBox3: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button4: TButton;
    Label5: TLabel;
    Button5: TButton;
    Panel1: TPanel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure checkdata;
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MaintananceNeeded: Boolean;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
R: textfile;
begin
//
if CheckBox1.Checked=true then begin
  if fileexists('C:\ProgramData\TTS\disablequit.in') then deletefile('C:\ProgramData\TTS\disablequit.in');
  assignfile(R,'C:\ProgramData\TTS\disablequit.no');
  rewrite(R); closefile(R);
end else begin
  if fileexists('C:\ProgramData\TTS\disablequit.no') then deletefile('C:\ProgramData\TTS\disablequit.no');
  assignfile(R,'C:\ProgramData\TTS\disablequit.in');
  rewrite(R); closefile(R);
end;
//
if CheckBox2.Checked=true then begin
  if fileexists('C:\ProgramData\TTS\forcequit60s.no') then deletefile('C:\ProgramData\TTS\forcequit60s.no');
  assignfile(R,'C:\ProgramData\TTS\forcequit60s.in');
  rewrite(R); closefile(R);
end else begin
  if fileexists('C:\ProgramData\TTS\forcequit60s.in') then deletefile('C:\ProgramData\TTS\forcequit60s.in');
  assignfile(R,'C:\ProgramData\TTS\forcequit60s.no');
  rewrite(R); closefile(R);
end;
//
if CheckBox3.Checked=true then begin
  if fileexists('C:\ProgramData\TTS\remindersenabled.no') then deletefile('C:\ProgramData\TTS\forequit60s.no');
  assignfile(R,'C:\ProgramData\TTS\remindersenabled.in');
  rewrite(R); closefile(R);
end else begin
  if fileexists('C:\ProgramData\TTS\remindersenabled.in') then deletefile('C:\ProgramData\TTS\remindersenabled.in');
  assignfile(R,'C:\ProgramData\TTS\remindersenabled.no');
  rewrite(R); closefile(R);
end;
//
assignfile(R,'C:\ProgramData\TTS\howlongwait.dat');
  rewrite(R);
  write(R,Edit1.Text);
  closefile(R);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
R: textfile;
begin
WinExec('cmd /k "taskkill /f /im "TTSm.exe""', SW_SHOW);
WinExec('cmd /k "taskkill /f /im "cmd.exe""', SW_SHOW);
ShellExecute(Handle, 'open', 'C:\Program Files\Timely Time Tracker\TTSm.exe', nil, nil, SW_SHOWNORMAL);

if not directoryexists('C:\ProgramData\TTS\') then mkdir('C:\ProgramData\TTS\');
if not directoryexists('C:\ProgramData\TTS\dts') then mkdir('C:\ProgramData\TTS\dts');
deletefile('C:\ProgramData\TTS\howlongwait.dat');
deletefile('C:\ProgramData\TTS\disablequit.no');
deletefile('C:\ProgramData\TTS\forcequit60s.no');
deletefile('C:\ProgramData\TTS\remindersenabled.no');
deletefile('C:\ProgramData\TTS\normalmode.in');
deletefile('C:\ProgramData\TTS\dtwkedit.no');
//
deletefile('C:\ProgramData\TTS\disablequit.in');
deletefile('C:\ProgramData\TTS\forcequit60s.in');
deletefile('C:\ProgramData\TTS\remindersenabled.in');
deletefile('C:\ProgramData\TTS\normalmode.no');
deletefile('C:\ProgramData\TTS\dtwkedit.in');

assignfile(R,'C:\ProgramData\TTS\howlongwait.dat');
  rewrite(R);
  write(R,'-1');
  closefile(R);
assignfile(R,'C:\ProgramData\TTS\disablequit.no');
  rewrite(R);
  closefile(R);
  assignfile(R,'C:\ProgramData\TTS\forcequit60s.no');
  rewrite(R);
  closefile(R);
assignfile(R,'C:\ProgramData\TTS\remindersenabled.in');
  rewrite(R);
  closefile(R);
assignfile(R,'C:\ProgramData\TTS\normalmode.in');
  rewrite(R);
  closefile(R);
assignfile(R,'C:\ProgramData\TTS\dtwkedit.no');
  rewrite(R);
  closefile(R);




  checkdata();

end;


procedure TForm1.Button5Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.checkdata;
var
A: textfile;
temp: string;
begin
//READ VALUES
assignfile(A,'C:\ProgramData\TTS\howlongwait.dat');
reset(A);
read(A,temp);
Edit1.Text:=temp;
closefile(A);

if fileexists('C:\ProgramData\TTS\disablequit.no') then CheckBox1.Checked:=true else CheckBox1.Checked:=false;
if fileexists('C:\ProgramData\TTS\forcequit60s.no') then CheckBox2.Checked:=false else CheckBox2.Checked:=true;
if fileexists('C:\ProgramData\TTS\remindersenabled.no') then CheckBox3.Checked:=false else CheckBox3.Checked:=true;


//MAINTANANCE CHECK
if (not fileexists('C:\ProgramData\TTS\disablequit.no') and not fileexists('C:\ProgramData\TTS\disablequit.in'))
or (not fileexists('C:\ProgramData\TTS\forcequit60s.no') and not fileexists('C:\ProgramData\TTS\forcequit60s.in'))
or (not fileexists('C:\ProgramData\TTS\normalmode.no') and not fileexists('C:\ProgramData\TTS\normalmode.in'))
or (not fileexists('C:\ProgramData\TTS\remindersenabled.no') and not fileexists('C:\ProgramData\TTS\remindersenabled.in'))
or (not fileexists('C:\ProgramData\TTS\dtwkedit.no') and not fileexists('C:\ProgramData\TTS\dtwkedit.in'))
or (not fileexists('C:\ProgramData\TTS\howlongwait.dat') and not fileexists('C:\ProgramData\TTS\howlongwait.dat'))
or (not directoryexists('C:\ProgramData\TTS')) or (not directoryexists('C:\ProgramData\TTS\dts'))
then begin
MaintananceNeeded:=true;
Label4.Font.Color:=clRed;
Label4.Caption:='Error';
Button4.Enabled:=true;

end else begin
MaintananceNeeded:=false;
Label4.Font.Color:=clLime;
Label4.Caption:='OK';
Button4.Enabled:=false;
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
if fileexists('C:\ProgramData\TTS\dtwkedit.in') then begin
Panel1.Left:=80;
Button1.Enabled:=false;
Button2.Enabled:=false;
Button3.Enabled:=false;
Button4.Enabled:=false;
Edit1.Enabled:=false;
CheckBox1.Enabled:=false;
CheckBox2.Enabled:=false;
CheckBox3.Enabled:=false;
Panel1.Show;
end;
checkdata();


end;

end.
