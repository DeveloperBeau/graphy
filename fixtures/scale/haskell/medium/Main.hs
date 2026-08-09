module Main (main) where

import Eval.Environment (empty)
import Functions.Registry (names)
import Io.Prompt (banner)
import Memory.Store (blank)
import Repl.Loop (step)

main :: IO ()
main = do
  putStrLn banner
  let (shown, _) = step empty "sqrt(16) + 2 * 3" []
  putStrLn ("result = " ++ shown)
  putStrLn ("functions: " ++ show (length names))
  putStrLn (show (length (blank :: [(String, Double)])))
