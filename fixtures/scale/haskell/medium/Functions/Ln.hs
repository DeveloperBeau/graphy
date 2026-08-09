module Functions.Ln (apply, arity, symbol) where

import Model.Number (Number)

apply :: [Number] -> Number
apply (x : _) = log x
apply [] = 0

arity :: Int
arity = 1

symbol :: String
symbol = "ln"
