module Core.Config (Config(..), defaults) where

data Config = Config { iterations :: Int, resultsPath :: String, verbose :: Bool }

defaults :: Config
defaults = Config 100 "results.log" True
