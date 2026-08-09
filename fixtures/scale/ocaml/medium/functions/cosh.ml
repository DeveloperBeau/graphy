let apply args =
  match args with
  | x :: _ -> cosh x
  | [] -> 0.

let arity = 1

let symbol = "cosh"
