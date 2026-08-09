let apply args =
  match args with
  | x :: _ -> x ** (1. /. 3.)
  | [] -> 0.

let arity = 1

let symbol = "cbrt"
