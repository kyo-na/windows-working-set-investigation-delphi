unit MemStats;

interface

uses
  Winapi.Windows;

function GetWSAndPF(out WSBytes, PFCount: UInt64): Boolean;

implementation

uses
  PsAPI;

function GetWSAndPF(out WSBytes, PFCount: UInt64): Boolean;
var
  pmc: PROCESS_MEMORY_COUNTERS_EX;
begin
  ZeroMemory(@pmc, SizeOf(pmc));
  pmc.cb := SizeOf(pmc);

  Result := GetProcessMemoryInfo(GetCurrentProcess,
    PPROCESS_MEMORY_COUNTERS(@pmc), SizeOf(pmc));

  if Result then
  begin
    WSBytes := pmc.WorkingSetSize;
    PFCount := pmc.PageFaultCount;
  end;
end;

end.

