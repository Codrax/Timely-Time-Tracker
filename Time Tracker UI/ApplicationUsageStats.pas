unit ApplicationUsageStats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ControlList, DateUtils, ShellApi, Vcl.WinXPickers,
  Vcl.Grids, Vcl.Samples.Calendar, Vcl.WinXCalendars, Vcl.Clipbrd;

type
  TAppUsage = class(TForm)
    corner_1: TImage;
    cornet_2: TImage;
    border: TImage;
    SyncData: TTimer;
    title: TLabel;
    usages: TControlList;
    OpenAnim: TTimer;
    CloseAnim: TTimer;
    closeapp: TLabel;
    utime: TLabel;
    appico: TImage;
    bgperc: TLabel;
    perc: TLabel;
    appname: TLabel;
    appnametx: TLabel;
    appicotx: TLabel;
    timetx: TLabel;
    usagperctx: TLabel;
    HdSeconds: TCheckBox;
    InfoPN: TCheckBox;
    AInfo: TPanel;
    pth: TLabel;
    secsid: TLabel;
    mostusedtx: TLabel;
    calen: TCalendarPicker;
    noinf: TPanel;
    muse1: TPanel;
    a1ico: TImage;
    appname1: TLabel;
    usedname1: TLabel;
    muse2: TPanel;
    a2ico: TImage;
    appname2: TLabel;
    usedname2: TLabel;
    noavalapp_2: TLabel;
    noavalapp_1: TLabel;
    procedure CloseAnimTimer(Sender: TObject);
    procedure OpenAnimTimer(Sender: TObject);
    procedure closeappClick(Sender: TObject);
    procedure borderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SyncDataTimer(Sender: TObject);
    procedure usagesBeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure InfoPNClick(Sender: TObject);
    procedure HdSecondsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure calenChange(Sender: TObject);
    procedure pthClick(Sender: TObject);
  private
    { Private declarations }
    function geticon(exel: string; bitmap: TBitmap): TBitMap;
    procedure SetMostUsedApps;
  public
    { Public declarations }
  end;

var
  AppUsage: TAppUsage;

  anames,
  aexes: array of string;
  asecs: array of integer;
  aerrors: array of boolean;
  gformat: string = 'hh:nn:ss';

  i: integer;

implementation

{$R *.dfm}

uses
  TTUmu;

procedure TAppUsage.borderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
SendMessage(Self.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TAppUsage.InfoPNClick(Sender: TObject);
begin
  AInfo.Visible := TCheckBox(Sender).Checked;
end;

procedure TAppUsage.calenChange(Sender: TObject);
begin
  SyncDataTimer(nil);
  SetMostUsedApps;
end;

procedure TAppUsage.CloseAnimTimer(Sender: TObject);
begin
  if i > 12 then
    Self.Left := Self.Left + 100
  else begin
    Self.Left := Self.Left - (Screen.Width div 50 - 2 * i);
    i := i + 1;
  end;
  if Self.Left >= Screen.DesktopWidth then begin CloseAnim.Enabled:=false; Self.Hide; i := 0; end;
end;

procedure TAppUsage.closeappClick(Sender: TObject);
begin
  CloseAnim.Enabled := true;
end;

procedure TAppUsage.FormCreate(Sender: TObject);
begin
  calen.Date := now;
end;

function TAppUsage.geticon(exel: string; bitmap: TBitmap): TBitMap;
var
  IconIndex: word;
  Buffer: array[0..2048] of char;
  IconHandle: HIcon;
  //Bitmap : TBitmap;
begin
  if not fileexists(exel) then Exit;
  
      StrCopy(@Buffer, PChar(exel));
      IconIndex := 0;
      IconHandle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);
      if IconHandle <> 0 then
        Icon.Handle := IconHandle;
      Bitmap := TBitmap.Create;
      try
        Bitmap.Width := Icon.Width;
        Bitmap.Height := Icon.Height;
        Bitmap.Canvas.Draw(0, 0, Icon);
        //Result := Bitmap;
      finally
        //Bitmap.Free;
      end;
end;

procedure TAppUsage.HdSecondsClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then gformat := 'hh:nn' else gformat := 'hh:nn:ss';

  SetMostUsedApps;
  usages.Invalidate;
end;

procedure TAppUsage.OpenAnimTimer(Sender: TObject);
begin
  Self.Visible := true;
  Self.Left := Self.Left - screen.Width div 20;
  if Self.Left <= Screen.Width div 2 - Self.Width div 2 then OpenAnim.Enabled := false;
end;

procedure TAppUsage.pthClick(Sender: TObject);
begin
  Clipboard.AsText := Copy(pth.Caption, 6, length(pth.Caption));
