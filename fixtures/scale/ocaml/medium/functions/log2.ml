let apply args =
  match args with
  | x :: _ -> log x /. log 2.
  | [] -> 0.

let arity = 1

let symbol = "log2"
