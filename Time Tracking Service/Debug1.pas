unit Debug1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TTSp, Vcl.ExtCtrls, Vcl.StdCtrls, InfScr;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button10Click(Sender: TObject);
begin
sec:=timetostop-1;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
sec:=strtoint(Edit1.Text);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
deletefile('C:\ProgramData\TTS\enabledebug.in');
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
Application.Terminate;
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

procedure TForm3.Timer1Timer(Sender: TObject);
begin
Label1.Caption:=inttostr(sec);
Label3.Caption:='Int:TimeToStop = ' + inttostr(TimeToStop);
end;

end.