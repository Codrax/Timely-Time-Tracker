unit AboutUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, ShellApi;

type
  TAboutTimely = class(TForm)
    border: TImage;
    corner_1: TImage;
    cornet_2: TImage;
    title: TLabel;
    abtl: TLabel;
    CloseAnim: TTimer;
    OpenAnim: TTimer;
    closeapp: TLabel;
    programico: TImage;
    vertx: TLabel;
    mostusedtx: TLabel;
    namecredit: TLabel;
    codsoftUI: TLabel;
    social_mail: TImage;
    social_twt: TImage;
    social_yt: TImage;
    social_web: TImage;
    myicon: TImage;
    procedure closeappClick(Sender: TObject);
    procedure CloseAnimTimer(Sender: TObject);
    procedure OpenAnimTimer(Sender: TObject);
    procedure social_webClick(Sender: TObject);
    procedure social_ytClick(Sender: TObject);
    procedure social_twtClick(Sender: TObject);
    procedure social_mailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutTimely: TAboutTimely;

  i: integer;

implementation

{$R *.dfm}

procedure TAboutTimely.CloseAnimTimer(Sender: TObject);
begin
  if i > 12 then
    Self.Left := Self.Left + 100
  else begin
    Self.Left := Self.Left - (Screen.Width div 50 - 2 * i);
    i := i + 1;
  end;
  if Self.Left >= Screen.DesktopWidth then begin CloseAnim.Enabled:=false; Self.Hide; i := 0; end;
end;

procedure TAboutTimely.closeappClick(Sender: TObject);
begin
  CloseAnim.Enabled := true;
end;

procedure TAboutTimely.OpenAnimTimer(Sender: TObject);
begin
  Self.Visible := true;
  Self.Left := Self.Left - screen.Width div 20;
  if Self.Left <= Screen.Width div 2 - Self.Width div 2 then OpenAnim.Enabled := false;
end;

procedure TAboutTimely.social_mailClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'mailto:petculescucodrut@outlook.com', PChar(''), nil, SW_SHOW);
end;

procedure TAboutTimely.social_twtClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://www.twitter.com/LAVAplanks', PChar(''), nil, SW_SHOW);
end;

procedure TAboutTimely.social_webClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://www.codrutsoftware.cf', PChar(''), nil, SW_SHOW);
end;

procedure TAboutTimely.social_ytClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://youtube.com/channel/UCdXU8fD7IUSs3Eh1GCXF1Cw', PChar(''), nil, SW_SHOW);
end;

end.
