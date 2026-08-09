let apply args =
  match args with
  | x :: _ -> log10 x
  | [] -> 0.

let arity = 1

let symbol = "log10"
