module Ciphers.Cast5128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 64

name :: String
name = "cast5-128"

rounds :: Int
rounds = 12
