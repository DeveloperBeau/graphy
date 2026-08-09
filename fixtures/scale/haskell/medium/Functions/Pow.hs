module Functions.Pow (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : y : _) = x ** y
apply _ = 0

arity :: Int
arity = 2

symbol :: String
symbol = "pow"
