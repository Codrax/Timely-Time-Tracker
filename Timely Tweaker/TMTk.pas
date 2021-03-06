unit TMTk;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, Vcl.ExtCtrls, Vcl.Themes, System.UITypes,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, IOUtils, Vcl.Buttons, MMSystem, TimelyLib, ShlObj, ComObj, ActiveX;

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
    ComboBox1: TComboBox;
    PlaySnd: TBitBtn;
    OpenAnim: TTimer;
    CloseAnim: TTimer;
    ComboBox2: TComboBox;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
    procedure PlaySndClick(Sender: TObject);
    procedure OpenAnimTimer(Sender: TObject);
    procedure CloseAnimTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
    procedure StartDataSync;
    procedure checkdata;
    procedure QuickWrite(filename, data: string);
    function QuickRead(filename: string): string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MaintananceNeeded: Boolean;
  add: integer = -1;
  node: integer = -1;
  h, i: integer;

  datalocation: string;

implementation

{$R *.dfm}

procedure CreateLink(const PathObj, PathLink, Desc, Param: string);
var
  IObject: IUnknown;
  SLink: IShellLink;
  PFile: IPersistFile;
begin
  IObject:=CreateComObject(CLSID_ShellLink);
  SLink:=IObject as IShellLink;
  PFile:=IObject as IPersistFile;
  with SLink do
  begin
    SetArguments(PChar(Param));
    SetDescription(PChar(Desc));
    SetPath(PChar(PathObj));
  end;
  PFile.Save(PWChar(WideString(PathLink)), FALSE);
end;

function GetTreeSize ( path: string ): integer;
var
 tsr: TSearchRec;
begin
 result := 0;
 path := IncludeTrailingPathDelimiter ( path );
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

procedure TForm1.PlaySndClick(Sender: TObject);
begin
case ComboBox1.ItemIndex of
0: sndPlaySound('C:\Windows\Media\Alarm10.wav', SND_ASYNC);
1: sndPlaySound(Pchar(datalocation + 'music\classic.wav'), SND_ASYNC);
2: sndPlaySound(Pchar(datalocation + 'music\electric.wav'), SND_ASYNC);
3: sndPlaySound(Pchar(datalocation + 'music\flute.wav'), SND_ASYNC);
4: sndPlaySound(Pchar(datalocation + 'music\loudbell.wav'), SND_ASYNC);

end;
end;

function TForm1.QuickRead(filename: string): string;
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

procedure TForm1.QuickWrite(filename, data: string);
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

procedure TForm1.StartDataSync;
begin
//Theme Loader
if fileexists(datalocation + 'modedark.dat') then begin
  TStyleManager.SetStyle('Windows10 Dark');
end else begin
  TStyleManager.SetStyle('Windows10');
end;
//

add:=add+1;
node:=node+1;
if fileexists(datalocation + 'dtwkedit.in') then begin
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
ComboBox1.Enabled:=false;
ComboBox2.Enabled:=false;
PlaySnd.Enabled:=false;
Panel1.Show;
end;
try
  checkdata();
except end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lk: string;
begin
//Other Writes
QuickWrite( datalocation + 'songchoice.dat',inttostr(ComboBox1.ItemIndex+1));

//
if CheckBox1.Checked=true then begin
  if fileexists(datalocation + 'disablequit.in') then deletefile(datalocation + 'disablequit.in');
  QuickWrite( datalocation + 'disablequit.no','');
end else begin
  if fileexists(datalocation + 'disablequit.no') then deletefile(datalocation + 'disablequit.no');
  QuickWrite( datalocation + 'disablequit.in','');
end;
//
if CheckBox2.Checked=true then begin
  if fileexists(datalocation + 'forcequit60s.no') then deletefile(datalocation + 'forcequit60s.no');
  QuickWrite( datalocation + 'forcequit60s.in','');
end else begin
  if fileexists(datalocation + 'forcequit60s.in') then deletefile(datalocation + 'forcequit60s.in');
  QuickWrite( datalocation + 'forcequit60s.no','');
end;
//
if CheckBox3.Checked=true then begin
  if fileexists(datalocation + 'remindersenabled.no') then deletefile(datalocation + 'remindersenabled.no');
  QuickWrite( datalocation + 'remindersenabled.in','');
end else begin
  if fileexists(datalocation + 'remindersenabled.in') then deletefile(datalocation + 'remindersenabled.in');
  QuickWrite( datalocation + 'remindersenabled.no','');
