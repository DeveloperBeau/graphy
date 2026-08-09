open Token
open Charclass

let explode s = List.init (String.length s) (String.get s)

let implode cs = String.concat "" (List.map (String.make 1) cs)

let rec span pred = function
  | c :: rest when pred c ->
    let hd, tl = span pred rest in
    (c :: hd, tl)
  | rest -> ([], rest)

let rec scan_chars = function
  | [] -> []
  | c :: rest when is_space_ch c -> scan_chars rest
  | '(' :: rest -> Tlparen :: scan_chars rest
  | ')' :: rest -> Trparen :: scan_chars rest
  | ',' :: rest -> Tcomma :: scan_chars rest
  | (c :: _ as cs) when is_digit_ch c ->
    let ds, rest = span is_digit_ch cs in
    Tnum (float_of_string (implode ds)) :: scan_chars rest
  | (c :: _ as cs) when is_alpha_ch c ->
    let ws, rest = span is_alpha_ch cs in
    Tident (implode ws) :: scan_chars rest
  | c :: rest -> Top c :: scan_chars rest

let scan line = scan_chars (explode line)
