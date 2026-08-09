module Ciphers.Threefish512.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 512

blockBits :: Int
blockBits = 256

name :: String
name = "threefish-512"

rounds :: Int
rounds = 36
