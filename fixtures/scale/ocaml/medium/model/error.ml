type calc_error = Unknown_sym of string | Arity_err of string * int

let message = function
  | Unknown_sym n -> "unknown symbol " ^ n
  | Arity_err (n, k) -> n ^ " expects " ^ string_of_int k ^ " args"
