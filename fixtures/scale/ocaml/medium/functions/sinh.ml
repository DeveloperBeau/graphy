let apply args =
  match args with
  | x :: _ -> sinh x
  | [] -> 0.

let arity = 1

let symbol = "sinh"
