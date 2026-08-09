module Ciphers.Present80.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 80

blockBits :: Int
blockBits = 64

name :: String
name = "present-80"

rounds :: Int
rounds = 9
