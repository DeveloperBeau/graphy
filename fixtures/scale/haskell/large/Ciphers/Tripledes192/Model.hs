module Ciphers.Tripledes192.Model (keyBits, blockBits, name, rounds) where

keyBits :: Int
keyBits = 192

blockBits :: Int
blockBits = 64

name :: String
name = "tripledes-192"

rounds :: Int
rounds = 16
