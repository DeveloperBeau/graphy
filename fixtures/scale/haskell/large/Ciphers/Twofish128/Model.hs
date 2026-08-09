module Ciphers.Twofish128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 128

name :: String
name = "twofish-128"

rounds :: Int
rounds = 12
