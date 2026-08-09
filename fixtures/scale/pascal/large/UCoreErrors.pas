unit UCoreErrors;

interface

type
  TBenchError = (beNone, beMissingCipher, beBadVector);

function DescribeError(E: TBenchError): string;

implementation

function DescribeError(E: TBenchError): string;
begin
  case E of
    beMissingCipher: DescribeError := 'missing cipher';
    beBadVector: DescribeError := 'bad vector';
  else
    DescribeError := 'ok';
  end;
end;

end.
