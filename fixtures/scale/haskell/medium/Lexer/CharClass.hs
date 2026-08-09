module Lexer.CharClass (isDigitCh, isAlphaCh, isSpaceCh) where

isDigitCh :: Char -> Bool
isDigitCh c = c >= '0' && c <= '9'

isAlphaCh :: Char -> Bool
isAlphaCh c = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')

isSpaceCh :: Char -> Bool
isSpaceCh c = c == ' ' || c == '\t'
