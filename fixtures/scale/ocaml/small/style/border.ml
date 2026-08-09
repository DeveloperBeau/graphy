type border = Ascii | Rounded | Heavy

let horizontal = function
  | Heavy -> '='
  | _ -> '-'

let vertical _ = '|'
