unit infoshow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ShowAN: TTimer;
    Timer1: TTimer;
    procedure ShowANTimer(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  times: Integer;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
Form2.Top:=50;
Form2.Left:=screen.Width + 200;
end;

procedure TForm2.Label1Click(Sender: TObject);
begin
Form2.hide;
end;

procedure TForm2.ShowANTimer(Sender: TObject);
begin
Form2.Show;
Form2.Left:=Form2.Left-25;
if Form2.Left=Screen.Width-(Form2.Width+100) then begin ShowAN.Enabled:=false; Timer1.Enabled:=true; end;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
times:=times+1;

if times=15 then begin
Form2.Hide;
Timer1.Enabled:=false;
times:=0;
end;

end;

end.