program ws_probe_delphi;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  BenchMain in 'BenchMain.pas',
  MemStats in 'MemStats.pas',
  MemTouch in 'MemTouch.pas',
  StartupIO in 'StartupIO.pas';

begin
  try
    RunFromArgs(ParamStr(1));
  except
    on E: Exception do
    begin
      Writeln('ERROR: ' + E.ClassName + ': ' + E.Message);
      Halt(1);
    end;
  end;
end.
