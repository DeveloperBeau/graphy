type bench_error = Missing_cipher of string | Bad_vector of string

let describe = function
  | Missing_cipher n -> "missing cipher " ^ n
  | Bad_vector n -> "bad vector for " ^ n
