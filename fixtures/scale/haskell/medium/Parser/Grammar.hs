module Parser.Grammar (isBinaryOp, isCallStart) where

import Lexer.Token (Token(..))

isBinaryOp :: Token -> Bool
isBinaryOp (TOp _) = True
isBinaryOp _ = False

isCallStart :: Token -> Bool
isCallStart (TIdent _) = True
isCallStart _ = False
