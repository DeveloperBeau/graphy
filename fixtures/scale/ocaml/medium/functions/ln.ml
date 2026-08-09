let apply args =
  match args with
  | x :: _ -> log x
  | [] -> 0.

let arity = 1

let symbol = "ln"
