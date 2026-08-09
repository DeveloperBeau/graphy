module Ciphers.Kuznyechik256.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 256

blockBits :: Int
blockBits = 128

name :: String
name = "kuznyechik-256"

rounds :: Int
rounds = 20
