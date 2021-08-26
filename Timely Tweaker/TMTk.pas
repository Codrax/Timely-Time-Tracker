unit TMTk;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, Vcl.ExtCtrls, Vcl.Themes, System.UITypes,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, IOUtils;

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
    CheckBox4: TCheckBox;
    InsFont: TButton;
    UnFont: TButton;
    GroupBox1: TGroupBox;
    Image1: TImage;
    CheckBox5: TCheckBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    TrackDataChanges: TTimer;
    rd1: TImage;
    rd2: TImage;
    closeapp: TLabel;
    minimise: TLabel;
    fontico: TImage;
    around: TImage;
    Label6: TLabel;
    GroupBox4: TGroupBox;
    StorUs: TLabel;
    StorageData: TLabel;
    DeleteData: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure checkdata;
    procedure Button5Click(Sender: TObject);
    procedure InsFontClick(Sender: TObject);
    procedure UnFontClick(Sender: TObject);
    procedure DeleteDataClick(Sender: TObject);
    procedure killcmdTimer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure TrackDataChangesTimer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure closeappClick(Sender: TObject);
    procedure minimiseClick(Sender: TObject);
    procedure FontAnimationTimer(Sender: TObject);
    procedure aroundMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MaintananceNeeded: Boolean;
  add: integer = -1;
  node: integer = -1;

implementation

{$R *.dfm}

function GetTreeSize ( path: string ): integer;
var
 tsr: TSearchRec;
begin
 result := 0;
 path := IncludeTrailingBackSlash ( path );
 if FindFirst ( path + '*', faAnyFile, tsr ) = 0 then begin
  repeat
   if ( tsr.attr and faDirectory ) > 0 then begin
    if ( tsr.name <> '.' ) and ( tsr.name <> '..' ) then
     inc ( result, GetTreeSize ( path + tsr.name ) );
   end
   else
    inc ( result, tsr.size );
  until FindNext ( tsr ) <> 0;
  FindClose ( tsr );
 end;
end;

procedure TForm1.aroundMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
ReleaseCapture;

