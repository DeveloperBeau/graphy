let apply args =
  match args with
  | x :: _ -> exp x
  | [] -> 0.

let arity = 1

let symbol = "exp"
