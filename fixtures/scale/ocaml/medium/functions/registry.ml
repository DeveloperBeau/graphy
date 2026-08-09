let dispatch name args =
  match name with
  | "sqrt" -> Sqrt.apply args
  | "abs" -> Abs.apply args
  | "sin" -> Sin.apply args
  | "cos" -> Cos.apply args
  | "exp" -> Exp.apply args
  | "ln" -> Ln.apply args
  | _ -> 0.

let names = [ "sqrt"; "cbrt"; "abs"; "sign"; "floor"; "ceil"; "round"; "trunc"; "exp"; "ln"; "log10"; "log2"; "sin"; "cos"; "tan"; "asin"; "acos"; "atan"; "sinh"; "cosh"; "tanh"; "neg"; "pow"; "hypot"; "max"; "min"; "avg"; "mod"; "gcd"; "lcm" ]

let known n = List.mem n names
