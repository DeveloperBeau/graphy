let apply args =
  match args with
  | x :: _ -> floor x
  | [] -> 0.

let arity = 1

let symbol = "floor"
