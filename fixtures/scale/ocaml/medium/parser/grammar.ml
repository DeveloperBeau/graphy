open Token

let is_binary_op = function
  | Top _ -> true
  | _ -> false

let is_call_start = function
  | Tident _ -> true
  | _ -> false
