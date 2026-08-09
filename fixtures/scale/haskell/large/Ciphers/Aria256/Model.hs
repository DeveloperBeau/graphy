module Ciphers.Aria256.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 256

blockBits :: Int
blockBits = 128

name :: String
name = "aria-256"

rounds :: Int
rounds = 20
