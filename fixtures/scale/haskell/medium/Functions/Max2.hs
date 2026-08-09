module Functions.Max2 (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : y : _) = max x y
apply _ = 0

arity :: Int
arity = 2

symbol :: String
symbol = "max"
