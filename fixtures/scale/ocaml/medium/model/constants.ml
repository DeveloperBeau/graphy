let constant = function
  | "pi" -> Some (4. *. atan 1.)
  | "e" -> Some (exp 1.)
  | "tau" -> Some (8. *. atan 1.)
  | _ -> None
