let apply args =
  match args with
  | x :: _ -> if x > 0. then 1. else if x < 0. then -1. else 0.
  | [] -> 0.

let arity = 1

let symbol = "sign"
