module Ciphers.Sosemanuk256.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 256

blockBits :: Int
blockBits = 0

name :: String
name = "sosemanuk-256"

rounds :: Int
rounds = 20
