module Ciphers.Blowfish256.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 256

blockBits :: Int
blockBits = 64

name :: String
name = "blowfish-256"

rounds :: Int
rounds = 20
