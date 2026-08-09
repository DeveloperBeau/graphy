let rec common_div a b = if b = 0 then a else common_div b (a mod b)

let apply args =
  match args with
  | x :: y :: _ ->
    let a = int_of_float x and b = int_of_float y in
    if a = 0 || b = 0 then 0. else float_of_int (a * b / common_div a b)
  | _ -> 0.

let arity = 2

let symbol = "lcm"
