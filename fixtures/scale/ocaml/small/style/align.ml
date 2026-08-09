type align = Left_a | Right_a | Center_a

let apply mode w s =
  let gap = max 0 (w - String.length s) in
  match mode with
  | Left_a -> s ^ String.make gap ' '
  | Right_a -> String.make gap ' ' ^ s
  | Center_a -> String.make (gap / 2) ' ' ^ s
