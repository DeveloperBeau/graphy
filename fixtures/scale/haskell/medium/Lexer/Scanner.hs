module Lexer.Scanner (scan) where

import Lexer.CharClass (isAlphaCh, isDigitCh, isSpaceCh)
import Lexer.Token (Token(..))

scan :: String -> [Token]
scan [] = []
scan (c : cs)
  | isSpaceCh c = scan cs
  | c == '(' = TLParen : scan cs
  | c == ')' = TRParen : scan cs
  | c == ',' = TComma : scan cs
  | isDigitCh c = let (d, r) = span isDigitCh (c : cs) in TNum (read d) : scan r
  | isAlphaCh c = let (d, r) = span isAlphaCh (c : cs) in TIdent d : scan r
  | otherwise = TOp c : scan cs
