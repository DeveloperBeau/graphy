module Functions.Avg (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : y : _) = (x + y) / 2
apply _ = 0

arity :: Int
arity = 2

symbol :: String
symbol = "avg"
