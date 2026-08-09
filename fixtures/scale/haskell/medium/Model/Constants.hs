module Model.Constants (constant) where

import Model.Number (Number)

constant :: String -> Maybe Number
constant "pi" = Just pi
constant "e" = Just (exp 1)
constant "tau" = Just (2 * pi)
constant _ = Nothing
