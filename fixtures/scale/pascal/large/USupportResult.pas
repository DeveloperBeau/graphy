unit USupportResult;

interface

type
  TTestResult = record
    Subject: string;
    Passed: Boolean;
  end;

function MakeResult(const Subject: string; Passed: Boolean): TTestResult;
function ResultOk(const R: TTestResult): Boolean;

implementation

function MakeResult(const Subject: string; Passed: Boolean): TTestResult;
var
  R: TTestResult;
begin
  R.Subject := Subject;
  R.Passed := Passed;
  MakeResult := R;
end;

function ResultOk(const R: TTestResult): Boolean;
begin
  ResultOk := R.Passed;
end;

end.
