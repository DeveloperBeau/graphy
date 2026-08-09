let pad_to w s =
  if String.length s >= w then String.sub s 0 w
  else s ^ String.make (w - String.length s) ' '

let blank w = String.make w ' '
