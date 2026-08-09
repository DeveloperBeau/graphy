unit UScanner;

interface

uses UToken, UCharClass;

const
  MaxTokens = 64;

type
  TTokenList = record
    Items: array[1..MaxTokens] of TToken;
    Count: Integer;
  end;

procedure Scan(const Src: string; var List: TTokenList);

implementation

procedure Scan(const Src: string; var List: TTokenList);
var
  I: Integer;
  T: TToken;
begin
  List.Count := 0;
  for I := 1 to Length(Src) do
    if not IsSpaceCh(Src[I]) then
    begin
      if IsDigitCh(Src[I]) then
        T := MakeToken(tkNum)
      else if IsAlphaCh(Src[I]) then
        T := MakeToken(tkIdent)
      else
        T := MakeToken(tkOp);
      T.Op := Src[I];
      T.Num := Ord(Src[I]) - Ord('0');
      T.Text := Src[I];
      List.Count := List.Count + 1;
      List.Items[List.Count] := T;
    end;
end;

end.
