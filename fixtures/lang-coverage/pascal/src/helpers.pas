unit Helpers;

interface

function FormatName(const Name: string): string;
function UnrelatedHelper: Integer;

implementation

function FormatName(const Name: string): string;
begin
  Result := 'hi, ' + Name;
end;

function UnrelatedHelper: Integer;
begin
  Result := 7;
end;

end.
