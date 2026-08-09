type value = Num of float | Name of string

let to_number = function
  | Num n -> n
  | Name _ -> 0.
