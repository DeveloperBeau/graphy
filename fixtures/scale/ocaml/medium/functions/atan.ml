let apply args =
  match args with
  | x :: _ -> atan x
  | [] -> 0.

let arity = 1

let symbol = "atan"
