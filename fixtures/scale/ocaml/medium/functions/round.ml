let apply args =
  match args with
  | x :: _ -> Float.round x
  | [] -> 0.

let arity = 1

let symbol = "round"
