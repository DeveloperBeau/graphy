unit UAst;

interface

const
  MaxNodes = 64;

type
  TNodeKind = (nkLit, nkVar, nkBinOp, nkCall);

  TAstNode = record
    Kind: TNodeKind;
    Value: Double;
    Name: string;
    Op: Char;
    Left, Right: Integer;
  end;

  TAst = record
    Nodes: array[1..MaxNodes] of TAstNode;
    Count: Integer;
    Root: Integer;
  end;

function AddNode(var A: TAst; Kind: TNodeKind): Integer;

implementation

function AddNode(var A: TAst; Kind: TNodeKind): Integer;
begin
  A.Count := A.Count + 1;
  A.Nodes[A.Count].Kind := Kind;
  A.Nodes[A.Count].Left := 0;
  A.Nodes[A.Count].Right := 0;
  AddNode := A.Count;
end;

end.
