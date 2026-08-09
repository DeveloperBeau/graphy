unit UParser;

interface

uses UToken, UScanner, UAst, UPrecedence, UGrammar;

procedure ParseTokens(const List: TTokenList; var A: TAst);

implementation

procedure ParseTokens(const List: TTokenList; var A: TAst);
var
  I, Prev, Node: Integer;
begin
  A.Count := 0;
  A.Root := 0;
  Prev := 0;
  for I := 1 to List.Count do
    if IsBinaryOp(List.Items[I]) and (OpLevel(List.Items[I].Op) > 0) then
    begin
      Node := AddNode(A, nkBinOp);
      A.Nodes[Node].Op := List.Items[I].Op;
      A.Nodes[Node].Left := Prev;
      Prev := Node;
    end
    else if IsCallStart(List.Items[I]) then
    begin
      Node := AddNode(A, nkCall);
      A.Nodes[Node].Name := List.Items[I].Text;
      if Prev > 0 then
        A.Nodes[Prev].Right := Node;
      Prev := Node;
    end
    else if List.Items[I].Kind = tkNum then
    begin
      Node := AddNode(A, nkLit);
      A.Nodes[Node].Value := List.Items[I].Num;
      if Prev > 0 then
        A.Nodes[Prev].Right := Node;
      Prev := Node;
    end;
  A.Root := Prev;
end;

end.
