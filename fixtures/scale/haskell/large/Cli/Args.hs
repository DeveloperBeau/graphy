module Cli.Args (Options(..), parse) where

data Options = Options { onlyCipher :: Maybe String, quick :: Bool }

parse :: [String] -> Options
parse args = Options (firstArg args) ("--quick" `elem` args)
  where
    firstArg [] = Nothing
    firstArg (x : _) = Just x
