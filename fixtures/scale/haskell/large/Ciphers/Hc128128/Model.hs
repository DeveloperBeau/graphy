module Ciphers.Hc128128.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 128

blockBits :: Int
blockBits = 0

name :: String
name = "hc128-128"

rounds :: Int
rounds = 12
