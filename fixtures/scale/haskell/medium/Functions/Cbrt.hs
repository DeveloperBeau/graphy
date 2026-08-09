module Functions.Cbrt (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : _) = x ** (1 / 3)
apply [] = 0

arity :: Int
arity = 1

symbol :: String
symbol = "cbrt"
