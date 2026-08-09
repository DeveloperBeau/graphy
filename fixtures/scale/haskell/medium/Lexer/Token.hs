module Lexer.Token (Token(..)) where

data Token
  = TNum Double
  | TIdent String
  | TOp Char
  | TLParen
  | TRParen
  | TComma
  deriving (Eq)
