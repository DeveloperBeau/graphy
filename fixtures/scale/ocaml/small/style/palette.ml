type palette = Plain | Bright

let pick p s =
  match p with
  | Plain -> s
  | Bright -> "*" ^ s ^ "*"
