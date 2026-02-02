unit MemTouch;

interface

procedure Touch512MB(ReadWrite: Boolean; PageStride: NativeUInt);

implementation

uses
  Winapi.Windows,
  System.SysUtils;

const
  TOTAL_SIZE = 512 * 1024 * 1024; // 512MB
  PAGE_SIZE  = 4096;

procedure Touch512MB(ReadWrite: Boolean; PageStride: NativeUInt);
var
  p: PByte;
  i: NativeUInt;
  stride: NativeUInt;
  tmp: Byte;
begin
  if PageStride = 0 then
    stride := PAGE_SIZE
  else
    stride := PageStride;

  p := VirtualAlloc(nil, TOTAL_SIZE, MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE);
  if p = nil then RaiseLastOSError;

  // 実験都合で Free しないケースもあるので、ここは “呼び出し側” で管理してもOK。
  // まずは確実に解放する版。
  try
    i := 0;
    while i < TOTAL_SIZE do
    begin
      if ReadWrite then
        p[i] := p[i] xor $FF
      else
      begin
        tmp := p[i];
        // tmp を使って最適化抑制（超軽量）
        if tmp = $FF then
          p[i] := tmp; // ほぼ起きないが、コンパイラ抑制用
      end;
      Inc(i, stride);
    end;
  finally
    VirtualFree(p, 0, MEM_RELEASE);
  end;
end;

end.

