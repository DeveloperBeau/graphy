unit UReader;

interface

uses UDocument;

procedure LoadSample(var D: TDocument);

implementation

procedure LoadSample(var D: TDocument);
begin
  AddLine(D, 'alpha');
  AddLine(D, 'beta');
  AddLine(D, 'gamma');
end;

end.
