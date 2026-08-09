module Eval.Evaluator (eval) where

import Eval.Environment (Env, lookupVar)
import Functions.Registry (dispatch)
import Model.Number (Number)
import Parser.Ast (Expr(..))

eval :: Env -> Expr -> Number
eval _ (Lit n) = n
eval env (Var nm) = lookupVar env nm
eval env (Call fn args) = dispatch fn (map (eval env) args)
eval env (BinOp op a b) = applyOp op (eval env a) (eval env b)

applyOp :: Char -> Number -> Number -> Number
applyOp '+' a b = a + b
applyOp '-' a b = a - b
applyOp '*' a b = a * b
applyOp '^' a b = a ** b
applyOp _ a b = if b == 0 then 0 else a / b
