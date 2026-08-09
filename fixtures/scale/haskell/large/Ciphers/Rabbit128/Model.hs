module Ciphers.Rabbit128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 0

name :: String
name = "rabbit-128"

rounds :: Int
rounds = 12
