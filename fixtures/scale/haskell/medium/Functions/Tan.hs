module Functions.Tan (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : _) = tan x
apply [] = 0

arity :: Int
arity = 1

symbol :: String
symbol = "tan"
