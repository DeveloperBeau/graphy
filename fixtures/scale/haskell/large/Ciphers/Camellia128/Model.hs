module Ciphers.Camellia128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 128

name :: String
name = "camellia-128"

rounds :: Int
rounds = 12
