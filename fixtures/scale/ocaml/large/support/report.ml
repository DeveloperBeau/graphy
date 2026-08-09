open Result

let line r = Fmt.pad_right 20 r.subject ^ (if r.passed then "PASS" else "FAIL")

let summary rs =
  let good = List.length (List.filter ok rs) in
  string_of_int good ^ "/" ^ string_of_int (List.length rs) ^ " passed"
