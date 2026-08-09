let apply args =
  match args with
  | x :: _ -> asin x
  | [] -> 0.

let arity = 1

let symbol = "asin"
