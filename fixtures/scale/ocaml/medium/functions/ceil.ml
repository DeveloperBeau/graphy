let apply args =
  match args with
  | x :: _ -> ceil x
  | [] -> 0.

let arity = 1

let symbol = "ceil"
