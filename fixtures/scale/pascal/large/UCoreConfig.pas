unit UCoreConfig;

interface

type
  TConfig = record
    Iterations: Integer;
    ResultsPath: string;
    Verbose: Boolean;
  end;

function DefaultConfig: TConfig;

implementation

function DefaultConfig: TConfig;
var
  C: TConfig;
begin
  C.Iterations := 100;
  C.ResultsPath := 'results.log';
  C.Verbose := True;
  DefaultConfig := C;
end;

end.
