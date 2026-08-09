module Ciphers.Rc264.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 64

blockBits :: Int
blockBits = 64

name :: String
name = "rc2-64"

rounds :: Int
rounds = 8
