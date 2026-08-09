module Input.Args (Options(..), parse) where

data Options = Options { boxWidth :: Int, heading :: String }

parse :: [String] -> Options
parse (w : rest) = Options (readWidth w) (unwords rest)
parse [] = Options 32 "report"

readWidth :: String -> Int
readWidth s = case reads s of
  [(n, _)] -> n
  _ -> 32
