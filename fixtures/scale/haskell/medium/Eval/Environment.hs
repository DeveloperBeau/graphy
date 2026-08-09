module Eval.Environment (Env, empty, bind, lookupVar) where

import Model.Constants (constant)
import Model.Number (Number)

type Env = [(String, Number)]

empty :: Env
empty = []

bind :: String -> Number -> Env -> Env
bind k v env = (k, v) : env

lookupVar :: Env -> String -> Number
lookupVar env k = case lookup k env of
  Just v -> v
  Nothing -> maybe 0 id (constant k)
