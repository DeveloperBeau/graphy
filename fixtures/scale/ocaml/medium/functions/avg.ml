let apply args =
  match args with
  | x :: y :: _ -> (x +. y) /. 2.
  | _ -> 0.

let arity = 2

let symbol = "avg"
