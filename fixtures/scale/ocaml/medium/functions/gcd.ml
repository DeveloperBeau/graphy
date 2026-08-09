let rec gcd_int a b = if b = 0 then a else gcd_int b (a mod b)

let apply args =
  match args with
  | x :: y :: _ -> float_of_int (gcd_int (int_of_float x) (int_of_float y))
  | _ -> 0.

let arity = 2

let symbol = "gcd"
