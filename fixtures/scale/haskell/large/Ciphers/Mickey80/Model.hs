module Ciphers.Mickey80.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 80

blockBits :: Int
blockBits = 0

name :: String
name = "mickey-80"

rounds :: Int
rounds = 9
