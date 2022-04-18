unit Debug1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TTSp, Vcl.ExtCtrls, Vcl.StdCtrls, InfScr, ShellApi, Vcl.Themes,
  TimelyLib, Vcl.Buttons;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Label2: TLabel;
    Button10: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Button11: TButton;
    CheckBox1: TCheckBox;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    CheckBox2: TCheckBox;
    Label5: TLabel;
    Button16: TButton;
    Button17: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button15: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initdebug;
  end;

var
  Form3: TForm3;
  apoint: TPoint;

  idl: integer;

implementation

{$R *.dfm}

procedure TForm3.Button10Click(Sender: TObject);
begin
sec:=timetostop-1;
end;

procedure TForm3.Button11Click(Sender: TObject);
begin
  if fileexists(datalocation + 'log.txt') then deletefile(datalocation + 'log.txt');
end;

procedure TForm3.Button12Click(Sender: TObject);
begin
if fileexists(datalocation + 'log.txt') then ShellExecute(0, 'open', PChar(datalocation + 'log.txt'), PChar(''), nil, SW_SHOW);
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
TStyleManager.SetStyle('Windows10');
Form3.SetFocus;
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
TStyleManager.SetStyle('Windows10 Dark');
Form3.SetFocus;
end;

procedure TForm3.Button15Click(Sender: TObject);
var
  IconIndex: word;
  Buffer: array[0..2048] of char;
  IconHandle: HIcon;
  Bitmap : TBitmap;
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    if OpenDialog.Execute then
    begin
      StrCopy(@Buffer, PChar(OpenDialog.FileName));
      IconIndex := 0;
      IconHandle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);
      if IconHandle <> 0 then
        Icon.Handle := IconHandle;
      Bitmap := TBitmap.Create;
      try
        Bitmap.Width := Icon.Width;
        Bitmap.Height := Icon.Height;
        Bitmap.Canvas.Draw(0, 0, Icon);
        //Glyph.Assign(Bitmap);
      finally
        Bitmap.Free;
      end;
    end;
  finally
    OpenDialog.Free;
  end;

end;

procedure TForm3.Button16Click(Sender: TObject);
begin
  Form1.Left := strtoint(Edit1.Text);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  sec := strtoint(Edit1.Text);sec:=strtoint(Edit1.Text);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
deletefile(datalocation + 'enabledebug.in');
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
Application.MainForm.Close;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
sec:=timetostop-901;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
sec:=timetostop-601;
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
sec:=timetostop-301;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
sec:=timetostop-61;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
sec:=sec+1;
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
sec:=sec-1;
end;

procedure TForm3.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.Checked=true then
enablelogging:=true else
enablelogging:=false;
end;

function IdleTime: DWord;
var
  LastInput: TLastInputInfo;
begin
  LastInput.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(LastInput);
  Result := (GetTickCount - LastInput.dwTime) DIV 1000;
end;

procedure TForm3.initdebug;
begin
  Self.Show;
  Timer1.Enabled := true;
end;


procedure TForm3.Label5Click(Sender: TObject);
begin
  InputBox('Text', 'Here is the text:', Label5.Caption);
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
Label1.Caption:=inttostr(sec);
Label3.Caption:='Int:TimeToStop = ' + inttostr(TimeToStop);
Label4.Caption:='Int:MusicOption = ' + inttostr(MusicOption);
try
  Label5.Caption:='Str:CurrentOpenApp = ' + (GetFileName);
except end;
Label6.Caption:='Str:Current Caption = ' + trim(GetCurrentAppName);
Label7.Caption := Format('System idle time: %d s', [IdleTime]);
Label8.Caption := 'Int:InfoScr Left = ' + inttostr(Form1.Left);

if enablelogging=true then CheckBox1.Checked:=true else CheckBox1.Checked:=false;

end;

end.