SendMessage(Form1.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
R: textfile;
ResStream: TResourceStream;
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
  if fileexists('C:\ProgramData\TTS\remindersenabled.no') then deletefile('C:\ProgramData\TTS\remindersenabled.no');
  assignfile(R,'C:\ProgramData\TTS\remindersenabled.in');
  rewrite(R); closefile(R);
end else begin
  if fileexists('C:\ProgramData\TTS\remindersenabled.in') then deletefile('C:\ProgramData\TTS\remindersenabled.in');
  assignfile(R,'C:\ProgramData\TTS\remindersenabled.no');
  rewrite(R); closefile(R);
end;
//
if CheckBox5.Checked=true then begin
  if fileexists('C:\ProgramData\TTS\allowaddbutton.no') then deletefile('C:\ProgramData\TTS\allowaddbutton.no');
  assignfile(R,'C:\ProgramData\TTS\allowaddbutton.in');
  rewrite(R); closefile(R);
end else begin
  if fileexists('C:\ProgramData\TTS\allowaddbutton.in') then deletefile('C:\ProgramData\TTS\allowaddbutton.in');
  assignfile(R,'C:\ProgramData\TTS\allowaddbutton.no');
  rewrite(R); closefile(R);
end;
//
if CheckBox4.Checked=false then begin
if fileexists('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Timely Time Tracker.lnk') then begin
ShellExecute(0, 'runas', 'cmd.exe', PChar(' /k del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Timely Time Tracker.lnk"'), nil, SW_SHOW);
    ShowMessage('You may now close the Command Prompt');
end;
end
else begin
begin

  ResStream := TResourceStream.Create(HInstance, 'Resource_1', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile('C:\ProgramData\TTS\Timely Time Tracker.lnk');
    ShellExecute(0, 'runas', 'cmd.exe', PChar(' /k "copy "C:\ProgramData\TTS\Timely Time Tracker.lnk" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Timely Time Tracker.lnk""'), nil, SW_SHOW);
    ShowMessage('You may now close the Command Prompt');
  finally
    ResStream.Free;
  end;
end;

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
ShowMessage('You may now close the Command Prompt');

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
  assignfile(R,'C:\ProgramData\TTS\allowaddbutton.no');
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

procedure TForm1.DeleteDataClick(Sender: TObject);
begin
if MessageDlg('Are you sure you want to delete ALL the computer usage files? This action is irreversibie', mtWarning, [mbYes, mbNo], 0) = mrYes then begin

  TDirectory.Delete('C:\ProgramData\TTS\dts', true);
mkdir('C:\ProgramData\TTS\dts');
StorageData.Caption:=(inttostr(GetTreeSize('C:\ProgramData\TTS\dts'))) + ' B';
MessageDlg('All the files were deleted.', mtInformation, [mbClose], 0);

  end;
end;

procedure TForm1.Image1Click(Sender: TObject);
var
J: textfile;
begin
if add=5 then begin
  assignfile(J,'C:\ProgramData\TTS\enabledebug.in');
  rewrite(J);
  closefile(J);
  label2.Caption:='- Timely Options. -';
end
else add:=0;


if node=15 then begin
  if MessageDlg('Are you sure you want to disable "Timely Tweaker"? This action can only be reverted by modifying the disable data file of Timely Time Tracker.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
  deletefile('C:\ProgramData\TTS\dtwkedit.no');
  assignfile(J,'C:\ProgramData\TTS\dtwkedit.in');
  rewrite(J);
  closefile(J);
  label2.Caption:='- (Close to disable) -';

  end;
end
else node:=0;

end;

procedure TForm1.InsFontClick(Sender: TObject);
var
ResStream: TResourceStream;
begin
fontico.Show;
fontico.Top:=40;


//EXTRACT FONTS
if not directoryexists('C:\ProgramData\TTS\') then mkdir('C:\ProgramData\TTS\');
if not directoryexists('C:\ProgramData\TTS\fonts\') then mkdir('C:\ProgramData\TTS\fonts\');
  //
  if not fileexists('C:\ProgramData\TTS\fonts\Nexa Bold.otf') then begin
  ResStream := TResourceStream.Create(HInstance, 'Resource_2', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile('C:\ProgramData\TTS\fonts\Nexa Bold.otf');
  finally
    ResStream.Free;
  end; end;

  //
  if not fileexists('C:\ProgramData\TTS\fonts\Nexa Light.otf') then begin
    ResStream := TResourceStream.Create(HInstance, 'Resource_3', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile('C:\ProgramData\TTS\fonts\Nexa Light.otf');
  finally
    ResStream.Free;
  end; end;


  AddFontResource('C:\ProgramData\TTS\fonts\Nexa Bold.otf');
  AddFontResource('C:\ProgramData\TTS\fonts\Nexa Light.otf');
  SendMessage(HWND_BROADCAST,WM_FONTCHANGE,0,0);
end;


procedure TForm1.killcmdTimer(Sender: TObject);
begin
ShellExecute(0, 'runas', 'cmd.exe', PChar(' /k "taskkill /f /im cmd.exe"'), nil, SW_SHOW);
end;

procedure TForm1.minimiseClick(Sender: TObject);
begin
Application.Minimize;
end;

procedure TForm1.TrackDataChangesTimer(Sender: TObject);
begin
//Theme Loader
if fileexists('C:\ProgramData\TTS\modedark.dat') then begin
  TStyleManager.SetStyle('Windows10 Dark');
end else begin
  TStyleManager.SetStyle('Windows10');
end;
//
end;

procedure TForm1.UnFontClick(Sender: TObject);
begin
fontico.Show;
fontico.Top:=80;

RemoveFontResource('C:\ProgramData\TTS\fonts\Nexa Light.otf');
RemoveFontResource('C:\ProgramData\TTS\fonts\Nexa Bold.otf');
SendMessage(HWND_BROADCAST,WM_FONTCHANGE,0,0);
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

if fileexists('C:\ProgramData\TTS\allowaddbutton.no') then CheckBox5.Checked:=false else CheckBox5.Checked:=true;
if fileexists('C:\ProgramData\TTS\disablequit.no') then CheckBox1.Checked:=true else CheckBox1.Checked:=false;
if fileexists('C:\ProgramData\TTS\forcequit60s.no') then CheckBox2.Checked:=false else CheckBox2.Checked:=true;
if fileexists('C:\ProgramData\TTS\remindersenabled.no') then CheckBox3.Checked:=false else CheckBox3.Checked:=true;
if fileexists('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Timely Time Tracker.lnk') then CheckBox4.Checked:=true else CheckBox4.Checked:=false;




//MAINTANANCE CHECK
if (not fileexists('C:\ProgramData\TTS\disablequit.no') and not fileexists('C:\ProgramData\TTS\disablequit.in'))
or (not fileexists('C:\ProgramData\TTS\forcequit60s.no') and not fileexists('C:\ProgramData\TTS\forcequit60s.in'))
or (not fileexists('C:\ProgramData\TTS\allowaddbutton.no') and not fileexists('C:\ProgramData\TTS\allowaddbutton.in'))
or (not fileexists('C:\ProgramData\TTS\normalmode.no') and not fileexists('C:\ProgramData\TTS\normalmode.in'))
or (not fileexists('C:\ProgramData\TTS\remindersenabled.no') and not fileexists('C:\ProgramData\TTS\remindersenabled.in'))
or (not fileexists('C:\ProgramData\TTS\dtwkedit.no') and not fileexists('C:\ProgramData\TTS\dtwkedit.in'))
or (not fileexists('C:\ProgramData\TTS\howlongwait.dat') and not fileexists('C:\ProgramData\TTS\howlongwait.dat'))
or (not directoryexists('C:\ProgramData\TTS')) or (not directoryexists('C:\ProgramData\TTS\dts'))
then begin
MaintananceNeeded:=true;
Label4.Color:=clRed;
Label4.Caption:=' Error ';
Button4.Enabled:=true;

end else begin
MaintananceNeeded:=false;
Label4.Color:=clLime;
Label4.Caption:=' OK ';
Button4.Enabled:=false;
end;
end;

procedure TForm1.closeappClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.FontAnimationTimer(Sender: TObject);
begin
if insfont.Enabled=false then fontico.Top:=40 else fontico.top:=80;

InsFont.Enabled:=true;
UnFont.Enabled:=true;
insfont.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
test: String;
begin
StorageData.Caption:=(inttostr(GetTreeSize('C:\ProgramData\TTS\dts'))) + ' B';

//Theme Loader
if fileexists('C:\ProgramData\TTS\modedark.dat') then begin
  TStyleManager.SetStyle('Windows10 Dark');
end else begin
  TStyleManager.SetStyle('Windows10');
end;
//

add:=add+1;
node:=node+1;
if fileexists('C:\ProgramData\TTS\dtwkedit.in') then begin
Panel1.Left:=95;
Button1.Enabled:=false;
Button2.Enabled:=false;
Button3.Enabled:=false;
Button4.Enabled:=false;
DeleteData.Enabled:=false;
Edit1.Enabled:=false;
CheckBox1.Enabled:=false;
CheckBox2.Enabled:=false;
CheckBox3.Enabled:=false;
CheckBox4.Enabled:=false;
CheckBox5.Enabled:=false;
InsFont.Enabled:=false;
UnFont.Enabled:=false;
Panel1.Show;
end;
checkdata();


end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
ReleaseCapture;
SendMessage(Form1.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

end.
