module Functions.Log2 (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : _) = logBase 2 x
apply [] = 0

arity :: Int
arity = 1

symbol :: String
symbol = "log2"
