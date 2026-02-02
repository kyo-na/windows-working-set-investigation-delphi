unit StartupIO;

interface

procedure RunStartupIO;

implementation

uses
  Winapi.Windows,
  System.SysUtils;

procedure RunStartupIO;
var
  sr: TSearchRec;
  h: THandle;
  buf: array[0..65535] of Byte;
  read: DWORD;
  path: string;
begin
  path := 'C:\Windows\System32\';

  if FindFirst(path + '*.dll', faAnyFile, sr) = 0 then
  try
    repeat
      h := CreateFile(PChar(path + sr.Name),
        GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL, 0);

      if h <> INVALID_HANDLE_VALUE then
      try
        ReadFile(h, buf, SizeOf(buf), read, nil);
      finally
        CloseHandle(h);
      end;

    until FindNext(sr) <> 0;
  finally
    FindClose(sr);
  end;
end;

end.

