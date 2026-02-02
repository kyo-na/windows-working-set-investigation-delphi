unit MemTouch;

interface

function Alloc512MB: Pointer;
procedure Touch512MB(p: Pointer; ReadWrite: Boolean; PageStride: NativeUInt);
procedure FreeBuf(p: Pointer);

implementation

uses
  Winapi.Windows, System.SysUtils;

const
  TOTAL_SIZE = 512 * 1024 * 1024;
  PAGE_SIZE  = 4096;

function Alloc512MB: Pointer;
begin
  Result := VirtualAlloc(nil, TOTAL_SIZE,
    MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE);
  if Result = nil then RaiseLastOSError;
end;

procedure Touch512MB(p: Pointer; ReadWrite: Boolean; PageStride: NativeUInt);
var
  b: PByte;
  i: NativeUInt;
  stride: NativeUInt;
  tmp: Byte;
begin
  b := PByte(p);
  stride := PageStride;
  if stride = 0 then stride := PAGE_SIZE;

  i := 0;
  while i < TOTAL_SIZE do
  begin
    if ReadWrite then
      b[i] := b[i] xor $FF
    else
    begin
      // ★ Win64対応：volatile read
      tmp := b[i];
      // 最適化防止（意味のない条件）
      if tmp = $FF then
        b[i] := tmp;
    end;

    Inc(i, stride);
  end;
end;

procedure FreeBuf(p: Pointer);
begin
  if p <> nil then
    VirtualFree(p, 0, MEM_RELEASE);
end;

end.