end;
//
QuickWrite( datalocation + 'idletime.dat',inttostr( ComboBox2.ItemIndex ));
//
if CheckBox5.Checked=true then begin
  if fileexists(datalocation + 'allowaddbutton.no') then deletefile(datalocation + 'allowaddbutton.no');
  QuickWrite( datalocation + 'allowaddbutton.in','');
end else begin
  if fileexists(datalocation + 'allowaddbutton.in') then deletefile(datalocation + 'allowaddbutton.in');
  QuickWrite( datalocation + 'allowaddbutton.no','');
end;
//
lk := 'C:\Users\' + WUserName + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Timely Time Tracker.lnk';
if CheckBox4.Checked=true then begin
CreateLink('C:\Program Files\Timely Time Tracker\TTSm.exe', lk, 'Timely Time Tracking Service', '');

end else if fileexists(lk) then deletefile(lk);

//
  QuickWrite( datalocation + 'howlongwait.dat',Edit1.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CloseAnim.Enabled := true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  StartDataSync;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
R: textfile;
begin
WinExec('cmd /k "taskkill /f /im "TTSm.exe""', SW_SHOW);
WinExec('cmd /k "taskkill /f /im "cmd.exe""', SW_SHOW);
ShellExecute(Handle, 'open', 'C:\Program Files\Timely Time Tracker\TTSm.exe', nil, nil, SW_SHOWNORMAL);
ShowMessage('You may now close the Command Prompt');

if not directoryexists(datalocation + '') then mkdir(datalocation + '');
if not directoryexists(datalocation + 'dts') then mkdir(datalocation + 'dts');
deletefile(datalocation + 'howlongwait.dat');
deletefile(datalocation + 'disablequit.no');
deletefile(datalocation + 'forcequit60s.no');
deletefile(datalocation + 'remindersenabled.no');
deletefile(datalocation + 'normalmode.in');
deletefile(datalocation + 'dtwkedit.no');
//
deletefile(datalocation + 'disablequit.in');
deletefile(datalocation + 'forcequit60s.in');
deletefile(datalocation + 'remindersenabled.in');
deletefile(datalocation + 'normalmode.no');
deletefile(datalocation + 'dtwkedit.in');

assignfile(R,datalocation + 'howlongwait.dat');
  rewrite(R);
  write(R,'-1');
  closefile(R);
assignfile(R,datalocation + 'disablequit.no');
  rewrite(R);
  closefile(R);
  assignfile(R,datalocation + 'allowaddbutton.no');
  rewrite(R);
  closefile(R);
  assignfile(R,datalocation + 'forcequit60s.no');
  rewrite(R);
  closefile(R);
assignfile(R,datalocation + 'remindersenabled.in');
  rewrite(R);
  closefile(R);
assignfile(R,datalocation + 'normalmode.in');
  rewrite(R);
  closefile(R);
assignfile(R,datalocation + 'dtwkedit.no');
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
if MessageDlg('Are you sure you want to delete ALL' + #13 + 'the computer usage files? This action is irreversibile', mtWarning, [mbYes, mbNo], 0) = mrYes then begin

  TDirectory.Delete(datalocation + 'dts', true);
mkdir(datalocation + 'dts');
StorageData.Caption:=(inttostr(GetTreeSize(datalocation + 'dts'))) + ' B';
MessageDlg('All the files were deleted.', mtInformation, [mbClose], 0);

  end;
end;

procedure TForm1.Image1Click(Sender: TObject);
var
J: textfile;
begin
if add=5 then begin
  assignfile(J,datalocation + 'enabledebug.in');
  rewrite(J);
  closefile(J);
  label2.Caption:='- Timely Options. -';
end
else add:=0;


if node=15 then begin
  if MessageDlg('Are you sure you want to disable "Timely Tweaker"?' + #13 + 'This action can only be reverted by modifying the disable ' + #13 + 'data file of Timely Time Tracker.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
  deletefile(datalocation + 'dtwkedit.no');
  assignfile(J,datalocation + 'dtwkedit.in');
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
if not directoryexists(datalocation + '') then mkdir(datalocation + '');
if not directoryexists(datalocation + 'fonts\') then mkdir(datalocation + 'fonts\');
  //
  if not fileexists(datalocation + 'fonts\Nexa Bold.otf') then begin
  ResStream := TResourceStream.Create(HInstance, 'Resource_2', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile(datalocation + 'fonts\Nexa Bold.otf');
  finally
    ResStream.Free;
  end; end;

  //
  if not fileexists(datalocation + 'fonts\Nexa Light.otf') then begin
    ResStream := TResourceStream.Create(HInstance, 'Resource_3', RT_RCDATA);
  try
    ResStream.Position := 1;
    ResStream.SaveToFile(datalocation + 'fonts\Nexa Light.otf');
  finally
    ResStream.Free;
  end; end;


  AddFontResource(Pchar(datalocation + 'fonts\Nexa Bold.otf') );
  AddFontResource(Pchar(datalocation + 'fonts\Nexa Light.otf') );
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

procedure TForm1.OpenAnimTimer(Sender: TObject);
begin
  Self.Left := Self.Left - screen.Width div 20;
  if Self.Left <= Screen.Width div 2 - Self.Width div 2 then OpenAnim.Enabled := false;
end;

procedure TForm1.TrackDataChangesTimer(Sender: TObject);
begin
//Theme Loader
if fileexists(datalocation + 'modedark.dat') then begin
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

RemoveFontResource(Pchar(datalocation + 'fonts\Nexa Light.otf') );
RemoveFontResource(Pchar(datalocation + 'fonts\Nexa Bold.otf') );
SendMessage(HWND_BROADCAST,WM_FONTCHANGE,0,0);
end;

procedure TForm1.checkdata;
var
A: textfile;
temp: string;
begin
//READ VALUES
Edit1.Text := QuickRead( datalocation + 'howlongwait.dat' );

try
ComboBox2.ItemIndex := strtoint(QuickRead( datalocation + 'idletime.dat') );
except end;
try
ComboBox1.ItemIndex := strtoint(QuickRead( datalocation + 'songchoice.dat') ) - 1;
except end;

if fileexists(datalocation + 'allowaddbutton.no') then CheckBox5.Checked:=false else CheckBox5.Checked:=true;
if fileexists(datalocation + 'disablequit.no') then CheckBox1.Checked:=true else CheckBox1.Checked:=false;
if fileexists(datalocation + 'forcequit60s.no') then CheckBox2.Checked:=false else CheckBox2.Checked:=true;
if fileexists(datalocation + 'remindersenabled.no') then CheckBox3.Checked:=false else CheckBox3.Checked:=true;
if fileexists('C:\Users\' + WUserName + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Timely Time Tracker.lnk') then CheckBox4.Checked:=true else CheckBox4.Checked:=false;




//MAINTANANCE CHECK
if (not fileexists(datalocation + 'disablequit.no') and not fileexists(datalocation + 'disablequit.in'))
or (not fileexists(datalocation + 'forcequit60s.no') and not fileexists(datalocation + 'forcequit60s.in'))
or (not fileexists(datalocation + 'allowaddbutton.no') and not fileexists(datalocation + 'allowaddbutton.in'))
or (not fileexists(datalocation + 'normalmode.no') and not fileexists(datalocation + 'normalmode.in'))
or (not fileexists(datalocation + 'remindersenabled.no') and not fileexists(datalocation + 'remindersenabled.in'))
or (not fileexists(datalocation + 'dtwkedit.no') and not fileexists(datalocation + 'dtwkedit.in'))
or (not fileexists(datalocation + 'howlongwait.dat') and not fileexists(datalocation + 'howlongwait.dat'))
or (not directoryexists(datalocation)) or (not directoryexists(datalocation + 'dts'))
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

procedure TForm1.CloseAnimTimer(Sender: TObject);
begin
  if i > 12 then
    Self.Left := Self.Left + 100
  else begin
    Self.Left := Self.Left - (Screen.Width div 50 - 2 * i);
    i := i + 1;
  end;
  if Self.Left >= Screen.DesktopWidth then begin CloseAnim.Enabled:=false; Application.Terminate end;
end;

procedure TForm1.closeappClick(Sender: TObject);
begin
CloseAnim.Enabled := true;
end;

procedure TForm1.FontAnimationTimer(Sender: TObject);
begin
if insfont.Enabled=false then fontico.Top:=40 else fontico.top:=80;

InsFont.Enabled:=true;
UnFont.Enabled:=true;
insfont.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.Top := Screen.Height div 2 - Self.Height div 2;
  Self.Left := Screen.Width;
  datalocation := 'C:\Users\' + WUSername + '\AppData\Local\TTS\';

StorageData.Caption:=(inttostr(GetTreeSize(datalocation + 'dts'))) + ' B';

StartDataSync;

end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
ReleaseCapture;
SendMessage(Form1.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

end.
