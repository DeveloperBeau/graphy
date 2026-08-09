module Ciphers.Threefish256.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 256

blockBits :: Int
blockBits = 256

name :: String
name = "threefish-256"

rounds :: Int
rounds = 20
