let apply args =
  match args with
  | x :: _ -> abs_float x
  | [] -> 0.

let arity = 1

let symbol = "abs"
