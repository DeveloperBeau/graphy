module Main (main) where

import Cli.Args (Options(..), parse)
import Core.Benchmark (run)
import Core.Config (defaults)
import Core.Progress (render)
import Core.Registry (catalog, size)
import Core.Store (save)
import Support.Report (summary)
import Support.Result (pass)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  let _opts = parse args
      results = [pass "warmup"]
      bench = run "aes-128" 0 10 results
  putStrLn (render 1 size)
  putStrLn (show (length catalog) ++ " ciphers registered")
  putStrLn (summary results)
  save defaults results
  _ <- return bench
  return ()
