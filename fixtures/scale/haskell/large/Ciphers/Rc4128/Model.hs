module Ciphers.Rc4128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 0

name :: String
name = "rc4-128"

rounds :: Int
rounds = 12
