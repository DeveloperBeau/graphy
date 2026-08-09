module Functions.Registry (dispatch, names, known) where

import qualified Functions.Sqrt as Sqrt
import qualified Functions.Cbrt as Cbrt
import qualified Functions.Abs as Abs
import qualified Functions.Sign as Sign
import qualified Functions.Floor as Floor
import qualified Functions.Ceil as Ceil
import Model.Number (Number)

dispatch :: String -> [Number] -> Number
dispatch "sqrt" = Sqrt.apply
dispatch "cbrt" = Cbrt.apply
dispatch "abs" = Abs.apply
dispatch "sign" = Sign.apply
dispatch "floor" = Floor.apply
dispatch "ceil" = Ceil.apply
dispatch _ = const 0

names :: [String]
names = ["sqrt", "cbrt", "abs", "sign", "floor", "ceil", "round", "trunc", "exp", "ln", "log10", "log2", "sin", "cos", "tan", "asin", "acos", "atan", "sinh", "cosh", "tanh", "neg", "pow", "hypot", "gcd", "lcm", "max", "min", "avg", "mod"]

known :: String -> Bool
known n = n `elem` names
