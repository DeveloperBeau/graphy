type expr =
  | Lit of float
  | Var of string
  | Bin_op of char * expr * expr
  | Call of string * expr list
