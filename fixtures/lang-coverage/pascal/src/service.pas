unit Service;

interface

uses SysUtils, Types, Helpers;

type
  TServiceRunner = class
  private
    FName: string;
  public
    constructor Create(const Name: string);
    procedure Run;
    function GetGreeting: string;
  end;

implementation

constructor TServiceRunner.Create(const Name: string);
begin
  FName := Name;
end;

procedure TServiceRunner.Run;
var
  Greeting: string;
begin
  Greeting := FormatName(FName);
  WriteLn(Greeting);
end;

function TServiceRunner.GetGreeting: string;
begin
  Result := FormatName(FName);
end;

end.
