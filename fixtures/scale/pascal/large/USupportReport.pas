unit USupportReport;

interface

uses USupportResult, USupportFormat;

function ResultLine(const R: TTestResult): string;
function Summary(PassCount, Total: Integer): string;

implementation

function ResultLine(const R: TTestResult): string;
begin
  if R.Passed then
    ResultLine := PadRightStr(R.Subject, 20) + 'PASS'
  else
    ResultLine := PadRightStr(R.Subject, 20) + 'FAIL';
end;

function Summary(PassCount, Total: Integer): string;
var
  A, B: string;
begin
  Str(PassCount, A);
  Str(Total, B);
  Summary := A + '/' + B + ' passed';
end;

end.
