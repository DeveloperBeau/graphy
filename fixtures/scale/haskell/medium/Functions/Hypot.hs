module Functions.Hypot (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : y : _) = sqrt (x * x + y * y)
apply _ = 0

arity :: Int
arity = 2

symbol :: String
symbol = "hypot"
