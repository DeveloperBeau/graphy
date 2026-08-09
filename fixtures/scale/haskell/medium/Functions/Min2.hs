module Functions.Min2 (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : y : _) = min x y
apply _ = 0

arity :: Int
arity = 2

symbol :: String
symbol = "min"
