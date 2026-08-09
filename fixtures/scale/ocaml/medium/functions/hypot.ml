let apply args =
  match args with
  | x :: y :: _ -> sqrt ((x *. x) +. (y *. y))
  | _ -> 0.

let arity = 2

let symbol = "hypot"
