unit infoshow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Themes,
  Vcl.Imaging.pngimage;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ShowAN: TTimer;
    Closein10: TTimer;
    crn1: TImage;
    crn2: TImage;
    border: TImage;
    HideAN: TTimer;
    procedure ShowANTimer(Sender: TObject);
    procedure CloseUI(Sender: TObject);
    procedure Closein10Timer(Sender: TObject);
    procedure HideANTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  i: integer;

implementation

{$R *.dfm}

procedure TForm2.HideANTimer(Sender: TObject);
begin
  if i > 12 then
    Self.Left := Self.Left + 60
  else begin
    Self.Left := Self.Left - (20 - 2 * i);
    i := i + 1;
  end;
  if Self.Left >= Screen.DesktopRect.Width + Screen.DesktopRect.Left then begin HideAN.Enabled:=false; Self.Hide; end;
end;

procedure TForm2.CloseUI(Sender: TObject);
begin
  i := 0;
  HideAN.Enabled := true;
end;

procedure TForm2.ShowANTimer(Sender: TObject);
begin
  CloseIn10.Enabled := false;
  HideAn.Enabled := false;
  Self.Show;
  Self.Left:=Form2.Left-40;
  if Self.Left <= Screen.DesktopRect.Width + Screen.DesktopRect.Left - Self.Width - 20 then begin ShowAN.Enabled:=false; CloseIn10.Enabled := true; end;
end;

procedure TForm2.Closein10Timer(Sender: TObject);
begin
  CloseUI(nil);
  CloseIn10.Enabled:=false;
end;

end.
