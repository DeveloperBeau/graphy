module Ciphers.Aria128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 128

name :: String
name = "aria-128"

rounds :: Int
rounds = 12