end;

procedure TAppUsage.SetMostUsedApps;
var
  i,
  b,
  bi,
  last: integer;
  IconIndex: word;
  Buffer: array[0..2048] of char;

begin
  muse1.Hide;
  muse2.Hide;
  if usages.ItemCount >=2 then begin
    muse1.Show;
    muse2.Show;
  end else begin
    if usages.ItemCount = 1 then
      muse1.Show
    else
      Exit;
  end;

  b := 0;
  for I := 0 to length(asecs) - 1 do if asecs[i] > b then begin b := asecs[i]; bi := i end;

  appname1.Caption := anames[bi];
  usedname1.Caption := FormatDateTime('hh:nn:ss', asecs[bi] / SecsPerDay);

  try
  if fileexists(aexes[bi]) then begin
      StrCopy(@Buffer, PChar(aexes[bi]));
      IconIndex := 0;
      if ExtractAssociatedIcon(HInstance, Buffer, IconIndex) <> 0 then
        Icon.Handle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);
      a1ico.Picture.Bitmap := TBitmap.Create;
      a1ico.Picture.Icon := Icon;
  end;
  except end;

  last := bi;

  b := 0;
  for I := 0 to length(asecs) - 1 do if (asecs[i] > b) and (i <> last) then begin b := asecs[i]; bi := i end;

  appname2.Caption := anames[bi];
  usedname2.Caption := FormatDateTime(gformat, asecs[bi] / SecsPerDay);

  try
  if fileexists(aexes[bi]) then begin
      StrCopy(@Buffer, PChar(aexes[bi]));
      IconIndex := 0;
      if ExtractAssociatedIcon(HInstance, Buffer, IconIndex) <> 0 then
        Icon.Handle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);
      a2ico.Picture.Bitmap := TBitmap.Create;
      a2ico.Picture.Icon := Icon;
  end;
  except end;;
end;

procedure TAppUsage.SyncDataTimer(Sender: TObject);
var
  fd: TStringList;
  dat,
  fname: string;
  lgt, i: integer;
  d,m,y: word;
begin
  if (not Self.Visible) and (Parent <> nil) then Exit;
  

  DecodeDate(calen.Date,y,m,d);

  dat := inttostr(d) + inttostr(m) + inttostr(y);
  fname := datalocation + 'dts\' +dat + '-app-usage.dat';

  if NOT fileexists(fname) then begin
    usages.ItemCount := 0;
    noinf.Show;
    Exit;
  end;

  noinf.Hide;

  fd := TStringList.Create;
  try
    fd.LoadFromFile(fname);

    lgt := fd.Count div 3;

    setlength(anames, lgt);
    setlength(aexes, lgt);
    setlength(asecs, lgt);
    setlength(aerrors, lgt);

    for I := 0 to lgt - 1do begin
      anames[i] := fd[1 + i * 3];
      aexes[i] := fd[i * 3];
      aerrors[i] := false;
      try
        asecs[i] := strtoint(fd[2 + i * 3]);
      except
        asecs[i] := 0;
        aerrors[i] := true;
      end;
    end;

    usages.ItemCount := lgt;
  finally
    fd.Free;
    usages.Invalidate;
  end;

  SetMostUsedApps;
end;

procedure TAppUsage.usagesBeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
  ARect: TRect; AState: TOwnerDrawState);
var
  IconIndex: word;
  Buffer: array[0..2048] of char;
  IconHandle: HIcon;
  bn: string;
begin
  if aerrors[aindex] then bn := '[Invalid] ';
  appname.Caption := bn + anames[aindex];
    utime.Caption := FormatDateTime(gformat, asecs[AIndex] / SecsPerDay);
  perc.Width := trunc(asecs[AIndex] / times * bgperc.Width);
  perc.Left := bgperc.Left;
  {appico.Picture.Bitmap := TBitMap.Create;
  appico.Picture.Bitmap := (geticon(aexes[AIndex]));
  appico.Picture.Bitmap.SaveToFile('wow.bmp');       }

  try
  if fileexists(aexes[AIndex]) then begin

      StrCopy(@Buffer, PChar(aexes[AIndex]));
      IconIndex := 0;
      IconHandle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);
      if IconHandle <> 0 then
        Icon.Handle := IconHandle;
      appico.Picture.Bitmap := TBitmap.Create;
      appico.Picture.Icon := Icon;
  end;
  except end;

  if (AInfo.Visible) and (usages.ItemIndex <> -1) then begin
    pth.Caption := 'Path ' + aexes[usages.ItemIndex];
    secsid.Caption := 'Seconds: ' + inttostr(asecs[usages.ItemIndex]);
  end;
end;

end.
