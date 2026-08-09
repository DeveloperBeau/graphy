let apply args =
  match args with
  | x :: _ -> acos x
  | [] -> 0.

let arity = 1

let symbol = "acos"
