module Ciphers.Gost256.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 256

blockBits :: Int
blockBits = 64

name :: String
name = "gost-256"

rounds :: Int
rounds = 20
