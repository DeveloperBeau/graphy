let level = function
  | '+' | '-' -> 1
  | '*' | '/' -> 2
  | '^' -> 3
  | _ -> 0
