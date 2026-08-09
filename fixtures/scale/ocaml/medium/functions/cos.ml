let apply args =
  match args with
  | x :: _ -> cos x
  | [] -> 0.

let arity = 1

let symbol = "cos"
