module Io.Prompt (banner, ps1) where

banner :: String
banner = "calc - type an expression"

ps1 :: Int -> String
ps1 n = "[" ++ show n ++ "] > "
