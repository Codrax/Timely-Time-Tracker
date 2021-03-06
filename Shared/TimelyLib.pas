unit TimelyLib;

interface

  uses Windows, Types, IOUtils, SysUtils, ShellApi, Vcl.Forms, Vcl.Graphics, Winapi.PsAPI;

  function WUserName: String;
  function GetCurrentAppName: string;
  Function GetFileName : String;
  function GetAppIcon(path: string): TBitMap;
  function PosLast(LongStr,ShortSbStr: string): integer;

implementation

const
  Max_Path = 260;

function GetAppIcon(path: string): TBitMap;
  var
  IconIndex: word;
  Buffer: array[0..2048] of char;
  IconHandle: HIcon;
  Bitmap : TBitmap;
begin
  StrCopy(@Buffer, PChar(path));
  IconIndex := 0;
  IconHandle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);
  if IconHandle <> 0 then
    {Icon.Handle := IconHandle;
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := Icon.Width;
    Bitmap.Height := Icon.Height;
    Bitmap.Canvas.Draw(0, 0, Icon);
    Result := Bitmap;
  finally
    Bitmap.Free;
  end;    }
end;

function WUserName: String;
var
  nSize: DWord;
begin
 nSize := 1024;
 SetLength(Result, nSize);
 if GetUserName(PChar(Result), nSize) then
   SetLength(Result, nSize-1)
 else
   RaiseLastOSError;
end;

function PosLast(LongStr,ShortSbStr: string): integer;
var
  a: integer;
begin
  //Result := Pos(ShortSbStr,LongStr,LongStr.Length);
  a := Pos(ShortSbStr,LongStr);
  repeat
    Result := a;
    a := Pos(ShortSbStr,LongStr,a + 1);
  until (a = 0);
end;

function GetCurrentAppName: string;
var
h: hWnd;
begin
  h := GetForegroundWindow;
  SetLength(Result, GetWindowTextLength(h) + 1);
  GetWindowText(h, PChar(Result), GetWindowTextLength(h) + 1);
end;

function GetFileName: String;
var
  pid     : DWORD;
  hProcess: THandle;
  path    : array[0..4095] of Char;
begin
  GetWindowThreadProcessId(GetForegroundWindow, pid);

  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, FALSE, pid);
  if hProcess <> 0 then
    try
      if GetModuleFileNameEx(hProcess, 0, @path[0], Length(path)) = 0 then
        RaiseLastOSError;

      result := path;
    finally
      CloseHandle(hProcess);
    end
  else
    RaiseLastOSError;
end;

Function GetFileName2 : ansistring;
var
  S : array[0..max_path] of char; // somplace to put the answer
  H : longword; // the window to be trapped
begin
  H := getforegroundwindow;
  Getwindowmodulefilename(h,s,max_path);
  result := S;
end;

end.
