let apply args =
  match args with
  | x :: _ -> tan x
  | [] -> 0.

let arity = 1

let symbol = "tan"
