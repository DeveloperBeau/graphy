let pad_right w s =
  if String.length s >= w then s else s ^ String.make (w - String.length s) ' '

let pad_left w s =
  if String.length s >= w then s else String.make (w - String.length s) ' ' ^ s

let bar n = String.make (max 0 n) '#'
