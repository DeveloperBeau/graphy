unit UGrammar;

interface

uses UToken;

function IsBinaryOp(const T: TToken): Boolean;
function IsCallStart(const T: TToken): Boolean;

implementation

function IsBinaryOp(const T: TToken): Boolean;
begin
  IsBinaryOp := T.Kind = tkOp;
end;

function IsCallStart(const T: TToken): Boolean;
begin
  IsCallStart := T.Kind = tkIdent;
end;

end.
