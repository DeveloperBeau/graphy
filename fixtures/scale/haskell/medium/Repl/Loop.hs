module Repl.Loop (step, evalLine) where

import Eval.Environment (Env)
import Eval.Evaluator (eval)
import History.Log (Entry, record)
import Io.Output (formatNumber)
import Lexer.Scanner (scan)
import Model.Number (Number)
import Parser.Parser (parse)

evalLine :: Env -> String -> Number
evalLine env line = eval env (parse (scan line))

step :: Env -> String -> [Entry] -> (String, [Entry])
step env line hist =
  let value = evalLine env line
  in (formatNumber value, record line value hist)
