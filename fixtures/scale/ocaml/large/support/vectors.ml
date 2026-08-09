open Rng

type vector = { key : int; plaintext : int list }

let sample key n = { key; plaintext = stream n (key + 7) }
