module Ciphers.Lea128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 128

name :: String
name = "lea-128"

rounds :: Int
rounds = 12
