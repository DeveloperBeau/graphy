module Parser.Ast (Expr(..)) where

import Model.Number (Number)

data Expr
  = Lit Number
  | Var String
  | BinOp Char Expr Expr
  | Call String [Expr]
