let apply args =
  match args with
  | x :: _ -> sqrt x
  | [] -> 0.

let arity = 1

let symbol = "sqrt"
