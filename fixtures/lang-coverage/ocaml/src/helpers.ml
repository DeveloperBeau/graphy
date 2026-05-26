(* feature: let (top-level), let rec, open *)

let format_name name = "hi, " ^ name

let rec factorial n =
  if n <= 1 then 1
  else n * factorial (n - 1)

let unrelated_helper x = x + 1

module StringMap = Map.Make(String)
