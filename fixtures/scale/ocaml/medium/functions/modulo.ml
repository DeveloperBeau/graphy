let apply args =
  match args with
  | x :: y :: _ -> float_of_int (int_of_float x mod int_of_float y)
  | _ -> 0.

let arity = 2

let symbol = "mod"
