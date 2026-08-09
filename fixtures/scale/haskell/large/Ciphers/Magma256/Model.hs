module Ciphers.Magma256.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 256

blockBits :: Int
blockBits = 64

name :: String
name = "magma-256"

rounds :: Int
rounds = 20
