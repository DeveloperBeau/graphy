module Functions.Exp (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : _) = exp x
apply [] = 0

arity :: Int
arity = 1

symbol :: String
symbol = "exp"
