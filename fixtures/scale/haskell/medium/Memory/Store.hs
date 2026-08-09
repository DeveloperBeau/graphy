module Memory.Store (Store, blank, remember, recall) where

import Eval.Environment (Env, bind, empty, lookupVar)
import Model.Number (Number)

type Store = Env

blank :: Store
blank = empty

remember :: String -> Number -> Store -> Store
remember = bind

recall :: Store -> String -> Number
recall = lookupVar
