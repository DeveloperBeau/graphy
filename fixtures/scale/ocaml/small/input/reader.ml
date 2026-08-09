let clean s = String.concat "" (String.split_on_char '\r' s)

let read_lines s =
  List.filter (fun l -> l <> "") (String.split_on_char '\n' s)
