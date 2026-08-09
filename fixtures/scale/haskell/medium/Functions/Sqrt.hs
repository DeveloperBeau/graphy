module Functions.Sqrt (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : _) = sqrt x
apply [] = 0

arity :: Int
arity = 1

symbol :: String
symbol = "sqrt"
