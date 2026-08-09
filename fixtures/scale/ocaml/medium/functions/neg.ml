let apply args =
  match args with
  | x :: _ -> -. x
  | [] -> 0.

let arity = 1

let symbol = "neg"
