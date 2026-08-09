let apply args =
  match args with
  | x :: _ -> sin x
  | [] -> 0.

let arity = 1

let symbol = "sin"
