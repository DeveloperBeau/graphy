let apply args =
  match args with
  | x :: y :: _ -> if x > y then x else y
  | _ -> 0.

let arity = 2

let symbol = "max"
